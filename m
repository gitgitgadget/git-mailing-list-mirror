Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3783515C7
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295483; cv=none; b=QDFggn7s94gSs+5Uqzf4/XHU4TeiSOZXXFf8oHQS5CzHhdWpZ03DZHmj940GginNFx8SFKcBzxeNZA29XwaluVqhowo/eG+nx8BbRC5OyA5/dmVMNe3LRqQwRQPOuH0cKRBcfBrJm1qN4HcXrbHlEbGOUJMWxvM2qBsvp+z+ORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295483; c=relaxed/simple;
	bh=QAgPXcT8MdfQCdTvRszWy/CTW6ABp0mOvniBQ98FO2g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W9cHGfLVU1IYYv6NRSzudI9Nb0yZz3DzePWzU4b206M6/1iQIHPeGS6JTMtO4Z8SipTCUx/xkgFPVPmbaUsMupU+z89r7F9iNcWGSVazFLl6OCUghoU3AX0wQ32eHcS11WeF9lxlkVotQob+oyYBA2gUir4APK+tJIm97PtZzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aukLRois; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aukLRois"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-939e59ff27eso226590685a.3
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 03:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789295478; x=1789900278; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y84DFnptjjoE2COC5Eju+nTRKHXkHJV7xmV+ka/6780=;
        b=aukLRoisthmy+9/2AYw5ZzZIiN6P44X4xPmAOzrGe9tN28gEYQK+AMN3ud919Y+JMY
         2d5gKOoyOqmCdSVLJ7Lex4NNUuOUz4sIqGnOJPOoT3Vltp0f0zLPp4fbqTG6/iQmVs7D
         TYIjRXAm1F2amPP3SgCfHPL2N48vxa7tLNYGt+PJ8wO/YVtlsx+fDEOkssuFDZtvzWZs
         Ld+gXMPcjcLj1af8m51delg6NEupp34uBuspSay1M9i5kTeM9fkZPrTgrh/3GWeht0S6
         +eMu+sKIxntYXDr+qKq3ca/TkNtthwThzBTCKOiDYe2iY8+D1np+De0bVdKm24sM0qB0
         NccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789295478; x=1789900278;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y84DFnptjjoE2COC5Eju+nTRKHXkHJV7xmV+ka/6780=;
        b=V+IgqiVtTTMVBA1sekc02by7+yGtBm3c+jUKw+qUSfrgkP1oSWgdnLUzaV0wBJ2rqa
         Kv9ADze9R6IMVVP/6+KTQ9JJkXNg97ZvzTOjvbV8Kh+WoPiDUIQlILCzq6/cAfOIa4Pu
         d8UDaRz/tm8LqDGHkJYi1m5wpKly6Qr9zrxJGBFsc34WEqdLc0JY+5SD02D4JkeV3yqv
         d5anbt/9bfFodUByB5vmANuYOfoJNxPol+5uKsqHb6E9bOWlAtI1AijkW5kly0w7xyaC
         434ZdheCU8n4fmurb0Yur1wz6h2nbDha5bYNkdbALbMde8eLjmOrC6Hw896Iw0QptlrO
         JljQ==
X-Gm-Message-State: AFuF++mF/rj++T5uBHaVmFZbC0PACTJL2oCQwegn+6Xcwhn+dMFMnigu
	oL0FKe9oU52KdGtLHDV01CpvzDawH0xeK1rV87C+0QjvoyD2qM4VKnQHmdzq3g==
