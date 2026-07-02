Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1934317173
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783030976; cv=none; b=OdYRHWt+n35BHorvZEkMuXl1RgsS38eR0ElKOsKzbL9Y14hFiodSSOguXXudbIHkb1tR7mc12WM0NhGDGyn1KxAm4tqQon4z4jOMBJMYEBx43m+udUeyYjPqTY6F7lpTSk6rp/beBmvZt8/U6EfmhGfJPnFVGZwn1PYMifbjhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783030976; c=relaxed/simple;
	bh=weiXmQNWcs2AnjwKBIyhjH04ZPU3/NPXjv7zK/3AZuw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j3kGgCtTDi6EeEM/gBNddhObgV101h+/nTXRJsKvuZu7xn2ed6L9JbF1pN06EYSwRvdFiCR9csQb9rlsVcnSo+AAnvZdWTBYNxTvAnMaFbXV0+H0Yk/u+MNLn+aGnJVP99ZxThQjUnNOxPZn0f5cdurGzwBAU+WL8xcNdcHiGnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbIrjCjP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbIrjCjP"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e51d3d83cso119349985a.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 15:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783030973; x=1783635773; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMsxeP9pVjqmrjEHMwMEKWb4xTUpyFV6NSfjHzke/PE=;
        b=qbIrjCjPY5w6GHV7f4l5G0M7Hh6ODWR4jvhNbc5waKnN0hPUDxcLe5gHpkVJvNybP1
         SnN+Dp6keMW9uqtAFtnwBJ8hnFZeh1xPu5q/1+hiBAdBW6Q6P9Z8MNMI5FZNq3ps5Yhb
         Zrj/zZljguDWNuUTZWxbWAKfwKf9n+/JVQ/VTfbj/X5vb7iYsmWfCKZQlrYooSsuLAoZ
         FgSrUPNTt/prjnX9Xwvb91rkl3UAtxRRXB5ZsXZ/RLzQE/8H5pG9OmM4vxxnfBr80v7j
         AVmzKUGORdHtBqwlrZckznCCEehmLnfKYHXw2CPCJjN2x8zTbdG8jPdeSSqZvaS8rrJd
         Kp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783030973; x=1783635773;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMsxeP9pVjqmrjEHMwMEKWb4xTUpyFV6NSfjHzke/PE=;
        b=UZVRfJZoJIJ13Y3jCxiMonIHnF6YPVXA/jUvh2s/aGmUqnJmljvdbLUHu6lBKI1okm
         y4sFuVugmWJ6pTlrQyUGKCASFdpkkgmR/zY8KPd3Kypz8dQHb9dKlI6clsTDObQaDiFH
         fSZsvm67xycKIokcBA07z9+HTHa2M46YtYLBVBRRwQR8MiE6km59ilJtA+YPsA8kPlRg
         rGriIW71tYkNksYUj895ThkH/85TZOSVy9sfevT8/BtCv9fwUK2DRzfnzuBjuMN5V1Xe
         QwDlBa5hxB4gNV8qX8nVg5sM1jh5Ypo50qI5QlzVASLn5IGxViGi+n+4twlPgCcP3V37
         YFMA==
X-Gm-Message-State: AOJu0YyhjfwrfEmSxT0o75zI0+Fgbl9Yja8zj0lgnmqVUeSjO5iW9YRB
	q/jE2LIBz/lLZy33dGi/kCY4zPFiYpfwV19ZN2bLTFgnyiO8E84vMzCMY8Zievil
X-Gm-Gg: AfdE7clqBj16XBBMLfDMP/le03WHlWjASLgvL9L3dS1XMfnyYYofWyCtJYL6qeF5EPJ
	BffPEuWWuNmip5u6wOFaVRBbGW19waxBLE/h8uWDy/LMbKPTshv0ib3ZKTsKmpCWKW9p1AVTnYx
	qL89vxr5I3DGZdafg87J8vdCXGhNv42Z2lJzEPGnhESMbdGjy855vJRyQpQnN5TUCWk5s/j3i5a
	qLKOtnaAX7zuU8522Qxjm7gfcYqL2ZyGtc7k1y241PjXBtoRc19cvdoqqsMWeygf62fBzDPFLMA
	S6c6ch+cC5tV0H3lHk7753lj75WWRoym5RaxD924sDqMumTAstOXMitxyeZLddeu7CQVI0boPId
	zUbVFszG92/8Ce/PmaMZGVogYWlpsv34/z7iUOSC8RytYRGCjONDwUayXFFoUsYB1RgyqqfJHyt
	/Ou1RIES8vx9hyguq4
X-Received: by 2002:a05:620a:46a6:b0:916:436:1fa3 with SMTP id af79cd13be357-92e782c62f8mr1018297085a.37.1783030973480;
        Thu, 02 Jul 2026 15:22:53 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.103.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e8019e58asm327132685a.40.2026.07.02.15.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:22:51 -0700 (PDT)
Message-Id: <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>
References: <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Jul 2026 22:22:49 +0000
Subject: [PATCH v3 0/2] Makefile: link osxkeychain helper against Rust
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
    Shnatu <snatu@google.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>

Shardul Natu (2):
  Makefile: add $(RUST_LIB) prerequisite to osxkeychain
  Makefile: support universal macOS builds via RUST_TARGETS

 Makefile | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)


base-commit: 602f6c329a7d99df269d382df353b4e1bbbbd8aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2288%2Fkiranani%2Fnext-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2288/kiranani/next-v3
Pull-Request: https://github.com/git/git/pull/2288

