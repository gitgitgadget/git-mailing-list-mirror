Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDBE3ACA45
	for <git@vger.kernel.org>; Sun,  3 May 2026 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777811396; cv=none; b=Q6bGRH2A3nrBZotiyAn+dFtGUYBNZCmlbsExb9Cj5cXGm9CB17QECpE2XLpSo0u2Mkq7rLPK6M00Q7HVGfFmlCxeGbIgYzmg7KxGP/uor6Q80MgiDrJORL5+sLU8IXK6af3Wz8/8s9gPWWQvBd9AxasJmFsYUx9HaXQcAFQ+1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777811396; c=relaxed/simple;
	bh=zawnHrD1Ig3pZPzCap9A+W8VJ10t2mEDsF3m9OC1Ako=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=pWL9k7QdIB87hEomXKcxUEE47lyUF4AS3pSn/Dapg9C5pLS4VZw83Zy6FVAzlqfbI009xeknLOcHuCfajsy9lhEF92oIauvtMHIucb07v8JqVdrQ7I8kR0GtHW9JeADWfO3CpCmnNdTyOYeMIJm2UH/0py2PmQ5N6Afwm+EF47E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpL/SQoE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpL/SQoE"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89fc4147f2eso43347186d6.3
        for <git@vger.kernel.org>; Sun, 03 May 2026 05:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777811394; x=1778416194; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=67IwxZ72ixf1mui2rK2D7NvbHsFQ4YHwcUUuLzEFAZ8=;
        b=lpL/SQoEJa023OsWLXrfEe0getYK1TPEbPRqWJpZGL50MDPOE264WRjhpklYeKEqbL
         G9xef/YZ5zIem6ew5QW28Nf8WC9EkErMzCW+VyP+krygXbTtKF/Qn8YwfXBldr5XkDIY
         hIiISs1b64N055A6jutUTtt88ypvQIRCdQAHB68CuRLt4Z88KURsQWHhdt4CGCaHXjK/
         ggUOuQviclms0TpDI1KskWKrOW76K1UNZYJsyWHjci/8TpDNiuPVxMS7eUfysd36nT5V
         R4WbWDl3tAWK45WAouFutK9Mb3TXkJ6pcqpRN4cGJpSDUt5KE3HLTZqHKJUMlf/MfFX6
         sFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777811394; x=1778416194;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67IwxZ72ixf1mui2rK2D7NvbHsFQ4YHwcUUuLzEFAZ8=;
        b=EyXb6G5rB9kaXkRWcV2x6+Yl+mtF6lBpZoLEuVoEihLQ7srzkah/htk5ZSOXZGxpJz
         SotghibSyEtJ4+aGGWTvseLOQPeFfyTCxZFqmMms/IEl5Zk+c9Vi9DvbsrPdzjKtgRBQ
         AGg9+M4eEIHxVPsXejgJWZkXyBb8imf1Qy8uUYFMmfkjYr5ImWW/PwSp6fwtxgPl4TfN
         EOr1/HbcS+hkViPEbaYgjd7wzcsOPLVEfe3EfbJWy05A6hp/HWc5nyk50zxG5mJCOCz0
         k9gHRViBXcnH754L6j5zFLIBKVBVx7Uf9b2ME9mWOqXcSBjc/VWXmwib/xjjwfSvdVie
         IQzw==
X-Gm-Message-State: AOJu0Yy5QtwPzLt1W9JgwUuOUYZK16s6zEz9M0jMh8jddh+a+Fq8PWf4
	4W0uJE0MU8C6v6hqMXnd9Vrt5bLz2phsRBQ+7L9hkeIaQNlZERBqcskET8IUSQ==
X-Gm-Gg: AeBDiet4JUOswR3qzFCxxDBcxsnW15xPSfnBmr8pPON/1yUIyJdQnkezXTcBCduwUbQ
	zKRTiATTGmN7Y83GN/1/a1/iNsyHToDSz09RE/1xfEKAvM6YBhhxzVGwWLN69egcNLfSmMGIH3q
	zIfhT+JTo/3B4Jzn1bQMSna2NN1wMkLIwAmjVl/ZrhzEt05/8sN78bG71mLav58JhU6ig58trc1
	4Hw7ZR20//f/K2l/hXqp3L74ga24ibvdV9yAeiep9FtYJ+d48438jmatxq3yAijw9BHe2YZ3nCS
	R4gIwNB4A4zkMiPvSvWKD7ZUNMW1RYUGCvS1Q7xBCu9rcd0Gi1Vf6NXoneSp4EHVsPsDxqahyx5
	OKEo8gKXjIKgwZ3ix+89yuJ/i/1/1WZGlZE6Z8Wvq6zaDGEuq9WHFAvbhQsf69HtvgnOGiFZ9ms
	8LqQuiZg7N5Y8qjXv6Jf4/C/wneA+R1YTzOw==
