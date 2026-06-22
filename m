Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628F35201B
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117851; cv=none; b=nWy9/ErE1d1rmstzKMuIAvnz+hQLEbxrGepLPyOYY+2KBC/ALiceyrtzZ2WWLeZ/laR6CJYhOz1LTAl77Gu6ixhdb4ZDSqf5JIX3c1MMfiC0tV2Xkb8i8hflCy2xyiyb335aSqumI1LY3xurGfFwQwyyXHSEdFuTzhAXOtUWFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117851; c=relaxed/simple;
	bh=6poTppdd76CLmksk0rGQ1x3Tu9v0rlna077KQ9glcFw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=TZAQTvBclm/ItFQ8C7/ZseeqhfkrhRja8cEsLjtXoqGztyyHY658TXaGIwmUYTL/uy/y3A0/0md0fWJnmFEOl/Krsnz4pGEBu97wSpMsadBf3TicG6y4FHfN8dLgN7kmCjV9LaMRPVnTxBfFO+Wbog6QRczImKkiZEFrgve7iP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DifyLw9/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DifyLw9/"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51a14efe25fso19739581cf.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782117849; x=1782722649; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tp5GHzs1qRtK14+8MBYJKFXz2pjDrzXyk4M4icxtLcI=;
        b=DifyLw9/BVPH8NGhFgy0RgiBpX898/xh70qZs1V4E4sdyI9YpQ41OCOTQnqLM6BVIQ
         kkTNABz+ZzryElryY9rSd6IJ4zuLPQ9R+dlCbAcFF0qHfnJAWyhwnxk6oTE/pTubGVmZ
         T+EdQyIj5MOi2ajOLBnPgZiDwu1GtYQmtT3sm3kOvGdr08tL2H+gz4q452RWfulZKPFm
         yo3MDqppTvT/0DvDyu2DDKZY55i80fIg6OQup3sEcV3NFgve8DHTps9b7a+SoCLvwDgD
         D+SMsjExLQ74b3/sJdVezjoHI0zDmdsRcIm483pXgv+w1HwTcDdT2rRi9NtbMPTkif4B
         RH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117849; x=1782722649;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp5GHzs1qRtK14+8MBYJKFXz2pjDrzXyk4M4icxtLcI=;
        b=F6Uw3GDeprumFIouvA++8DKdBRuUpFgY6LZBBLCeUrhPqqB2lBLoKOlRghZs2X0tD4
         cN9wsU61FMdN2GocJSQaJPeB7k8zlFStxXMFmE/eZtiKOS9rQvjerCjzsHtWY1HKFdqR
         PLEVGWbm3li9cQ4x/PcAxG3XUBWg/pvc6ykZTY6D44h/4p88cGjA+TjkczvBMM6IyutE
         ON2megV9L5vSxvvR/s8JfHTuKUxXGt4nvZTxpjdMIfqfFsIJMrMx1QI3IBMHmQ5Hsl6R
         qjx4k+uSS+r7KIJBqin5JX0FuXndehT8vso6/pRZ4wdaCJ7EXczMgVWT8gz1LqfyWAE0
         d+aA==
X-Gm-Message-State: AOJu0Yxa3ZqXKLPLvpojZJpSYVZwZIHSVU3R+EEhqGK6/G0UdvH2LGm1
	0mrp52CpwwFdXtgh9rCKIVmiAPBwIPIhHKe2DpVkckCDTfrkM+pHyFDA1eV3ig==
X-Gm-Gg: AfdE7cn0O2v+1TYjg4JbpgxBDGKYDEA+8tWErSBvdnYuEl5K34CXiyqAgKMWz5hXQnw
	zzY3WrkR68gZYF9WLM7r9WNi+NVwxQ6gjFJWwj5MYmiHLZbzwHWfECAqncfOTizM2ejAND3d7ld
	2clEiPXxbVE0T5ZPCm1ITvFRTioTcvmrH0EVwAiiJIr+sikZIxPsHPSOFBUQSt2NjJbjPqvNGLZ
	9M/GAnhXTl0KzZuB+vm8eJ2M0cbD+b1GaZx3NEMN4sQnenNM7zp8QhJbl8lW/VVI7SOOENs0oBT
	9hiVqf2a67jOGX/C+KzfhC9O8FzieTXPt6S1ZPOVnvlTNUxChYBPzCC9zSHsFjKBbcOZ3wIk82i
	oyUTKGktpshBE9ijAdJSchA58wpbilyjb1tvsmFOUJj//3uvuGBfDFdpjxBIQbqYKetUJefXGmj
	SZodloHIxuykView8LTw==
X-Received: by 2002:a05:620a:290b:b0:915:c858:7d1c with SMTP id af79cd13be357-9208f832d22mr2067849285a.14.1782117848888;
        Mon, 22 Jun 2026 01:44:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.190.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921daa8073fsm872030185a.31.2026.06.22.01.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:44:07 -0700 (PDT)
Message-Id: <pull.2157.git.1782117847057.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 08:44:06 +0000
Subject: [PATCH] win32: ensure that `localtime_r()` is declared even in i686
 builds
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

The `__MINGW64__` constant is defined, surprise, surprise, only when
building for a 64-bit CPU architecture.

Therefore using it as a guard to define `_POSIX_C_SOURCE` (so that
`localtime_r()` is declared, among other functions) is not enough, we
also need to check `__MINGW32__`.

Technically, the latter constant is defined even for 64-bit builds. But
let's make things a bit easier to understand by testing for both
constants.

Making it so fixes this compile warning (turned error in GCC v14.1):

  archive-zip.c: In function 'dos_time':
  archive-zip.c:612:9: error: implicit declaration of function 'localtime_r';
  did you mean 'localtime_s'? [-Wimplicit-function-declaration]
    612 |         localtime_r(&time, &tm);
        |         ^~~~~~~~~~~
        |         localtime_s

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    win32: ensure that localtime_r() is declared even in i686 builds
    
    Git for Windows plans on reducing the scope of its i686 support after
    v2.55.0 even further, therefore this patch (which I had forgotten about)
    needs to be in that version.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2157%2Fdscho%2FFix-i686-build-with-GCC-v14-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2157/dscho/Fix-i686-build-with-GCC-v14-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2157

 compat/posix.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/posix.h b/compat/posix.h
index 2f01564b0d..e2e794cad7 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -56,7 +56,7 @@
 # define UNUSED
 #endif
 
-#ifdef __MINGW64__
+#if defined(__MINGW32__) || defined(__MINGW64__)
 #define _POSIX_C_SOURCE 1
 #elif defined(__sun__)
  /*

base-commit: 8d96f09e9245ddf80c1981476fcbac8c4bb4125f
-- 
gitgitgadget
