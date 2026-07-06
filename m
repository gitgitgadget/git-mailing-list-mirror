Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770682F5321
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358102; cv=none; b=UDZWZqGX6JQEuqqOTTZKLeBF7LqZ8z4U2lfagdqE0caouR4GNveQ1wpWwQXzBhu9G0pygr+86Sp66suwEFNN5TCHGov1KJSzIETBjHhni2Q064nxzLoPwtJ1wYCyXS4eFs0x8E7qz0UlnsS8HRSYiMouNpCNNOUilDnpdwCAyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358102; c=relaxed/simple;
	bh=RE0uRaMMG17aCWEnb4rncPuLdPXGRi/90gBi3uxxM68=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VbDJhVj1ytlVc2uWiopZKVqHRvUPXaMjVR6iRyxJ4LPd0gplSRR79vbCyXor3DKVigAHpf3NEVYwYUU4KTt1ccUVw1X5G+qhb/I5ffNc0wcBOJ32W3v11S/2Cxkl40LnMqNa64zpAwJXtWi+l4bN8nL5WfMlulRmqX746x7pIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng/vDMYc; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng/vDMYc"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a340cead37so849215eaf.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358099; x=1783962899; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MnllBzPmiWV6ng26gh7BpBSMOJZKm0EosNSHILId7FQ=;
        b=ng/vDMYcp+IhwOK+Tq1XN7Dfcgo8nTBYzj+brFEi8gMwKB/y8Z5CO3qsH8h23xAXMN
         2n6Q7fsx8KnO7KyXHG6GV4ljZUGA/3IBac9yXKFr2B0JKSEOqYwafz7AwDu+hkrgFRUz
         SbImahR8IPeLrp6a6FQcAt/zuLMSXv4IJTcThL19e1GdxtRcuVVOerx+Ci2jdHpLBVnl
         9HFUWIOBEwvbLGBkyY+hwAsTF+I5IyfhWEaCsiYk+ARhgm505Mo/iGG2pjoJEYB4ZI9g
         gC3A2R4Ac1tfrbB+frs/FkrI2u2RTz6hupHA4TFH6YtHKMwEkYq5iVU1VJBn43azYMqQ
         8d/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358099; x=1783962899;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MnllBzPmiWV6ng26gh7BpBSMOJZKm0EosNSHILId7FQ=;
        b=r5CE85IjHtbBQkXIrBA3HfBrxkJu+PUv+3gNIPRC6drip7nPDQknmh10ku/i2TyPuA
         2ZQbeu5gS2VkZeJ04lGS7eGaRH0K5t6FtWhTmJQecoFLdnNOoDYsvBmF1OIExcF7mO17
         EO025/gyx6rOlC7WhItJVlKQJaxd8PNLRDzzLpL8pxSR1qJk4GmFYhJF8seMC/PX2CeK
         uHiMe5VOVsG1h4nND+7/pA7+AhGPnlX+Ii4d1w9J/IA3S8stGHz2fdZpuNeDQ3Uom+2l
         szcHAE3N4fgLGSbGoGcRMCGOiwe6C9H0dnBVuUfWj3nQWQGIVWtAFZ9N1UsWeVKe9PX+
         q8HQ==
X-Gm-Message-State: AOJu0YzEK1MxqZ64jxkBSc124J5yYfj4WEFa1ewszFha6VRZAa2fVRqo
	Rex5Dw/sdAMGDhfbRPb5BxKN0MA/urUbSa8b7+G1MVu7y9RPp0YMlaRE/xD8SA==
X-Gm-Gg: AfdE7clm5f1lG4jvnYx1dkgYc5NpvQRP7i/PLT/nxwj45YtEZao0Uea3Pxy20++BSLH
	Lz85LPyl3LsogNkKoiFnThup9uLgoyLj5nhFYiRjFsfHkZXtErcnhKxax6sgLIOLZA4KY3qnfgk
	tN6E+/AK0bhvN695GFPDvlXGFK72bMqKQXZTTBaEkGXZUMiRatNc0Is05rfReGXR9FvYtEZ/luw
	m9cYzXghqjA061b2Oaob3lVd5wD+6uJzV27ZtrANqbkGrJ70gt3mzDFHtH5WyDYcsSYihkpw9+C
	0OEBWukZsfLVh058t+bZpPMgSA0tjzMi9K9DL9XExUf9t6FPE7Qcxp/xQ7osRCFYX4xK9ZG+OYQ
	vao1YIdhBowgu/1Qb4DFCKypfko/1oQAFhE0SZZY1T0jov6s8EH7q7PVtbkQT9bWPsY1mh5xilf
	ibu+UsDIgTduaUtx8=
