Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E221C160
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752784352; cv=none; b=bBy8WQ7c8mfh9kAy9gRGUoeNA1qy/8kgAbeIiWVtvJ+jxdOKlqx1wQHEVSHW6Swy/45A//xYHOwystPTyMIvEIMrA7uq8q4ZSro2//9x7hG47Oy/GpRUzF7XHpHrKGnTZy64g5U3+TtFijy6CWMEzs1R3I7a2yqgoD+HXeU+/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752784352; c=relaxed/simple;
	bh=mlkxe/Kwz5aUDN7TOIzYk3bwL7aKwXIIdAwzt/YLDI8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Pi9ZL9Pd16bKDKt7L5WriY0wVDtaVOOGh96sLxOLnE1VPl4yb7DvLmfloS6OGtiJNf/aZoH+D5MrgKt0RAjYCKjcxZThWEOiAcqNlfD1B8xJ0U6Fr6AWoPa+SUfiwnFG9s4fRCutDoWtKsuncq8hv/UsQXP3x2oevODWDozwh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8HUejLy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8HUejLy"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so6361685e9.3
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752784348; x=1753389148; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEpDLiDMcCnW/Y7y70xjcOvTs8tWToNKwbLjQvCYgO4=;
        b=N8HUejLyyrh9TnYE64o9MJql7LMoR+T6/FUa6kWjo7GRMPsClbWuIH8BSebjk2g1jk
         POcQa6ztRFjHF71+txe44ERoz2C8o8ujeJfexQoYMbSqg66AFTWJ8ne3w+ty32yCVII/
         Wx3yFgH3+Qr0sBZOIaQc9ML4G2AN/spqUumdgIwVG9jkKt3XTcrnX8o1way8BcZoMdfN
         XlnYZU9Rx47iDcfXrQ00v4G8OQ9im6RUhHI/F/mZaPTpCFGyIw1i45gWLZVaR2RXwGgX
         cr05jAWomY3/dOWnZZ59KciUtZ+jX4kCmNdyZ1SViOD8jdXyf5FnmMw7Yq5kLh+SqVy7
         vFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752784348; x=1753389148;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEpDLiDMcCnW/Y7y70xjcOvTs8tWToNKwbLjQvCYgO4=;
        b=mNmoJ7f0i4zo7sWE2TJdX24cvCDrzYfjQOCQXCR+cTFInFkb0U+vOSkbx7BnYb9r7F
         /pgGLqRAsGoPyGqHGuwXr7Y3+B+wHM3x97UkFkUZ+L+mwD1//RxKmjpcDs2XoGhrFzYO
         PHlVWIsuhVsIbLquMdhMNHTNWQFFcsy0k6g6/58vlynwLBsGH1M/+yrgYFZ0+oznXix4
         IiibhM8bo2/f8Kv49qGHxnTwpaLWzSHbw1qLRurbrCUtVYaP2u7dD5JGnWdA9kJIHiR5
         9AqJ/EjV6BSLPV4CcIMCl53zZCKRSoohRJvLbhLVkSso06pPjFQoW91ogcjiYUUh+tHR
         Qfcw==
X-Gm-Message-State: AOJu0Yzs419ClZs5JHmngKPh5BBn+92hIz0OWsMS+wH3BCWURVU3Hzqn
	rZrF8nFMJ9/bbEbs3ZP0pU7nuWeLhqqAE2DopNeMwhEAu9yzQSBleP+Xj7S+aA==
X-Gm-Gg: ASbGncs8Dmjd7AJgPWcjM5rl7UzXLP7M1O47T+q46zpkhh2orNV0RQmZruc4cjgS+Kv
	ZCzwdRuGxhB420dvMIfy1/f3NbbF9tr1WWeenAwRsev5QTh2YiwmPbwpbiK31/ZB5I4mHTVkysQ
	Ie28iu0w56RQ47hThriR0c7Bft4kFQkwkMahnOlGKvLdaMa9ntzhhVrWS7uVvseHpTg6U9SGl/n
	XEbUHkG12iIrYz6vv3RVDBrfdTIy64ophnAkScJCE3sIQZXIdAmao0IWfPs8p/zfL7D8xen7Uq0
	+64wZeqlCBOM6YKLQhY0+F2D2w2a5wReUnRXEoMbwVNbxTpqxcxNOXSvTaeFzfMJuDwap78BXtf
	yy0cJ97unp5CeH6fMVJJzNr4=
X-Google-Smtp-Source: AGHT+IGDDoXdSGJBBu++rvyl2v4Ubom5F6syMkyAtsINKpG/rPJN0hrQdGrPex1j8ufsU1P3SEqt0g==
X-Received: by 2002:a05:600c:4e4a:b0:456:117b:94bc with SMTP id 5b1f17b1804b1-4562e2747eamr92118075e9.17.1752784348169;
        Thu, 17 Jul 2025 13:32:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e1a5sm21273854f8f.74.2025.07.17.13.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 13:32:27 -0700 (PDT)
Message-Id: <b0b744b9acf5299d323d56cbcc01411a228c1fc8.1752784344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 20:32:19 +0000
Subject: [PATCH 2/7] xdiff/xprepare: remove superfluous forward declarations
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
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Move xdl_prepare_env() later in the file to avoid the need
for forward declarations.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 116 ++++++++++++++++++++---------------------------
 1 file changed, 50 insertions(+), 66 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index e1d4017b2dde..a45c5ee208c8 100644
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

