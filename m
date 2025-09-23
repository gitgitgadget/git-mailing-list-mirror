Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611E30C357
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662676; cv=none; b=V6d6FqRymjiNlAkV7mXL6wC5hzPfLcv12r6fpqWRz8wTqQKkC/p3mivk8ZDITubvLRmAPoh536yzVpBXsk2T0ip7mKTk9PIOkLuNrqMWwNNRTDrZ9r7YOjRVZmgPXnJwaDo8V/QiLGBia5397Qp3VoMQYv7dMy5dOoMY40GiM0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662676; c=relaxed/simple;
	bh=Eoy8OK8PESnNoLZ5qIFd+pIalmqG6lGs9UrjiWW1pXM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XQNHUSGk0IMzsK3jeVaLVfRzwYhiIKGz+sUe/I/fdwIjnx/p6AkJlBEwazqsCQRkFQtSIlir+bD3UhQxgVyJKzF0rcVFGjchVcrnY7pWLL8ocwZzMMKxoC1ZMfyZ+MkQ4Zy8fYMXELSajFAbH05iMWX7qxkS85F568mTt9U+lrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhOD0VXE; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhOD0VXE"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f22902b46so3463927b3a.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662674; x=1759267474; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0VzieRHStQ+5X9TlxDCB2FswSvRLr733STSF2LI/fY=;
        b=VhOD0VXEp1zoIE8IsZwW7b9Y2fqYxOanX6Nm3itXUjv3vr9tvziTosVtRfOJUPokqL
         lmh6RUSNbzHhDXKPzE9FtOvL9qUslq74lN0nCLjI0CF1huLp2FIHUmIZ82IZpg1uljgp
         h1nK/IShRdQ+1c3cCiJyz0oeVkWbchPz1sFCXbaHM37U+BUR2875tlh30jUWBodelRPe
         aw554PYYaOBkWfaZGq4zY29wR0L9GzFaZm8oMOXEcw1WjHkFOngFN5QIwAG2t8b5mC6T
         I3valLIB5zS1QZtsyQzUssTFvV24IhqThWpHMMnCO2+mBpQ2EGhZB9dRj5EaEgMEtjD4
         VAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662674; x=1759267474;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0VzieRHStQ+5X9TlxDCB2FswSvRLr733STSF2LI/fY=;
        b=PuYs+WauL4HhxPslbtQ5pd7zYNmjLFkzG33HOXTMv+zP5fCUmKSIERx4IblkikzWKm
         KteaGWINDniYmSaDQp40CZdsjkdrPYEL21oUJRJEp4hmfMy2Ow4QyOGcGVEb64gsWgsZ
         Cr0+3Mxd+ZWZEqdUiyLLwFpVqGKkCER/0XnWf2YeIH03IsDjjizM1Y2nS/ZWICnr4GPV
         Qcy6qzVeS1LbHe5S3PIoeXiwNV3TywAfitYXZhcwSN8A2Yq6mZaLVUvIvrJ254pRVeLL
         39jVioz6FqczSJnIG5zceqV2XPVmmIjAWCS3+H+blsT4ufWPWA4LlK4jxeo3ydgk2hGn
         YaLQ==
X-Gm-Message-State: AOJu0YzFPft7vqjxuq7KFns3QsqMtx0BLswt5o3y2P3Z2eNnMp5cEIuc
	ynytfqFdu0L+0Ndd2+10iQsF/d7nFLy3t6DNtDal1ubnP+yWckjU3BBXxP1jFVCZ
X-Gm-Gg: ASbGncuzd3Bg+ShIhIOznHkTBEAzqE5ImfPldeGVF1xz+WKW1Qf4ogVVKoGAJ6cbsU2
	AZiffIMIL/Dwk+zGYWagB1IfEHiWW0t/xoSrac7zMW9bhCsB5c/Al3XdgM0iDGQ3gvEj/shnznN
	5tnR6S0q4rI0sD1FULiqLiimIESZQz37SCJ7kV6yVOaYetYiKLeyy4Dv8duOU3LC+GvU2E8RqsM
	PpgN2x+ONBekjfg8bDMHwJe3txorL6jVngHEVa2JDE+CrUNNxpwx3OcQr3oCYMTjBjGNCSHSH9j
	pXsM2H5+Rz/de86aT5BfoETBKktqbXLsknXWjl0DCi8r1mQNQ6I89xH0yKbU3oKEJzzXvBFumbA
	C9/Wfi0iRuDLH1PTKnMFGScukLoVUPSVgrQfV
X-Google-Smtp-Source: AGHT+IGbHJvh1fYroajxL+BgRouWSDesE/DfosNLRF/Q/IgrVU4Z1nmR3EA8TMQxI7m4LZKQBsajHQ==
X-Received: by 2002:a05:6a20:7d9d:b0:249:d3d:a4d4 with SMTP id adf61e73a8af0-2d00813e4b7mr5844144637.26.1758662673988;
        Tue, 23 Sep 2025 14:24:33 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f286119f4sm8602965b3a.74.2025.09.23.14.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:33 -0700 (PDT)
Message-Id: <890e5080008a6ccf8f8157a9a11fbffa401953a6.1758662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:18 +0000
Subject: [PATCH v5 01/13] xdiff: delete static forward declarations in
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
    Jeff King <peff@peff.net>,
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
index e1d4017b2d..249bfa678f 100644
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
+	}
+
+	xdl_free_classifier(&cf);
+
+	return 0;
+}
-- 
gitgitgadget

