Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55253311C14
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570711; cv=none; b=TboEr4BsXncN4LgjfgtqMFhI0L/Y44s7X+HV2+ZELmenlgaxQyOl461sct0RRKi/KTFu9+LWYkGLSmmtDfsyGD9r/TxKjs25AcQ6Bi8NmtdEFcK7prjTeLqfU8gq2KfsGf9ljys8zoIH5lO1XLOE11oYVDCdPKsQOv44ktyNnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570711; c=relaxed/simple;
	bh=zLaLm+acLxRKWT4dJMbCriLwPg8F3tVK9tlJCwmesl0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UfrZuvvZ0hVw5tKyi1EzG7nho6V3f1sftNWjj17MBfX369KLkykoAbnQDQOFsTCGYSz16NATT4bkDQoasnA4WUvssXiuV4G+9j7HPxvdHj2N6w5QIg73fIkJCHDSp9pjA5QedYDTjK4KVKbhNUqkYHX6O7bkXCbtXufhFuzCs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqII9u27; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqII9u27"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-425635acc4dso24144495ab.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570708; x=1759175508; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/f3fVkZgqxlrBMT+OkQorHDqPi/LadWJpexffwlwBg=;
        b=fqII9u27xZfyXiSoBxEdlRxnBNG29+BCedeNuCHEzbj998V8xgexbTg++yIYcrfj86
         4ZXEa02nlGAKXmT6l19y/8Dd2GyVjWcqffXImlaj+Y9l+376tu1mQ/q1oi4eluvSGx2o
         pA4B2d82nVRr270SoBRHWeKK+lV1vTX0rT/+RCzRKA5fkrJIZV02d40xV+jOZ0vfUXoK
         Tw1UlI7Err9KgMrX8Oby2ukDc8M9UZA4QIU6jehTiyioorlHUHpXad4ul5deRH0x5Euj
         CLtuJ1ideu2Myx0tERm41RvYQImz96+KWvqA9m6Xur2Eb7bPQ0+VnMkh/7oirG4uKh2d
         RQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570708; x=1759175508;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/f3fVkZgqxlrBMT+OkQorHDqPi/LadWJpexffwlwBg=;
        b=Wewux0b9vc8B7p5uA+TRID1YY/O1TqHt1jHB2CK8GQV5mopXCykP434BSi0SthXAnU
         alUdfpC03JzHVjTLrLt9549MSZ40TgnXOzZun/jQnGzFZJsVH328Z/lBusJaNgFTAF9E
         R7PW1QmQmlK3h+4zS+yo3JrrVEoW99jS+spsw/8iSlT6RgvQZa+SChOtuvjnviqCUm+x
         qhenSbd6i5wBtZWHm1J1Jgz5WkeXpMNPN1pa2rDrWIFkjPVDfz6crgFbqeHPUwf5u5aK
         r6lg9Sh46+rVYcmYxyCPlrXToyUAEjPEtBbgFxic0g4VSPA1jGSuB5K7oHX8oADbbj+2
         0U3A==
X-Gm-Message-State: AOJu0Yw255FKCMyD3UYm67Yn0wa2zTVWlzOMRLgNcWxxYQ+WRoMfUub5
	jk10ItsQydm66Vz4iztNHAFymozM55kuZVwF6avClzZZzGy1umTzRcm036LaZw==
X-Gm-Gg: ASbGncs/bnwfor7XjB7HJi8xFDXP3kngaSzPMuu9Duc5ksr8vv0haioCUUlRCueWuPv
	SmOktuhPUXRYQmX3g21x+6+d9qo1Csf127aeEObJW+uCYE5u4oHGc/wlvAX914bi5c2m8bVv63Y
	+HHfEiTl7Ik0QTJtmo+xLEs7fqzYebiiUc9ZutjMFZgcLDRaJZaE8CAHpse2/FCu2l3ncefwNM6
	QjSVjFT+kbQoYDyWoXCBbpPvJodT5syV5AP8OAkFteySXzRCVxsq9Ty4p+gBxnXMxFNKXbx0PAv
	aB4fojt4Hl/SuVR9W+ykZt+vpxjUcI27G3nDAx4PDiJ5YgMA2i+RkHPllFeB1UuxhvZ/z/gTZmP
	fT/Clm1TuoaftdFGfJ4KAkspcVQ==