X-Gm-Gg: AYBFou0EnLy6nlj14+bLtgB8Q83b00DqN/F2Ooz/9N4x7PQ6V9TEvT530+0JDCc20Yo
	1zRR9rByzQcC2fJHHHBRwj7vakiFwAjMuCWaIkH3nwRAzfW9Cq5FL3TkbfLRbE6TZodziCiheEe
	H6yxxUgMOc9ZWKfqtoSJen14+wbMgbk23amiyETH7r/JEV14orejOzSjVUokeis+DYohCFM7qwv
	s5V/FWFyhLZdDBCzaHxjBY1f5k4G3LNtC+i9vxzvwuACQeDlIolrI6QE21cdlH8c9f3gtlzxSbH
	XWcIdR0CHlc+T5IgF34hUDaoKsipGIWKZN7XWPWuNYS7QYiUby/ke3xlBtykg6vfCfQ2L7sNaam
	FDoI1Lo1uN95j0oqLbWLa/o+xaqy84HN6b9rH5S8Wgd+mKy2NfxeW3ssfaYtnMawci7J3Q1kbyQ
	T3+W1fnN0UeVBCOuYiApvFnv3ym8Fs5Er72tgXSS4iNkqPwH/AXx5Ht+EzlCizpEh33Dks3nzGz
	dw=
X-Received: by 2002:a05:620a:a19a:20b0:939:fe9e:881c with SMTP id af79cd13be357-939fe9e936cmr372921385a.49.1789295478294;
        Sun, 13 Sep 2026 03:31:18 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.119.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f184d9sm717777285a.12.2026.09.13.03.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 03:31:17 -0700 (PDT)
Message-Id: <pull.2213.v3.git.1789295476.gitgitgadget@gmail.com>
In-Reply-To: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 10:31:14 +0000
Subject: [PATCH v3 0/2] Use Rust in the Windows CI jobs
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
Cc: Patrick Steinhardt <ps@pks.im>,
    James Le Cuirot <chewi@gentoo.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

With v2.55.0, Git requires Rust by default, with an opt-out that is intended
to be dropped in one of the next versions.

Due to the special circumstances in the Windows part of the CI builds, each
Windows build job first downloads a "minimal Git for Windows SDK" that
contains the GCC toolchain required to build and test Git. As a consequence,
brian m. carlson opted out of Rust in Git's CI definition in 32d5b905909e
(Enable Rust by default, 2026-04-09).

So: How could we stop opting out? Notably, Rust is not part of that minimal
Git for Windows SDK, and including it would more than double that payload,
which I consider prohibitive. Yet including Rust in the minimal Git for
Windows SDK is not actually necessary, at least not for the GitHub workflow:
The runners on which this workflow is defined to run come with Rust
pre-installed.

Granted, this Rust installation is configured to target the Windows-native C
compiler, Visual C. To accommodate for the Windows CI job building with GCC,
this patch series adds a step to the workflow that ensures that the needed
Rust bits are installed and configured.

RFH: I haven't been able to confirm that GitLab's Windows runners come with
Rust preinstalled,
https://docs.gitlab.com/ci/runners/hosted_runners/windows/#available-runtimes
did not clarify that for me. Patrick (or anyone else with access to GitLab
CI), could you see whether this patch series builds on
saas-windows-medium-amd64 without need for further changes?

Changes since v1:

 * The inconsistency pointed out by Junio, that UCRT64 was once marked as
   using clang and once as using gcc was fixed by clarifying that UCRT64
   uses GCC.

Johannes Schindelin (2):
  rust: pick a GCC-compatible Cargo target under MSYS2/MinGW
  ci(windows): build with Rust

 .github/workflows/main.yml | 24 ++++++++++++++++++++++++
 Makefile                   |  2 +-
 ci/lib.sh                  |  3 ---
 config.mak.uname           | 25 ++++++++++++++++++++++++-
 4 files changed, 49 insertions(+), 5 deletions(-)


base-commit: f4742f3165d096130c39a71feb26374da37620f2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2213%2Fdscho%2Fuse-rust-in-windows-ci-builds-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2213/dscho/use-rust-in-windows-ci-builds-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2213

