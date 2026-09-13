Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD42360EDC
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295484; cv=none; b=DNIoJPOTTcmBItyW5Bs52Z3PrMi61jFznlQEUnbkkoO9xZeFumFjXl4FhTQ0aGL92GaGGHXwLEboB2IBxOtz+u8XcZM7TLbi97S/cNHsQ1vGelSNpvcrqCvvCM3q63vM1G1i9yx5qHfjl+lfgGJNiVmw4rbaJE33wG7Nee37iw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295484; c=relaxed/simple;
	bh=QnzrsI4Q5DxNXBbBVJYFO4IukEMRumprZHQwBgm7rcw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G6cSS6eH4j79DKxX9njpo6jteVqv33sOzlOsFRImxPwWiFDECTOCAacTalE3q+AEtMpyw8Wy+e64Mcci7VlRFaYcwwPQZTlUIdkxzgrSkRqXpzse7z9AxwPimhda/s95r5sn7PHueUPl/2g3djywyyGsuX9wzvnPgu/CXyPPrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAT6ZPmE; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAT6ZPmE"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-910316a2fc9so34765526d6.2
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789295480; x=1789900280; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V/RP2NCGeA58FsqMLqtXBobwKCxl3B93xusR5F9+3Wo=;
        b=hAT6ZPmEZla2YnvpqHcNX6KvvWiLv6Bn0tsudIeeaXGezwvdtb8b6C9VMb9jF6dg0S
         uehMh2U1dlRnhFQc2u81sXOR3866zadRuZ8RvunsInxdZAEoF9OSsURAofWiuRR9ZRbU
         VpYcYKMkf5C7Ar2um0SXFJNpTHNZHx/5tEQMrpbT0Lvrim82nc0rukuhInzLinzZqw2+
         XsjPdR6J2iNElylH37lfFwiVLcZNpxe04Ly+wBKa8WdE7tiyc/bu/+auTlgUvQEPq3Gy
         BbBJUFZ6Bz5hdDcdnc1Mtln6P/nEDKdjP+ty5APxatylCWJdQx1FEcnPgMactvKtUldZ
         zFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789295480; x=1789900280;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/RP2NCGeA58FsqMLqtXBobwKCxl3B93xusR5F9+3Wo=;
        b=A20T7LVXPJDxAWXFL1lrr5k+6wYswD83obz1Z5CladJjmaeY9/HUMkjEVNcvjJg2Wq
         n/uUNvq9kMCnuhu3IxJQXkqbD33adzlOd00zbsT9ZFt1cg5ymVy/7pw+jJhM8K3XyPVA
         ACNpGyGf+gDjH+BvMUrgJqqK+giGF/KkSdxXjllqGCdQWO1UVMXpagTUvGdnFlARDNt/
         QMKmiR50xWf1/8oqmMBmEFXxIhCp6Awpmzf9Rb3zvgNxEUpXroVm4KiVUlPJxJSW6shc
         Z5J8Ehbi1+Vad/UiC18cn6PCMdhRGLJ3kX04chL2vTODv0fkiuJawyecc3pn4ey7XWoE
         4CEA==
X-Gm-Message-State: AFuF++nfEhU5i2sZ5maZPamPOw12bOKFoX3ihZdfXQF8azkftooHqixc
	SK2zo2xCwl2noH0RKb9e3BJZ8PAEzg5uI/Y9ckz8KMsi9vpEPyhCFPYtjQxpXmuW
X-Gm-Gg: AYBFou3bAD6ytIwLhx9DMOdsnRnaoFw9GaFKD8KgQ0KYfYSMhcPIzzPEprCAK2hEJ31
	f2JK0Mot5hAZh3Eo6xlrWIznKmJ8M81PTY3Lw2BBtySf3G0AW/vdhmuH0z4GRGmUlt/1qYmFggI
	YW/v8TxvbJ1VV+tTB3fT9CER8+dlXlNqfnfAkKBdgPATqmv2d7TCymPFc39Ozh6LjHwvnl98kyq
	hb9ZxkRwPAeFnwxUpHcCw8P1KiBzCZ1BFDsPiS00DKLyk50XvmohSefQs4F8J71I7nUPEkyewQ/
	owxAX9kjKjy6v4RpcTxEipGttlMpiu+0oL1SXKZmgl1O0a5OzFVZnNi0IBNaMtwCbOnMuqCGpa9
	dyKK7glyEQwTpfZ/x5Kp16UWLFKTun2iXGleEYkAb2PiaOY704fMil96NWHJ4+3l43R1DwOLmv3
	iwbWVBNzZD/V/TgjzfRmFr9m8W9khVLg/DFbrQlThVIJKBsrgpQ89E43glGqpbL5mPmnipIDlV3
	UDV
