Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD525782D
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378340; cv=none; b=DHsNbXQCA8EjHS/4L4DOn+yaBXO4jf17mqZbA0SMTV8g658gZoVLX5uIwEa1gjuF1yhpG69Nl2KltXr1lLy0E6ydRj2Uyt/NVRGo5z+UqwP9Cpxbqze2KAQzYpsdhQP8X09QaC0L1oBASdZI1kXlr5m2DdQLUpfX0glKPclbQh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378340; c=relaxed/simple;
	bh=aT8vRggQxqvPozXZShk3V8oeDx2mAy8yYrsosVUh+xo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B7Y/h4vsFaKpIRzDQ7ZasoU5QHewmk2xGRCQig5ELmY8S751KCUu0HGoDeEdROLN0KzK2c1vIKCTW+TZ8AGEYBd+ElAJLyH2qFM9920q4yPKro+4M0h2j1RHCGL9og0qARpV98O93mMlyM+Qv10OuacopAnMgEfvMeg5JrNBVus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiDhgeVH; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiDhgeVH"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c5382806fso24833871cf.2
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783378337; x=1783983137; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bAIGkNivCUgOvc1J6l+a3O+CQrN3hmimln0GmmL9Mr8=;
        b=NiDhgeVHSiTwS+w5t54t+LDEjYtrS2TILSD1H0jZZ6clTGSCagQXZ5rPWSs5PJkKiH
         T/PMPXdcHURy9eJmcNF10BLMeB8wuo3S7q4Er1s12Cet6wbEj+XPPQATeECoSeqL2DgA
         d/yJ+PBawre49NeY4hghhgYomMXxuVuCXGu7w7eHbRiAl86rjIYArZwuHTd26LDIoWut
         /L8gj3sh13EcNepbk6r8tDpgC5BXV4b4mMzZU+h0dyiWtM7/Hg+i9OJL4LU7Pe862gjZ
         qeJ0UhTPgo79u67L4+yqhDHDQ7BvTOTM5OP0YbleWaK4AqLiKTNWoLb2FYCPl/6yNVfE
         jP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783378337; x=1783983137;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bAIGkNivCUgOvc1J6l+a3O+CQrN3hmimln0GmmL9Mr8=;
        b=CiqsYYZMqnvWxI+PaB6ZeP8qvsyGuAlfJ6pZCRnBpE7bj7Fg9FuegUBl6uBVQEhxLP
         WTVujJXdY6wcOkR29UaxRzAZaXpPCkAQrtrzxnqQ6kew2YAms8izk0qwJEGzORhZtq4/
         Ey4upJfNWN4gx22bIxkOa6TI9F7+oc7J54KCEhZm68Ar/TdYj3AcnkVCqWZpuSa58Va7
         Fwg9RS8TYGM4vrv0dYzbZOZdwl9T/zgphVD2gViaLsC5Gg4cgXlbXcC6KwPq889t8mQK
         H5k1er9yptu51G6MPl7632Cz002KryUnh8vrE/rU2LvLLga95SZFSE33MR2kclxQeFaF
         Gjdg==
X-Gm-Message-State: AOJu0YwJTkpv821ULyaQGoitRe2+0fDrjnIzvWrTKpcBtat/cEfbuF7a
	WuKF7Yxd/q8GOIQniFPMrQbC47Cssa1sHcUicZLtojn7ENioZhRt7WOnnGmLb7OK
X-Gm-Gg: AfdE7cn+z8pPy/kLnXSzDpqGMqt/TWXNYUgezTjdRPjdckM+5IGIM1kGjW1kNBiIpOD
	6iwR7roJexalzbh2J0KcQqP6eyoaLqZ644/FHwPjinyfLr4qGNC8q7H52+a86fGSjF0MiXSXXN0
	rc2RMGdFUFVDpp8OkilQOv7kg8Td+GtbPvG3fVlQ6UPZtFbp+9iNMrp2pxNffmdYKTNzHPelAcE
	QkiqK3ionVpskRNdoNTpWha0dIRESKshf5SD3xP6Xk5NJb1RgbHN4vg1uN7HoygPfC5CATAwfMo
	XVYgS3IirLOxy177STYFkvpLQhmsALAHZzztrQES4aid3TPOLk1EUyT6RDVN3B14Tkjgd++nI1i
	psH7eet/oHXkhDR3UlXNtWYa33yLaiGRq02uQptUBZLFlrjZ1/U6UdOMkYW6FHcr096s59p+YJ8
	kg3Br8HgrhQAqjYQU=
