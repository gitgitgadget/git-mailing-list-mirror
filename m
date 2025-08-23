Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43047204863
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921367; cv=none; b=BIQd75u1d0CS8Vfws3F+3VC0YmhgMf4cKDUh2ojjoC6sGh5j4FzJeJ7b61u3kB6iJkKJxR3lAf9muZ4Cvtz29fF7SpdsVlHomQNZeD315dln8PoN/k+7/1VAa+GgU+alDKsS561doJj/iRKbkqjglARMhyUjZcKoLwazdoRXMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921367; c=relaxed/simple;
	bh=1cyYw8Qu6C0AgbdfuZ0V3Xk2F7b8figR/yKZtByV5yY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TGeo6b6KJf/NgZqh3f26oIf4gC8v4bddh1VOXpCg4ZNqNnGu/7hLBZYMwx8D2WQ/a437mGItkDEWyhnXbr3NwONxC5zeQk+NdQBLEW1IM3/+S/tJaJrSAqwKTVpCcrUSJKlxTUMwEMPu6KVmxwuv9aTwItIeavVbyxZY3JVZPWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzz+3A7i; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzz+3A7i"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c6df24f128so451696f8f.3
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921363; x=1756526163; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLgfdMXmpRvF2bkjPHG5L025mnYf8ZbvohP2cTijZfE=;
        b=fzz+3A7iRxpRMjacp+IpwfcTyyfv9erSJ5y43FgZ9+xHCtbT10rxwroxdi82TZhyIm
         XQC/duDodbgUPnisIppZAt0Ovrh/NASN1U/lLL35A59KrVmz2RdmAVRlL/946uJKtk0F
         rwzmJH3xbGScQ2pvhFoX+40+wSQ/NdGqBY46amJI/QN5T67sJ1bL4UzjF6zGUFxpZpvl
         ampOHhSSTxgoigQ3SxlMaWIASz7+Mr3RPScyaWhg/eNANtZxXhXf05drSALCohRjxLd1
         le8DhMsUtomsj54e82lA05NEDZ5X9E71g0XJH+14ym2D/KNN1UTHfM/D70IZUgXsJDCs
         +1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921363; x=1756526163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLgfdMXmpRvF2bkjPHG5L025mnYf8ZbvohP2cTijZfE=;
        b=r5YuJ5uQ/ZfCCarwaJizOQrxUxpgI7eutcvWfVi70ZthyNNgBHHh2pTYfUJASnjXbY
         9mw2jc5ZBIRA/aBBaRZcL3b+U2LEceIAHeiB6JWbEQCR220/vslDS76C7y6xzZbvnXWZ
         cEAcb1jj45aN+z3INzENh4htCxw4B8Cke+/lXRfTfgknjGhYRhPfsiyd6Tc7yereYMqZ
         VQdHgXY1/Q/GotXBZGo5PrJngWf4Tz4rwASBiYvXO736aHpxTtBjUIFsa5TK1iIyDJF8
         njBHyLXE81eaUO6WbqJe5CMZYv5PsSz1Jc2BOuxR9DooM4l8bSbMLJQvvrD/ziiEFQ46
         U/SA==
X-Gm-Message-State: AOJu0YxhSb4AtThljSwa7TddPnAXbuu2js6y2zOY8N5kfUsrAlcYrEPD
	+ruOK9Z4T+cJiki9ISjKgDVnzBamjYqvuUj3hIehCBMjddl47e/na0kJG/cbDQ==
X-Gm-Gg: ASbGncuPO/xIP04ZG18HjgNvXij5U2IBRS1sT8YtFGcny5KYWC85qK8t/1uq0Wq0g+z
	d7JWBcdf/vrMxHdGcGlOTI5lUxsif4/h1Jgm3X4U5tMftTS2a8xe9hWrj3LdrXfImffP7Jho4eE
	QJsIcWHhjA3uRjpSlOkLM1WwIUUvsTJ52Q/2RbnUfL2u6/uXkmVUsepjMRy5Zo6lzbSnKnZg/6D
	eKLba+Ty+3TGe6QYC2iZfRzIanh0V3rQD3ZGihzgeew4vhtOQPjZLpP8a5DUp8qDCnAbKk6I8rV
	3or3flU/4aGDKvc+W/aLP1A4nNg4Fwz0PsZSC4JWiOy1Z/jSmqJXYwSomWv9txwwnP6/Th+MVhS
	SvDqpHvnQ7T/hqQ4q0c84Hpoy2Vo=