X-Received: by 2002:a05:6820:1907:b0:69e:98c0:a9c with SMTP id 006d021491bc7-6a35538e0e0mr937784eaf.11.1783358099163;
        Mon, 06 Jul 2026 10:14:59 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.32.69])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a310378faesm9134306eaf.11.2026.07.06.10.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:14:58 -0700 (PDT)
Message-Id: <pull.2288.v5.git.git.1783358097.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
References: <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 17:14:55 +0000
Subject: [PATCH v5 0/2] Makefile: link osxkeychain helper against Rust
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

This series improves macOS build reliability and distribution support when
Rust is enabled in the Git build system. It addresses two distinct
challenges: a parallel build race condition in git-credential-osxkeychain
and support for macOS Universal Binaries (multi-architecture distribution).


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

Shardul Natu (2):
  Makefile: add $(GITLIBS) prerequisite to osxkeychain
  Makefile: support universal macOS builds via RUST_TARGETS

 Makefile | 46 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)


base-commit: 602f6c329a7d99df269d382df353b4e1bbbbd8aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2288%2Fkiranani%2Fnext-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2288/kiranani/next-v5
Pull-Request: https://github.com/git/git/pull/2288

Range-diff vs v4:

 1:  41de7d391a ! 1:  e0bb18ff01 Makefile: add $(RUST_LIB) prerequisite to osxkeychain
     @@ Metadata
      Author: Shardul Natu <snatu@google.com>
      
       ## Commit message ##
     -    Makefile: add $(RUST_LIB) prerequisite to osxkeychain
     +    Makefile: add $(GITLIBS) prerequisite to osxkeychain
      
          When Rust is enabled, the git-credential-osxkeychain helper depends on
          Rust symbols compiled into $(RUST_LIB). While commit 522ea8ef7d
     @@ Commit message
          clean working tree can fail because Make does not know to invoke Cargo
          to build libgitcore.a before linking git-credential-osxkeychain.
      
     -    Add $(RUST_LIB) as a prerequisite dependency to the
     -    git-credential-osxkeychain target.
     +    All other core Git targets that link $(LIBS) already depend on
     +    $(GITLIBS), which bundles common-main.o, $(LIB_FILE), and $(RUST_LIB)
     +    when Rust is enabled. Add $(GITLIBS) as a prerequisite dependency to the
     +    git-credential-osxkeychain target to make it consistent with the rest of
     +    the codebase.
      
          Additionally, wrap the definitions of $(RUST_LIB) and the "rust" build
          target in "ifndef NO_RUST". This ensures that when NO_RUST=1 is
     @@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
       
      -contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
      +# When Rust is enabled, git-credential-osxkeychain depends on Rust symbols in $(RUST_LIB)
     -+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIB) GIT-LDFLAGS
     ++contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(GITLIBS) GIT-LDFLAGS
       	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
       		$(filter %.o,$^) $(LIBS) -framework Security -framework CoreFoundation
       
 2:  88fc2e0bd8 ! 2:  66f71fb0d7 Makefile: support universal macOS builds via RUST_TARGETS
     @@ Commit message
            3. On macOS, if multiple targets are specified, use "lipo" (part of
               the mandatory Xcode Command Line Tools) to combine the resulting
               static libraries into target/release/libgitcore.a.
     -      4. Ensure target directory creation before invoking lipo via
     -         mkdir_p_parent_template.
      
          Once $(RUST_LIB) is compiled into a universal static archive, the
          standard C linker seamlessly links it with the C object files to
     @@ Makefile: include shared.mak
       # Building Rust code requires Cargo.
       #
      +# Define RUST_TARGETS if you want to cross-compile. If left unspecified, it uses
     -+# the default rust target on the system.
     ++# the default Rust target on the system.
      +#
      +# On macOS, this supports specifying multiple targets, separated by a space.
      +# This will produce a Universal static library using `lipo`.

-- 
gitgitgadget
