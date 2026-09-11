Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7E41BA69
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153741; cv=none; b=o0kCD2uSnp63k6UkiBeFlKnqvUHTHzDAXRKIr+ZQBCuGeOc/cDQtJaiLAoAZ98vNPioKyA34a+MeLRAYTW8jQSOPy4UP1vRmlIFhzyrUFnc+ohWoC3nIWFsBpX4zPqCTajD7wgtqHqbfW8WCDX1N0Re7FHw9Bl8MIvhl6mU9TWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153741; c=relaxed/simple;
	bh=VhPiiQPBt4bV2IVLYGykO0jLIN73YCj+uY3Qrz10mbs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OctYY1S3lYddRVbVf6gPGXFMWbcG0Fi0tEwHMJF0yFVY54QP/dPxhwHl+P8o1fgNp7KPKsKxGrW+lG4OaYukz6bZP1hiQtwJv8RFBxC9kPNKsHq8opuqSN8y9Te5T9Ni0ekeAp1pfrxLAy2f+jJfEaskmCmzLUmxOPHNUJHJm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbFPufQX; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbFPufQX"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90ceab90152so10785206d6.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 12:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789153733; x=1789758533; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=erFLYHvYkJXXp1Iz+TexscG3VUIqDMEbI92tjpQ88HE=;
        b=ZbFPufQXoOF0iRvpHYxXPymBOiD48xc2frqtRJGS+H6SSY3Ib8S8U3N2AftHFNKGmc
         Pm8Tax0Nf1JM2PDMuA06kEyQeA9z0t6yEfXpOAmGHrZcd07qdeyqq0vqfQX55C3VPjDU
         5Un1T0V0C7qoz8YczrHSx7fjrQJJKXOWpaAIwPuxbxfz1n3zGqtgJ/yL++nUIrkDm3Na
         6bbjbsXt3Cp+s+TRlJiBz1itfOwwGaanr/6vhMZp8rzGVcyCAaBl6YmgncqGjLaXOgPN
         LUhLz9BspfkdCq5r2Y75enm2a7ZlPmkZXTgouj2x2PhaKj8UBVYKmq/wrDlMZ6DVLwgq
         1sCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153733; x=1789758533;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=erFLYHvYkJXXp1Iz+TexscG3VUIqDMEbI92tjpQ88HE=;
        b=aIlpe7dvR5gytmrV4MtusZAwetpFmwukLMHPXPdN8JLxEeNEC8Qa/gpgDSnjn+CskM
         qayLyht6BdpGkngWVBnI8vvtqit9+kRH2miWajCJlOwHTxWQjYr+u091IU0aC6NdqnS5
         NRhYIERSzihybO1Urf/CE5K3IFPRoLRzchHGHe8PwuO/GptPBYcInMEY8TimaMA4q9XU
         GwPWnAiazRCJpQCIBSgk2VACpkTjYe8xB9n4072z5gRvIVKGOscog1khrlCcqf5jE6ak
         f+dOjCC7XWYmNhI9lgDwK6ocnu4KXFHLFcbYrLeSk8+xN9ImEdXkkxAhmeOTLqceZukj
         Pg0g==
X-Gm-Message-State: AFuF++m+qPwHfentddXQQkhx92iDJB3r1S6VJBWrveQuOdz9y822Slh6
	iFNeel7DUOTnzggLGkeRYe+xp45ujXiaJlfa8hSVhUffCCuW2tXzsf4KPXZL8g==