X-Google-Smtp-Source: AGHT+IFZDcmCqeaVZiPZhLQbryCHFVo3ftfmYyx0DfyGz+vjanPqyvoS57qcOfLDTUoi1uOrdQVQ0Q==
X-Received: by 2002:a05:6000:238a:b0:3b6:1a8c:569f with SMTP id ffacd0b85a97d-3c5dac171cemr3518710f8f.1.1755921363266;
        Fri, 22 Aug 2025 20:56:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711ca623asm1808160f8f.59.2025.08.22.20.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:02 -0700 (PDT)
Message-Id: <a98d9e4d21baebb9c774413d6a9918e91691fe2c.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:44 +0000
Subject: [PATCH v3 03/15] github workflows: install rust
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Prefer using actions-rs/toolchain@v1 where possible to install rustup,
but for docker targets use a script to install rustup. Consolidate the
Rust toolchain definitions in main.yaml. Use install-rust-toolchain.sh
to ensure the correct toolchain is used. Five overrides are used in
main.yaml:

  * On Windows: Rust didn't resolve the bcrypt library on Windows
    correctly until version 1.78.0. Also since rustup mis-identifies
    the Rust toolchain, the Rust target triple must be set to
    x86_64-pc-windows-gnu for make (win build), and
    x86_64-pc-windows-msvc for meson (win+Meson build).
  * On musl: libc differences, such as ftruncate64 vs ftruncate, were
    not accounted for until Rust version 1.72.0. No older version of
    Rust will work on musl for our needs.
  * In a 32-bit docker container running on a 64-bit host, we need to
    override the Rust target triple. This is because rustup asks the
    kernel for the bitness of the system and it says 64, even though
    the container is 32-bit. This also allows us to remove the
    BITNESS environment variable in ci/lib.sh.

The logic for selecting library names was initially provided in a patch
from Johannes, but was reworked and squashed into this commit.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .github/workflows/main.yml   | 61 +++++++++++++++++++++++++++++++++++-
 ci/install-dependencies.sh   | 14 ++++-----
 ci/install-rust-toolchain.sh | 30 ++++++++++++++++++
 ci/install-rustup.sh         | 25 +++++++++++++++
 ci/lib.sh                    |  1 +
 ci/make-test-artifacts.sh    |  9 ++++++
 ci/run-build-and-tests.sh    | 13 ++++++++
 7 files changed, 145 insertions(+), 8 deletions(-)
 create mode 100755 ci/install-rust-toolchain.sh
 create mode 100755 ci/install-rustup.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 7dbf9f7f123c..2fa5fab0fa83 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -26,6 +26,13 @@ jobs:
     outputs:
       enabled: ${{ steps.check-ref.outputs.enabled }}${{ steps.skip-if-redundant.outputs.enabled }}
       skip_concurrent: ${{ steps.check-ref.outputs.skip_concurrent }}
+      rust_version_minimum: 1.61.0
+      rust_version_windows: 1.78.0
+      rust_version_musl: 1.72.0
+      ## the rust target is inferred by rustup unless specified
+      rust_target_windows_make: x86_64-pc-windows-gnu
+      rust_target_windows_meson: x86_64-pc-windows-msvc
+      rust_target_32bit_linux: i686-unknown-linux-gnu
     steps:
       - name: try to clone ci-config branch
         run: |
@@ -108,12 +115,26 @@ jobs:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
+    env:
+      CARGO_HOME: "/c/Users/runneradmin/.cargo"
     concurrency:
       group: windows-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v4
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - name: Install rustup via github actions
+      uses: actions-rs/toolchain@v1
+      with:
+        toolchain: stable
+        profile: minimal
+        override: false
+    - name: Install Rust toolchain
+      shell: bash
+      env:
+        RUST_VERSION: ${{ needs.ci-config.outputs.rust_version_windows }}
+        RUST_TARGET: ${{ needs.ci-config.outputs.rust_target_windows_make }}
+      run: ci/install-rust-toolchain.sh
     - name: build
       shell: bash
       env:
@@ -254,12 +275,26 @@ jobs:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
+    env:
+      CARGO_HOME: "/c/Users/runneradmin/.cargo"
     concurrency:
       group: windows-meson-build-${{ github.ref }}
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v4
     - uses: actions/setup-python@v5
