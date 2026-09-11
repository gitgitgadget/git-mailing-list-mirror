Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3A40DB2E
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153740; cv=none; b=ogFMLIplKby8jddAk/FmHi+Pdsu6CPRNyo+TpQVm/0XCNFoPiNaBZs3CtWbhxepjpi/yqbRKgRAaylRaiyn/I1C5CgbFgXVZoAOsBD86m1z1cFMXUOWBJVxGZwRnXMwnq2pp+/lQagxdwzjhVOx3hxrbE9jdujZvHMhSToYBGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153740; c=relaxed/simple;
	bh=jpuIPORCkuC6X+ePCQOAbqBxtAWbBnS+IbOAxwMnHd4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M2p5j8TQti1opoDVmQCB9UjjKnGEDpqRH4KqPSmnehpvl9FWiMVh3QxfYkbgqJWAFAcfwaTza8mOkjo+sS62zLqPtN5yj/wGMEd+ay0VtKMN+BG8JHq4dpF5820hpNa+xNm8s0B20TMgB3guqDO0PqkgUlVKkQdgF2QSaKgM0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbB7XidD; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbB7XidD"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcc3e03so1010276d6.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789153733; x=1789758533; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w3K/u+P88PBfhmazXlSGPe71t0FVVNCHXYJIPfIoWSg=;
        b=QbB7XidDINYnk4ErX2pmhiH34D3SJN2PZXZrPOrZRkfC6v/elFrAt5mI2YjyxIoQPX
         s0iRYQWG6GFan2HAV6Iaou/7M55fy+5robqbNNo7XtPpjwQ4BVAxffngVMEHI3hAsbof
         lqIX3ONi5o8oM/jFshmAYLf0tjAnk7eoD0LKkmcpSkM6hRZ6Ts4/jarhS5YFGZWc79/b
         yVRstE2FlGIoS7vUpzGL/3hU60cvPoAmgqIBvN74Fh9hQfBQabdVzoLHj07cXwXSMR5X
         rd8IGKPwl6mhlPQiuguqJoRH0g3W0i09862WPr0Toelv6AxPoUw2pyTsxBQ5Yoq6K4vF
         E6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153733; x=1789758533;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3K/u+P88PBfhmazXlSGPe71t0FVVNCHXYJIPfIoWSg=;
        b=FtuTeBgbdmVlcSTOJPSPWIsdtq94LNpDLwHhFx0L4HTXXnKP2nIPTLrJSNfZBfIWnJ
         tboXD0tzJvgO+BzeeBLs8pu/iBjjWP8UZ8vnrYWMXfhmlwyMm3E7/lfKZ8x/cnsVgVoR
         MXT6arcr2omLUSEEuaPJ+OuMrwlpJlXV7IUPJOGPFtdUw74O3XS2QKeDcmk3CU1dVcT+
         ynZEsh/hBUo7k/ieaEXwZv+FLXioS82JmfVij00xqBNBUce4dXzvF3cF2p2zt+FAdv7h
         zHhowvAqWcCN3+eAjH6j5fGcBsepWr0h98BShGQExsk8tMRc5SL522jb4C/iGVy2IBol
         ghuQ==
X-Gm-Message-State: AFuF++mvUIj7x0pxaxDZpjssbrHCWSyiLb9h8OrwXh1Rp1BaUb4+CICI
	0lQkpxUuf31V/ZwPS4qYgfMsqn8M7Av7i85DCdKXZJ1Vy1c04KfqwW77/JD0Vg==
X-Gm-Gg: AYBFou37PfysjCo3lYTGy09odFWA84vTUoUy/EWNTRiDtmsz5fNbrwP0KLjgz8SFno6
	RxdBHH5TNjXBwPG1VO4mowKw05iEtqHTSgDZfcNFFRa99rXD9h8nV07ehX0JCHhewBi41xemOu5
	QITIVmvFg3ii1+O57P1MYkicage0DDD+LmfJvFc/c0tdbLQIBVgATh3hgoZxqWrFgAdFW+FMl5Q
	SGoIOeoc9MYRKHMUm2fcjFfhxOsTthnIeFgVT3dbk443YIOq5j00G/Hy5+5ytCPc0SFbeTJQafX
	GRke9ZkqroSthYOkSTBI/XxsiiyrgoMdetYfrJeOKgjXbujg0MwdjcwOJFIGg5+lNbe19+X8au9
	F5uIZd3o0XGoM4VRx3fK6uhMOEZKdw0wmK2Elu9c1bMFpookpMNAfdwS1pXANIN5EKYLEskMlQu
	lAL30J7+V4gg/SGF4e4ydYWP1lI+//oout2GLGU8zeO+98JO03KR8NaeVxJGU7ZFO7TNnNAsO/
