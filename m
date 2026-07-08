Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DD369D53
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783480886; cv=none; b=PPzuTKHFoSftqEGr8/JnRCED7UMrYu9ZWfYOxKNcHJU/TvpqnOmWcAMYE1cAV3UrZ2dMiqJeIi8vsUO4UztkCdiw8GGk1xzycGT+Ocg3cYzaKERvcGJw10+rtcV3w92rRy11Pqphifk4wS/G/52m8+zuSX9Wfiz2MEAUt2sdz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783480886; c=relaxed/simple;
	bh=cuU8RC3W9Lk/hrx95nyzvsyc0i49Cy+2TnOdhozT9+g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oReco5EBBhdny9PzIn72SJt1AZpWcrKva8hzaDOxSx0uMSqXCdipwKf+/rUBddJ1DmFdxp7/Nftl5M13te1ZXOIPeSdEXuWsquFlBTO8J4h3ghkClGJPoubJ8ZQQwL0cqSZNFkgTX1bTIB7jYSJgQW3cmWjKzSKtKYBxB2mD7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XopoCUyk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XopoCUyk"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c2808dbc3so808461cf.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 20:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783480884; x=1784085684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUTcY/V2NbDHBGxFvmbXYYnLSIhm4RzPzbJApRVr2GU=;
        b=XopoCUykYsPxo1J2IxRRp73ysJ0rC3BAjvzC2tbFjnp0UatnS6mIjLC3LTLRCvYJRa
         YOADoPpQXbWjON2w/1tWPL75yArk5VWDVDWpqthfe0EFHTcrccb1D65ohKhaOK2RdfkW
         Yn36wwLsxzDFuyZS/pmmJ5KcAWsjHMrS4XKsBOynL9/0dp560vVXHihfJEy8UbQpiFk6
         rXjYqB0G+e0edFZKEADX9ZdN9nVI6EvR+JdeGDKSd8+QR+5V1H8LkXcfX2LCQmkYDxxa
         kjHAoB/n4d31jOd6tvRIP+5k7z5F1XQdj4aPnsY/JwfYFr0rJGpDlegSrTS9cahOdp1z
         16ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783480884; x=1784085684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sUTcY/V2NbDHBGxFvmbXYYnLSIhm4RzPzbJApRVr2GU=;
        b=iIx8Wz4XR+OXX/BJBWC0dD7/EDNUQn3KQEDVAbgk1UK+A1mxVesog6CVjElk0XM9rm
         KfoT5fwiIibpo0MGl3GMgRH/isfpo0kv7IdF2B9/B3DGL9Rzu8/QxKY31OMxCttrCR3G
         IcYPLb4IKPGZGujlUqOUS/ZeV5cCwyU25mP3jP+7gNM9nCINhv4fCXzcJHNfgJxJ+8Ra
         XQPp4ecj2dswIuJzXd77iH300YeWS6Z6+c0pXC74tGzR2pu574Zfb/Ops7UkvSbcz892
         mOBvHY1BLpQkAWU8B8Usnex9qiI2xoFO2oHXRCk3NPyd6CoHeQ35rhH9h1vT4PN19x46
         Q6mA==
X-Gm-Message-State: AOJu0Yx/57zA9UvByhJq0ksGC+N8ssyfMj6Derme2fgevrE7mMtGaULQ
	7wZPF0/d07yNpY0GgwDgQMWRmaREoBQ8HC0taQokHtVMdEuiYyOVy9a5DrqmM7f+
X-Gm-Gg: AfdE7cnqX0hC7IdA+35/Zb0rCIImqDPCTeZoCj72bNzYZThiaE8CztL1CwBT+qT4zUG
	bOvuYw5SHH8OPY4BGBPDrLoAXsNnPOD4zPHEuuYMK4eZxsmnbqxhqDQjbc0cagBoGzBKGVLiIj+
	rM0OkjdqjobkLURUtPQrsaeH/93eER5wN+gLgJDbRQ4omGxKKi7bIz/bEsQC770uNmtoM5SmoMW
	D4fCTV5AEpZuwz9L0+xf3mi1Nhja1aGfDwliWBaslTcnJeH5USQR+H4ehOrVU0D03othaq7/hz8
	3fb4WYTdxsxL1lAYo7GLaqzJKJ1WNhLm8r6JQtP09j2/9pX4WlQum9PcbDfXj3D92g3hVqtSv70
	wg7VyEglqDe+yoPU6tlFOV7UBHrQvRIAC4z5m6Q3shLi67S0BJeCUTmAtsfHQOYqnPE3HqVnufg
	l5XgE4pyWDVkGX9Jc7TA==
