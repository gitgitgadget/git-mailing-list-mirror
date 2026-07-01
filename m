Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832933769E2
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943311; cv=none; b=bG5ZhRs7S9nRPRYuvzTR8vOefZdHYtTWNM+wWVf+Zr40TjTfRi4lKgzLBSn2exZvOavzCfjsAtrdaeoNVkFyTJnZioZHIVneOLqJO/IxjXJRXCsv/svS3ArsV8K1UYtpItDC0ArEOSmbrdxntfsdRxLV4xijNRzBVC8GtmMRnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943311; c=relaxed/simple;
	bh=7Xl67f0Eg/ce/HjGazHyXKhN/PRHJ79C55jj2mcnaOE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nvQBXUvtNf2efK0PrYQBFsAiromkZpxhQBmElTx73vbd8bG2bMdsb4lC8+z77OavAPlVqDLzZJ9OVRdK55BKruLsxVTrG5UryDFqSkvr+opYCKxP7UsREPK60qPNSoVL2+OMOQX2Ignr4e8T7/njLvOHywiAet1EL1yAbt0sqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nly4UR5f; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nly4UR5f"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c1d487f2cso10450251cf.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782943308; x=1783548108; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=47M7wnaW091iEGUATP9MgjPlST6933eu7ca97aXXBsw=;
        b=Nly4UR5fWoBaCv8g316uxTnwz3txhfHy9ElpyXzaLj7uLG9ZCzkQL0fb7YVweELgSN
         hCsdSFzb4oXNf7bJfffCWlxO16VIjvVUB1UpxuwNrA7TN1TqFYdmGVkE2wvzbEZBKiAC
         KFmVBsK3q2bR8PlJXZxZo9qUaHPEnk5Y7bPzVKNhZZ0sFS8NV7lY3ybzKfFX76u+76jr
         5OGvQOPIHTLHgLIDRPkAC4A4zP2Y/fkRxJ2TXzHajIjaNJo/+j6eyPvUIpd3t8xV1h54
         YLs3cOzJ+4hnTbtvQG6vgBq/TbYdE8FtKVfKIviPj4eCFL741hWVLMyY50T3LfQ8c+ib
         SHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782943308; x=1783548108;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=47M7wnaW091iEGUATP9MgjPlST6933eu7ca97aXXBsw=;
        b=EMCoDBtVffZ4fex5IBLIzNC4XV2QdJ8fll2t4N7Q86WYV9RaiAG/EACxyDdQUhl0bW
         Ji9CXwFryXHBMwBe8L94qfCYesImxI0HFndlSpyVEBr+DUeIDpbGGyOpCqmpDUSHhTTo
         NDCd07Maglqiqe9j/UTxoZS0/Mfl6Bvx4vvgOeiI6O1zcapmximGl6J35QsFibZZIfEs
         LC7xZ+8jfGwJXMAIsw0j7/zh3cifpfzHUwIrHMXITmN01jEo0gQCCiEqTAdSMnrBrsDH
         dShMQLdV/W/Ycw7k41NQbNolzTfaYeU2ggetfy0RDk996VxKoXHuePMyU/hROjId1SxB
         DCmQ==
X-Gm-Message-State: AOJu0Yw1dx4M4T2CHF39ewjddVtC39D5BrL88hHf1b1kJxOc1FRrA8KA
	e4Uob9eH6s+hBN0JlNlqXbvDeloXozjBnigHF4dov6QZg0yWcA/5IqVC2fkM7A==
X-Gm-Gg: AfdE7clBF75iU+NWfDhmSCcrN5J5c/yoSpUeaMhGNkQmKdHt3mHa4R2ZUpjmXQg464Q
	7OX/NA1VklZtzXX6VLzdYTEO59JjN6KTIlOxLj2Rs2J9HiD/51VGJKn5URKO4sEaZnjONA2O9Rq
	EBOI9fY4i+Eqjj9Q12JOljG6SfqyXq9ze7oxE75adZXvLzNB4V4SaGnnQ6MpuU61qi/4hDLhAUL
	kwkaz1Ciw7Vr9+B8BrUWOHtB/uZvfm07OO0YvNq3X5xaVQg5I7pG2sWKdz0qCiAGB38m6fyyuTA
	IpAfgGkrglroKudUs1sWXmQrw5MVH/L2QsWA2hs0CE0Wc/n2wueWerPiVzDMS6MuDfYsQfDXLz4
	yYFIhGphS46/2oBJp3bgZOxOZsts92jNwq22QYxro4r13nlxF7uYPzFoAPSHTfUKJdmR6Onqbnh
	Im3q2uKo3CmGF9yqO3