X-Received: by 2002:ad4:5e8b:0:b0:910:63f9:29f9 with SMTP id 6a1803df08f44-91212086712mr182444466d6.10.1789295479607;
        Sun, 13 Sep 2026 03:31:19 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.119.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47a239sm67891126d6.26.2026.09.13.03.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 03:31:18 -0700 (PDT)
Message-Id: <b70b001f625e7cbf3947fbed4632a1fdb6e99763.1789295476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2213.v3.git.1789295476.gitgitgadget@gmail.com>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
	<pull.2213.v3.git.1789295476.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 10:31:15 +0000
Subject: [PATCH v3 1/2] rust: pick a GCC-compatible Cargo target under
 MSYS2/MinGW
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Git is built under MSYS2/MinGW with Rust support enabled, the
Makefile expects `cargo build` to drop a `target/release/libgitcore.a`
that is linkable by the same MinGW GCC used for every other object. With
Rust installed via `rustup` (the way it ships on the GitHub-hosted
`windows-2022` and `windows-11-arm` runners that build git/git and its
forks), the default toolchain targets the MSVC ABI; cargo then writes
`target/release/gitcore.lib` instead, which the MinGW `ld.exe` cannot
consume:

    LINK git-shell.exe
    D:\git-sdk-64-minimal\mingw64\bin/ld.exe: cannot find target/release/libgitcore.a: No such file or directory
    collect2.exe: error: ld returned 1 exit status

See https://github.com/microsoft/git/actions/runs/27341625000 for a
full example log.

Let's define the correct target, using the `CARGO_BUILD_TARGET` variable
that will be picked up by Rust, see
https://dirname.github.io/rust-std-doc/cargo/reference/environment-variables.html#:~:text=CARGO%5FBUILD%5FTARGET

Re-use (and fix) the existing `HOST_CPU` variable to determine the
correct value. Avoid relying on environment variables that are simply
not defined in Git for Windows' minimal SDK that Git uses in its CI
runs.

Note that this _still_ requires an explicit `--target` option to be
picked up in the way Git's build process calls cargo.

Assisted-by: Claude Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile         |  2 +-
 config.mak.uname | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index fac3e8879c..ad1ba26f91 100644
--- a/Makefile
+++ b/Makefile
@@ -959,7 +959,7 @@ RUST_LIB_NAME = gitcore.lib
 else
 RUST_LIB_NAME = libgitcore.a
 endif
-RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
+RUST_LIB = target$(if $(CARGO_BUILD_TARGET),/$(CARGO_BUILD_TARGET))/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
 endif
 
 GITLIBS = common-main.o $(LIB_FILE)
diff --git a/config.mak.uname b/config.mak.uname
index 0b63be10b7..f3f3bcc4ef 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -758,7 +758,30 @@ ifeq ($(uname_S),MINGW)
 			MINGW_PREFIX := /$(shell echo '$(MSYSTEM)' | tr A-Z a-z)
                 endif
 		prefix = $(MINGW_PREFIX)
-		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
+
+		# A rustup-managed Rust on Windows defaults to the MSVC ABI and
+		# produces a `gitcore.lib` that the MinGW `ld.exe` cannot link.
+		# Pick a GCC-compatible Rust target triple matching the MSYS2
+		# subsystem instead: `*-pc-windows-gnullvm` for the Clang/LLVM
+		# subsystems (which on Windows is also the only choice for
+		# ARM64, where no MinGW-GCC port exists) and `*-pc-windows-gnu`
+		# for the MSVCRT-based MinGW subsystems. For a `staticlib`
+		# crate-type Cargo does not invoke an external linker, so
+		# `rustup target add <triple>` is sufficient.
+                ifneq (,$(filter %ARM64, $(MSYSTEM)))
+			HOST_CPU = aarch64
+                else ifneq (,$(filter %32, $(MSYSTEM)))
+			HOST_CPU = i686
+                else
+			HOST_CPU = x86_64
+                endif
+                ifneq (,$(filter CLANG%, $(MSYSTEM)))
+			CARGO_BUILD_TARGET = $(HOST_CPU)-pc-windows-gnullvm
+                else
+			CARGO_BUILD_TARGET = $(HOST_CPU)-pc-windows-gnu
+                endif
+		export CARGO_BUILD_TARGET
+
 		BASIC_LDFLAGS += -Wl,--pic-executable
 		COMPAT_CFLAGS += -DDETECT_MSYS_TTY \
 			-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" \
-- 
gitgitgadget

