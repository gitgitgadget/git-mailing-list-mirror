Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3F28030E
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188359; cv=none; b=WHQciRTjh6p/WPdYraCDtLOhPBL+bmx4igqPVMCCfmqmtnuZfG+qiatNOF7Pr2EQVA7U6F1Ny/dHCXqfUT9peAc/uocFW6rFSLuFqefmYkcKYOFKOU0W0xILWmTZcSLRe1PVyQULPJGjZOaEZSHkOmTwLDy04+AEWhmNvgpbWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188359; c=relaxed/simple;
	bh=IQ0xKjAj9LY+pef4sbvxGU/WqhOAYNgzk6B+hZYzaO4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DdH8aDCg/m8Cirm2w+zg0jUrwE7y3ehvY7qmMuqIgg+eRiW10JB4L3H8fizjvKjPkpmjO/oHXCjH8hvFzaSnw0cDKurZt0l3UmR1LgC3UB2q4Q0uq+lN/sdPmYReFYlAOyx5pMgtx85XYgMgLvnKb3Zrcop0I65KtK44YgvfbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe27H6OS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe27H6OS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ca11143dbbso11404485ad.2
        for <git@vger.kernel.org>; Sat, 04 Jul 2026 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783188357; x=1783793157; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJT38vkR2N8MOWg7QCRSV3uZIAkxh7d1M7Uj8ndQ+18=;
        b=Qe27H6OSlnfPbcHQwOVWmVHQY9o8de7IddGJwgRQsrErnTzo3JiRBpZPopVgr3mOad
         zjVaLOom/atjFTNao3HOctW1YwgpG1ZigIybGq8YxA91P5zhylK7mQSeiGcSag/Zuwt2
         9zgS9O3f5EFTeihLjT5AwEiTaKExMdEiLxmMW6hnzr9BuL+qvAh5VhbLNJKdsCsd+LbM
         alrZdpTYLqUoVu/bWHU3AGlW3WU7lPl9ENpaWl0RkTserFstS/Ff40w8Jvw0ymfoz4+O
         3xM5wuWYJuSBw1eCxC6BpLiJ0k0Ie3eYel/3M0pXKzGsnMdvh/7itCR8jvTJ7L/wPTGM
         C7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783188357; x=1783793157;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJT38vkR2N8MOWg7QCRSV3uZIAkxh7d1M7Uj8ndQ+18=;
        b=rj2kWldRjt8RBVJVIrxKGfWxiLBN0OjlQD7YW9dxP0ScUPfxcinrlch5HiKFn30TX+
         jAfidZgE8OBp2usJBnWEmGSzzZB4MUP5UNkKxIbhZPyPejdSazcwADY5OrEqqude5Nkq
         j8J/eiuu85xgLYE+tg5JUtu/aIQyayPMNfq69hghyFv8wl7YRVSd+jfOSR0xpUAdnhjX
         HV7pChnMlcHb91sOKblsXDvin878ve3kSC153wdyoOSu0n1aoxl/6eRtC3PSrLPu7UCC
         HzpL382qyW41uKgnqV6ynEa0qzCan2M1s2FP1vDiz9GR1IKeOosT9msFTpH9nqg7Xfjq
         NEPg==
X-Gm-Message-State: AOJu0YyF0T9HqPKP8EgjjRpU3LJwSTizkgjM2rOBcNv1whb1ZZCaf0ls
	VK4HdBcpRX7ewnZhkIHVBs+Up7qCiNNPRMW4FQYWu7qnUERjyt3zn99Wsm9uEw==
X-Gm-Gg: AfdE7ckAVYGcBg/hRZHN1+CfFH27DbwegXTSOWUPS95vutEZpABjUECFm83915pLhcG
	S7JJ4B7DCrg6uoOrsorNwSXrc74KQeJ/uzN+zxC06bL1Qf810EpTtHSzpkJkKxNDlQmooimm9Ua
	5rlY2EB3+WXPmk8Kzms5pjc3Ziku4yoqr7rfY3pdIHvawFiwT9+gPVoHwY7AB72lvQ5CvPdOu5w
	Cp0zPvUsp7xC5fPQ6pVvoektUp9JLcbDctBOQ5DaI8x22OEfDgjOHMBsiDhzB9rq5qps1eKkHm5
	3IsYfehPFKggT4NiJQaoWDyfknnLsdTKIc5Tcqcs3cpKQiCBkwrsPVOczgZUpOK6yrvVMWwhgBM
	5Shlfguhyac9FxRIIBdX/0GVLwnZfUKL7E2leK2d3YHJhFhwWgX91YJxMTm1BvLnZogxNdSWxZB
	FNjajLZ2/jBbJpdC/U4/7QwrUGjGcc
