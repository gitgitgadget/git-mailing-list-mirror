Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6225D549
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757274327; cv=none; b=puR9dvDbRvbDqsN92kEVoCUa2NAgxjzI1OMawgH/HMzzswlgKfXeo4FR7N9W4uro5kkyGECiRwp7Fw9JSvudOyCSQPF6YX3Y0gkNbIAXzEX/6xz4WTEDAHSUcbrGsojnrR4XZRHF1AHJ1Y94HuXSuS99T0MVMR6o7AUipKJIKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757274327; c=relaxed/simple;
	bh=dU4wYyBhAcZ5PNhzGUmrvmmafT8Ew0yxTiWmx8xhO08=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nftUxmJweRyYuikKS3gdZ+mzaPxlfGjIwU0dtGjXZfxb3I1F0ekNv5OxpGlYeG8Yk93sNVJGOzl5PMOhxQWwcCQ4h5c3RJbTAMHKPPo0S+UiI/bWpIFJPOXB5kkgzjasKQ4bLjHPxUedVZpDh9X7h17LIfVg+t2AwzeY2MKioSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqN9UPOw; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqN9UPOw"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-729c1074875so25862816d6.0
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757274324; x=1757879124; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVAlKw/hlcY7GBqWnUlav549rDYQs3WDXpJiF1xIVls=;
        b=VqN9UPOw6PZcA2TbNIebFVYD4AuxOnz0gooPeqbnSD6c/yTtX2CXUNvtnOxwVbv3rH
         5esei67WqnEWPx+cc5zHMYPMJXmK4Xoq+9K6HU8SX62TEs1KvFGLKXXq8/GZ0tUlQpLz
         dczi9aXR7r9FrtOsACcdoJfkFCl0g+tyuZXrm7kOakNTipm+kHjbZ/HisjbZp2zZDeBI
         bkJWOLdrP2IKq7WTsvySnvjdkbfhZ9jp5YEvCA90qd2stNwUo90NIRD4mn1NF1Pd1NZ3
         ZrmBFFTsGN60zc5nnW/xdhYznCmRfTrpGqwq1b57Hs1liU0ru2yZjG1QhhBbXpfTYrTJ
         eKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757274324; x=1757879124;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVAlKw/hlcY7GBqWnUlav549rDYQs3WDXpJiF1xIVls=;
        b=fanw8qfgJaJjrBcoSOK2pc3bk4WJ5LblSRUOBb96Ux53LMWLGFdbypt30GDrRlhyHM
         XeczHwvekZd1Nt1rrO4Ed1mALOHRNCyrqhH+WP4f2MEMSYu51EzCcjIDHI9FV+IGK1ya
         660y6jA8hMZxUdK5LpFKupvmkEq7n3CSFVsQixHhJVRfO4qG/3WqOIqLoPpG+3A5VLJx
         +lA4Xah2J4vIzVwOFohQ6qRvm/oavRRIiJsQNe9sZ6ZTzuQyvYvwhe/Mwmi4Tkfq3adV
         wzuDNy44NaGqTa3+SfCbWkXfbmPjDdWXsmdvKYKBc+aNn6iLm9sW0roxOKYpyTPYN//a
         CnSQ==
X-Gm-Message-State: AOJu0Ywg4YBZypTxRkP9YsVHbpSbb3FbQ+jlIQ7FiVfU99D61fTHxGZl
	WRmz27tbgExCOhlPx0frK/8V97QBG2vke8c6V6L9NF6y7f4Efoj2/TMQs++ufMVs
X-Gm-Gg: ASbGncuTTQBQD2cIccfdsF8IQbm7H6SmIhtM8mQfeZj9T74suC4/gs3ODucQnxCOgTN
	vpvab+ZrqoyvmnPYxgngeU8p1ZP0dHrMZVdbSsFiwWKm1ipfIQ2UP75RJr2n2eX6s07zdRK7xLm
	s0zZ7w+D3pSnn/+IR9ae1xHLZj+y0Z5cMReZFNeQxo5ok8GQJvYc6dDBGWPCtay0CRQOFdojn37
	GQWO+6i3vYMcnSKtmf9F1EyExdTuxu0gL4vIv0tIPWhJExVenOcfRvWYn/M8boUvlefxwyBwrnj
	ujGRr/YcMTUhHPFE8kgw6TYG/bk7oEMp3HRifa0ESaqB/rLbtnZluN/l7IttFWiKabUbWE4pgXd
	lQ8Dd/tmGUamXEgxf8W3ZtBagXx18454VwQ==
X-Google-Smtp-Source: AGHT+IE2ZD5z+Llw/7b1IjZmaczZz6hRaZcqFhsG5ZTkbr3yzGd7+6ZLNYRnv0mWFNRTZJ7G1zCMxA==
X-Received: by 2002:ad4:4eea:0:b0:726:32d9:db53 with SMTP id 6a1803df08f44-739435ce873mr60553936d6.59.1757274324224;
        Sun, 07 Sep 2025 12:45:24 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.97])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-73fc2cdc577sm27229766d6.66.2025.09.07.12.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 12:45:23 -0700 (PDT)
Message-Id: <15832ad2715d377ed9b0c9f3de66cc4532cac2ba.1757274320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Sep 2025 19:45:05 +0000
Subject: [PATCH 02/17] xdiff: delete local variables and initialize/free
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

xdl_prepare_ctx() uses local variables and assigns them to the
corresponding xdfile_t fields if there are no errors. Delete them and
use the fields of xdfile_t directly.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 79 +++++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 48 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index a45c5ee208..2ed1785b09 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -134,99 +134,82 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 }
 
 
+static void xdl_free_ctx(xdfile_t *xdf)
+{
+
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

