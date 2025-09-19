Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE824BBEE
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294998; cv=none; b=ENmGCU1RG37/xoQ/pgNjaM1DkORham3FpK3fgwxljUXivkkmLn3LTdmuKAzBy8HDZL3m49/Yap+tdKquGjZ7kefJU7qWBQOj8LhGj2zi7DUpHuoyTh7UarP/lhWznjCs5CKVplunSUYShdWN+qVOxX06pdGzxdAvVIxZ0o4BYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294998; c=relaxed/simple;
	bh=tdL3sbhllOs2HxTYEeArCw3djMbOqN6Cw57m9QGzwos=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l9pWAGWc1jPb6skYyLH3kM/CZn3+rLm3co0IziQdvvqdJnS7NKsSBVjlfipJnR6TTURItyatpgblMaZgUZGe5qWxZieGGnee/+EZLfBkZGo3AjfUzfcXNgepJUPnQIQxJYnbqTkp4+Mfj7wjsKeLvHg6ymrPXzrGnns6H8Petcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6ODQyNR; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6ODQyNR"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8877b60f7a5so83842539f.3
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758294996; x=1758899796; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5FbEnqiElnpC6FbWKiLcegXM5pLQlUSDTHfYtY46wk=;
        b=D6ODQyNR7OVoeh2wklWBofIDDqG7sTpB2grjCo67vayyMpI4v+iMXofvEZid8uiHNQ
         XJJ8dYJQj1MST2tQdlsTah9UquAtl7lydZU/MMz0dH4XDxt6o5H4PHeNu+tUcmqsYzAR
         g8u5rD5MRcRWS7RxNwr74yGNUg4qd6bYHPE0XIoOAL5rlngSoZOt+s7xhVyZzR+s+faC
         wMDkmXtptEmKt7X0zOmlvtJ0QFyszUUKrRv8ugveYZnt30J0FdMjFdZRabYZVWGs+8p0
         z0T6112hIntPtZqVVn330uu6Jpk0BDhQ5Z6XLqTK1FQHTq13Gly5ovl7wKB5aXtiREAQ
         UhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294996; x=1758899796;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5FbEnqiElnpC6FbWKiLcegXM5pLQlUSDTHfYtY46wk=;
        b=B8LdiQ3oWySi3sIalOCufWt2yUnWDEp85/FnFlz8dwDhAifMYLJU26hQGTELR36JWD
         PYUyo2WWw4nN2xubsOUC5kJ3cYnCNI1SzojEg93SQF56aZhFBIDgjeP8ALoQtAd3mpBi
         slU4bnhxLtbVX7BMKUlKYQDaXiUmZ18r5gcgBGtEkSS7Qs6JkhIVAZLiL+LHoC8lxSnT
         9TELMA43XGYJzTOefbi3v7ejmibJneYf0vSRSykNajrgrUYItekbyU5I/6p8J+8DnOa6
         gc77GBt29oh0xVfR/V70ePAXEwRdcmP2V6d6ejO5tKGpaUjSzL3yOU4in1kaZnTEaIYy
         QMAQ==
X-Gm-Message-State: AOJu0YzNKDcy41LCYPJLKuevRHmpLd80KTpi03MmW/GRdsm731Afo0te
	4X4rrObkLsieLsqERr9rssuEnTxeQIUp0EquPeDKL8k4WENicdvKdEa3Ke/AKw==
X-Gm-Gg: ASbGncsRDc7nXo61F/U8zv8zxfWfbC6RoxaTn+hB3iQlh9U41Eb4BdJmO8tJrvbOIbo
	Ik4s9LgUPR8AdmRo6yj8W0s3fqLW1V3bu77YR+CH50er89BFOK3G4Qyw0NNKdoG4VT7NLUSP9fM
	+VDr1swA/7rU+AzgYMenpJ/UNkr7umtrq1rqAywxeU254VFo6TQGHpd71ex+0pEJTWmNPzcUsr3
	0mE9NWPC6SCnl7Mo3wzTdhOwxV9jnIgdDjEyN0Sq1DJiKSS8G1wKpoFK/YnPVZmeIRlOgW2VjH3
	si+KnpxHKr5ls4SpNWbd2NHHnQQKCD0e44wMHmHwyknu+my+k/FWPSEow0vSL2k0qULEgT3S2ZK
	F58XvV+IpZPamHehUk5js2xD8Pg==
