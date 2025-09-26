Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5715278E
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926525; cv=none; b=gEBjyF6c/A0ATiyirvenpF+4LryC86IJ8H6uAzAto0zmhQLs4ey6ytbhj3vg8SQZeOIboZH5dHtvnxZLEu9kpBdPLzBnOSfxr7yYRVFDA9i1UT0IaeLB3jq8uAz5ZTe2AJd/QFFVQy/hMg5NBhN1IY9IgVn+1yLAL5w9mCN6nc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926525; c=relaxed/simple;
	bh=Eoy8OK8PESnNoLZ5qIFd+pIalmqG6lGs9UrjiWW1pXM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hUl4ZM/J1U7c5nwxOLYwc2HTWv7V4h0rHRiuLK4KVCdv1zoZ3g8Knpeuernphh4O62HrlmrVvx4t2XDal1UWA+Bp0f3RE8zpe3tgkdukAvXF72nscTHoN8wtdg/6i5+TmoiOlQkjrNU4MgwcDBjSEdNO/F9thqtVMVNscWlMtuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrglBOmv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrglBOmv"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so3279321a91.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926523; x=1759531323; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0VzieRHStQ+5X9TlxDCB2FswSvRLr733STSF2LI/fY=;
        b=hrglBOmvoooVG820Q/gPUi368dUqYqlfpAWT4UqYDF05HueOZsEkEqynCh/1VYnZO2
         mfcY8ZR+PjJcyCj0cOr7RPapRgHPeN7WdvmHHCrn5BRm7rHHwj5SwrgqUeymyBaD2/8x
         HdPVvOo/yLcwg5aw5WCq+V0PZCoFPQftwQgMJbIwSDVuxSIhs6iSGM5uneNSiAg0rmkH
         t17NZAL3lQunhEahP9zqszGP23QJXxJEW4ogDqMZQtAumppFSULsOzgr51jG68r5tbL2
         jQML1blxkwscVFrRTVsXVzCsdTFlJNinMm1ufimdCsYQdLLJ+6+0R4RJnz9wNO1Oiyia
         YSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926523; x=1759531323;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0VzieRHStQ+5X9TlxDCB2FswSvRLr733STSF2LI/fY=;
        b=qwcpmIzSM6c8lHtJs5WAcgSVUVxC+WdFmJbBkRWVWaj44dxe2FTulP11ZaYIo5hkuO
         77ky3/iYXfVzeD5cniykuqCfP3JS6/jS8KIUp+1J2Qams5Md/XN1q2gxod2IXaA3PAV0
         f7TIy75tOVs/4AQoxDxllnGZBNlrFNtOSWGD7KY4uU6IBolkLGESRzdDA3/yWI7p1qye
         mySrc8qK7ShgjHnoDs7Rcg08fOa1vmQlgnpv/npCeZmjQKma4BJ2OCbbst8wLP7FWzjX
         L7IUgxDk9bszUDytNxY25CcB4kaRe6qgSt2KQ3j4R6tiEErfVd4F5TS4JKZyG8zi55Kp
         jrXA==
X-Gm-Message-State: AOJu0Yz3tbO2VPtnxc6Vl7cJ2HbH8kSfe6cyIZ6Bmcft0odu9MHok7go
	15t0czUAJbwJYzx0SkGXIRj/naugVgjyl6rbdC6vZ/8NYNO2K8MjoP+dlIt3Lg==
X-Gm-Gg: ASbGncvk+JAXILzRIP0OHKKTdOpp8Ii7YA9edkxmUfKfNUNIDmMmA5soLbVO9bqYLUA
	zJxtadpmVmGkudaAAMubFIBmr7A0CRtbPLjJWDyzYZom1rY2tozZEIxjacOhJZ+mODvfko8JNIZ
	05CYhbfyJjrXEIlQrzDbCPufwCBfxc5CJ6lRnTbPs1Rq6iq0E8lvf9rWec2jhASkj6MBhJt7mnK
	64vzehnkr2c33kQVrzid8vS13pQgHjwdv9C8+VMiSOTfM8oL2/iSS5c+dZwr0+ucU/QWDlkMOdg
	4/l0Kxy9JbUelbXVc9Tfqv90MBzINNt14CRc7m5oushF1yH/+N7ZjuC3pan6omBdLJpCO+/ZmpG
	8YyzdBTN5wh7WvdoD9JBGQD6lGg/bVouDzT0=
X-Google-Smtp-Source: AGHT+IFsr9ywVh4dSkOSwXUa9Rdy7csiMnhTtOaMqzkVruusSRV/APdK1GLV26dmBg27g+PiQT2kvg==
X-Received: by 2002:a17:90a:d60f:b0:32e:3837:284f with SMTP id 98e67ed59e1d1-3342a2d8c3dmr10555920a91.21.1758926522910;
        Fri, 26 Sep 2025 15:42:02 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3347453dc35sm6414383a91.16.2025.09.26.15.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:02 -0700 (PDT)
Message-Id: <890e5080008a6ccf8f8157a9a11fbffa401953a6.1758926520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:48 +0000
Subject: [PATCH v6 01/12] xdiff: delete static forward declarations in
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

