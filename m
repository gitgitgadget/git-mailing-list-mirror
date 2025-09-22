Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC889317703
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570712; cv=none; b=NoT1BFA7Pu85wbmawRgj86PUAYSIzS+vQnBnNP7gNguD3QuNTHEtK0KhHlU5hKf6BY/YEGZK9nSa/HHwOAYJhKXHST1Lw/hiu49UyZJ1N8zaVKbHyv6JDS9X/6ibGfekjMwu6v1SV0adSrONKjNY1NpAxSuukk7cU8Mn18B8dEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570712; c=relaxed/simple;
	bh=H0vk7Iho1uobFZT1woK07XACFDhpd2nfLTMK+RFC4Hk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Rax0qXI25ZkNRAG626603R/Doam6z0vTX9tBa/XIG8pRbkFP5yK74DURk756vukrbsyeih2PeXaRuuwd0r6oKyb5HLUGwuxzMGDGpI0uzq35p+FW/WYGewgjxGSVUaKZssO3omfqZQv141oERQHk+Sxymrb3Dlh1S9nMH8EncOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKRgnmNo; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKRgnmNo"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-88c347db574so154344939f.0
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570709; x=1759175509; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNoB8dA3QXZovXWByOA1SSyUYe1Pg3dvSpPs38dGyIc=;
        b=HKRgnmNo0rXjdfJwutikHGpyOFyNKUdUWLqAJ5d5H/n4Msa3n0rF6deh1eOCUApNnY
         HF4mpIibNhclo7/4KnPk0ipZJRzkqeL1yAC4cD0ZYmyIUJy2WhjeaWuc/2ytXAoZuihV
         KXgB8qsuBwEWgtYzQlKdOlDCgX/eRXotMBaMF0ghh3zwiuzX5TrE+9ltm8IzSn+sHAfD
         dp8g0mgKBHghiJt8pbGXVavkGKORY+Y+jjO/vSV1f6lUK19GtyLxX1K4xqyA7mTW7tCa
         8nMjzp8Viwvdp/EtlHKu1eHabzxaAO94MjLsTHr8CHOx/V1UK7niXhTiojPmgz1S2oMl
         fvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570709; x=1759175509;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNoB8dA3QXZovXWByOA1SSyUYe1Pg3dvSpPs38dGyIc=;
        b=j4XbyFPxrPvw/3DU/Zjjnb1HH5BmyLosSAqZrm4Z16iGP3EWbQ504qnQJmQsqJewSm
         Nn1PdlskP130wbh6JFswjgx+J9Yw5MwArORpVaoCmjl0JER47qxzoZmSkUrwiKiszmlV
         5+mlZL1jxvYK86sVGTynxzzf9x6vFNSKyQc8qogzgMVq7+cbKiQAWluve4OdqjC+9+pE
         i+pB8BoL5zz8oAT4NgQZDP4tDd9eaTrFL/kDUcNaWg/T4g3VtxqnsT6FtW1O/zuz7H0X
         AHxy+wAOqTsnt2DO7nr+JP1N0/QU3vnSQDOO6lu5QndMK06mZ/QkBUdtRcDRIWybzIyh
         6hqQ==
X-Gm-Message-State: AOJu0Yy8ddjNd3KmJcLerBC8c02tlSlqgUMBuPRYMv8LyyYkJKmk9/SF
	QR15dNUVpJBOmWsqk+KVcrzgJDSuZIEreuXhjKOui78bZut+Yi65EmFT2cVbyA==
X-Gm-Gg: ASbGncupWIhkzf5M11aXmAkleCcoZxzo4DBb1K8YUIqH8ty+6We8wJOq43vK/EGnggr
	x/Ze9ixvp1LEfHvRzPaiNyt/GSlcVkCKuXwBTiQhWQbsdtcDgdmYUDbAnwOmipVxJR94LZcrqwD
	yUtbhLgsM6L+Z7Pc0UoOwx3PSsjenVP8o6Y+BAPSTID8O1kaGQDOiECjCkkRsfDctFGEa+0Fwts
	epW02fSzYv8bOrSePbXgyOfZEa0SBE+d0dorgajbaRn21Tswn4DrU1VrwZxX/xfRT1AsqxM8CXN
	Cb5TvWuyYAxgekVQ1dCumtX3nwTZ7baM8FTjZwbK6ep08tIdaLl/PyzeW7fNPdcNShwtXIEkmpF
	cuHsnbgZfQCLT5agc3WR0EnJNE7Ce7WsKonuu
X-Google-Smtp-Source: AGHT+IEsvtiOoj5LsC5Lu1PvSt7bJ3iuQpvFA0Ct34TRu23aL4T0BqlG8BUCcZHFNee8SCTzuExZgA==
X-Received: by 2002:a05:6e02:1989:b0:420:f97:7446 with SMTP id e9e14a558f8ab-42581ec3f8emr1636375ab.22.1758570709313;
        Mon, 22 Sep 2025 12:51:49 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5603dd64f19sm1073493173.83.2025.09.22.12.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:51:48 -0700 (PDT)
Message-Id: <13f00f5683353a649a5d816474b2cc051cb8cbca.1758570701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:32 +0000
Subject: [PATCH v4 03/12] xdiff: delete unnecessary fields from xrecord_t and
 xdfile_t
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
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Jeff King <peff@peff.net>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

xrecord_t.next, xdfile_t.hbits, xdfile_t.rhash are initialized,
but never used for anything by the code. Remove them.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 15 ++-------------
 xdiff/xtypes.h   |  3 ---
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 96134c9fbf..3576415c85 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -91,8 +91,7 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 }
 
 
-static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t **rhash,
-			       unsigned int hbits, xrecord_t *rec) {
+static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
 	long hi;
 	char const *line;
 	xdlclass_t *rcrec;
@@ -126,17 +125,12 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 	rec->ha = (unsigned long) rcrec->idx;
 
-	hi = (long) XDL_HASHLONG(rec->ha, hbits);
-	rec->next = rhash[hi];
-	rhash[hi] = rec;
-
 	return 0;
 }
 
 
 static void xdl_free_ctx(xdfile_t *xdf)
 {
-	xdl_free(xdf->rhash);
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
 	xdl_free(xdf->ha);
@@ -155,7 +149,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	xdf->ha = NULL;
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
-	xdf->rhash = NULL;
 	xdf->recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
@@ -163,10 +156,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
 		goto abort;
 
-	xdf->hbits = xdl_hashbits((unsigned int) narec);
-	if (!XDL_CALLOC_ARRAY(xdf->rhash, 1 << xdf->hbits))
-		goto abort;
-
 	xdf->nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
@@ -180,7 +169,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			xdf->recs[xdf->nrec++] = crec;
-			if (xdl_classify_record(pass, cf, xdf->rhash, xdf->hbits, crec) < 0)
+			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
 	}
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8442bd436e..8b8467360e 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -39,7 +39,6 @@ typedef struct s_chastore {
 } chastore_t;
 
 typedef struct s_xrecord {
-	struct s_xrecord *next;
 	char const *ptr;
 	long size;
 	unsigned long ha;
@@ -48,8 +47,6 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	chastore_t rcha;
 	long nrec;
-	unsigned int hbits;
-	xrecord_t **rhash;
 	long dstart, dend;
 	xrecord_t **recs;
 	char *rchg;
-- 
gitgitgadget