X-Google-Smtp-Source: AGHT+IEsEAc2zhFDStecsRWmxL1r0ESR6VX+ErggGTwtHy1D9E+SqcAZVOhaLyxI7A3Dgt2mzpsnFg==
X-Received: by 2002:a05:6e02:188b:b0:424:8749:df47 with SMTP id e9e14a558f8ab-4248749e1a1mr22380725ab.28.1758294995664;
        Fri, 19 Sep 2025 08:16:35 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.65])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244b299d03sm23505745ab.33.2025.09.19.08.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:16:34 -0700 (PDT)
Message-Id: <784cffcef564b31a32c401b35f33610b85126f7b.1758294992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Sep 2025 15:16:23 +0000
Subject: [PATCH v3 01/10] xdiff: delete static forward declarations in
 xprepare
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
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Move xdl_prepare_env() later in the file to avoid the need
for static forward declarations.

Best-viewed-with: --color-moved
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 116 ++++++++++++++++++++---------------------------
 1 file changed, 50 insertions(+), 66 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index e1d4017b2d..a45c5ee208 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -53,21 +53,6 @@ typedef struct s_xdlclassifier {
 
 
 
-static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags);
-static void xdl_free_classifier(xdlclassifier_t *cf);
-static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t **rhash,
-			       unsigned int hbits, xrecord_t *rec);
-static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
-			   xdlclassifier_t *cf, xdfile_t *xdf);
-static void xdl_free_ctx(xdfile_t *xdf);
-static int xdl_clean_mmatch(char const *dis, long i, long s, long e);
-static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2);
-static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2);
-static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2);
-
-
-
-
 static int xdl_init_classifier(xdlclassifier_t *cf, long size, long flags) {
 	cf->flags = flags;
 
@@ -242,57 +227,6 @@ static void xdl_free_ctx(xdfile_t *xdf) {
 }
 
 
-int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
-		    xdfenv_t *xe) {
-	long enl1, enl2, sample;
-	xdlclassifier_t cf;
-
-	memset(&cf, 0, sizeof(cf));
-
-	/*
-	 * For histogram diff, we can afford a smaller sample size and
-	 * thus a poorer estimate of the number of lines, as the hash
-	 * table (rhash) won't be filled up/grown. The number of lines
-	 * (nrecs) will be updated correctly anyway by
-	 * xdl_prepare_ctx().
-	 */
-	sample = (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF
-		  ? XDL_GUESS_NLINES2 : XDL_GUESS_NLINES1);
-
-	enl1 = xdl_guess_lines(mf1, sample) + 1;
-	enl2 = xdl_guess_lines(mf2, sample) + 1;
-
-	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
-		return -1;
-
-	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
-
-		xdl_free_classifier(&cf);
-		return -1;
-	}
-	if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
-
-		xdl_free_ctx(&xe->xdf1);
-		xdl_free_classifier(&cf);
-		return -1;
-	}
-
-	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
-	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
-	    xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
-
-		xdl_free_ctx(&xe->xdf2);
-		xdl_free_ctx(&xe->xdf1);
-		xdl_free_classifier(&cf);
-		return -1;
-	}
-
-	xdl_free_classifier(&cf);
-
-	return 0;
-}
-
-
 void xdl_free_env(xdfenv_t *xe) {
 
 	xdl_free_ctx(&xe->xdf2);
@@ -460,3 +394,53 @@ static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2
 
 	return 0;
 }
+
+int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
+		    xdfenv_t *xe) {
+	long enl1, enl2, sample;
+	xdlclassifier_t cf;
+
+	memset(&cf, 0, sizeof(cf));
+
+	/*
+	 * For histogram diff, we can afford a smaller sample size and
+	 * thus a poorer estimate of the number of lines, as the hash
+	 * table (rhash) won't be filled up/grown. The number of lines
+	 * (nrecs) will be updated correctly anyway by
+	 * xdl_prepare_ctx().
+	 */
+	sample = (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF
+		  ? XDL_GUESS_NLINES2 : XDL_GUESS_NLINES1);
+
+	enl1 = xdl_guess_lines(mf1, sample) + 1;
+	enl2 = xdl_guess_lines(mf2, sample) + 1;
+
+	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
+		return -1;
+
+	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
+
+		xdl_free_classifier(&cf);
+		return -1;
+	}
+	if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
+
+		xdl_free_ctx(&xe->xdf1);
+		xdl_free_classifier(&cf);
+		return -1;
+	}
+
+	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
+	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
+	    xdl_optimize_ctxs(&cf, &xe->xdf1, &xe->xdf2) < 0) {
+
+		xdl_free_ctx(&xe->xdf2);
+		xdl_free_ctx(&xe->xdf1);
+		xdl_free_classifier(&cf);
+		return -1;
+	    }
+
+	xdl_free_classifier(&cf);
+
+	return 0;
+}
-- 
gitgitgadget

