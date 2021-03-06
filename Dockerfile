FROM ruby:2.6.5-slim

LABEL version="1.0"

LABEL name="Nick Janetakis <nick.janetakis@gmail.com>"

RUN export DEBIAN_FRONTEND=noninteractive

ENV RAILS_ENV=production \
    RACK_ENV=production

RUN apt update && \
    apt-get install -y \
    curl \
    build-essential \
    default-libmysqlclient-dev \
    cron \
    vim \
    libgmp-dev \
    libssl-dev \
    git-core \
    openssl \
    less \
    net-tools \
    sudo \
    telnet \
    socat \
    dnsutils \
    netcat \
    tree \
    ssh \
    rsync \
    python \
    python-pip \
    jq \
    git \
    software-properties-common \
    supervisor \
    rsync \
    htop \
    nano \
    tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -

RUN apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update -qq && apt-get install -y nodejs postgresql-client vim && \
    apt-get install -y yarn && \
    apt-get install -y imagemagick && \
    apt-get install -y libvips-tools && \
    apt-get install -y locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN gem update --system

RUN echo 'gem: --no-document' >> ~/.gemrc

RUN gem update

RUN gem install nokogiri -v '1.10.7'

RUN gem install bundler:1.17.3

RUN gem install bundler procodile whenever tzinfo tzinfo-data

RUN gem install bundler foreman procodile whenever tzinfo tzinfo-data \
    && gem cleanup

EXPOSE 3000
