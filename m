Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0455042669A
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500502; cv=none; b=sur6EFU5yaWVbpNF8A4heSVjxJnwcDHRFXdPPdIpEEVsEKlGJ84uZHssmDzct/UeMTqmCC+FvDxBpCfXOBNCVA2Xsrg94BW+hVYDZUrbuxa0D6h55j37gYwe8O1Y4mdIKgDkuUhxJzgXCX9aUKYyWociA6pzJ1Fig7y99kKd/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500502; c=relaxed/simple;
	bh=/tMhb1hF8evtEbXZhK5bKT9POH0y47YWJ6PEXp7J+P8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uXBTmVoqUzYOjQAn2puso8o6+US32yaI1fMZCyIQSv2Ir1+4QyaIOKkbImB9Z9/AYWaJtB/cuLN21OiA6mff7Kmt4ojba09HlUoF31nm96uQ4kUdTgQgXtbdVEcQUMhKfhFLmZ86oDDNdvfwXLthM+rSW1Y50yqLHyCFsl1gQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3niVWGj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3niVWGj"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8eb5ad01402so27789185a.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777500499; x=1778105299; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAh2YlWtHIQUSN4USii4XmZm0LRrKAOwgLHkCDgwEYY=;
        b=J3niVWGjea/qwoSbaWGgm9IhdlPzjChCLpMsXoDeNpAeJUP5bCzka8DwIT+8KF8sUF
         tIP1c97YlNbTaxBShEzTKj7CXww19wQHnvk0oNILYDKXVUuV/1xS06huakFoAqwTqsMs
         XoB4wtuq6jMiuFHn0s51l69s/akMQesWVQLVlaklMcbUVrMiAHgnYJ96XTJj1DI3TD5l
         RqENljmdeFfSkHID0A2rW+apITxVInH5TrAvBBzBwsimH9jCB0ePA1voXz3XXVugtCVU
         FSeeaSXDfBrUrt6NK2Plo3jpuQFmtdzSwKJf8DG3xIYoHSsg7exLT1yT716/DAeN1ROR
         4y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777500499; x=1778105299;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aAh2YlWtHIQUSN4USii4XmZm0LRrKAOwgLHkCDgwEYY=;
        b=SH/Cysy+i2OgVyMtw/Hz8JRIMCuYwsx7BA6YrG0dudYPju0dD+Cldc7ZGg1/2gj+Yk
         QHUoLlgOCvudZnhmOKrEiH4M4hm+8XeCQOhXnvtjlD/mpIpgtbfA97eAUs+U3mpGP04r
         MTx9KNoq+bIuseVgQziiNVfq8pvhmA9bQByXVlOwvHemHV4xwEcGxFULEVsPx/7HUQb3
         VyXHtqXWMKg9EKYXPX0WevQ2j/g1+oP6WyymaMxrb2QW9JW0Y6MBTR8imPZgRJodFEoo
         MBj0Vw8CfdmWK83DyC7+tTh2Z2/jpYTMK/XJ9IW4rpQj5k85pl+NhEi84f+9g+XJ0gAq
         5xUg==
X-Gm-Message-State: AOJu0Yy7+xTBS3KG6S4tBs4TxEDoq1TGltUwme276dgqCz2vfzs3Z+n4
	EjmrTB5oAqx1knAN6ZTEtrWElysLwmhSS4UtDlF4lpqz6drIFEu3gCOxG3BH9Q==
X-Gm-Gg: AeBDiesyUlwSyLfdt+4yuDmDLnFsRLMHyiVlgOmdtgTmTp3zVZ/QkHHNt0hGdUFXQMx
	qHUxYnNzvD2VJqZUF3qG9sAURobXXSIgiRIsoevsp4mSqvDxXf0KigE3oMY+wMKalqmhEeygMdg
	5M284RWrEEGEB/n6HQk4Ni1BqK/NZT4P7Ho2YEErSt+v3sEyQlKw/xvVZTM/ef70Id2naqr1zUA
	M08AEPL+fstRmdbczR9/fGKLIX2Dv/nWbclkSAuZC7lgjydMTB3eIK530BIiQBwVPbQpHH1Fh/n
	y34xl01zH5HunJe69+H9m+u/8J9hyphjw3ilVttufd64rsyxUWBOTY+AyTqbt28xOjm29mxvQYg
	OKoeT/efZIvEphBegQB2aUwQhHFYRgPGI+pW5bUyTweHgU1KBHlXDT6V1OCLF5ODE7ocI8XX1AB
	KO6WKb3L4OMQwOTAfGUwqWwfCMaIABqwKPLquFCPuHAY338cJWBg==
X-Received: by 2002:a05:620a:f0f:b0:8f0:10b0:9e37 with SMTP id af79cd13be357-8fa88e2f677mr93850385a.41.1777500499504;
        Wed, 29 Apr 2026 15:08:19 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.100.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93c713577sm328891585a.9.2026.04.29.15.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:08:18 -0700 (PDT)
Message-Id: <1822166fef0c5dcafb4f3c717eff235db6404342.1777500495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
References: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
	<pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Apr 2026 22:08:11 +0000
Subject: [PATCH v6 2/6] xdiff: use unambiguous types in xdl_bogo_sqrt()
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

There is no real square root for a negative number and size_t may not
be large enough for certain applications, replace long with uint64_t.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c   | 2 +-
 xdiff/xprepare.c | 4 ++--
 xdiff/xutils.c   | 4 ++--
 xdiff/xutils.h   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 4376f943db..88708c12a3 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -348,7 +348,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	kvdf += xe->xdf2.nreff + 1;
 	kvdb += xe->xdf2.nreff + 1;
 
-	xenv.mxcost = xdl_bogosqrt(ndiags);
+	xenv.mxcost = (long)xdl_bogosqrt((uint64_t)ndiags);
 	if (xenv.mxcost < XDL_MAX_COST_MIN)
 		xenv.mxcost = XDL_MAX_COST_MIN;
 	xenv.snake_cnt = XDL_SNAKE_CNT;
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index d6e1901d2d..48fb5ce6fe 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -290,7 +290,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
@@ -299,7 +299,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
-	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 77ee1ad9c8..9a999acdc0 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -23,8 +23,8 @@
 #include "xinclude.h"
 
 
-long xdl_bogosqrt(long n) {
-	long i;
+uint64_t xdl_bogosqrt(uint64_t n) {
+	uint64_t i;
 
 	/*
 	 * Classical integer square root approximation using shifts.
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 615b4a9d35..58f9d74cda 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -25,7 +25,7 @@
 
 
 
-long xdl_bogosqrt(long n);
+uint64_t xdl_bogosqrt(uint64_t n);
 int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 		     xdemitcb_t *ecb);
 int xdl_cha_init(chastore_t *cha, long isize, long icount);
-- 
gitgitgadget