X-Received: by 2002:a05:622a:1186:b0:51c:1ec5:d11 with SMTP id d75a77b69052e-51c2ad275d0mr33777401cf.19.1782943305598;
        Wed, 01 Jul 2026 15:01:45 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c30c67294sm1635651cf.30.2026.07.01.15.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:01:45 -0700 (PDT)
Message-Id: <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com>
References: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 22:01:43 +0000
Subject: [PATCH v2] Makefile: link osxkeychain & support universal Rust
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
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Shnatu <snatu@google.com>

From: Shnatu <snatu@google.com>

When Rust is enabled, ensure that the git-credential-osxkeychain
helper is linked with the necessary Rust libraries.

Also, introduce native support for macOS Universal Binaries
(multi-architecture builds) in the Git build system by allowing
the user to specify a list of target triples in the RUST_TARGETS
environment variable.

To implement this cleanly without complex shell scripting in recipes:
  1. We introduce a declarative Make pattern rule (target/%/...) to
     compile each target-specific library slice (e.g.,
     target/aarch64-apple-darwin/...).
  2. We update the $(RUST_LIB) recipe to depend on the list of
     compiled target-specific member libraries ($(RUST_MEMBER_LIBS)).
  3. On macOS, if multiple targets are specified, we use lipo to
     combine them into a single Universal static library at
     target/release/libgitcore.a.
  4. If only one target is specified, we copy it to the standard
     path.
  5. We enforce that building for multiple targets requires macOS
     (as lipo is only available there), raising a clear make error
     on other platforms.

This is a highly elegant and native Makefile solution that avoids
complex shell scripting in recipes and fully supports macOS Universal
Binaries.

Signed-off-by: Shardul Natu <snatu@google.com>
---
    Makefile: link osxkeychain helper against Rust

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2288%2Fkiranani%2Fnext-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2288/kiranani/next-v2
Pull-Request: https://github.com/git/git/pull/2288