X-Received: by 2002:a17:903:19c5:b0:2ca:b8d:e65e with SMTP id d9443c01a7336-2cbb9ecc08dmr41925035ad.37.1783188357143;
        Sat, 04 Jul 2026 11:05:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.214.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef188sm32596893c88.2.2026.07.04.11.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 11:05:56 -0700 (PDT)
Message-Id: <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
References: <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Jul 2026 18:05:53 +0000
Subject: [PATCH v4 0/2] Makefile: link osxkeychain helper against Rust
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
    Koji Nakamaru <koji.nakamaru@gree.net>

This series improves macOS build reliability and distribution support when
Rust is enabled in the Git build system. It addresses two distinct
challenges: a parallel build race condition in git-credential-osxkeychain
and support for macOS Universal Binaries (multi-architecture distribution).


Why This Series is Needed
=========================

 1. Parallel Build Race Condition ("make -j"): While commit 522ea8ef7d
    ("osxkeychain: fix build with Rust") updated the link command for
    git-credential-osxkeychain to pass $(LIBS), it omitted $(RUST_LIB) from
    the target prerequisite list. When running a parallel build ("make -j")
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
passing "-arch x86_64 -arch arm64" in CFLAGS and LDFLAGS, Cargo and rustc do
not support multiple "-arch" flags in a single invocation. Instead, Cargo
must be invoked separately for each target triple ("--target
x86_64-apple-darwin" and "--target aarch64-apple-darwin"). This series
bridges that gap.


Overview of Patches
===================

 * Patch 1: Makefile: add $(RUST_LIB) prerequisite to osxkeychain Adds
   $(RUST_LIB) as a prerequisite dependency to the osxkeychain target,
   eliminating the parallel build race condition. Additionally, wraps the
   definitions of $(RUST_LIB) and the "rust" build target in "ifndef
   NO_RUST" so that disabling Rust cleanly makes the dependency a no-op.

 * Patch 2: Makefile: support universal macOS builds via RUST_TARGETS Allows
   users to specify space-separated target triples in RUST_TARGETS.
   Introduces declarative pattern rules (target/%/...) to compile each
   target slice via Cargo, and uses "lipo" (part of the mandatory Xcode
   Command Line Tools) to combine the resulting static archives into a
   universal library at target/release/libgitcore.a. Uses
   mkdir_p_parent_template to guarantee directory creation before lipo.

Changes since v2:

 * Split the original combined commit into a two-patch series to separate
   prerequisite bug fixes from Universal Binary features.
 * Added $(call mkdir_p_parent_template) prior to invoking lipo to guarantee
   that parent target directories exist.
 * 

Shardul Natu (2):
  Makefile: add $(RUST_LIB) prerequisite to osxkeychain
  Makefile: support universal macOS builds via RUST_TARGETS

 Makefile | 46 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)


base-commit: 602f6c329a7d99df269d382df353b4e1bbbbd8aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2288%2Fkiranani%2Fnext-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2288/kiranani/next-v4
Pull-Request: https://github.com/git/git/pull/2288

Range-diff vs v3:

 1:  41de7d391a = 1:  41de7d391a Makefile: add $(RUST_LIB) prerequisite to osxkeychain
 2:  257f5ef42f ! 2:  88fc2e0bd8 Makefile: support universal macOS builds via RUST_TARGETS
     @@ Makefile: $(LIB_FILE): $(LIB_OBJS)
      +	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
      +
      +$(RUST_LIB): $(RUST_MEMBER_LIBS)
     -+	@$(call mkdir_p_parent_template)
     ++	$(call mkdir_p_parent_template)
      +	$(QUIET_GEN)\
     -+	if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
     ++	if test $(words $(RUST_TARGETS)) -gt 1; \
     ++	then \
      +		lipo -create $^ -output $@; \
      +	else \
      +		cp $< $@; \

-- 
gitgitgadget