X-Google-Smtp-Source: AGHT+IGH9wN94vNFm12zpqw/2TEr20h78e1iu/5z4fpP/+mE+7s+boyUA2rop4n1rkWXkp5hTGy85Q==
X-Received: by 2002:a05:6e02:3784:b0:41f:5e50:23f1 with SMTP id e9e14a558f8ab-42581e8ef84mr2095095ab.25.1758570707928;
        Mon, 22 Sep 2025 12:51:47 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d560d3993sm6015144173.67.2025.09.22.12.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:51:47 -0700 (PDT)
Message-Id: <9142f28fcdee62b323088d6d34cfc15fd4c58010.1758570701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:31 +0000
Subject: [PATCH v4 02/12] xdiff: delete local variables and initialize/free
 xdfile_t directly
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

These local variables are essentially a hand-rolled additional
implementation of xdl_free_ctx() inlined into xdl_prepare_ctx(). Modify
the code to use the existing xdl_free_ctx() function so there aren't
two ways to free such variables.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 78 +++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 249bfa678f..96134c9fbf 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -134,99 +134,81 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 }
 
 
+static void xdl_free_ctx(xdfile_t *xdf)
+{
+	xdl_free(xdf->rhash);
+	xdl_free(xdf->rindex);
+	xdl_free(xdf->rchg - 1);
+	xdl_free(xdf->ha);
+	xdl_free(xdf->recs);
+	xdl_cha_free(&xdf->rcha);
+}
+
+
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
-	unsigned int hbits;
-	long nrec, hsize, bsize;
+	long bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
-	xrecord_t **recs;
-	xrecord_t **rhash;
-	unsigned long *ha;
-	char *rchg;
-	long *rindex;
 
-	ha = NULL;
-	rindex = NULL;
-	rchg = NULL;
-	rhash = NULL;
-	recs = NULL;
+	xdf->ha = NULL;
+	xdf->rindex = NULL;
+	xdf->rchg = NULL;
+	xdf->rhash = NULL;
+	xdf->recs = NULL;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
 		goto abort;
-	if (!XDL_ALLOC_ARRAY(recs, narec))
+	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
 		goto abort;
 
-	hbits = xdl_hashbits((unsigned int) narec);
-	hsize = 1 << hbits;
-	if (!XDL_CALLOC_ARRAY(rhash, hsize))
+	xdf->hbits = xdl_hashbits((unsigned int) narec);
+	if (!XDL_CALLOC_ARRAY(xdf->rhash, 1 << xdf->hbits))
 		goto abort;
 
-	nrec = 0;
+	xdf->nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
+			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
 				goto abort;
 			crec->ptr = prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
-			recs[nrec++] = crec;
-			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
+			xdf->recs[xdf->nrec++] = crec;
+			if (xdl_classify_record(pass, cf, xdf->rhash, xdf->hbits, crec) < 0)
 				goto abort;
 		}
 	}
 
-	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
+	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
 		goto abort;
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
 			goto abort;
-		if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
 			goto abort;
 	}
 
-	xdf->nrec = nrec;
-	xdf->recs = recs;
-	xdf->hbits = hbits;
-	xdf->rhash = rhash;
-	xdf->rchg = rchg + 1;
-	xdf->rindex = rindex;
+	xdf->rchg += 1;
 	xdf->nreff = 0;
-	xdf->ha = ha;
 	xdf->dstart = 0;
-	xdf->dend = nrec - 1;
+	xdf->dend = xdf->nrec - 1;
 
 	return 0;
 
 abort:
-	xdl_free(ha);
-	xdl_free(rindex);
-	xdl_free(rchg);
-	xdl_free(rhash);
-	xdl_free(recs);
-	xdl_cha_free(&xdf->rcha);
+	xdl_free_ctx(xdf);
 	return -1;
 }
 
 
-static void xdl_free_ctx(xdfile_t *xdf) {
-
-	xdl_free(xdf->rhash);
-	xdl_free(xdf->rindex);
-	xdl_free(xdf->rchg - 1);
-	xdl_free(xdf->ha);
-	xdl_free(xdf->recs);
-	xdl_cha_free(&xdf->rcha);
-}
-
-
 void xdl_free_env(xdfenv_t *xe) {
 
 	xdl_free_ctx(&xe->xdf2);
-- 
gitgitgadget

