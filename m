Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF76387359
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940017; cv=none; b=BFncECVbxDOkF+qcdTcSF01cuJjwwz+qfM6BpzaTy4zP8xrMM5PpsO34i/zrwbJr/7L1sZHFp2CIrDhWtBljUc/ZrM0yvIkziIf9beJhNhnkCIxoebfKzca4eFnx9Q5H9rVlGwTrDwM0NaCVhOYaoNQFc9Jy82HlNWkXK203TC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940017; c=relaxed/simple;
	bh=otKoDAwZCTLMe/mhK/XkAqcZlc7oxBQe8IkHMg+2zxc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XExHimyUUNbPJmEeHkSsq/sVZiNAF5zMgGZ9kpbnwcCjG+rZUMatmVhqyYvYFIL/BHuH6GZ62nx+EHObSneQJEs2ho33fz8eqbo5NPigAgd5BtXmB/9rkXf8LedKRic7hqgaaX5QDMyUiOXQhj5Uo8EqxLpZ0UOFBbDncheA1ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4ZDuNah; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4ZDuNah"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5218927884fso9810521cf.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940007; x=1786544807; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hyw55P1alNCMt5VS/ljJlX/iuvMulsFfubfBfjeaYmU=;
        b=p4ZDuNahpGOOv5guVnbhb4GV0+Y5XkQtUKm8MjgQByf3xBwGnW5vnCypqiiy9BxvO/
         ptug1yExat4e9ilNNmRMzcmBnZcX3501gJ0iBDn23g7D79XtOlRbEE8+PNioshqhXhov
         L6PRYdW8kNQD2RJm+DJQdTv1hWmpttOT/1ZqAgT9z7k/hbJ9QcZCBGts7k1gaecYBbTw
         nqo4Yq9NaM6FBMeSDu90A+c7KmD8NVdHGaPYiGayvZJsJVYDCZGfwjsbWhf4M62kDRjC
         3NSHhRbonjTe5f/9NaYKfgDV0Kkl3SdlHrpEe0G9k5pLiBvCyMo3Uv3ycizHAEr8N2b+
         SlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940007; x=1786544807;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyw55P1alNCMt5VS/ljJlX/iuvMulsFfubfBfjeaYmU=;
        b=IDKZmTxUnqUvbCEnA1yz1Ll5oFBNP2+YjpPmFnhS5SXGXaIUYXxBCg/uGBkY9/vBBS
         wUzC5p1cSJDzpljhqjzbGmhBLa0ktiHPqRxZzjlppk1OapAYr5ivaohMz/AtwbkdbZqK
         6VQQo+IJPNafLYl+MaHfJzjCLSGIESOIyUwKQjAyRYDb9IY9LhrbJWHku2+gtNPES8+d
         xTDKMJnmwcEcDrzryIf0Jigs3mMptJOx2SKka4zEdLYrzpeWAULWHzJUx0q08/UjLy8s
         kZEK+QRHFhwHLeYwzK3xK6H8hQqy1uATgmX4t4BRwbz1i1kR/hbcH4Ge2c2gw86mbv3k
         Wshw==
X-Gm-Message-State: AOJu0Yyveauv00UFcQAV5morTR3jgwosHuDiMeG6oEtK4gc7+/RhOt0t
	H9RW9dWk7q8slvYAts99H3Ksqx2lGVIbcxxgY3CElH6EkuKQP3zxAYiHtXqsNg==
X-Gm-Gg: AR+sD13ZNJuCXDpHamx8qkmYu0oeGM5eqFQnZRvgZBuguHHFKro8YNBwV7jiP/GsVFb
	KWoDHR+F5xVXrC8F2G8vaRciXGgHXm58OV6Zi+Vjkxz1g98lMmhlhV81cPdYW5yHm+7hySyhQY4
	j2eUn+/AvhRUrOTTMmPyMCt2qF62MjQ3UcEI94JYIj6xcNFR42e0Tq/xQGDcSIEKz56FuBbZ2yc
	9cf6B4d0LWaDGyNBvE8hsr387i7iPsmSM/2R9a+HnAF0BFUC8kp/sUFaFOCpMmfTCVevyK7aG+6
	RzvKcp35eX68xxVsJQpomBWR7vS7ZVvsL4JLaxVFkcy0LeLjG8n5NP/jKz/bdnArpQO50JohTaj
	Pn6l3W7VkoMgdt08lyDpOoBzcpUT8hU6a7fDvwq6rjkX/Si49/71n8P2S5fRBsKUn9iI89FuYnZ
	xe5eQF5mxF9MH0/m/e+9QR7rvbmemdBhjvOcftWn0DOqbJ5B6ExL3v3MK8lM+YX5o=
X-Received: by 2002:ac8:5d16:0:b0:51c:a8e2:57a3 with SMTP id d75a77b69052e-52ce6180b12mr57508861cf.28.1785940006971;
        Wed, 05 Aug 2026 07:26:46 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce8975b31sm20831431cf.28.2026.08.05.07.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:46 -0700 (PDT)
Message-Id: <53f1fd576379a7331e827a2384605a1445f85d86.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:29 +0000
Subject: [PATCH 03/12] mingw: drop the -D_USE_32BIT_TIME_T option
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This option was added in fa93bb20d72 (MinGW: Fix stat definitions to
work with MinGW runtime version 4.0, 2013-09-11), i.e. a _long_ time
ago. So long, in fact, that it still targeted MinGW. But we switched to
mingw-w64 in 2015, which seems not to share the problem, and therefore
does not require a fix.

Even worse: This flag is incompatible with UCRT64, which we are about to
support by way of upstreaming `mingw-w64-git` to the MSYS2 project, see
https://github.com/msys2/MINGW-packages/pull/26470 for details.

So let's send that option into its well-deserved retirement.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index a464b2009c..cc0ed63af3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -768,7 +768,6 @@ ifeq ($(uname_S),MINGW)
 		HOST_CPU = aarch64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
         else
-		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
-- 
gitgitgadget