X-Received: by 2002:a05:6214:5294:b0:8ac:a757:c1e2 with SMTP id 6a1803df08f44-8b6696e1925mr102190236d6.47.1777811393692;
        Sun, 03 May 2026 05:29:53 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.34.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538a293dbsm101686306d6.2.2026.05.03.05.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:29:53 -0700 (PDT)
Message-Id: <pull.2104.git.1777811392756.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 May 2026 12:29:52 +0000
Subject: [PATCH] mingw: stop using nedmalloc
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

The vendored nedmalloc allocator under compat/nedmalloc/ has been
unmaintained upstream for a very long time: the original repository at
https://github.com/ned14/nedmalloc received its last commit on July 5,
2014, and was archived (made read-only) by its owner on March 15, 2019.
Our copy has been carried forward unchanged ever since.

The Git for Windows commit that introduced mimalloc as a replacement
on Windows ("mingw: use mimalloc", 2019-06-24, present in the Git for
Windows branch thicket but not upstream) already observed at that time
that nedmalloc had ceased to see any updates for several years.

This came to a head when the Git for Windows SDK upgraded to GCC 16:
the `add_segment()` function in `compat/nedmalloc/malloc.c.h` declares
`int nfences = 0` and only references it inside an `assert()`, which
GCC 16 now flags as `-Wunused-but-set-variable`. Combined with the
`-Werror` enabled by `DEVELOPER=1`, this turns into a hard build
failure:

	compat/nedmalloc/malloc.c.h: In function 'add_segment':
	compat/nedmalloc/malloc.c.h:3897:7: error: variable 'nfences' set but not used [-Werror=unused-but-set-variable=]
	 3897 |   int nfences = 0;
	      |       ^~~~~~~
	cc1.exe: all warnings being treated as errors

The same source built without complaint under GCC 15.2.0; the
regression was bisected to the SDK package update at
https://github.com/git-for-windows/git-sdk-64/commit/188d93dd455
(`mingw-w64-x86_64-gcc 15.2.0-14 -> 16.1.0-1`), with the failing CI
run captured at
https://github.com/git-for-windows/git-sdk-64/actions/runs/25244795074.

Rather than patch the unmaintained vendored sources to silence the
warning, stop opting into nedmalloc altogether on MINGW. The platform
allocator is what every non-MINGW build already uses, and a fresh
build of git.git's master against a minimal Git for Windows SDK
upgraded to GCC 16, with `USE_NED_ALLOCATOR` removed from the MINGW
section, completes successfully.

The compat/nedmalloc/ subtree itself is left in place to keep this
change minimal; nothing in the build links against it any longer, so
it can be removed in a follow-up if desired.

Assisted-by: Claude Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: stop using nedmalloc
    
    Git for Windows' SDK wants to update GCC to v16. Since it is used in the
    CI builds also of the git/git repository, it is crucial that GCC can
    compile even the latter all right, but currently it does not, see
    https://github.com/git-for-windows/git-sdk-64/actions/runs/25244795074.
    
    Git for Windows switched away from nedmalloc to mimalloc a long time
    ago, anyway. I plan on upstreaming this soon-ish, after this here patch
    lands.
    
    Note that with this patch, I reverse the order I indicated in
    https://lore.kernel.org/git/00fd3145-b3d2-ddab-466d-d06fd27298ec@gmx.de/:
    I first disable nedmalloc for MINGW builds (and possibly drop the
    vendored-in nedmalloc from Git's source code). The reason is that I am
    still trying to figure out the best way to integrate mimalloc:
    https://github.com/git-for-windows/git/commit/d67535b61dd (Import the
    source code of mimalloc v2.2.7, 2026-01-16) in patch form would weigh
    some ~700kB, which would not only be rejected by the Git mailing list,
    but which I myself would reject if I was the Git maintainer merely on
    the basis of the sheer size of the patch. Probably the best course of
    action is to add support for a non-vendored-in mimalloc first, then keep
    the vendored-in copy in Git for Windows (where no mailing list stands in
    the way of large patches). Whatever it will be, it's best to fast-track
    this here patch to disable nedmalloc for Windows builds, so that the CI
    builds can switch to using GCC 16 (and the current Git for Windows SDK)
    on Windows.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2104%2Fdscho%2Fstop-using-nedmalloc-with-mingw-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2104/dscho/stop-using-nedmalloc-with-mingw-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2104

 config.mak.uname | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 5feb582558..3636b98238 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -758,9 +758,6 @@ ifeq ($(uname_S),MINGW)
 	HAVE_LIBCHARSET_H = YesPlease
 	USE_GETTEXT_SCHEME = fallthrough
 	USE_LIBPCRE = YesPlease
-        ifneq (CLANGARM64,$(MSYSTEM))
-		USE_NED_ALLOCATOR = YesPlease
-        endif
         ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 		# Move system config into top-level /etc/
 		ETC_GITCONFIG = ../etc/gitconfig

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
