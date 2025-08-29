Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4834244679
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496549; cv=none; b=r6rHvIy51HFfVaf+MS6GP1vdw9fQrnOwcZgrfuZNjF+CyvU1z1YaBYD7Swbb7dwTIkcTQDWlrd92mOXjtGxFMG1JNcxABryjZUatEltM6BeNYxuGRam3NbqL1YCe+B3rugnrS9F/zoKpuw65OLw/FOSPfS6eUPB9sXlUt0iqGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496549; c=relaxed/simple;
	bh=TFAnfn597WIcNhA4OZEsVwXWFWSsRDnLteVNrskEOR8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s6VS8YbbPSKZqjTaRZqkQvIG8PnLmOiCgZrp2qXsERJkb42kJVaJ7NFwWdh7QrJvAX9rnzjxKusEmemHG9SJE9RV9Hfj8+lSYHLAtKDub2rs/d+WOoirdzkzcQ+26lN26GAiI6dPfH9YB7BYRY8iHHbVQKw6MI+sL04Qw6AEkig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRbnYRSe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRbnYRSe"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445824dc27so21712295ad.3
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496546; x=1757101346; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1erInDUU9OzlOSjItFHWtLlWjkpNpInhJQ1yAFbYFI=;
        b=iRbnYRSeNT3MGImoKvpeJ+s+6YvEpPXsO/O+qJU7tzS+IFXpdUC5vU1wLvJySwN7ti
         Wig+O3ozO69vG3WtE5h3sm1JJ2hzBpIpsDVzxHAek3F/nivyXAhuG7P4aoALF2DY4V9w
         4W46ycLxDg4U6Q91KW7NsxyN9RkhHSrlfX6fWHV3F6aNqbQDXRQQJQeVgYXyJT5Y2T5h
         cl/a5n4Rp79DI1formoFbpDhPNIrS90bRtfNUW4fG6AAWDS+J3+RPjAITPyUrpUH5G8e
         tXF4NXqylPAXyqTCqr25GNwAdOOMsJc8ZS2h4nFhA7XsNQxt58h1tCp/NCl0uyg5uaWi
         2OhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496546; x=1757101346;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1erInDUU9OzlOSjItFHWtLlWjkpNpInhJQ1yAFbYFI=;
        b=ScYnAouBos5Pycsi+KfhNMACXxXICOEJ0c3EQVpU8bLS7bd/+FoNnj/CgbOVoW9rn5
         ygBQRJYWCSOS+9mG7MfN/nNuQg9hGmU2bFvlLDt3nHLEPmFLKlPzITVY8snSSN+YutRa
         i7zr/8obUcWUDg+h1xiNfZpSVEMK1TXJDWFgWuNnbU2R04Nb/Y41LJeNfvWM0QwaIR+V
         Qd2VMAz4BqAny7iZ7UmD+fHWEqUcU0sZmGKXVR05oqot26KxYVxbACZXt5c7MCSdpqSt
         yqsYX9F0zOk50mEN573wmRqpUe9XuIz6QStAClnc4+x0tz/APAyCKLOXq/ewahVHo2L8
         20KA==
X-Gm-Message-State: AOJu0YyvogzM0lsfnklxbEgaSjc7DIixiiDDD/RZfnPz36LQRN0MNorB
	XNQA5yZkpKEJHA3NsF3cOdnVK6covUaz2aC4jOLwb+rZLZa9AxOi2ZdbrtVj5A==
X-Gm-Gg: ASbGncteSakirwDpXufXh7SOgHYeHzgCc/w0fQUpDxdj/oGOHh2i97jp50uyVnYH62M
	q1e3LcU1F5RTmLhtf+5D37PQ8mXFJfNba1nisQkOe4/Lu8tDtXMbM/S4A8kCZvgSb6ywlGe04G5
	eialjsy7tJHPUgJEZ5ciFDsFBXSFwD3M/NCyekFJ/oidwWdxURgBESsR/P5iGhVv1rQGRqfK6yx
	FeO/93ePx34Ti7d+DccRS/c0JDss7sXwM2NdsibDDHbGbMYijK3I0C1qQW0ehKAJBkWc9XGhLeP
	HvFSGHnWdIKNIN7dSlDH/SY8KuY7e05cTPiavU+JJNP/SmOQkvnUgz/qKnbILdi6xU4DcA/ZNCX
	TyTTydt4jGUrIkdS149Czm+HZU6L8TPmdqhHcjA==
X-Google-Smtp-Source: AGHT+IFRueff3o3P3eTp/9twKDbt+lo3OebWmughWvTNrXiMdgsYsHD5ssIjUDNHBgB6Q2pvPGl+Ow==
X-Received: by 2002:a17:903:1b4b:b0:245:fbf8:dd0b with SMTP id d9443c01a7336-2462efd4ec2mr385249385ad.57.1756496545663;
        Fri, 29 Aug 2025 12:42:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da472bsm32948875ad.66.2025.08.29.12.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:25 -0700 (PDT)
Message-Id: <6c47401ba00d7eabce4a74a47a495c9b23f52ee7.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:07 +0000
Subject: [PATCH 03/15] github workflows: install rust
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
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
 .github/workflows/main.yml   | 60 +++++++++++++++++++++++++++++++++++-
 ci/install-dependencies.sh   | 14 ++++-----
 ci/install-rust-toolchain.sh | 30 ++++++++++++++++++
 ci/install-rustup.sh         | 25 +++++++++++++++
 ci/lib.sh                    |  1 +
 ci/make-test-artifacts.sh    |  9 ++++++
 ci/run-build-and-tests.sh    | 13 ++++++++
 7 files changed, 144 insertions(+), 8 deletions(-)
 create mode 100755 ci/install-rust-toolchain.sh
 create mode 100755 ci/install-rustup.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 7dbf9f7f12..ac1d583ab2 100644
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
@@ -409,6 +459,7 @@ jobs:
       CC: ${{matrix.vector.cc}}
       CI_JOB_IMAGE: ${{matrix.vector.image}}
       CUSTOM_PATH: /custom
+      CARGO_HOME: /home/builder/.cargo
     runs-on: ubuntu-latest
     container: ${{matrix.vector.image}}
     steps:
@@ -433,6 +484,13 @@ jobs:
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
index d061a47293..7801075821 100755
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
index 0000000000..06a29c4cfa
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
index 0000000000..0036231aee
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
index f561884d40..a7992b22fd 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,6 @@
 # Library of functions shared by all CI scripts
 
+
 if test true = "$GITHUB_ACTIONS"
 then
 	begin_group () {
diff --git a/ci/make-test-artifacts.sh b/ci/make-test-artifacts.sh
index 74141af0cc..e37ed7030c 100755
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
index 01823fd0f1..22b61e2812 100755
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