X-Gm-Gg: AYBFou2e1+DIYRhUJbvtuu3oEtx+R2CGFcj8XTcMKhN+obESvfqNSJA0PJYt7B40AOM
	12C7K72FYxwl7PSirv+Jf4asLw8oV5hPu8ra8F/gVmLegWkJ+IfZn8n34R4ZecnnM6mlRGLxo+F
	jvXvwh80zjG+NNR5gqm/Ywi8A4og6Hy3Tp4qBrJdzJVik2eoOXm1d/ZJEFeOBGOYca1ebRF1dNp
	61J3flmiqRxjheEgJIxtj9SyWyTg3O1+XJawGPcaAhZX+Lzk12uwTX9z1KzBaSAnMl1JN/YCRM5
	MlkOJSXn3Fe1/yAJ4jSr/seJ28CSLVGNovnJtDbFtcd+Xr/hNHXoYDN0GGLfUh7CD+JzhMMweAG
	iLcShumiGkl59Djg5zTpC1PgMmc0j4J+oWlHtNgJ5WjuAzrRcBjB666xtOhw48Dzf+5JxGfs3W4
	g+lU8iJS1ZHOVOInI/s6kW5gaT196PxmN32Eo23joWxjCv/5J2+bFTfgCscaSFqCaBk3LK/t7s
X-Received: by 2002:a05:6214:226a:b0:911:9375:bc33 with SMTP id 6a1803df08f44-912120f2d2bmr73238456d6.30.1789153732637;
        Fri, 11 Sep 2026 12:08:52 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.38.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4dd2f2sm27859436d6.44.2026.09.11.12.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 12:08:52 -0700 (PDT)
Message-Id: <6567eceb32c1bdcff5927c6baf0cadc97af7485b.1789153730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2213.v2.git.1789153730.gitgitgadget@gmail.com>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
	<pull.2213.v2.git.1789153730.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 11 Sep 2026 19:08:49 +0000
Subject: [PATCH v2 1/2] rust: pick a GCC-compatible Cargo target under
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Git is built under MSYS2/MinGW with Rust support enabled, the
Makefile expects `cargo build` to drop a `target/release/libgitcore.a`
that is linkable by the same MinGW GCC used for every other object.
With Rust installed via `rustup` (the way it ships on the
GitHub-hosted `windows-2022` and `windows-11-arm` runners that build
microsoft/git), the default toolchain targets the MSVC ABI; cargo
then writes `target/release/gitcore.lib` instead, which the MinGW
`ld.exe` cannot consume:

    LINK git-shell.exe
    D:\git-sdk-64-minimal\mingw64\bin/ld.exe: cannot find target/release/libgitcore.a: No such file or directory
    collect2.exe: error: ld returned 1 exit status

See https://github.com/microsoft/git/actions/runs/27341625000 for the
full log.

Let's define the correct target. Re-use (and fix) the existing
`HOST_CPU` variable for that purpose. Avoid relying on environment
variables that are simply not defined in Git for Windows' minimal SDK
that Git uses in its CI runs.

Assisted-by: Claude Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile         |  3 ++-
 config.mak.uname | 24 +++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index fac3e8879c..bf2a11c08a 100644
--- a/Makefile
+++ b/Makefile
@@ -959,7 +959,7 @@ RUST_LIB_NAME = gitcore.lib
 else
 RUST_LIB_NAME = libgitcore.a
 endif
-RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
+RUST_LIB = target$(if $(CARGO_TARGET),/$(CARGO_TARGET))/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
 endif
 
 GITLIBS = common-main.o $(LIB_FILE)
@@ -993,6 +993,7 @@ endif
 ifndef DEBUG
 CARGO_ARGS += --release
 endif
+CARGO_ARGS += $(if $(CARGO_TARGET),--target $(CARGO_TARGET))
 
 # For the 'sparse' target
 SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
diff --git a/config.mak.uname b/config.mak.uname
index 0b63be10b7..720d9ba3ed 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -758,7 +758,29 @@ ifeq ($(uname_S),MINGW)
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
+			CARGO_TARGET = $(HOST_CPU)-pc-windows-gnullvm
+                else
+			CARGO_TARGET = $(HOST_CPU)-pc-windows-gnu
+                endif
+
 		BASIC_LDFLAGS += -Wl,--pic-executable
 		COMPAT_CFLAGS += -DDETECT_MSYS_TTY \
 			-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" \
-- 
gitgitgadget

