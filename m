Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED4C30CB41
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662678; cv=none; b=ldX+wOtYw5INTos1Jdll/YZLjCXdOO4Qrk+HR31nyp8OBVcqslP5i8r5Ldat4uy+V//78SpwxDNWwj3g6xdaab5+YWraAXRCmi9RzfNqNVEzHCmCiVwPRtgvNtGvAv5sNL7zKTCyoCavAoWAPPVsKFPnw+x6Ey2wpJU3JpTtdZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662678; c=relaxed/simple;
	bh=zLaLm+acLxRKWT4dJMbCriLwPg8F3tVK9tlJCwmesl0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MiukIzIXvyPiLOUnn+2I4Sk4MNjEOepd+OfGex5RNSByDrbA2gxDVlzKOT1RoXj7tGqoT7lS8He0YmrqfjVsJyLbovKu8vFIrYgCrK4vKa4oW5APTD6ThulVPEO4r0qkLY5Lmil0HOBBPwvXqW0G3BF2eO+WkB44Mm+Ab7epPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhxDJHIz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhxDJHIz"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3322e63602eso3364651a91.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662675; x=1759267475; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/f3fVkZgqxlrBMT+OkQorHDqPi/LadWJpexffwlwBg=;
        b=UhxDJHIzlftDI6C32UlTupm3+ZJRF0y/HiHfoiseMVBij91Mso8djojIArJczL+xhR
         NWI/T6dRFfIumM2uQhzI7WBiA9ssKD/xyxlDjga17REAMWokFE8bzjnFhQN+E6CDQL6Y
         L0R0Zgd3yEMudLFpqYATKkCZGgpcazD2G37C4Ju6J/eaJ+mFYFcaksAfT9JMVUfPTeSe
         woq6Y94erUASINf2o5zLWzNkRIj8VuSG+lqRw3whH1VG4DmxgmfhksV1zdC1Hm4pGoVc
         d02k5V+S8VBxp/WOgs13tIhHQ71NPkurPyFoQrJIaONyJc/QM5wWGdh5Rygtr0Gn+CKp
         cmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662675; x=1759267475;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/f3fVkZgqxlrBMT+OkQorHDqPi/LadWJpexffwlwBg=;
        b=XdR/ua8Y4fRtjMhxOmJSs+QLiDuqFybLHF6Il4nvNHhs2t1jhtuIjmPIuEuTnfgz2D
         j9wYsYsIQCtIbfBYMgJS9tVSvvvipx1J1ePZ8lrf4a1O6zZ+fB4wb6TT7aLyiVy3xmCE
         lj1OWZW5CuNfx7GsovTvvIWuEck/K+bZMbQ5MwNnuyfp52xYF53J0R+CiiquT2d+lsdH
         tIdquN/oOr/ms3BwWxiHypu1jav5Ftlq4VlPfkjiFdSkKipMBbgAbrdMG418yPwyvRyK
         5e18Yr8zv2JMs6IT2X8+hq1sfDYIZT3VcdZduhT1pEfZdscW4Kdxpvk7rOzS40us/DxC
         ZUqQ==
X-Gm-Message-State: AOJu0YwtMPHhc5KaXlzlHtoUJA0hat/oEpt1ZqVCnwNObrWtWZyhlktX
	acCYptQVw6Eal16UYAwDymD+fyMkvhOeL1sKl6Ysv1IKsFGzKbmO+Vbpz6XqFQ==
X-Gm-Gg: ASbGncsBqlX1j4eeH/HjjRU/bbcndF0lM/beoAohP6noniR3juxHvOGrzDG54ma4Mce
	AwZVg6wOJcnOU0CHA6oI0IjFMhxHDpryrBzznUxzd11Djn87m3wlK6pmR+C0UwIHmyatLtMA0yg
	TP9pccNc6GKvnaTWv+d+lrVSxo0Yb8FNAXRK1lmGsOOz5Hjploc5tqFZrrzTwhz52pF7LKmoOOr
	FeIVyxIIYs4Eg0XYIIkZLeIg3mLQSJl8PI2Xtrai59rrkQnGZ7oU54rVsSwm5BVKmbfli8AyF0d
	0cmxpQDj/6SsyJDkTNJ660GVdhgZzks8Pcg0wPujCDneccbfdfH2ZYQp2rtVxvecxXFIFbPvtv/
	Bu/H0VxHXiktBG2uyxnR1a+UFrpjC133FaoUa
X-Google-Smtp-Source: AGHT+IHnvv6W2Rk+ss6zdy03EkQQSvGX4LyKDNfN8agdvzCb77bdGBog2pCf13Yg66Nv20RRSDsnaQ==
X-Received: by 2002:a17:90b:3f87:b0:32e:42bb:dc58 with SMTP id 98e67ed59e1d1-332a9704ff6mr4201211a91.26.1758662675415;
        Tue, 23 Sep 2025 14:24:35 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bda0e0esm119985a91.11.2025.09.23.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:34 -0700 (PDT)
Message-Id: <0cfd75b1ffa3f02cf1230866e6a060e653691825.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:19 +0000
Subject: [PATCH v5 02/13] xdiff: delete local variables and initialize/free
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