Range-diff vs v2:

 -:  ---------- > 1:  41de7d391a Makefile: add $(RUST_LIB) prerequisite to osxkeychain
 1:  6a11aff909 ! 2:  257f5ef42f Makefile: link osxkeychain & support universal Rust
     @@
       ## Metadata ##
     -Author: Shnatu <snatu@google.com>
     +Author: Shardul Natu <snatu@google.com>
      
       ## Commit message ##
     -    Makefile: link osxkeychain & support universal Rust
     +    Makefile: support universal macOS builds via RUST_TARGETS
      
     -    When Rust is enabled, ensure that the git-credential-osxkeychain
     -    helper is linked with the necessary Rust libraries.
     +    On macOS, Universal Binaries contain native executable code for
     +    multiple architectures (such as Intel x86_64 and Apple Silicon arm64)
     +    bundled into a single file. This is standard practice for macOS
     +    distribution and CI packaging (such as internal distribution packages
     +    or tooling like Burrito/Homebrew), allowing a single build artifact
     +    to run natively across all Macs without Rosetta emulation or
     +    maintaining separate packages.
      
     -    Also, introduce native support for macOS Universal Binaries
     -    (multi-architecture builds) in the Git build system by allowing
     -    the user to specify a list of target triples in the RUST_TARGETS
     -    environment variable.
     +    When building Git C code for multiple architectures on macOS, the
     +    Apple toolchain (clang) natively supports universal builds via
     +    CFLAGS/LDFLAGS. When "-arch x86_64 -arch arm64" is passed, clang
     +    automatically compiles and links universal binaries for all C object
     +    files and executables out of the box.
      
     -    To implement this cleanly without complex shell scripting in recipes:
     -      1. We introduce a declarative Make pattern rule (target/%/...) to
     -         compile each target-specific library slice (e.g.,
     -         target/aarch64-apple-darwin/...).
     -      2. We update the $(RUST_LIB) recipe to depend on the list of
     -         compiled target-specific member libraries ($(RUST_MEMBER_LIBS)).
     -      3. On macOS, if multiple targets are specified, we use lipo to
     -         combine them into a single Universal static library at
     -         target/release/libgitcore.a.
     -      4. If only one target is specified, we copy it to the standard
     -         path.
     -      5. We enforce that building for multiple targets requires macOS
     -         (as lipo is only available there), raising a clear make error
     -         on other platforms.
     +    Cargo and rustc, however, do not support multiple "-arch" flags or
     +    emitting universal binaries in a single invocation. Instead, Cargo
     +    requires invoking each target triple independently (e.g., passing
     +    "--target x86_64-apple-darwin" and "--target aarch64-apple-darwin").
      
     -    This is a highly elegant and native Makefile solution that avoids
     -    complex shell scripting in recipes and fully supports macOS Universal
     -    Binaries.
     +    To bridge this gap when Rust is enabled:
     +      1. Allow specifying space-separated target triples in RUST_TARGETS.
     +      2. Introduce declarative pattern rules (target/%/...) to compile
     +         each target-specific library slice via Cargo.
     +      3. On macOS, if multiple targets are specified, use "lipo" (part of
     +         the mandatory Xcode Command Line Tools) to combine the resulting
     +         static libraries into target/release/libgitcore.a.
     +      4. Ensure target directory creation before invoking lipo via
     +         mkdir_p_parent_template.
     +
     +    Once $(RUST_LIB) is compiled into a universal static archive, the
     +    standard C linker seamlessly links it with the C object files to
     +    produce universal Git executables.
      
          Signed-off-by: Shardul Natu <snatu@google.com>
      
     @@ Makefile: include shared.mak
       # == SHA-1 and SHA-256 defines ==
       #
       # === SHA-1 backend ===
     -@@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
     - 
     - LIB_FILE = libgit.a
     +@@ Makefile: LIB_FILE = libgit.a
       
     -+ifndef NO_RUST
     + ifndef NO_RUST
       ifdef DEBUG
      -RUST_TARGET_DIR = target/debug
      +RUST_BUILD_CONFIG = debug
     @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
       else
      -RUST_LIB = $(RUST_TARGET_DIR)/libgitcore.a
      +RUST_LIB_NAME = libgitcore.a
     -+endif
     + endif
      +RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
       endif
       
       GITLIBS = common-main.o $(LIB_FILE)
     -@@ Makefile: scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
     - $(LIB_FILE): $(LIB_OBJS)
     +@@ Makefile: $(LIB_FILE): $(LIB_OBJS)
       	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
       
     -+ifndef NO_RUST
     + ifndef NO_RUST
      +ifeq ($(RUST_TARGETS),)
       $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
       	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
     @@ Makefile: scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
      +	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
      +
      +$(RUST_LIB): $(RUST_MEMBER_LIBS)
     ++	@$(call mkdir_p_parent_template)
      +	$(QUIET_GEN)\
      +	if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
      +		lipo -create $^ -output $@; \
     @@ Makefile: scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
       
       .PHONY: rust
       rust: $(RUST_LIB)
     -+endif
     - 
     - export DEFAULT_EDITOR DEFAULT_PAGER
     - 
     -@@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
     - contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
     - 	$(AR) $(ARFLAGS) $@ $^
     - 
     --contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
     -+# When Rust is enabled, git-credential-osxkeychain depends on Rust symbols in $(RUST_LIB)
     -+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIB) GIT-LDFLAGS
     - 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
     - 		$(filter %.o,$^) $(LIBS) -framework Security -framework CoreFoundation
     - 

-- 
gitgitgadget
