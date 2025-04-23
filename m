Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803DE265CD3
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745395314; cv=none; b=GkrFtozrHtGjNN00nmVjOrQft9U+uj/K2Q5SxQ1OJUVynj2iA7YNlsLf3T2xkqAYhiA2HR+Jdb69nNQ/Q0fKZhCcaQ7Zgx6kU/6ARrdh9mDCRtbV7RajH7XTQEG+MdWikWr1uFqdeUQoKJSYsx8oCoJoBNGuL2DgM7HAq+y/If0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745395314; c=relaxed/simple;
	bh=nx4NW5H/+8KOt7YWQ4m9QF76B0t6YuTUOGb3uuuiDHo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SAXI8wwrrOJqOQTkIBv4ZHLZpUQwZv3IAXGk0sHkGuqKxnDejLggO8Shpp5usCbzcfx+gtuFJ/KUBN9dzwGIU8nS4SdZLAwg0le26UIWdwFyKygcZDOyPQ9cp99UQ1h/wDVtYqYTEAkcuJCxxHxkRTQvdz0WCBbQ6UHyCRbUst8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu2+VWBg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu2+VWBg"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so33961975e9.2
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 01:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745395310; x=1746000110; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJDKLUefEcApRTWDD8AnXnPNOK5IIxfPfym9DwV2T/0=;
        b=cu2+VWBgTgeQS7xqau5kuv2FIRxoujxsP+8H0aJFlKQ98hKLce96nChWeb13xTT5hh
         tyyYKzd0TxhsyOpOwWEP3npdZU7Br6LF44sSqXlsbyQdQLNYgF0UTx+cEFcRhziXO/rh
         UbM3xGFHoYEHW97NkwS8UFtHX7hzyPHL1HCkRy/koXytI/Xg28PXdBJ79LiFNLl3Wpty
         8Clo8pv1mVQswtw2Uq0k2/GTLm/4u6RLv0eiysI2IPHMek5cyatg3RTfA+mJlLrFs4+M
         a3lf+EFq5ZxJIBYMp40+/FeLYkbqPgCrpLIW2Flo2VzA1V6UA8VKDR9ydbc0lgbgASoW
         ItBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745395310; x=1746000110;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJDKLUefEcApRTWDD8AnXnPNOK5IIxfPfym9DwV2T/0=;
        b=G/FuiPhry/g07/BBJNXSY0UPXCdm75B7m1APQ2Ue8W08qRXyCZ+L4r88tqXb4A6EXV
         W6kFwGtpWcfUFyNoqnK+998hnNel2qS8GH8zxwS1wwEVgkBzTJ+hshuyo7w7yDMs4wex
         n2LLvy9JQvJjpz0n1tXFbDKZSB+EoQJ0rVtKIzn1/w5NbznmjEIuT4zBLJpu0bYBGZc1
         pqTt5Ss8rtzbs8EhcvaFQ2LE2Aci1zFf/pVqVJ9isIkK6O0a8VRqm5vOC/zxcCyBGa8N
         QtiHYcxjIoxeAUz05wpTgC8eUTFNd09iGH3roOQk50+dWAvg7LUc07iZUSYz5INY9zME
         Vgsg==
X-Gm-Message-State: AOJu0Ywz35VUAuQV94B80J5GtixdWWc30JQtIso/nAdDmMz9rGpo1M70
	bkUtdWcK6iIRgNYfjQ8xSoDGSpymQYnLp/hDy8GG7HCXYQIcNqKri/CLgg==
X-Gm-Gg: ASbGncuQBRV5GQxA6ZLUyTaL2O6AJ11I9RsnY1/iFIdcM/QfS+AEpvBuppXeV6vDhCm
	Bp0swo3kU17JsS1oOxNB8ARac408JZVH6a1HmTOR467U/ZAAuFX2BCmj6YHdxuBVdpRLcfnLjQh
	0g+YiAZiO8qDnZ53nYO42N73uttRPJ/evc/AuZEugS00fHQifT5mpzdzoq0YV+MQs5NIzaMMHPH
	D7Hb8sB0/9d3rbpqN4Rss+bdPJYIFUpjlc0CxR1MRs0bh5bpiWcWKL+uBRxDYTj4Keh1VPtLKec
	J9kXRnSj3XCOtabBF82zAZn7X/SB2oJUcT+CVEc7Jg==
X-Google-Smtp-Source: AGHT+IFt+G5luFt3oIs++rdkaC+xD8G5dvaxxsUpa3d3QdRQqvuvn9b/Bj2fLF2LapZAlvxSDlMT9g==
X-Received: by 2002:a05:600c:4706:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-4406ab96b35mr166749285e9.14.1745395310092;
        Wed, 23 Apr 2025 01:01:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d22f69sm16027085e9.10.2025.04.23.01.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:01:49 -0700 (PDT)
Message-Id: <pull.1904.v2.git.1745395308.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 08:01:42 +0000
Subject: [PATCH v2 0/6] Support Windows/ARM64
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows has started building artifacts for Windows/ARM64 since
v2.47.1 (November 25th 2024). Now that Windows/ARM64 GitHub Action runners
are available in public preview
[https://github.blog/changelog/2025-04-14-windows-arm64-hosted-runners-now-available-in-public-preview/]
at long last, it is high time to upstream the minimal set of patches to
build Git on Windows/ARM64 and pass the test suite.

Changes since v1:

 * Replaced an #else #if construct by an #elif one.

Dennis Ameling (2):
  bswap.h: add support for built-in bswap functions
  config.mak.uname: add support for clangarm64

Johannes Schindelin (4):
  mingw: do not use nedmalloc on Windows/ARM64
  msvc: do handle builds on Windows/ARM64
  mingw(arm64): do move the `/etc/git*` location
  max_tree_depth: lower it for clangarm64 on Windows

 compat/bswap.h   | 14 +++++++++++++-
 config.mak.uname | 18 ++++++++++++++----
 environment.c    | 10 ++++++++++
 3 files changed, 37 insertions(+), 5 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1904%2Fdscho%2Fsupport-clangarm64-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1904/dscho/support-clangarm64-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1904

Range-diff vs v1:

 1:  b89f39cbac6 = 1:  b89f39cbac6 bswap.h: add support for built-in bswap functions
 2:  2feeadb0d3f = 2:  2feeadb0d3f config.mak.uname: add support for clangarm64
 3:  6c2e17eca68 = 3:  6c2e17eca68 mingw: do not use nedmalloc on Windows/ARM64
 4:  c89ead8eaba = 4:  c89ead8eaba msvc: do handle builds on Windows/ARM64
 5:  939bcb0dc63 = 5:  939bcb0dc63 mingw(arm64): do move the `/etc/git*` location
 6:  6ebc3ef57fd ! 6:  e0e78bd5131 max_tree_depth: lower it for clangarm64 on Windows
     @@ environment.c: int max_allowed_tree_depth =
       	 * the stack overflow can occur.
       	 */
       	512;
     -+#else
     -+#if defined(GIT_WINDOWS_NATIVE) && defined(__clang__) && defined(__aarch64__)
     ++#elif defined(GIT_WINDOWS_NATIVE) && defined(__clang__) && defined(__aarch64__)
      +	/*
      +	 * Similar to Visual C, it seems that on Windows/ARM64 the clang-based
      +	 * builds have a smaller stack space available. When running out of
     @@ environment.c: int max_allowed_tree_depth =
       #else
       	2048;
       #endif
     -+#endif
     - 
     - #ifndef PROTECT_HFS_DEFAULT
     - #define PROTECT_HFS_DEFAULT 0

-- 
gitgitgadget
