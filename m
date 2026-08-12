Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF231B10B
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521177; cv=none; b=TIqs7tnkt90EibvR19dt0wiRyJFerWj9DVfUTLCKp46uC/bfjXpmM55glGi0q53YjyO2sQwG3dWUnanTsjIwKCfMqcG45v2YcmJYS2ePmVlrx1MSy+WtBVoS6WFRGDk6qRQHdHxTf0LxDLZyMv5QI5o4yn6rpd+LIFXPm0e/KiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521177; c=relaxed/simple;
	bh=3/b+Snt4Ng1eFL08Dzgv9nzuzn74relU8+sfqnLbK5Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IVK9vsKV/MkAFltirQHQzNYuoqlLq5dXZ/ZZd0O0CK96KlSocAeIVYbuoQNhpeVgUorXI7fYzPHoFPLv+tXSbwFJxOREBgiftTx7Pdjst9aOKGlr/NTZtfZSfD4vQMTLYBraQmptgb0AT562YPwu22I5DkAPz4qjlEW7ywXxZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfoHIimC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfoHIimC"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e08baf860so820634a91.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521175; x=1787125975; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tKqh1h4+2jOQ+8/8JgqlWfHbnQYRYS+oDbNjRgTzYZI=;
        b=nfoHIimC5S3FQgQaelWYx4jXFR92KkI2NOBRpYwz2gC4CL5J6JWu+MNNVNrjUDa5dU
         4tfAPUAkKGPDt5vWC7sRJWbZcReOsgOmANrVY9sZAClwvwl3HrvlJWMxG58vZ6Ny4z1D
         QciiHdwXDuTBHLEWf/7SFZ2EDDVbHiSr1z64Czy0jVs/D4DY3szmTZblY49q4C2ntCBs
         gfaLT7PQAkOaBynxW+EJr5talgS3FQA0R+3H668nHeYMMScuXWCmKsuoFg0QZnExoSvl
         XxBuFBkDRNnTchp0CF4kR+HzIikCf83ZrUVHj2EMucV3Pi7EvxMJpU93KVblyltxpFUO
         KiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521175; x=1787125975;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKqh1h4+2jOQ+8/8JgqlWfHbnQYRYS+oDbNjRgTzYZI=;
        b=QuKyOYXYUtPMVXq8oge3YulREyrA5phqj3cacBy+GY1YgxijwsoQB0w83Hee00sRa4
         zbEuaKOfNByTz71OnuUUMzVQP/R5o0ZhFrctx9FH144lbqv47gCcapag6Hq4rZLwUcE9
         aGSbFoxUGSUR5QDMv14TiAGuwWyqnewu3xwu4S+F1vOBFzMHT6bg4Ddtw1tOrWzwYHcq
         Ftn5OYV3Mf1WweAAljE7i3F5UDTny6fw7LA94lfFdLGLtUP7jo9R9+Tf8ulgZQByTgg9
         M5e3QHRalioJmcp1Zbv+Vtal6CxnWPA9D7jrZpzp0/1SL6wzfKIs8+H5LE2L09FkeTWP
         VWsA==
X-Gm-Message-State: AOJu0YzTpfvEzUmuaUq92/xxWokWvodvz5E+iLciQlMRHSTfMR+BMv6s
	LMAKri1Uy17RvX9okzxhFQxVDBc/JCYG7ed+0EsJUbNXcYJQr4bJ+1ogWiTcDg==
X-Gm-Gg: AR+sD12k3MtJmDGhvb5iWBS1e2XaQGwEKjqWi7ZP9ZUA3iJIOz+Kn2obRFe8W2Ysy3w
	V+Gchs7TNJ8duiyiAKoleL/btTx+dxPlW0TZQJ+GKOamCxR4IVDq2b1lgEWO/KG+4VSjjzKOy9j
	9oua0j3YTvP/gde97U5NtgEqOXTq9QFpBWi+Qq9wnAypnpsgFTs4/PnVPAts5Imsm0X04CjoOJ3
	Ooj3+kclJnlCuPlL82TKf90WsdPwTc4ZCgAsBF/5wAkPSiGq59PSvJHdg3UhL+Zo+rCaoEJoOvd
	vrhNulmoDLQwb0zOh5FLOLc0bJZDd3zerPw/tNd7qxrx6ZC9SrL3ugqE1rneCMciW8DiDv958Tq
	fa2c4znkEqgCebGjRIH/G7CSTlYlWUnEizkFcpySYvMUq6BFsP9NVozARclqdBGWBSKP0Yq2KM/
	xCuRX28INe305lqofU2tI4iU770BHZvCDclMJkLA0U/miLYZdL+bk8ChohBo4aJyXbqpdKcMPmm
	Xs=
