Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75921CC7B
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921374; cv=none; b=ZLcX6+DcKdkpg7ZLr3g/6Hw/msqorO4BwI88QKWCFTQN/cMtwQgY5B+FgssmzbZlwZAIVf52RH0l/tkOKrH5Q1uVmTgflSnwoQfkJnmOKTtWgYauoSOpfS9LrHqwC/HnVy27j7YfygZsJKdgxNqoFkAblRutrU2Eqt6QBvcPHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921374; c=relaxed/simple;
	bh=YIilIqca+n65mmS8J+ZdzxjRx7Cs2dxlrw/1lq6EKpM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fDwidPElYrtEj0cA1wBMT2K8Z4tWEkEV0OoNKnYZ//5ycI+tkYLShSjkoCA82JW3udL2L698wPJrzRjDsPPGRmTCG1TxF8t9GSW2L2m48qGGrR2CIUkPlmB9lauJr/IL8CQCwvUaPNQ6YG+PL9GDRCj7TGahkyq1Cmb+C2m0a4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4UJZ74k; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4UJZ74k"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c79f0a606fso41637f8f.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921370; x=1756526170; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIDXsU/xFaq4iC+H19Ui1PXwG74bqfF/kpe893jD03c=;
        b=X4UJZ74kKkuPxzuUkMk6cwBaYlVfuuBX2VXNSbnIbdlXPoo8RBQi1E+e0BZ0RRXxDq
         vxIfFMN7gHHix6J5Crnye+iMROLMvHdnhYoaT7X9YdUsjAqz7jxKYIwqUpjyELHKcG0D
         Wf3d1nZzpzgXs9ysgTgS260BWQGjB9OjDaYdCjVttnM68SKOsyXeN2AVxy1QYM41Fk0x
         yeuil2iuihqiw4VUGiD9AkrXC0K7oqsFTSzXS6bCpnYpxivoo6hKtgT7Giw9lpaEXmQA
         QgGRZrfFNzoOJbFtZDCm7qFzjcorpN5SJuVALEm9SOvjAjpE7bKaOYu5Kb0b2MRCyl67
         UnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921370; x=1756526170;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIDXsU/xFaq4iC+H19Ui1PXwG74bqfF/kpe893jD03c=;
        b=fNdcC8Y7EKoEQ+/JP5oBVKHk749z1jNeSU0p9EUt8Ilc5bZtyKaZ5Urs5vZfwSLQWM
         pNTdiMJojnA+vb5Y01QG26euvOXB0pKYY9E57l/8ReY5ri6YSYH2TZ3Dtt2Uy5SUigFg
         +dh8LA7fAXU4JNDiXMdmxVlDlFx/Em1HtlJ/plUQSqsiu4Uvb80Ct+H+5JrrRXNbS52t
         kgadkYlfLWVjDcUn7x3IbreNu5AK9/EswNOY+WQdygCs1c9XHeMV4HK54rukUvGB8ZDL
         ohssivHVlrgu5HOqsmTQPJZbgcq2A17QDxIG6LYp1EwSxUaT71kzs9xl/Px4hR3erGmK
         4AyA==
X-Gm-Message-State: AOJu0YyhfPQr3N2BtJJu0MMiA9VTSetEbO/jaWCWVAHnxwDi4roms6KB
	WxJcSAe36ca5q6j+j27m3Sd0meumrCSXDzFBEuXkiFHdt0vW85YbiP4QQQuSWw==
X-Gm-Gg: ASbGncsjkAaSs3AID1imsTRP1ErbEaKTtBbCMiL78Y6lqj1HyfhBsyIKASJkeKRi4Rh
	1NMAPRCNQkKDnV42Gmjj/ARrS9F9exQeLGIfA4V5GL/2vhYTtOfEVqdPbHr4fjsOXuJNzTGhSqg
	xPR5fuh/C1UTuj5xrv/G9CeybfOnLrmo1hJIVOit7BxxUuxSgOoiqfJP/ygY2jAl4dOe7XRQdiZ
	WANOLp+I17+EPRzDeH9F06iWPQ6uXp0W3nhis1jGF4e5CDFbbm3KJhOWz5BxWY4ueQ8PJHQ164D
	7e2uWyftSnECLQBE+s54OFXmzH34oy5fE7PiV1bVtYekVGNZ+PvsdpWCWIK4EW9FXPipC317Uk1
	pxANxzj1DPD94CTd4HQb43/AAHBg=
X-Google-Smtp-Source: AGHT+IE6QwvesnN+61Z3kERYvlUS4kCb7JeIo0vg4ehaykUUp9VEAml3v/i6gVWxKlfHHsGQ6Ivrng==
X-Received: by 2002:a05:6000:230d:b0:3b9:5002:3b4d with SMTP id ffacd0b85a97d-3c5dbf68962mr2956156f8f.19.1755921370049;
        Fri, 22 Aug 2025 20:56:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm1830299f8f.47.2025.08.22.20.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:09 -0700 (PDT)
Message-Id: <21bfb9f08836898c6e46564c3a2ce65cdcfa4471.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:51 +0000
Subject: [PATCH v3 10/15] xdiff: use one definition for freeing xdfile_t
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
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Simplify xdl_prepare_ctx() by using xdl_free_ctx() instead of using
local variables with hand rolled memory management.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 60 +++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 00cdf7d8a038..55e1cc308756 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -129,86 +129,74 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 }
 
 
+static void xdl_free_ctx(xdfile_t *xdf) {
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
-	long nrec, bsize;
+	long bsize;
 	unsigned long hav;
 	char const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
-	xrecord_t **recs;
-	unsigned long *ha;
-	char *rchg;
-	long *rindex;
 
-	ha = NULL;
-	rindex = NULL;
-	rchg = NULL;
-	recs = NULL;
+	xdf->ha = NULL;
+	xdf->rindex = NULL;
+	xdf->rchg = NULL;
+	xdf->recs = NULL;
+	xdf->nrec = 0;
 
 	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
 		goto abort;
-	if (!XDL_ALLOC_ARRAY(recs, narec))
+	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
 		goto abort;
 
-	nrec = 0;
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
 		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
+			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
 			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
 				goto abort;
 			crec->ptr = (u8 const*) prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
-			recs[nrec++] = crec;
+			xdf->recs[xdf->nrec++] = crec;
 			if (xdl_classify_record(pass, cf, crec) < 0)
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
-	xdl_free(recs);
-	xdl_cha_free(&xdf->rcha);
+	xdl_free_ctx(xdf);
 	return -1;
 }
 
 
-static void xdl_free_ctx(xdfile_t *xdf) {
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

