Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7A38399D
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940010; cv=none; b=NoBUg2EHBP4xZshES20YAVEgHErOfwWXPMvOW358Vbgm/Tw/b6B+RwL2zSy/2u0GtFKcRfljJ3wCTVl9pULOisijgrRCLNhZcOizIRyDXVz7LWU7l+FsPr46YDweryXr2Sk2v0pKjcaFOOIr2qF3cJ1gSSN78+UEsOZh4Ocicbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940010; c=relaxed/simple;
	bh=ljRlkbbR0e3CH0NN89NURbWl5SVWPOpBTXSFnR4Rx7M=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=StkyvBkLdkbp6ZJ4j+GXeATIkIWeTJWA0xpCRw3Y1MQoV4Y1xtl9U0bVMCFUxOkO5WsB8gRsrmhf2zDCDAJaUn69K5A8kBoLdPPzd25rYdgAIpBvf/pOtU7KItD6apQTx9v3lChCeo0eLdNxf9L9//z+V9v4JsJmxLwZwbmx7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEzTxTL7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEzTxTL7"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c167c58f2so8277051cf.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940001; x=1786544801; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ILJAB4qavaGqqstHSq3mRv4ArnfJE8+2aF5sV/vpOYc=;
        b=SEzTxTL7J9Os9/HdvmEfS1Ul1QlSsv7LtZ7v0/4ONCJ15MQ9KuN7TBCCGxmZykCVF/
         mjZonMoI/4hnokn+XWVpb5YC9swAr2n/2wbNfj80bzGDD22X71BGkD66YlYuqQMcv6tB
         0yjObwEXBSvXS9ykrs9x7WMcVSRgwcWDS8vPFFBXiQ/dDrWQvsg3oa69jPpwt1eTaq+D
         ZJTleeiSdkTkuEM1Wkg6EfCKJkR50BOKVH5YY40BHsIZVM6MbXAn+H/+B5B+tl7RGB5H
         SwQFB8Fxqdg4nzdZuy+XHGMskIbdBTSaavjc2/vBm3jG4kLMGG5M8lcGwyE2H5YUw3O9
         0Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940001; x=1786544801;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ILJAB4qavaGqqstHSq3mRv4ArnfJE8+2aF5sV/vpOYc=;
        b=ekZus0mYA7x4QmmfD5Jxn/OekgFsDttLZt4T/xO6+Vx4wjdNitsIcrFYr4XG2YDbNU
         vJz/XfNgDBm6m9z1mpb8gjAznor6x9J9wBnpsNk9tp5VkDiRqwrfwdQM/+ZVrAA7Kt6N
         QySnR/at1jIRMztUtcFBBbbp3n7SqS0AzxdXDri4psuyOXv3M50IvPsFQiHlzKUQDEn1
         OHCikdxh/k7Ew7u3dgTa0DiL2lES0NTdloUGdENtUpuWhinlxqy6mYnkpf8eWoY10Zn0
         01e4iFLd0Y1/L3b7Vha6Bc537b0/BvkL9u30moLAP4acjPFvt2S5idCM2sb8J1HWvmDT
         iKwQ==
X-Gm-Message-State: AOJu0YxLHja48wu1E23+dzVazGKlNh0f32TUIIYsdGtDwRq/55HA8IaE
	TOmyaNNkoOwCPbTJ6QU9V+YeOJGIwH3j+RHzFfWpzfVVq4lgJXRsKnAn2+J7CA==
X-Gm-Gg: AR+sD11Zbq/4NvUQt0cGjsOe6em1U0xY4oA2FnvfeR1eg7OdoXUs79hzw1BbOKgQyse
	K01jvIYJeJkjPQXdyqouZGGCTeih3M5v8J6w35AWqP4PwKJ+z7TLqtusfqi6Sbgvrs5awIiakCq
	yQ9aw5mG2zZJpo1s0F+A4SDP7s7Emyiljk6IBzE8ifDM1cFITh821GsXI3Ja6pN3jkDC1zxqiCK
	1aBIx6TVbYei6lX7HCf2Hq+/aZiXobT7jKtTyNTvuWVuV7IWxq7UxkXsgFUtdE+C/NC9pt/dsW2
	6XaeohvztQ710gYu0xMXjN4auCzFUFAbIks26XaHGZUh10Lyq3F5C361PpIp2YbHxvTtEbHGGjM
	saOSpfN+mX8/g9gCsMH5qDm2UbNFnErv1YWj+CehcsVQVo+HNI6E2kGtX05nibUk4yxpp3TiyLY
	PiIG+1gGJiEjwde25YcVfzPOW9OR8gXRQeFu/hs9Uq2TThxlLgmeXO5uv5HxNbHNU=
X-Received: by 2002:a05:622a:2612:b0:529:e058:d185 with SMTP id d75a77b69052e-52ce6108b6fmr79739981cf.24.1785940000649;
        Wed, 05 Aug 2026 07:26:40 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce87aa78asm21342161cf.1.2026.08.05.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:39 -0700 (PDT)
Message-Id: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:26 +0000
Subject: [PATCH 00/12] Upstream some more Git for Windows' patches
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
 meson.build                         | 13 +++++-
 meson_options.txt                   |  4 ++
 t/t0060-path-utils.sh               | 33 +++++++++++++-
 6 files changed, 151 insertions(+), 37 deletions(-)


base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2195%2Fdscho%2Fupstream-some-more-git-for-windows-patches-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2195/dscho/upstream-some-more-git-for-windows-patches-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2195
-- 
gitgitgadget
