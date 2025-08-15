Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40F189F43
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220981; cv=none; b=pyW1C27uKROUZM3hw2lgZGs4USGeIxlTg4/N1jC7g/txbGOJEl92rc8M08Z0lSssLmeVtc4fr5EarO1TBQtqOi+SmqQK7KZfN0Jwos7mSy1likh5VYepYGpTdAoIGnr/V+wzbk1BGEi8x6R/81Gj9/rsO1JG2VJhllWNHhP3D10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220981; c=relaxed/simple;
	bh=mlkxe/Kwz5aUDN7TOIzYk3bwL7aKwXIIdAwzt/YLDI8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X+HZhXt21hC1JIhdkZFaIJGLZ6BKZhBIeDjQlj+vlAnlG9Y2K3yvXNTGWPGi/vjke4Vbk22eu4IDpwRHiaGNwoeJmCqZ+pzblZxX/2TT9WLvYf5kvTUYAuJ42zB7BBs4RFjUeWJIOWHeuvp6rTULEayau8S36gL8QSGZPoLi7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+7kkShS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+7kkShS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9e4106460so1331980f8f.2
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220977; x=1755825777; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEpDLiDMcCnW/Y7y70xjcOvTs8tWToNKwbLjQvCYgO4=;
        b=d+7kkShSjgNHGOvGmHWtMc97asx9h24PBERDxTQmyGXV8FNuLgT9oS8HsauUTO934P
         tnwENuc5zMnLeExUlVGXgl1qhCfbUZa4VcytELcf0YqG4WFNrZQrmVhGdb78lMsH1NfH
         +XoKQ/QEZIH5ODq0Cg91JaQrMnkbcIolVERIKiSHfe70Ku25cgSK1dmmoO90zMUqG6Ag
         GbUy7BsUMK3WuR502J7rWHJowQ0yjHRUfiDvB4C7gApMY/KkRp60hTeh3Z1U45b9rH+9
         MbuVWS0lvV1LQjjxdp3RTBCepppk/AKauUso/Z4cVi1OZwXjja+4BvnHCGgYndn6qyo2
         5DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220977; x=1755825777;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEpDLiDMcCnW/Y7y70xjcOvTs8tWToNKwbLjQvCYgO4=;
        b=hUmc3ZGNKMYRZKU93ZWRAkrnuAIj3qK583V1gtr2raZmKUDqHiqcu+oMnU83hlE6Pu
         /zb87DyQe6YaITeSfhIDmR1p9T15OE29N3CKr/25oNeKoju0t7pLFEHkEtoTMvDymbnP
         pKsizfwnYeHTiPHCpekq7CkZ3Cz9O6ZAgD7bUJIXqBwHg2SV9ckIUXtKlhx03y/JkJSf
         K9qJKbFbknWONuSAFA2/mY3cWWDp+Rs62zVrT99ivJ2V5s7B6AHnT3TkUEomUxWZo+mi
         9o6i+ooAvE63jA9Rw3NTUxb5HUFu8+8++J3HabuYoo4/ngmSZB5n0k6SWsztiAG8Im0v
         oHOg==
X-Gm-Message-State: AOJu0Yw4s3ikILFEzRs+gslQT/JV6d8oRKdOK3JmXfz7Z2DqKrizxxPc
	aiNGxS+B27AjhFMoX2cvZbHEQJg0eLkibKywFDaMtr97RjKglX2h2qYPCWm6cw==
X-Gm-Gg: ASbGncvQuiww+L1po86hoxlazwkRWfxbmn6jhwkTKKhRxg8iN6G0TMrLaGAGo1EJDti
	nvAm/qPXt1D/CCZor+jBibPuLNN3Cv/5DIhM6WqvRsoBiLe0ne5zi58JW3HqGGB44RUNPtO8HmZ
	ny5jDcjl0Cn7MeOIc6tjkf6yby02bkWC22CGfqcai3F1m2MyLSWR7s0GdMLu/eJ2o3gOwm3nRt1
	aHl/DsmM3C42D0mZ1JKOrMyZ1arf/NnULqevUOKEoX9Fle3uq381AomxCYPXFjufecE6C49roZV
	x4738UPELJcINGbkD80iZR+Tw93aEawR+xAap4a6FkafOm++kCiOVNAJ+YSRWQdJ7JYTwso2Xwf
	fUw8W4Q+ggSVYWtT5GE18hQ8=
X-Google-Smtp-Source: AGHT+IHHOl06Ok0KpUIqjUrozXBoyubPxpGZasp4a+AwQx+tsSdUFAgQRvg4HCO0rZX3l72DfQDQyQ==
X-Received: by 2002:a05:600c:1906:b0:459:d8c2:80b2 with SMTP id 5b1f17b1804b1-45a217f71b3mr2249015e9.7.1755220977283;
        Thu, 14 Aug 2025 18:22:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a220d87bcsm405525e9.5.2025.08.14.18.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:22:56 -0700 (PDT)
Message-Id: <56c96d355544609b26be69b6d2ae04b5bdf3d7a3.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:38 +0000
Subject: [PATCH v2 03/17] xdiff/xprepare: remove superfluous forward
 declarations
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