Range-diff vs v2:

 1:  6567eceb32 ! 1:  b70b001f62 rust: pick a GCC-compatible Cargo target under MSYS2/MinGW
     @@ Commit message
      
          When Git is built under MSYS2/MinGW with Rust support enabled, the
          Makefile expects `cargo build` to drop a `target/release/libgitcore.a`
     -    that is linkable by the same MinGW GCC used for every other object.
     -    With Rust installed via `rustup` (the way it ships on the
     -    GitHub-hosted `windows-2022` and `windows-11-arm` runners that build
     -    microsoft/git), the default toolchain targets the MSVC ABI; cargo
     -    then writes `target/release/gitcore.lib` instead, which the MinGW
     -    `ld.exe` cannot consume:
     +    that is linkable by the same MinGW GCC used for every other object. With
     +    Rust installed via `rustup` (the way it ships on the GitHub-hosted
     +    `windows-2022` and `windows-11-arm` runners that build git/git and its
     +    forks), the default toolchain targets the MSVC ABI; cargo then writes
     +    `target/release/gitcore.lib` instead, which the MinGW `ld.exe` cannot
     +    consume:
      
              LINK git-shell.exe
              D:\git-sdk-64-minimal\mingw64\bin/ld.exe: cannot find target/release/libgitcore.a: No such file or directory
              collect2.exe: error: ld returned 1 exit status
      
     -    See https://github.com/microsoft/git/actions/runs/27341625000 for the
     -    full log.
     +    See https://github.com/microsoft/git/actions/runs/27341625000 for a
     +    full example log.
      
     -    Let's define the correct target. Re-use (and fix) the existing
     -    `HOST_CPU` variable for that purpose. Avoid relying on environment
     -    variables that are simply not defined in Git for Windows' minimal SDK
     -    that Git uses in its CI runs.
     +    Let's define the correct target, using the `CARGO_BUILD_TARGET` variable
     +    that will be picked up by Rust, see
     +    https://dirname.github.io/rust-std-doc/cargo/reference/environment-variables.html#:~:text=CARGO%5FBUILD%5FTARGET
     +
     +    Re-use (and fix) the existing `HOST_CPU` variable to determine the
     +    correct value. Avoid relying on environment variables that are simply
     +    not defined in Git for Windows' minimal SDK that Git uses in its CI
     +    runs.
     +
     +    Note that this _still_ requires an explicit `--target` option to be
     +    picked up in the way Git's build process calls cargo.
      
          Assisted-by: Claude Opus 4.7
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     @@ Makefile: RUST_LIB_NAME = gitcore.lib
       RUST_LIB_NAME = libgitcore.a
       endif
      -RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
     -+RUST_LIB = target$(if $(CARGO_TARGET),/$(CARGO_TARGET))/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
     ++RUST_LIB = target$(if $(CARGO_BUILD_TARGET),/$(CARGO_BUILD_TARGET))/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
       endif
       
       GITLIBS = common-main.o $(LIB_FILE)
     -@@ Makefile: endif
     - ifndef DEBUG
     - CARGO_ARGS += --release
     - endif
     -+CARGO_ARGS += $(if $(CARGO_TARGET),--target $(CARGO_TARGET))
     - 
     - # For the 'sparse' target
     - SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
      
       ## config.mak.uname ##
      @@ config.mak.uname: ifeq ($(uname_S),MINGW)
     @@ config.mak.uname: ifeq ($(uname_S),MINGW)
      +			HOST_CPU = x86_64
      +                endif
      +                ifneq (,$(filter CLANG%, $(MSYSTEM)))
     -+			CARGO_TARGET = $(HOST_CPU)-pc-windows-gnullvm
     ++			CARGO_BUILD_TARGET = $(HOST_CPU)-pc-windows-gnullvm
      +                else
     -+			CARGO_TARGET = $(HOST_CPU)-pc-windows-gnu
     ++			CARGO_BUILD_TARGET = $(HOST_CPU)-pc-windows-gnu
      +                endif
     ++		export CARGO_BUILD_TARGET
      +
       		BASIC_LDFLAGS += -Wl,--pic-executable
       		COMPAT_CFLAGS += -DDETECT_MSYS_TTY \
 2:  07415393e5 = 2:  76469029ff ci(windows): build with Rust

-- 
gitgitgadget
