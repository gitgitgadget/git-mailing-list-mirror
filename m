Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E91199931
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220982; cv=none; b=GDzhtImwDBQJ4B+OsKk/A0w86Jg1BRWhmK6BpIHnHR5W93Us1Djfu/QYuHwjC3Rz6ZtagiNsOal5bPKehkVYiU7oirnoib07hKKR8F5ltsEwYosokLmqHRzMcPfeU+VPsw/5X887aflwQfOvMkr9Z24opvmriOeD9ZvJE24WOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220982; c=relaxed/simple;
	bh=LMHWr/Jk/LCHA9l1VxqyJm3U48rkduLIbJrelWeCdfA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GlLe84Dhe6Qdg4fEMVlwQv/9HL5N7q5cgLF17rfIoodupgGmEmnyylCMeHI4+j8TVVb3jj2suA9cVqMXkHNP8rK/ykpG99otPJGCHJ/+BakotejHbblAlg3n2VkCwvv3DHvZDzIvHWM5pDZINIef250vs0hcNW/Ygo7C2r1DDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9+CEcMc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9+CEcMc"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so774716f8f.0
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220978; x=1755825778; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqOowsYrOMLRM9RauuBk8vQViQlOWdRCXqM9cNH/Jk4=;
        b=j9+CEcMcSS2PVxSa4uCftI6sLAHZ/CcCHWZdnxBhxYJaWesKgjxCgvo84K5lwGH8Ve
         SdOJiJkd7lf1OKuN6pq/Y08lfvruU7lUrXMSfQZAfWRYvqXFZuEOY6xqjguzNdEEsn2d
         jYvs3k3n9zKN5RvwIlwQOF+dPKZCAyZb8vsLpDQHpKGbMxuCbBmQkJybyAOo2LTOdNJX
         gzgMH6EnedeRxKtlgYLf5RjjjCeQjKRIlTA5nU6zrLYPSd/BRpkLlbVcIniLv15VpR9J
         JFlr8nYNqBiDtfJo5VBtLj7Mmcu3twACGG4hJvxp6LB0TB11yBadQBlcZXzl98BFFp2U
         v/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220978; x=1755825778;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqOowsYrOMLRM9RauuBk8vQViQlOWdRCXqM9cNH/Jk4=;
        b=I3umKwgaE1K0CFXm7SKAoxR1U1TofYnQPLoyj3NZsD60Awc5CT6JXsC4Lz5Pv9QSdC
         xWH8CLZs/hNjyWOT8J9MjATWrrNFUi2fXB4wkobcNVYvxd9V2kpCUZjTubFdI/F0o4Yh
         pMCalfjCwntDStG4aQY3ZGXSCpXZl/jJt/MPulKsek2tU7NAUvvl+nJdwGhA3Vth19tw
         PrdQ2pSu/cl+wwfF67ba2qhC4T5mOAzdp76V7AyfrEt3fg82zuhUwGloHc+oq3hIJCo+
         UfsL4/oIvMf4vkXmStISrMKHAY/UQJfRDR3DJrXkvT6J5u7z8qNyDftBqHxQ+CNSInva
         WliQ==
X-Gm-Message-State: AOJu0YxCXfMvgGoU7BgSI27FnSTzX0kca789KNBWuu07LyelxdiliYgZ
	+jNVsrJFY8zasROEn5BinrGod4H1JPBN4YTy9wM6bkLI9C4RftLGiU020wZvaQ==
X-Gm-Gg: ASbGncvSWC0G3+oSA4P13oLTUOe/Hw63BBHst4gvrS20Xx77uws0QMGPFQAwrG2f4lE
	Hw4zqNJyV4dsC2eK3ZC1FKHcNtwAZNBN0c4AGEY7GhkI9+IQ4nlQqRboKSmYqC73SbvLAS4anuc
	xxR7R3q0+6dzqEBuDngimAclU9c30ePJUysw/2l+ubAM4oHeBRqSYxjaetTbhkm4sz9Xeg60rCp
	RgKlfnfRjqrn7IyqLrS6hsqrau/Fqp3youQgEJy5jqx6PsLei+N0Rcw/njivSNH8PJHICGSoS0L
	rwBv51TMLwvP4nlL9Vl5fHo73Tddp2sIQuC1gy6HoFO2vO/QNGzBklYEuf7C8uUOmKBPzAbGeaY
	TjVzlGdBYqdu6z09feLpUm4pwnmcVAu3adkRg1Humm2BT
X-Google-Smtp-Source: AGHT+IEecPLeVOwDs4XFOrGBu5y5sgCW5OpiOA29tKziEZBlRz94r2SQzfAA24JJ8ZuniqmuF1fdAw==
X-Received: by 2002:a05:6000:2010:b0:3b8:d360:336f with SMTP id ffacd0b85a97d-3bb68a17b6fmr74023f8f.28.1755220978313;
        Thu, 14 Aug 2025 18:22:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c61a66esm39095585e9.0.2025.08.14.18.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:22:57 -0700 (PDT)
Message-Id: <ebec3689dcea838cb57b11465ea4340b8b84d842.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:39 +0000
Subject: [PATCH v2 04/17] xdiff: delete unnecessary fields from xrecord_t and
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
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

xrecord_t.next, xdfile_t.hbits, xdfile_t.rhash are initialized,
but never used for anything by the code. Remove them.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 24 +++---------------------
 xdiff/xtypes.h   |  3 ---
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index a45c5ee208c8..ad356281f939 100644
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
@@ -126,23 +125,17 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 	rec->ha = (unsigned long) rcrec->idx;
 
-	hi = (long) XDL_HASHLONG(rec->ha, hbits);
-	rec->next = rhash[hi];
-	rhash[hi] = rec;
-
 	return 0;
 }
 
 
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
-	unsigned int hbits;
-	long nrec, hsize, bsize;
+	long nrec, bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 	xrecord_t **recs;
-	xrecord_t **rhash;
 	unsigned long *ha;
 	char *rchg;
 	long *rindex;
@@ -150,7 +143,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	ha = NULL;
 	rindex = NULL;
 	rchg = NULL;
-	rhash = NULL;
 	recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
@@ -158,11 +150,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	if (!XDL_ALLOC_ARRAY(recs, narec))
 		goto abort;
 
-	hbits = xdl_hashbits((unsigned int) narec);
-	hsize = 1 << hbits;
-	if (!XDL_CALLOC_ARRAY(rhash, hsize))
-		goto abort;
-
 	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
@@ -176,7 +163,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
 			recs[nrec++] = crec;
-			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
+			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
 	}
@@ -194,8 +181,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 
 	xdf->nrec = nrec;
 	xdf->recs = recs;
-	xdf->hbits = hbits;
-	xdf->rhash = rhash;
 	xdf->rchg = rchg + 1;
 	xdf->rindex = rindex;
 	xdf->nreff = 0;
@@ -209,7 +194,6 @@ abort:
 	xdl_free(ha);
 	xdl_free(rindex);
 	xdl_free(rchg);
-	xdl_free(rhash);
 	xdl_free(recs);
 	xdl_cha_free(&xdf->rcha);
 	return -1;
@@ -217,8 +201,6 @@ abort:
 
 
 static void xdl_free_ctx(xdfile_t *xdf) {
-
-	xdl_free(xdf->rhash);
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
 	xdl_free(xdf->ha);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8442bd436efe..8b8467360ecf 100644
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

