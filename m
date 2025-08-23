Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8121C183
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921373; cv=none; b=OCa703gyA0nlaRQDtoGULygQNf8NTr4qxRahPv/DcrbXTvNrzhEEfu2ofgM6F/U0JmIGALgZyLjfPhnURy5GS+a2hMWKYkki9UYZFOcqnnL2pJR6D+YbH6aHp+DLjaeAiz/+T4SM7MoWnSGIyIyhXXubjwz9Ysr1vkDZWjqBpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921373; c=relaxed/simple;
	bh=mlkxe/Kwz5aUDN7TOIzYk3bwL7aKwXIIdAwzt/YLDI8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=um8pY6L9d26blQQ+0wNBkXFS30L0rBQEtZYqOFqZ3hEBfhNjRt2Q06h19Ki8cj+7exBjENy4nDyCYtQKTIiQHuNHGlWVpy254dbCKEcq0BEqaNFjHbE0UiVHRkrWx3YLTMR9Ei0r6BhVHQhCckCUWQaJRWTjrgWOx0Jf0rmlm34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=holytRdw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="holytRdw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so16885705e9.3
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921367; x=1756526167; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEpDLiDMcCnW/Y7y70xjcOvTs8tWToNKwbLjQvCYgO4=;
        b=holytRdwAAvmHo7ELwsENp6csEZZbVc2g5Xdbl3bGE4TFru04uJiwhQ4EWIgp0R0h6
         uQlsHlj/8TVwyETHxI9J0M4yfnIHOvHDQiwfZrO/DaVk07sDwCtThUyAMfkUD9JiwOHb
         ftJ4mAI9EQzW12Xaqq7zMeIGNJq/b2mPmJTvvHeDLxDJhv/qiUIg+bVBTd8+l7AqorrO
         +/YwiUmMfcs70eO7X2bZuephirCkyBOkbxZ77auYA5HeAtwE7ZUDCwJdS1kwCij/GK9L
         IUkugKlzNHVA4kOXC+dY906yCQ6hCzf4w0QbFJ+BTx3BonRxJMY4Jt++YDX0rmB6CtrJ
         n0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921367; x=1756526167;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEpDLiDMcCnW/Y7y70xjcOvTs8tWToNKwbLjQvCYgO4=;
        b=qKsw1TXwyspMNC5D9uWYFDt7qOVWlZt1dFgdPQUpjCPNvAGGBVcV1eTmWyl3Odc/AX
         EhS288UCipmCe5i8OUt5Q5VSzwBCXFUfTweq5MgAaEeXYHXtU5+FF5kXIElK9vHGPBYt
         kcBvYk2GYqC0ynNZXglU23oRfWnfZ8nqo9qlmS/wpL4jwNuodw0tWVdNk9NRjQQa6BJ8
         kB59zoYmMvz/xsi8JDwgkLvcXfCrCFs+cEU3sJTEX8UBcOhXHwbT0gl1IsYhylcht4/l
         jRzXZT8DY3/syFE1T/rETN1HmuCtTD1e292SbsXgempITD59g+SOTyxzOWdHE27hZ7dq
         iVEA==
X-Gm-Message-State: AOJu0YwJcRE2TX45eKetetYtj1U/5iV4GQODOZ6GSZPPMaLSGftwj4AK
	LgCaWVGnHir8GcrX9Kv3NresDFRT9V7Crsponbq4sjQ0HZv5dGUiOs57CtEtww==
X-Gm-Gg: ASbGncss7KCntxqZJwLNM7rkLJUtQvSPAW2atcUfwlp24mRJUOT/PTdV0DJ1WZ8pMdX
	OsTaW3xh2bimLY0hRs77qgpy4C186rSW/1I6ZzIiCMKdtYfXDFzJx6cxdKUdG7YT8K4svHmEiXw
	j7iGRBisfzeAKDMjo3pdedwUoUg92MG5RPZzdIVlHZov9XvXstpSy7hktaZi9hPgl090J9DCPHQ
	/3gRGlGVOc/Mc7SJ5+7R8mWWVvoa4p8AH6KArs0IadpBE2CYTHsVkdf+UrzguZG817JPpUdjap5
	CZhby6IBfkBEXJNTdkp6t5Ttt6cPOSC3KfhHdFNwSBLocjlFEL+x3jVDbcpC6Yx2hf/HR8lBSlg
	wG+JRy5Om20/oAgxggLqGSTKkEHvzQE6XsHocqg==
X-Google-Smtp-Source: AGHT+IFWhUT8W6Pe9LIAywB/AkiCumsUopIU6gQzM/oL38aVOvIqQS6rOmK7vogKoMveTmndEoHjrQ==
X-Received: by 2002:a05:600c:3b95:b0:459:df07:6db7 with SMTP id 5b1f17b1804b1-45b5179b2a1mr44187995e9.6.1755921367309;
        Fri, 22 Aug 2025 20:56:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9d30sm1884488f8f.13.2025.08.22.20.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:06 -0700 (PDT)
Message-Id: <d4bed95463216668e7c024e6186ca4574c7114dc.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:48 +0000
Subject: [PATCH v3 07/15] xdiff/xprepare: remove superfluous forward
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
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
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