X-Received: by 2002:a05:622a:181a:b0:51c:1a17:eba0 with SMTP id d75a77b69052e-51c8b2aded6mr10040891cf.2.1783480883963;
        Tue, 07 Jul 2026 20:21:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.110.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41e084e8sm123427581cf.28.2026.07.07.20.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:21:23 -0700 (PDT)
Message-Id: <a999be6939284e4fdd9781f01fb9b9214ebc6516.1783480879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v8.git.git.1783480879.gitgitgadget@gmail.com>
References: <pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
	<pull.2288.v8.git.git.1783480879.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 03:21:18 +0000
Subject: [PATCH v8 2/3] Makefile: support universal macOS builds via
 RUST_TARGETS
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Shardul Natu <snatu@google.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Patrick Steinhardt <ps@pks.im>,
    Shardul Natu <shardul.27591@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Shardul Natu <snatu@google.com>

From: Shardul Natu <snatu@google.com>

On macOS, Universal Binaries contain native executable code for
multiple architectures (such as Intel x86_64 and Apple Silicon arm64)
bundled into a single file. This is standard practice for macOS
distribution and CI packaging (such as internal distribution packages
or tooling like Burrito/Homebrew), allowing a single build artifact
to run natively across all Macs without Rosetta emulation or
maintaining separate packages.

When building Git C code for multiple architectures on macOS, the
Apple toolchain (clang) natively supports universal builds via
CFLAGS/LDFLAGS. When "-arch x86_64 -arch arm64" is passed, clang
automatically compiles and links universal binaries for all C object
files and executables out of the box.

Cargo and rustc, however, do not support multiple "-arch" flags or
emitting universal binaries in a single invocation. Instead, Cargo
requires invoking each target triple independently (e.g., passing
"--target x86_64-apple-darwin" and "--target aarch64-apple-darwin").

To bridge this gap when Rust is enabled:
  1. Allow specifying space-separated target triples in RUST_TARGETS.
  2. Introduce declarative pattern rules (target/%/...) to compile
     each target-specific library slice via Cargo.
  3. On macOS, if multiple targets are specified, use "lipo" (part of
     the mandatory Xcode Command Line Tools) to combine the resulting
     static libraries into target/release/libgitcore.a.

Once $(RUST_LIB) is compiled into a universal static archive, the
standard C linker seamlessly links it with the C object files to
produce universal Git executables.

Signed-off-by: Shardul Natu <snatu@google.com>
---
 Makefile | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 7db38ecce9..9921af992b 100644
--- a/Makefile
+++ b/Makefile
@@ -500,6 +500,14 @@ include shared.mak
 #
 # Building Rust code requires Cargo.
 #
+# Define RUST_TARGETS if you want to cross-compile. If left unspecified, it uses
+# the default Rust target on the system.
+#
+# On macOS, this supports specifying multiple targets, separated by a space.
+# This will produce a Universal static library using `lipo`.
+#
+# Example: RUST_TARGETS="aarch64-apple-darwin x86_64-apple-darwin"
+#
 # == SHA-1 and SHA-256 defines ==
 #
 # === SHA-1 backend ===
@@ -941,16 +949,17 @@ LIB_FILE = libgit.a
 
 ifndef NO_RUST
 ifdef DEBUG
-RUST_TARGET_DIR = target/debug
+RUST_BUILD_CONFIG = debug
 else
-RUST_TARGET_DIR = target/release
+RUST_BUILD_CONFIG = release
 endif
 
 ifeq ($(uname_S),Windows)
-RUST_LIB = $(RUST_TARGET_DIR)/gitcore.lib
+RUST_LIB_NAME = gitcore.lib
 else
-RUST_LIB = $(RUST_TARGET_DIR)/libgitcore.a
+RUST_LIB_NAME = libgitcore.a
 endif
+RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
 endif
 
 GITLIBS = common-main.o $(LIB_FILE)
@@ -3022,8 +3031,30 @@ $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
 ifndef NO_RUST
+ifeq ($(RUST_TARGETS),)
 $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
 	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
+else
+ifneq ($(words $(RUST_TARGETS)),1)
+ifneq ($(uname_S),Darwin)
+$(error Building universal Rust libraries requires macOS (lipo is not available on $(uname_S)))
+endif
+endif
+
+RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
+$(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
+	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
+
+$(RUST_LIB): $(RUST_MEMBER_LIBS)
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)\
+	if test $(words $(RUST_TARGETS)) -gt 1; \
+	then \
+		lipo -create $^ -output $@; \
+	else \
+		cp $< $@; \
+	fi
+endif
 
 .PHONY: rust
 rust: $(RUST_LIB)
-- 
gitgitgadget