X-Received: by 2002:ac8:5854:0:b0:517:c6b1:bffa with SMTP id d75a77b69052e-51c748b0ac5mr29737331cf.48.1783378337491;
        Mon, 06 Jul 2026 15:52:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.72.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b281c9sm101953131cf.9.2026.07.06.15.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:52:15 -0700 (PDT)
Message-Id: <pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v5.git.git.1783358097.gitgitgadget@gmail.com>
References: <pull.2288.v5.git.git.1783358097.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 22:52:10 +0000
Subject: [PATCH v6 0/3] Makefile: link osxkeychain helper against Rust
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
    Ben Knoble <ben.knoble@gmail.com>

This series improves macOS build reliability, automated CI verification, and
distribution support when Rust is enabled in the Git build system. It
addresses three distinct challenges: a parallel build race condition in
git-credential-osxkeychain, support for macOS Universal Binaries
(multi-architecture distribution), and missing automated CI test wiring for
macOS contrib utilities.


Why This Series is Needed
=========================

 1. Parallel Build Race Condition (make -j): While commit 522ea8ef7d
    ("osxkeychain: fix build with Rust") updated the link command for
    git-credential-osxkeychain to pass $(LIBS), it omitted $(RUST_LIB) from
    the target prerequisite list. When running a parallel build (make -j)
    from a clean working tree, Make can attempt to link
    git-credential-osxkeychain before Cargo has finished compiling
    libgitcore.a, causing linker failures.

 2. macOS Universal Binary (lipo) Support: On macOS, Universal Binaries
    bundle native executable code for multiple architectures (Intel x86_64
    and Apple Silicon arm64) into a single file. This is standard practice
    for macOS distribution and CI packaging (such as Burrito, Homebrew, and
    Git's macOS CI runners), allowing a single artifact to run natively
    across all Macs without Rosetta translation.

While Apple's C compiler (clang) natively supports universal builds by
passing -arch x86_64 -arch arm64 in CFLAGS and LDFLAGS, Cargo and rustc do
not support multiple -arch flags in a single invocation. Instead, Cargo must
be invoked separately for each target triple (--target x86_64-apple-darwin
and --target aarch64-apple-darwin). This series bridges that gap.

 3. Automated CI Verification for Contrib on macOS: When running make test
    with TEST_CONTRIB_TOO=yes (default in macOS CI workflows), $(MAKE) -C
    contrib/ test is invoked. However, contrib/Makefile only invoked tests
    for diff-highlight and subtree, meaning git-credential-osxkeychain was
    never compiled or verified during standard CI test runs.


Overview of Patches
===================

 * Patch 1: Makefile: add $(RUST_LIB) prerequisite to osxkeychain Adds
   $(RUST_LIB) as a prerequisite dependency to the osxkeychain target,
   eliminating the parallel build race condition. Additionally, wraps the
   definitions of $(RUST_LIB) and the rust build target in ifndef NO_RUST so
   that disabling Rust cleanly makes the dependency a no-op.

 * Patch 2: Makefile: support universal macOS builds via RUST_TARGETS Allows
   users to specify space-separated target triples in RUST_TARGETS.
   Introduces declarative pattern rules (target/%/...) to compile each
   target slice via Cargo, and uses lipo (part of the mandatory Xcode
   Command Line Tools) to combine the resulting static archives into a
   universal library at target/release/libgitcore.a. Uses
   mkdir_p_parent_template to guarantee directory creation before lipo.
   
   * Patch 3: contrib: wire up osxkeychain in contrib/Makefile on macOS Adds
     a test target to contrib/credential/osxkeychain/Makefile that depends
     on building git-credential-osxkeychain. Introduces a generic OS_CONTRIB
     variable in contrib/Makefile to conditionally wire
     credential/osxkeychain into all, test, and clean whenever running on
     macOS (Darwin). This guarantees that standard CI test runs on macOS
     automatically compile and link the helper, preventing build
     regressions.

Changes since v5:

 * Reverted Patch 1 to depend explicitly on $(LIB_FILE) $(RUST_LIB) rather
   than $(GITLIBS). Unlike Git builtins or scalar (which define cmd_main()),
   git-credential-osxkeychain.c defines its own standalone main(), meaning
   $(GITLIBS) caused a duplicate symbol error for _main during linking.
 * Added Patch 3 ("contrib: wire up osxkeychain in contrib/Makefile on
   macOS") using a scalable OS_CONTRIB variable so that running make test
   with TEST_CONTRIB_TOO=yes in macOS CI workflows automatically verifies
   compilation and linking integrity.

Changes since v4:

 * Changed the osxkeychain prerequisite dependency from $(LIB_FILE)
   $(RUST_LIB) to $(GITLIBS) to match the canonical prerequisite pattern
   used by all other core Git targets linking $(LIBS).

Changes since v3:

 * Removed leading @ from $(call mkdir_p_parent_template) so it relies on
   the built-in $(QUIET_MKDIR_P_PARENT) behavior, matching existing Makefile
   conventions.
 * Replaced if [ with if test in Bourne shell recipe snippets to strictly
   adhere to the project's CodingGuidelines.

Changes since v2:

 * Split the original combined commit into a two-patch series to separate
   prerequisite bug fixes from Universal Binary features.
 * Added $(call mkdir_p_parent_template) prior to invoking lipo to guarantee
   that parent target directories exist.

Shardul Natu (3):
  Makefile: add $(RUST_LIB) prerequisite to osxkeychain
  Makefile: support universal macOS builds via RUST_TARGETS
  contrib: wire up osxkeychain in contrib/Makefile on macOS

 Makefile                                | 46 ++++++++++++++++++++++---
 contrib/Makefile                        | 10 ++++++
 contrib/credential/osxkeychain/Makefile |  4 ++-
 3 files changed, 54 insertions(+), 6 deletions(-)


base-commit: 602f6c329a7d99df269d382df353b4e1bbbbd8aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2288%2Fkiranani%2Fnext-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2288/kiranani/next-v6
Pull-Request: https://github.com/git/git/pull/2288

Range-diff vs v5:

 1:  e0bb18ff01 ! 1:  0d21513940 Makefile: add $(GITLIBS) prerequisite to osxkeychain
     @@ Metadata
      Author: Shardul Natu <snatu@google.com>
      
       ## Commit message ##
     -    Makefile: add $(GITLIBS) prerequisite to osxkeychain
     +    Makefile: add $(RUST_LIB) prerequisite to osxkeychain
      
          When Rust is enabled, the git-credential-osxkeychain helper depends on
          Rust symbols compiled into $(RUST_LIB). While commit 522ea8ef7d
     @@ Commit message
          clean working tree can fail because Make does not know to invoke Cargo
          to build libgitcore.a before linking git-credential-osxkeychain.
      
     -    All other core Git targets that link $(LIBS) already depend on
     -    $(GITLIBS), which bundles common-main.o, $(LIB_FILE), and $(RUST_LIB)
     -    when Rust is enabled. Add $(GITLIBS) as a prerequisite dependency to the
     -    git-credential-osxkeychain target to make it consistent with the rest of
     -    the codebase.
     +    Note that we depend explicitly on $(LIB_FILE) and $(RUST_LIB) rather
     +    than $(GITLIBS). Unlike standard Git builtins and programs like scalar
     +    (which define cmd_main() and rely on common-main.o to supply main()),
     +    git-credential-osxkeychain.c defines its own standalone int main().
     +    If $(GITLIBS) were used, $(filter %.o,$^) in the link recipe would
     +    match both git-credential-osxkeychain.o and common-main.o, causing a
     +    duplicate symbol linking error for _main on macOS.
      
          Additionally, wrap the definitions of $(RUST_LIB) and the "rust" build
          target in "ifndef NO_RUST". This ensures that when NO_RUST=1 is
     @@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
       
      -contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
      +# When Rust is enabled, git-credential-osxkeychain depends on Rust symbols in $(RUST_LIB)
     -+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(GITLIBS) GIT-LDFLAGS
     ++contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIB) GIT-LDFLAGS
       	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
       		$(filter %.o,$^) $(LIBS) -framework Security -framework CoreFoundation
       
 2:  66f71fb0d7 = 2:  21dedb91f0 Makefile: support universal macOS builds via RUST_TARGETS
 -:  ---------- > 3:  8455e449f3 contrib: wire up osxkeychain in contrib/Makefile on macOS

-- 
gitgitgadget