+    - name: Install rustup via github actions
+      uses: actions-rs/toolchain@v1
+      with:
+        toolchain: stable
+        profile: minimal
+        override: false
+    - name: Install Rust toolchain
+      shell: bash
+      env:
+        RUST_VERSION: ${{ needs.ci-config.outputs.rust_version_windows }}
+        RUST_TARGET: ${{ needs.ci-config.outputs.rust_target_windows_meson }}
+      run: ci/install-rust-toolchain.sh
     - name: Set up dependencies
       shell: pwsh
       run: pip install meson ninja
@@ -329,11 +364,24 @@ jobs:
       jobname: ${{matrix.vector.jobname}}
       CI_JOB_IMAGE: ${{matrix.vector.pool}}
       TEST_OUTPUT_DIRECTORY: ${{github.workspace}}/t
+      CARGO_HOME: "/Users/runner/.cargo"
     runs-on: ${{matrix.vector.pool}}
     steps:
     - uses: actions/checkout@v4
     - run: ci/install-dependencies.sh
-    - run: ci/run-build-and-tests.sh
+    - name: Install rustup via github actions
+      uses: actions-rs/toolchain@v1
+      with:
+        toolchain: stable
+        profile: minimal
+        override: false
+    - name: Install Rust toolchain
+      shell: bash
+      env:
+        RUST_VERSION: ${{ needs.ci-config.outputs.rust_version_minimum }}
+      run: ci/install-rust-toolchain.sh
+    - name: Run build and tests
+      run: ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       run: ci/print-test-failures.sh
@@ -393,9 +441,11 @@ jobs:
           cc: gcc
         - jobname: linux-musl-meson
           image: alpine:latest
+          rust_version_override: ${{ needs.ci-config.outputs.rust_version_musl }}
         # Supported until 2025-04-02.
         - jobname: linux32
           image: i386/ubuntu:focal
+          rust_target_override: ${{ needs.ci-config.outputs.rust_target_32bit_linux }}
         - jobname: pedantic
           image: fedora:latest
         # A RHEL 8 compatible distro.  Supported until 2029-05-31.
@@ -408,7 +458,9 @@ jobs:
       jobname: ${{matrix.vector.jobname}}
       CC: ${{matrix.vector.cc}}
       CI_JOB_IMAGE: ${{matrix.vector.image}}
+      CI_IS_DOCKER: "true"
       CUSTOM_PATH: /custom
+      CARGO_HOME: /home/builder/.cargo
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
@@ -433,6 +485,13 @@ jobs:
     - run: ci/install-dependencies.sh
     - run: useradd builder --create-home
     - run: chown -R builder .
+    - name: Install rustup via script
+      run: sudo --preserve-env --set-home --user=builder ci/install-rustup.sh
+    - name: Install Rust toolchain
+      env:
+        RUST_VERSION: ${{ matrix.vector.rust_version_override || needs.ci-config.outputs.rust_version_minimum }}
+        RUST_TARGET: ${{ matrix.vector.rust_target_override || '' }}
+      run: sudo --preserve-env --set-home --user=builder ci/install-rust-toolchain.sh
     - run: sudo --preserve-env --set-home --user=builder ci/run-build-and-tests.sh
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d061a4729339..7801075821ba 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -24,14 +24,14 @@ fi
 
 case "$distro" in
 alpine-*)
-	apk add --update shadow sudo meson ninja-build gcc libc-dev curl-dev openssl-dev expat-dev gettext \
+	apk add --update shadow sudo meson ninja-build gcc libc-dev curl curl-dev openssl-dev expat-dev gettext \
 		zlib-ng-dev pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;
 fedora-*|almalinux-*)
 	dnf -yq update >/dev/null &&
-	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl curl-devel pcre2-devel >/dev/null
 	;;
 ubuntu-*|i386/ubuntu-*|debian-*)
 	# Required so that apt doesn't wait for user input on certain packages.
@@ -55,8 +55,8 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 	sudo apt-get -q update
 	sudo apt-get -q -y install \
 		$LANGUAGES apache2 cvs cvsps git gnupg $SVN \
-		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
-		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
+		make libssl-dev curl libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
+		tcl tk gettext zlib1g zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
 		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
@@ -121,13 +121,13 @@ ClangFormat)
 	;;
 StaticAnalysis)
 	sudo apt-get -q update
-	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
+	sudo apt-get -q -y install coccinelle curl libcurl4-openssl-dev libssl-dev \
 		libexpat-dev gettext make
 	;;
 sparse)
 	sudo apt-get -q update -q
