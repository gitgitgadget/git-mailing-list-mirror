Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1241D4CB
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443805; cv=none; b=MvdCzplB9ff/f6Ul8Mhh75TMTsdKVklkE5SP7URufSdqWLAqBstLw8fhuEiNGKW+tGm3PsecEXXYOL/8FDXAiepkqP96cB1kyJ+Es0Xec6OSr0psRXhHrd9KvxhiJtUqbsCLruRWGT48D0lBsT7uvL1N2OlSbTF2XGehGcGpKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443805; c=relaxed/simple;
	bh=NNB4D853wCUC2DaOYh1mLgqAoHpF5qo1/TFajXQtSmQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XIlE8Kkpa/qVxu62fS+otG7ZjGIoY7y+MvghgegEki4bZPu9P2wG0q7CAP/Y3iAgQyh8Vn/eKgjbwr7K7xMcfIT/1d4PQxEETLZj9s2mruCfwqmH9DuGYnmSipmJgsl0RypUaAliPyGsMcYqFrr5aTeC3alyWsglOneRAdQkeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj0+vk5j; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj0+vk5j"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso3856959a34.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 10:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443802; x=1784048602; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YgAS8yUR9avtdkpFw8L6qkogUJmHLCZNvjAjckVa8Y=;
        b=Rj0+vk5j5ZqYa/BqavvRhthnT0yTc9arJiqiRWosFMT3B3IXND89mycBtE2DrhF6lK
         DMOL4mhoxfarBudU+Fke1vzE5X+kpgAOtlRv9aJNwM08fWdZimAT5RYwfkGI+pcHN80T
         LoVY2Ek87FcjWFqEb3OxcjaZ+sXP79l+aQ+AsRiqeh0Vkb9zphNWZyv+CeK/qC6QWs46
         1Irc9G+e7FInHb0z1teh6k+yfL2Lu42wdm0zFVQurqyWFHISFGYO0oE67YIO/9dU4fGE
         Ne6vq/EngMMw1jvxDlEml+tZ2e4+xfULecudWzXFdakXe7SGvhL8thg2UVI+sPiu2iFu
         hUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443802; x=1784048602;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6YgAS8yUR9avtdkpFw8L6qkogUJmHLCZNvjAjckVa8Y=;
        b=dECJ9I3KPelZfbHyJP4j0Dk53pZjS+8buQQtzmWmmZ8m25IjrgaTwqt6UQMCcQCsiw
         OmTIZ4d2sGNPTjNFiuS2qHI8e6U/qqVzSRoYAFLs2zSL9CcfKvh1vYUkFGB0fz/619E8
         Bb445J66b5Z0sSL44iKRS5NFc8riwu85qPEh4MdDccqIYyvFCk8i4HzhgP9mWj2vT4H5
         HAZc+NN+yvqja3ly76XYQgyy7rJxY0T6mWXm6FT34FBmRgFD6zTIwiKt6JguD+wWyibt
         kyKuiUF0QHgq+R5sWUKtfcPUxi+nvoQGqHjZYDKnhCE7cyog8HkMFQnjvbtXjuMDkVMM
         MHSQ==
X-Gm-Message-State: AOJu0Yw4EeA8fiyWzW15R7sAHzf0nhYJfmmIEMVD8CNhnfLMOT6D/3B6
	pvaN5pDXNimG5X+9wiMBy2nerRjJw2cn/ZYYe5h67AkK8RzstXkk0lfBK0z0Dw==
X-Gm-Gg: AfdE7cnnmeGokQZzKyJRnVibaZ1/aqpVhiGZ0npTMAvypttbKL77kHv0OMVD1CuNlI1
	rTEYN6ZDSMau0Ew2AecwhbWAzNt10rD77olBuFn08C7IpFJmXYjXALQOtJgg4iFh9aREgQ6QA+D
	t9S5mUZ5CLgY/OjUlfQcHVrywqPRWACgiac5pZJbuXCaJU+5QXQzv7xREDgVcM5rPyU7OnAcEm2
	yy7AtHm1iJ1TkDx6LhasMF58rKRzx1EsWxskr0bvU1x3eEbJXQmFHFpmMFKSwsjVuNXv/QIJcNA
	M2qEgBDxlSe/rbIszlFy4FNQ4IK0s/idZMGGdL7bP2w9GSVoLZ7+DKP0xenMZfbA7OMLzcgJl5w
	IGxrORPoBfwHsLckVZ8TZQxqMHV8m/IuF8frDFqVeBHtYKni8NS0caXfK2VeT/1TBKe/PnoqdLe
	VjZLID0Br7B5+WqNw=
X-Received: by 2002:a05:690c:6f09:b0:808:2762:2d18 with SMTP id 00721157ae682-81be184106dmr48981097b3.31.1783443757068;
        Tue, 07 Jul 2026 10:02:37 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.38])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e371f44sm173460736d6.2.2026.07.07.10.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:02:35 -0700 (PDT)
Message-Id: <pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
References: <pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 17:02:22 +0000
Subject: [PATCH v7 0/3] Makefile: link osxkeychain helper against Rust
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


base-commit: 00534a21ce949ef80a5b8b9d7fc20b7d381038e9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2288%2Fkiranani%2Fnext-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2288/kiranani/next-v7
Pull-Request: https://github.com/git/git/pull/2288

Range-diff vs v6:

 1:  0d215139406 = 1:  8f2bd4b14a3 Makefile: add $(RUST_LIB) prerequisite to osxkeychain
 2:  21dedb91f09 = 2:  a999be69392 Makefile: support universal macOS builds via RUST_TARGETS
 3:  8455e449f38 = 3:  32af2c51a89 contrib: wire up osxkeychain in contrib/Makefile on macOS

-- 
gitgitgadget