X-Received: by 2002:a17:90b:5828:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-393014c10cemr3946318a91.16.1786521175285;
        Wed, 12 Aug 2026 00:52:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94adf39sm2480324a91.11.2026.08.12.00.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:52:53 -0700 (PDT)
Message-Id: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:40 +0000
Subject: [PATCH v2 00/12] Upstream some more Git for Windows' patches
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

When rebasing a Git for Windows commit to enable Rust in Windows CI, I
noticed just how many of the preceding commits touching adjacent code
haven't been upstreamed yet. This patch series rectifies that.

Changes since v1:

 * Fixed the meson-side handling of the MINGW_PREFIX constant (this was not
   noticed in the Git for Windows project because it does not use Meson to
   build the project).

Johannes Schindelin (12):
  mingw: include the Python parts in the build
  mingw: stop hard-coding `CC = gcc`
  mingw: drop the -D_USE_32BIT_TIME_T option
  mingw: only use -Wl,--large-address-aware for 32-bit builds
  mingw: avoid over-specifying `--pic-executable`
  mingw: set the prefix and HOST_CPU as per MSYS2's settings
  mingw: only enable the MSYS2-specific stuff when compiling in MSYS2
  mingw: rely on MSYS2's metadata instead of hard-coding it
  windows: skip linking `git-<command>` for built-ins
  mingw: always define `ETC_*` for MSYS2 environments
  mingw: ensure valid CTYPE
  mingw: allow `git.exe` to be used instead of the "Git wrapper"

 compat/mingw.c                      | 68 +++++++++++++++++++++++++++++
 config.mak.uname                    | 61 ++++++++++++--------------
 contrib/buildsystems/CMakeLists.txt |  9 +++-
 meson.build                         | 15 ++++++-
 meson_options.txt                   |  4 ++
 t/t0060-path-utils.sh               | 33 +++++++++++++-
 6 files changed, 153 insertions(+), 37 deletions(-)


base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2195%2Fdscho%2Fupstream-some-more-git-for-windows-patches-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2195/dscho/upstream-some-more-git-for-windows-patches-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2195

Range-diff vs v1:

  1:  fd594ffa6c =  1:  fd594ffa6c mingw: include the Python parts in the build
  2:  47fc974582 =  2:  47fc974582 mingw: stop hard-coding `CC = gcc`
  3:  53f1fd5763 =  3:  53f1fd5763 mingw: drop the -D_USE_32BIT_TIME_T option
  4:  ad96aedda6 =  4:  ad96aedda6 mingw: only use -Wl,--large-address-aware for 32-bit builds
  5:  d67201f9b3 =  5:  d67201f9b3 mingw: avoid over-specifying `--pic-executable`
  6:  b49c42c50d =  6:  b49c42c50d mingw: set the prefix and HOST_CPU as per MSYS2's settings
  7:  b00d242621 =  7:  b00d242621 mingw: only enable the MSYS2-specific stuff when compiling in MSYS2
  8:  1593d1d1a0 !  8:  9de4ea7fc1 mingw: rely on MSYS2's metadata instead of hard-coding it
     @@ Commit message
          as before, but drops it for Meson (because it is unclear how Meson could
          do this in a more flexible manner).
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## config.mak.uname ##
     @@ meson.build: elif host_machine.system() == 'windows'
      +  if msystem != ''
      +    mingw_prefix = get_option('mingw_prefix')
      +    if mingw_prefix == ''
     -+      mingw_prefix = '/' + msystem.to_lower()
     ++      mingw_prefix = msystem.to_lower()
     ++    elif mingw_prefix.startswith('/')
     ++      mingw_prefix = mingw_prefix.substring(1)
      +    endif
      +    libgit_c_args += [
      +      '-DENSURE_MSYSTEM_IS_SET="' + msystem + '"',
  9:  c4e97449c1 =  9:  60a2999b75 windows: skip linking `git-<command>` for built-ins
 10:  625f01ad29 = 10:  1dd6ac9295 mingw: always define `ETC_*` for MSYS2 environments
 11:  39a138a773 = 11:  d44d05c897 mingw: ensure valid CTYPE
 12:  f822133191 = 12:  679d1fdd41 mingw: allow `git.exe` to be used instead of the "Git wrapper"

-- 
gitgitgadget