-	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
-		libexpat-dev gettext zlib1g-dev sparse
+	sudo apt-get -q -y install libssl-dev curl libcurl4-openssl-dev \
+		libexpat-dev gettext zlib1g zlib1g-dev sparse
 	;;
 Documentation)
 	sudo apt-get -q update
diff --git a/ci/install-rust-toolchain.sh b/ci/install-rust-toolchain.sh
new file mode 100755
index 000000000000..06a29c4cfa17
--- /dev/null
+++ b/ci/install-rust-toolchain.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+if [ "$CARGO_HOME" = "" ]; then
+  echo >&2 "::error:: CARGO_HOME is not set"
+  exit 2
+fi
+export PATH="$CARGO_HOME/bin:$PATH"
+rustup -vV || exit $?
+
+## Enforce the correct Rust toolchain
+rustup override unset || true
+
+## install a specific version of rust
+if [ "$RUST_TARGET" != "" ]; then
+  rustup default --force-non-host "$RUST_VERSION-$RUST_TARGET" || exit $?
+else
+  rustup default "$RUST_VERSION" || exit $?
+fi
+
+rustc -vV || exit $?
+
+RE_RUST_TARGET="$RUST_TARGET"
+if [ "$RUST_TARGET" = "" ]; then
+  RE_RUST_TARGET="[^ ]+"
+fi
+
+if ! rustup show active-toolchain | grep -E "^$RUST_VERSION-$RE_RUST_TARGET \(default\)$"; then
+  echo >&2 "::error:: wrong Rust toolchain, active-toolchain: $(rustup show active-toolchain)"
+  exit 3
+fi
diff --git a/ci/install-rustup.sh b/ci/install-rustup.sh
new file mode 100755
index 000000000000..0036231aeea7
--- /dev/null
+++ b/ci/install-rustup.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+## github workflows actions-rs/toolchain@v1 doesn't work for docker
+## targets. This script should only be used if the ci pipeline
+## doesn't support installing rust on a particular target.
+
+if [ "$(id -u)" -eq 0 ]; then
+  echo >&2 "::warning:: installing rust as root"
+fi
+
+if [ "$CARGO_HOME" = "" ]; then
+  echo >&2 "::error:: CARGO_HOME is not set"
+  exit 2
+fi
+
+export RUSTUP_HOME=$CARGO_HOME
+
+## install rustup
+curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
+if [ ! -f $CARGO_HOME/env ]; then
+  echo "PATH=$CARGO_HOME/bin:\$PATH" > $CARGO_HOME/env
+fi
+. $CARGO_HOME/env
+
+rustup -vV
diff --git a/ci/lib.sh b/ci/lib.sh
index f561884d4016..a7992b22fdc9 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,6 @@
 # Library of functions shared by all CI scripts
 
+
 if test true = "$GITHUB_ACTIONS"
 then
 	begin_group () {
diff --git a/ci/make-test-artifacts.sh b/ci/make-test-artifacts.sh
index 74141af0cc74..e37ed7030cdf 100755
--- a/ci/make-test-artifacts.sh
+++ b/ci/make-test-artifacts.sh
@@ -7,6 +7,15 @@ mkdir -p "$1" # in case ci/lib.sh decides to quit early
 
 . ${0%/*}/lib.sh
 
+## ensure rustup is in the PATH variable
+if [ "$CARGO_HOME" = "" ]; then
+  echo >&2 "::error:: CARGO_HOME is not set"
+  exit 2
+fi
+export PATH="$CARGO_HOME/bin:$PATH"
+
+rustc -vV
+
 group Build make artifacts-tar ARTIFACTS_DIRECTORY="$1"
 
 check_unignored_build_artifacts
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 01823fd0f140..22b61e2812db 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -5,6 +5,15 @@
 
 . ${0%/*}/lib.sh
 
+## ensure rustup is in the PATH variable
+if [ "$CARGO_HOME" = "" ]; then
+  echo >&2 "::error:: CARGO_HOME is not set"
+  exit 2
+fi
+. $CARGO_HOME/env
+
+rustc -vV || exit $?
+
 run_tests=t
 
 case "$jobname" in
@@ -72,5 +81,9 @@ case "$jobname" in
 	;;
 esac
 
+if [ -d "$CARGO_HOME" ]; then
+  rm -rf $CARGO_HOME
+fi
+
 check_unignored_build_artifacts
 save_good_tree
-- 
gitgitgadget