X-Received: by 2002:a05:620a:4546:b0:939:6652:b338 with SMTP id af79cd13be357-939e8be53aamr693582085a.13.1789153733497;
        Fri, 11 Sep 2026 12:08:53 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.38.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80bc225sm306970685a.36.2026.09.11.12.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 12:08:53 -0700 (PDT)
Message-Id: <07415393e5e30f1cd4babc56296f8ed140ae262a.1789153730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2213.v2.git.1789153730.gitgitgadget@gmail.com>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
	<pull.2213.v2.git.1789153730.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 11 Sep 2026 19:08:50 +0000
Subject: [PATCH v2 2/2] ci(windows): build with Rust
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

The Windows runners used by Git's GitHub workflow's `windows-build` job
ship `rustup` plus a `*-pc-windows-msvc` default toolchain (see
https://github.com/actions/runner-images/blob/main/images/windows/Windows2022-Readme.md
and
https://github.com/actions/partner-runner-images/blob/main/images/arm-windows-11-image.md),
but no precompiled `std` for `*-pc-windows-gnu` or
`*-pc-windows-gnullvm`. With the Makefile now picking a GCC-compatible
target triple based on `$(MSYSTEM)`, the build step needs that
precompiled `std` to be installed before invoking `make`, otherwise
`cargo build --target <triple>` fails to find a usable `std` for the
chosen target.

Add a step between the SDK setup and the `make` invocation that selects
the matching triple from `$MSYSTEM` (which
`git-for-windows/setup-git-for-windows-sdk` exports for every subsequent
step) and runs `rustup target add` for it. The mapping mirrors what
`config.mak.uname` derives from `$(MSYSTEM)` and `$(HOST_CPU)`, just
enumerated explicitly here since CI has direct knowledge of which MSYS2
subsystems the matrix actually exercises (`CLANGARM64` for the ARM64
runner, `MINGW64` for the x86_64 runner). Technically, we only need to
handle MINGW64 at present, but the switch to UCRT64 is imminent, and the
other case arms serve as a very fine documentation of what people should
do for other MSYSTEM values.

For a `staticlib` crate-type `cargo build` does not invoke an external
linker, so no further toolchain components (e.g. the `gnullvm` LLVM
linker) need to be installed; `rustup target add` alone is sufficient.

Assisted-by: Claude Opus 4.7
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 24 ++++++++++++++++++++++++
 ci/lib.sh                  |  3 ---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 85cfedf5b0..0972547395 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -114,6 +114,30 @@ jobs:
     steps:
     - uses: actions/checkout@v6
     - uses: git-for-windows/setup-git-for-windows-sdk@v2
+    - name: Install GCC-compatible Rust target
+      shell: bash
+      run: |
+        # The hosted Windows runners ship a rustup-managed Rust whose
+        # default toolchain targets the MSVC ABI. That produces a
+        # `gitcore.lib` which the MinGW GCC used by the rest of the
+        # build cannot link. Install the precompiled `std` for a
+        # GCC-compatible target triple matching the MSYS2 subsystem;
+        # the Makefile selects the same triple via $(MSYSTEM) and
+        # passes it to `cargo build --target`.
+        case "$MSYSTEM" in
+        CLANGARM64) target=aarch64-pc-windows-gnullvm ;;
+        CLANG64)    target=x86_64-pc-windows-gnullvm  ;;
+        CLANG32)    target=i686-pc-windows-gnullvm    ;;
+        UCRT64)     target=x86_64-pc-windows-gnu      ;;
+        MINGW64)    target=x86_64-pc-windows-gnu      ;;
+        MINGW32)    target=i686-pc-windows-gnu        ;;
+        *) echo "::error::Unsupported MSYSTEM: $MSYSTEM"; exit 1 ;;
+        esac &&
+        rustup target add "$target" &&
+
+        # Ensure that cargo.exe is found even with the minimal SDK's restricted PATH
+        CARGO="$(type -p cargo.exe)" &&
+        echo "export PATH=\$PATH:${CARGO%/cargo.exe}" >>/etc/profile
     - name: build
       shell: bash
       env:
diff --git a/ci/lib.sh b/ci/lib.sh
index 6c52154eac..c6ccbf8c17 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -391,9 +391,6 @@ linux-asan-ubsan)
 osx-meson)
 	MESONFLAGS="$MESONFLAGS -Dcredential_helpers=osxkeychain"
 	;;
-windows-*)
-	export NO_RUST=UnfortunatelyYes
-	;;
 esac
 
 MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
-- 
gitgitgadget
