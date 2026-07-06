Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3B3DCD99
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378344; cv=none; b=FoCnWH5gl43Nho8MC9yI+z0RKM1EIGe+tSWFn8PxzOuEQuS8xo3XZctKJvFjH6mPdMyPxYvABltCeMaW849AE3tJRXBax2D9Kzzj3aAdOj6BKAj/Ff8KsJB+EmoPToU2NaSd63xF+chQL+5N6z4a6Vd3d125nzPKvE7RhT5o2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378344; c=relaxed/simple;
	bh=cuU8RC3W9Lk/hrx95nyzvsyc0i49Cy+2TnOdhozT9+g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=grwEYI7KsUZvmOvnQLkDfVbha2teQIcSusvOTkDyHCl4jNtHv4U21bhBEhahRHVs2G/QX82QXQWMAUsPego4XboTbRwHH0bTNL+O2faKAghlToqiUWuIVdC8Ai2XbG8BOmyXKnOpPXm8VhO10entRAinAGQ/7qk7uPmBnaum8o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3HBp5t7; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3HBp5t7"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c1805b8a7so41127391cf.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783378342; x=1783983142; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUTcY/V2NbDHBGxFvmbXYYnLSIhm4RzPzbJApRVr2GU=;
        b=J3HBp5t7twB4fJVG6sigc6Wqgx9neW5MfFcSiYTnmuZZMLNEN26ZYGVC5uivnTZ+bW
         xreGkpz3rHDTmHY5o4QZTvtNABTGQ7fN2RUWJH4TQc36qWjIeTMGdpQlSuT0cE4YJN8M
         ZA/Y5tzkCTeT7q95DdlGqApGIYGxR4ipd37cJzZJaj6ZQU5bK/AfycjiZauEeRXKyGTp
         5CJux3S6Mp8dmeXB01rTiF7VZSRCFNBW2arsLFYudcVaWFO4pN6bDWJcLaTMkJP7X/js
         AFbPwh3+Iq7xuU49cccmgCqd4z4KBUtaix7dhN28VOfyvWjyKNLkxBoXR6uxiDlwiHVE
         6drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783378342; x=1783983142;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sUTcY/V2NbDHBGxFvmbXYYnLSIhm4RzPzbJApRVr2GU=;
        b=A+aRidKMIVQbsW1fiCmRfJyr7F/vGJr3f07hvxLTxFCpN7e1+42GmuMsmrpr8v9T+n
         Kz7XhUB+nNA5zg0ezaeemBTsMKhfYAGZpBybrSVFozYa5c1Cc4DcLIhR/SML9i+SHkqm
         dmVAW0PdSy16ny5fJ0FMZKoNx/gQmwop5jMbSfgmjAVyUUn2azuzTyeJvsa6utNCJSNx
         Hp5SU5NqtH8BsLDGqndJK5zrG9FvRjUrh/eJyzhfVNx3h4UT+oG/Gr0xhvU/Q6o7/PcX
         2VNkjkBVnt8gsopB/olo2ewivru/B5IJacFr7LJongGnIJQwBuVrGaqZ1HIz8rNwtRDB
         zS8w==
X-Gm-Message-State: AOJu0YxBO6fpHEHCZ5Aj1kXWGE1bohjW/va4F4BVbRKcBTBNGLF6yso8
	myJIqwtmhHilHi8dkFOBFODgkCEhjs4K1AMnLtSWZDcaUzudbZtpGRuKlhQ+JsbD
X-Gm-Gg: AfdE7cn1osLZY/HlFON0vidrmpn2ZPyGHPNj9d6fILQF4YN4LEN9T2gsGIIpp3k0UJc
	7p0CjcOkBx2tiQtSOO6ZJUHpGt2+XDaH0C3Du1RghRK29QlbCZsj54ivC8QdmOUIbAjVi6sctr9
	UcNr3NSl/zz6pG/eiK+LCWdzZWlKkBKW5TUCVlfMp6NDlLKP0k2wb7lzPFy7jApfWU57eedWBZS
	fqlfFamuNMlQYLslzLpqON2b8qYFkJsfxTpkmdgXX0wVIHmG4dFNiIsOwpwwbGyXz0dmtBSPWti
	nnOW9JIbAPLHkhxhW3cIynoyXyV/vYVqKxnh057TvwuxMCvQUhB/jleACc65dlgST8+XtGnpwt7
	ykPGQAjvtnXrXMMvB5WA/T4hQBiJOI8Xt+z6Cf8Ux5KIV62hMOL041BJHXj45NwIfa+bAaoCado
	5B3CgF9OIilKw1zBA=
X-Received: by 2002:a05:622a:138c:b0:51b:ef9c:573c with SMTP id d75a77b69052e-51c7489f71bmr30702621cf.50.1783378341934;
        Mon, 06 Jul 2026 15:52:21 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.72.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b5d704sm109417221cf.12.2026.07.06.15.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:52:20 -0700 (PDT)
Message-Id: <21dedb91f093e9035f25cdf1673ff41976fe68bf.1783378333.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
References: <pull.2288.v5.git.git.1783358097.gitgitgadget@gmail.com>
	<pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 22:52:12 +0000
Subject: [PATCH v6 2/3] Makefile: support universal macOS builds via
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

