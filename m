Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4AD13A86C
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358105; cv=none; b=J3jNEfaUZG/dc9dyAIbZr45ybTUy3CaAt758bLewqpV2RsJ1jGMGIlzSiCJJKlsJgsMGrBVIFBzbUui9EkmZ8N3TrTIVotLr5MWO6+J7P8rvwogd8mbBs8g2OBehP77oMvyWiupB0M3ksPIbW1VILlOkEIm9ntMKo7C8NPD97SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358105; c=relaxed/simple;
	bh=hiWkdWxC5GYvv/od6sJFYqQDLlppl2yN5paut59OQVY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tiX/EHrODMR42ZgEihnzJvIWkAp3t6Aj+cAmEE4f57ZGvvyQ676hwNhCvsyX2T+DXLM7THCuklw1MblbN51lm8XqMO8Moa1lsaslMY0RnNn0Iw/sQp4mNbwemHOg4/1KA/Rxpa/gbYsM13BL6XW/lrPyDglR5sjpDTYXjTFIQOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyzOgqJG; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyzOgqJG"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6a116bd18ebso1593311eaf.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358103; x=1783962903; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=joXLCE22BGNg4P2obVyiXsxOVnryRZ1AScpGXOzyrNQ=;
        b=JyzOgqJGFGBCkhHmYDVAy/kvPR8dcSqkHQBOLYEot495Ax4F6zopDGvLPUKT/MvBo0
         XVGNbXAVafq9DoqeTfdPR2pqyONsnmpmE2LveX5eBUx2vLifKnPM1QsJUrX60KCKjXo+
         c0pZgQ3DpnKvvQvWvZuJV3tndxQ8C6OaTSycOkchK71bG9jLYSTnhM1nJNo1tnk7AvFI
         YqyeRyT9pO5b+ewtGc197ZsjfOYTdIRgvIehrFRgen8rXD2Ji9mOMHm24R34WgGkk6nX
         xbPB0OlIrQ2LGC6Kx8Nw6waOJdyC6BcH4LG3hcmgYAW1tp2Jfk7MctfRAulrT4bRgsKc
         q5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358103; x=1783962903;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=joXLCE22BGNg4P2obVyiXsxOVnryRZ1AScpGXOzyrNQ=;
        b=oaHCvN038sRXSV/EWTHsco5vinDNMDUMSTP7ACbkrVl+YufFJiN78e/C5jAmkw28yu
         k1A54ZjBzMEoensEeH+KHygnvwPCz40L7CQhKSSkAvlItQyJzOatwqvUAhCs4w79QrAU
         U80F1yYpvFUiOfLBvbksgBV+SMN6LbL+EZNt2bX8USiM7DyYOrE/u2FXTEY4/1/1qkat
         ldq+yq+B6i45bcTIK0kpD3JGy7gAFWNI/HMAJuANK/bc+Uj2rAyyB7kHgQc9wuz2NfZp
         FDc1wrLuUCy3zb5qoAvQWCyyDc/twDpbKmV34Be57+ih65riV12qiVbORPI5Ufxrq6Gk
         /iKg==
X-Gm-Message-State: AOJu0YzpkQlcUY54jHvMr3AXxxgWEr5uYejJXKyIjsL8nDXkXFWnG593
	gcN6ZciOEumOIigRmHszsmIFdSe6h8gH5sVaeN3lC0VfAuMNsKHhWyXu/qa2HA==
X-Gm-Gg: AfdE7cm43HV0ojLhjem5xELI3Q04O3b4eB4JDKb5fSoCjBytRhIvDNi//1V+8vi0DeL
	JCjE8DV16ykHAds4aNEgxNS15P1hhEh/c9TSL2EA2ELESjJf/fCxKXQ3t2aP84+3O47a8geOjYI
	AqEilVRhbxFFaSLD7m5Jp1GNkL1HPbp9IbkaPI+ZguWfL6YRclo3CBm+A4LqX/+AbPxgN6rlngR
	2G8Xi1QwzAhAQCEpzMG1VTuK0uQq4l0OrPRqq5SCaRMuHnudxVxvhqwadah5kp+t6r89c8hFthp
	6/t5fBx/2h5oX6dGXN7s4mTW7wbXFRBTw4OtybebcbmQbb78/FKBFiY68T4DuLfQnIrrA/FsfZI
	Om/ZuGUOVFBxcxKNOoVy0uwc/lCIiT7jzZthVHUaRjORz6ZLkXz54jvW0vYS3DFaTVXvQCAWM6P
	ZpA8FtWcFD9kRlOhs=
X-Received: by 2002:a05:6820:6ac6:b0:6a1:8223:4677 with SMTP id 006d021491bc7-6a355516f94mr931118eaf.32.1783358103186;
        Mon, 06 Jul 2026 10:15:03 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.32.69])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb1d011asm11316895fac.8.2026.07.06.10.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:15:02 -0700 (PDT)
Message-Id: <66f71fb0d712f45c51753bde0064a10e57c426f1.1783358097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v5.git.git.1783358097.gitgitgadget@gmail.com>
References: <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
	<pull.2288.v5.git.git.1783358097.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 17:14:57 +0000
Subject: [PATCH v5 2/2] Makefile: support universal macOS builds via
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
index 7f4be97b90..335fd056fa 100644
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
