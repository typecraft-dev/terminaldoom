FROM ubuntu:latest

# Update package lists and install Git
RUN apt-get update && \
    apt-get install -y curl build-essential && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the Zig version you want to install
ENV ZIG_VERSION=0.13.0

# Download and install Zig
RUN curl -L https://ziglang.org/download/${ZIG_VERSION}/zig-linux-x86_64-${ZIG_VERSION}.tar.xz | \
    tar -xJ -C /usr/local/bin --strip-components=1

# Set the working directory
WORKDIR /app

# Clone the GitHub repository
RUN git clone https://github.com/cryptocode/terminal-doom.git

WORKDIR /app/terminal-doom

# Build terminal doom with zig
RUN zig build -Doptimize=ReleaseFast

CMD ["zig-out/bin/terminal-doom"]
