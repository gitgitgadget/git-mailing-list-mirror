Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753742472BA
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496554; cv=none; b=B/sFecoPknBYSfozpYi1PCnw6IfEYAJohRjXsDq+iV/IeEiHa1ySSI0Zhsym5mkJ87ct1JT52NPRpgTFN83C/cMybubRvr+1CqmbEtBfBb4IMOLkJlyEfUCQrghL0IHZVHGhpZDk8Bn0omQ/WoqRJ3lRdijUquoE6njxkxujLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496554; c=relaxed/simple;
	bh=GHBOcfRdjxUBijF8talmqWOxEFmlAPdhHM/I6o/0agU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IxK3rucxw9Ags7zyLTjgYBEkrNgeWPje3O4eJDfgJIW4yDzU00ecIYN6417whtgtKQRPA6ikUa5/aiPWFtloerxECc66Eob7MvSW69RezvrURsbFwT3uvUPv4aMLjwMBSCrcaTadEOn06WsZksbFH8uNg6yKTIPaCWgyFp9ZBHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMu82adt; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMu82adt"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7718408baf7so2436715b3a.3
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496551; x=1757101351; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXLZ0/G6joU54kVKsmwoiufYy4k2UtOi5JKTavOZGBA=;
        b=dMu82adtLWbXvYIlq7htRM4peYaiQjHw64jDSKb4WWo32Ej3LKjlovAxHBkjaNagNf
         21eFWQak/WF+BA1Ovs2boalzaiYk8cG2PsjLqR9pQITzchwjfiSRZawM2vr6YBybr7o3
         JN+dO1/E/2PToF/vhGeVQgDuZICHJf5ZXn0JsN+jJM4P1t5PJM+xiDJ/08ClfdTtZK+W
         mdhjq7HbtjIpc763yHX+iwqoHuqhCUJCZhBhAcM2214AQ7fk+T1+uv9nFBa3+GLiO0lZ
         GaN1ODt/4uzAPrN4X0TNfFemoPj6aRN+h5zQLSVRao5kS4iKgvQ66u4VTdjHSTUv/zG4
         qdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496551; x=1757101351;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXLZ0/G6joU54kVKsmwoiufYy4k2UtOi5JKTavOZGBA=;
        b=Yh1Ss47J4X+lULJOJE9HSY2rGVbrF+KUyPpAw/vUC1xB2ROZEpUyrpkY3NeGQ82w9z
         j572QPAq6nU1StH1CeMz/U6xbcyZw6tD0n7qdOK7FrdlbLO10OvoR43VrVGjvqLDQt4Y
         PO8lOTNfbdRnF8aMfV62cYY993mkhttjjXTsqjnhsuEXOKoyfEAox8nezy6W/SZCU8Wq
         WVFAstKahahr4JxOUxrOvzIuA1+bdQwKFzMmQxCDWtee7M6cBW/JqvRUxu0GYqwkBUJ3
         xxx8+YrKwalICvHnoplGiTcn1QV3SET9eRN3dt52fYG54XeS3lcX3gUxTE93UUeq0gk/
         OnRg==
X-Gm-Message-State: AOJu0YyRsxlzfTacnljzbpwUdRC5MSEmKVFfKc3EpKq1PQZyz88WRskb
	YdK2ZMzJXal7Q/7N0ciJWuqX0pL2sp3jGAMuo/jDjTjxgHQK+fqyMVHaqDAbbA==
X-Gm-Gg: ASbGnctwD61IbKZ1pS0MH/nunwKA2bE4Gkr74BMCE6qRVmv7xSZIgSRPz2gi9t/+v54
	DAc/lp+4wDBkRenWla1+WL4Uw4Y0WSnLvBhwh9ALAEKFhUp07eYWuS+TG64/rZFXX7uQKdAX6FD
	cdwC8NSIC4b2JelUt/Nq11srvQJUMUXl2aOuG5dIRMq2+EqOiDLbLd9Ze2rOBJB3+beoT8prk0E
	TU9oeXNGbNezuV6U9VwFMOvjq8AEdkP2Uxeo6V0PHHtmj/4xutXE3cMBExSPEXPxs/LqGhlJiUV
	/FvaxUp1ZCxmLBZusj2MJuKXYLC3zqmNaoQLAR5+QWCoLCFY1mCIus9ny2EaWKgtjSk0CuSidnk
	JXfrQfErXFI1vEW9MZxFvXZninsI8i4WUpbv6JA==
X-Google-Smtp-Source: AGHT+IH/aWd8OQX9wCqSYoA54xgEIHZA/Fdokv8pcW0wjrdfGTDkI9WAfUIhYAbz1wtsic+ZJJttOw==
X-Received: by 2002:a05:6a20:734a:b0:243:d1bd:fbbb with SMTP id adf61e73a8af0-243d1be03bfmr2196614637.59.1756496551159;
        Fri, 29 Aug 2025 12:42:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm3099693b3a.48.2025.08.29.12.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:30 -0700 (PDT)
Message-Id: <3a6f822e2adbdd896732dc8e0f622a862ee462dd.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:11 +0000
Subject: [PATCH 07/15] xdiff/xprepare: remove superfluous forward declarations
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

Move xdl_prepare_env() later in the file to avoid the need
for forward declarations.

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