Range-diff vs v1:

 1:  57046d2f78 ! 1:  6a11aff909 Makefile: link osxkeychain helper against Rust
     @@ Metadata
      Author: Shnatu <snatu@google.com>
      
       ## Commit message ##
     -    Makefile: link osxkeychain helper against Rust
     +    Makefile: link osxkeychain & support universal Rust
      
          When Rust is enabled, ensure that the git-credential-osxkeychain
          helper is linked with the necessary Rust libraries.
      
     -    Introduce the RUST_LIBS variable inside ifndef NO_RUST block
     -    to hold the Rust library dependency, and use it in the helper's
     -    build target. This cleanly handles cases where Rust is disabled,
     -    making it a no-op and avoiding any build failures on systems
     -    without Cargo.
     +    Also, introduce native support for macOS Universal Binaries
     +    (multi-architecture builds) in the Git build system by allowing
     +    the user to specify a list of target triples in the RUST_TARGETS
     +    environment variable.
      
     -    This addresses reviewer feedback from internal CL 910223487
     -    by simplifying the variables and avoiding confusing "LINK"
     -    terminology.
     +    To implement this cleanly without complex shell scripting in recipes:
     +      1. We introduce a declarative Make pattern rule (target/%/...) to
     +         compile each target-specific library slice (e.g.,
     +         target/aarch64-apple-darwin/...).
     +      2. We update the $(RUST_LIB) recipe to depend on the list of
     +         compiled target-specific member libraries ($(RUST_MEMBER_LIBS)).
     +      3. On macOS, if multiple targets are specified, we use lipo to
     +         combine them into a single Universal static library at
     +         target/release/libgitcore.a.
     +      4. If only one target is specified, we copy it to the standard
     +         path.
     +      5. We enforce that building for multiple targets requires macOS
     +         (as lipo is only available there), raising a clear make error
     +         on other platforms.
      
     -    Signed-off-by: Shnatu <snatu@google.com>
     +    This is a highly elegant and native Makefile solution that avoids
     +    complex shell scripting in recipes and fully supports macOS Universal
     +    Binaries.
     +
     +    Signed-off-by: Shardul Natu <snatu@google.com>
      
       ## Makefile ##
     -@@ Makefile: ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
     - ifndef NO_RUST
     - BASIC_CFLAGS += -DWITH_RUST
     - GITLIBS += $(RUST_LIB)
     -+RUST_LIBS = $(RUST_LIB)
     +@@ Makefile: include shared.mak
     + #
     + # Building Rust code requires Cargo.
     + #
     ++# Define RUST_TARGETS if you want to cross-compile. If left unspecified, it uses
     ++# the default rust target on the system.
     ++#
     ++# On macOS, this supports specifying multiple targets, separated by a space.
     ++# This will produce a Universal static library using `lipo`.
     ++#
     ++# Example: RUST_TARGETS="aarch64-apple-darwin x86_64-apple-darwin"
     ++#
     + # == SHA-1 and SHA-256 defines ==
     + #
     + # === SHA-1 backend ===
     +@@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
     + 
     + LIB_FILE = libgit.a
     + 
     ++ifndef NO_RUST
     + ifdef DEBUG
     +-RUST_TARGET_DIR = target/debug
     ++RUST_BUILD_CONFIG = debug
     + else
     +-RUST_TARGET_DIR = target/release
     ++RUST_BUILD_CONFIG = release
     + endif
     + 
       ifeq ($(uname_S),Windows)
     - EXTLIBS += -luserenv
     +-RUST_LIB = $(RUST_TARGET_DIR)/gitcore.lib
     ++RUST_LIB_NAME = gitcore.lib
     + else
     +-RUST_LIB = $(RUST_TARGET_DIR)/libgitcore.a
     ++RUST_LIB_NAME = libgitcore.a
     ++endif
     ++RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
       endif
     + 
     + GITLIBS = common-main.o $(LIB_FILE)
     +@@ Makefile: scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
     + $(LIB_FILE): $(LIB_OBJS)
     + 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
     + 
     ++ifndef NO_RUST
     ++ifeq ($(RUST_TARGETS),)
     + $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
     + 	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
     ++else
     ++ifneq ($(words $(RUST_TARGETS)),1)
     ++ifneq ($(uname_S),Darwin)
     ++$(error Building universal Rust libraries requires macOS (lipo is not available on $(uname_S)))
     ++endif
     ++endif
     ++
     ++RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
     ++$(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
     ++	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
     ++
     ++$(RUST_LIB): $(RUST_MEMBER_LIBS)
     ++	$(QUIET_GEN)\
     ++	if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
     ++		lipo -create $^ -output $@; \
     ++	else \
     ++		cp $< $@; \
     ++	fi
     ++endif
     + 
     + .PHONY: rust
     + rust: $(RUST_LIB)
     ++endif
     + 
     + export DEFAULT_EDITOR DEFAULT_PAGER
     + 
      @@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
       contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
       	$(AR) $(ARFLAGS) $@ $^
       
      -contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
     -+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIBS) GIT-LDFLAGS
     ++# When Rust is enabled, git-credential-osxkeychain depends on Rust symbols in $(RUST_LIB)
     ++contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIB) GIT-LDFLAGS
       	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
     --		$(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework Security -framework CoreFoundation
     -+		$(filter %.o,$^) $(LIB_FILE) $(RUST_LIBS) $(EXTLIBS) -framework Security -framework CoreFoundation
     + 		$(filter %.o,$^) $(LIBS) -framework Security -framework CoreFoundation
       
     - contrib/credential/osxkeychain/git-credential-osxkeychain.o: contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
     - 	$(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<


 Makefile | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 1f3f099f5c..8d49ecc897 100644
--- a/Makefile
+++ b/Makefile
@@ -500,6 +500,14 @@ include shared.mak
 #
 # Building Rust code requires Cargo.
 #
+# Define RUST_TARGETS if you want to cross-compile. If left unspecified, it uses
+# the default rust target on the system.
+#
+# On macOS, this supports specifying multiple targets, separated by a space.
+# This will produce a Universal static library using `lipo`.
+#
+# Example: RUST_TARGETS="aarch64-apple-darwin x86_64-apple-darwin"
+#
 # == SHA-1 and SHA-256 defines ==
 #
 # === SHA-1 backend ===
@@ -939,16 +947,19 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 
+ifndef NO_RUST
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
+endif
+RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
 endif
 
 GITLIBS = common-main.o $(LIB_FILE)
@@ -3019,11 +3030,33 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+ifndef NO_RUST
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
+	$(QUIET_GEN)\
+	if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
+		lipo -create $^ -output $@; \
+	else \
+		cp $< $@; \
+	fi
+endif
 
 .PHONY: rust
 rust: $(RUST_LIB)
+endif
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
@@ -4074,7 +4107,8 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
 	$(AR) $(ARFLAGS) $@ $^
 
-contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
+# When Rust is enabled, git-credential-osxkeychain depends on Rust symbols in $(RUST_LIB)
+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIB) GIT-LDFLAGS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS) -framework Security -framework CoreFoundation
 

base-commit: 43192e7977f5f05138abcdb3212a3f87ab513bef
-- 
gitgitgadget
