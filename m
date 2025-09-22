Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD231A059
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570730; cv=none; b=JcGjwboD/PK2GNVm3pOsBru8TOTftnq7xWlQbmBsOu7DtEgYsIoHaWbJKuEE6Eb+/GzjM0MtxGNHgA17a0Vl/o+MFfZbupTFugm1EutnrI/7BgtJI//u7whH/wNBIydaFJ0sAAXX6Tm1evf7AY+Lx/8PRKa2K7tK7u2Jq1lF4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570730; c=relaxed/simple;
	bh=r7IbiAeZ2GnyYdxPF/GUJV5tBx8NRsEGz71rbLBXCrE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HLy2QZKh2d1L91u/LKiv6XuiFA6CjWCNlLjJJlEw+lhQmRkxBuuEbgrKNacJpp3PODiJFGDNgM0RZF/47Ed0friOHlhkPbfqqbeyvgqrHfH39DRpMPGUiOvXEAaWnBGX5dgswaZn/nuRi1SKioD3QGtOdQDaLqpLhVLoYr9LlWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y05Za9WD; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y05Za9WD"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-4248b079780so11173735ab.3
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758570727; x=1759175527; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD1SD0JXFMBSOipFnhfOlZe8WUENRwMZfx/UidvyVWQ=;
        b=Y05Za9WDZI78qTumEYLQFDo1AqWQb7DN35euWs/9G+esWuPSMRJ1Gmrp0w42rpcbWA
         +K6L0LUBiH650m9v6q8wq5ghvxgSos/I3rFMPSBmTcnYnPQ4yMSfVGZk/L8MrwxkQrpr
         F6Noc5R0WqOz1GwP8YEAFXxW87BoaAgPwqLxu6HMdnCyFYAYxJrRULxNhh6tFam4/stQ
         PHYUvraR7zskKzsYDDHgQq67hAwRleZPN9gay5k2rbDLGKv4Hksdo/uoCFciGiS/al6j
         pTERD8QZiPP+Zbia2y2HDIVdN/YufbicELdaTmDK73cRKzrYrqKtCv/DXfHGpYf3UY75
         2vjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758570727; x=1759175527;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fD1SD0JXFMBSOipFnhfOlZe8WUENRwMZfx/UidvyVWQ=;
        b=rlaunKnvse5LIrKLepjO10/qkiQIxdX6FckgSb8/xuBWprQqnrqyV+XIXseVpXhxM/
         yK3fRelFY0d1kCgmsvZLrKHWzWc1u85K2B2ULSTnbntPkMk2lh4ys4ITO3qgKq5YiDR6
         Ytv8Wf+DeJWZV9M49Mrrx/ZlKOqh5E/XbnFG6nHPKoHz6jmEvgSzSEL67CI4gBj3zPs5
         5pJtWDbhChACLFOhT6AEJuVwvv4ub7HTDaPacANTIxOGrcHdbrbTMlG841dlWKbuOOxC
         yMjMiTLRSB+e2Dgp3w4ZoYK/GxVPU9efo6ukB6g2jB8aQLbHjmvxh2hLBsD/UIL36uqS
         NeLA==
X-Gm-Message-State: AOJu0Yw6Maeww2da7w9GG4FZLGs5H3owa7y8D3EfVpYFlDKBveAMhbyo
	uRZzrGLZ8wvFN0rFABLRB2OptfocsvS+GgSE0X25MMfoefpRtQSlO/brrcRJdA==
X-Gm-Gg: ASbGncugJzUmOOCJ8hd56AbSHYs86XtPhGwBbSEjCGh4UOHD3nKr2ia23ANRnwDFfsG
	J6vhJc0aW6z+o1FNGVIrcN1sbYQt9CpEjRtgZuXE75do+G6o0Y++tOOUHAAVWKRrWW5Tf7blxUb
	T0ezy5Ag6HWIbrYaXjpcBuK1DAcbgj//16PztEqqOO5SSf3jyvctAHaVxFlELVbQzUJdjEWfwYd
	wnLHSC3jNT43KtnrTw+1zS8JqJFnkP4iMUQGGrcafI1gUJ/ddL9lENOfAjmbLchaTkJDfLoOWvA
	mhyxDC2LJ4bxF3DKrrZ4GMi+0amS0AVF/W059uJ8a15hBMGZFLkHBKJFjMwJfIRt6Vx88Bu7FXP
	GF/zAS1cUAhupNIdphePQupEilQ==
X-Google-Smtp-Source: AGHT+IFKMp5D1DW26xIj9Ox7I2XZIKLaYHQsxvYgBFTebI7Kp3RuxB+71B4zcCtE5kaF3fe244xqxA==
X-Received: by 2002:a05:6e02:1a4b:b0:405:5e08:a3e4 with SMTP id e9e14a558f8ab-42581e036d7mr1973965ab.1.1758570727167;
        Mon, 22 Sep 2025 12:52:07 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.80.135])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-556bf59a051sm2703251173.80.2025.09.22.12.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:52:06 -0700 (PDT)
Message-Id: <034a4a7b2ad18812f68b5fcb8a61fb24f0a84d66.1758570701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Sep 2025 19:51:41 +0000
Subject: [PATCH v4 12/12] xdiff: refactor 'char *rchg' to 'bool *changed' in
 xdfile_t
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

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c     | 28 ++++++++++++++--------------
 xdiff/xhistogram.c |  8 ++++----
 xdiff/xpatience.c  |  8 ++++----
 xdiff/xprepare.c   | 12 ++++++------
 xdiff/xtypes.h     |  2 +-
 xdiff/xutils.c     |  4 ++--
 6 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 6213ce7a03..b902be9d0e 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 	 */
 	if (off1 == lim1) {
 		for (; off2 < lim2; off2++)
-			xdf2->rchg[xdf2->rindex[off2]] = true;
+			xdf2->changed[xdf2->rindex[off2]] = true;
 	} else if (off2 == lim2) {
 		for (; off1 < lim1; off1++)
-			xdf1->rchg[xdf1->rindex[off1]] = true;
+			xdf1->changed[xdf1->rindex[off1]] = true;
 	} else {
 		xdpsplit_t spl;
 		spl.i1 = spl.i2 = 0;
@@ -708,7 +708,7 @@ struct xdlgroup {
 static void group_init(xdfile_t *xdf, struct xdlgroup *g)
 {
 	g->start = g->end = 0;
-	while (xdf->rchg[g->end])
+	while (xdf->changed[g->end])
 		g->end++;
 }
 
@@ -722,7 +722,7 @@ static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
 		return -1;
 
 	g->start = g->end + 1;
-	for (g->end = g->start; xdf->rchg[g->end]; g->end++)
+	for (g->end = g->start; xdf->changed[g->end]; g->end++)
 		;
 
 	return 0;
@@ -738,7 +738,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
 		return -1;
 
 	g->end = g->start - 1;
-	for (g->start = g->end; xdf->rchg[g->start - 1]; g->start--)
+	for (g->start = g->end; xdf->changed[g->start - 1]; g->start--)
 		;
 
 	return 0;
@@ -753,10 +753,10 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->end < xdf->nrec &&
 	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
-		xdf->rchg[g->start++] = false;
-		xdf->rchg[g->end++] = true;
+		xdf->changed[g->start++] = false;
+		xdf->changed[g->end++] = true;
 
-		while (xdf->rchg[g->end])
+		while (xdf->changed[g->end])
 			g->end++;
 
 		return 0;
@@ -774,10 +774,10 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->start > 0 &&
 	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
-		xdf->rchg[--g->start] = true;
-		xdf->rchg[--g->end] = false;
+		xdf->changed[--g->start] = true;
+		xdf->changed[--g->end] = false;
 
-		while (xdf->rchg[g->start - 1])
+		while (xdf->changed[g->start - 1])
 			g->start--;
 
 		return 0;
@@ -938,9 +938,9 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
 	 * Trivial. Collects "groups" of changes and creates an edit script.
 	 */
 	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
-		if (xe->xdf1.rchg[i1 - 1] || xe->xdf2.rchg[i2 - 1]) {
-			for (l1 = i1; xe->xdf1.rchg[i1 - 1]; i1--);
-			for (l2 = i2; xe->xdf2.rchg[i2 - 1]; i2--);
+		if (xe->xdf1.changed[i1 - 1] || xe->xdf2.changed[i2 - 1]) {
+			for (l1 = i1; xe->xdf1.changed[i1 - 1]; i1--);
+			for (l2 = i2; xe->xdf2.changed[i2 - 1]; i2--);
 
 			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
 				xdl_free_script(cscr);
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index ad88406656..6dc450b1fe 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -318,11 +318,11 @@ redo:
 
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = true;
+			env->xdf2.changed[line2++ - 1] = true;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = true;
+			env->xdf1.changed[line1++ - 1] = true;
 		return 0;
 	}
 
@@ -335,9 +335,9 @@ redo:
 	else {
 		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
 			while (count1--)
-				env->xdf1.rchg[line1++ - 1] = true;
+				env->xdf1.changed[line1++ - 1] = true;
 			while (count2--)
-				env->xdf2.rchg[line2++ - 1] = true;
+				env->xdf2.changed[line2++ - 1] = true;
 			result = 0;
 		} else {
 			result = histogram_diff(xpp, env,
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 042e889348..669b653580 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -331,11 +331,11 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* trivial case: one side is empty */
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = true;
+			env->xdf2.changed[line2++ - 1] = true;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = true;
+			env->xdf1.changed[line1++ - 1] = true;
 		return 0;
 	}
 
@@ -347,9 +347,9 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* are there any matching lines at all? */
 	if (!map.has_matches) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = true;
+			env->xdf1.changed[line1++ - 1] = true;
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = true;
+			env->xdf2.changed[line2++ - 1] = true;
 		xdl_free(map.entries);
 		return 0;
 	}
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index f152e3acd8..009556f7c2 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -129,7 +129,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 static void xdl_free_ctx(xdfile_t *xdf)
 {
 	xdl_free(xdf->rindex);
-	xdl_free(xdf->rchg - 1);
+	xdl_free(xdf->changed - 1);
 	xdl_free(xdf->recs);
 }
 
@@ -142,7 +142,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	xrecord_t *crec;
 
 	xdf->rindex = NULL;
-	xdf->rchg = NULL;
+	xdf->changed = NULL;
 	xdf->recs = NULL;
 
 	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
@@ -164,7 +164,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		}
 	}
 
-	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
+	if (!XDL_CALLOC_ARRAY(xdf->changed, xdf->nrec + 2))
 		goto abort;
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
@@ -173,7 +173,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			goto abort;
 	}
 
-	xdf->rchg += 1;
+	xdf->changed += 1;
 	xdf->nreff = 0;
 	xdf->dstart = 0;
 	xdf->dend = xdf->nrec - 1;
@@ -290,7 +290,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		    (dis1[i] == MAYBE && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->rindex[nreff++] = i;
 		} else
-			xdf1->rchg[i] = true;
+			xdf1->changed[i] = true;
 	}
 	xdf1->nreff = nreff;
 
@@ -300,7 +300,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		    (dis2[i] == MAYBE && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->rindex[nreff++] = i;
 		} else
-			xdf2->rchg[i] = true;
+			xdf2->changed[i] = true;
 	}
 	xdf2->nreff = nreff;
 
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 3d26cbf1ec..f145abba3e 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -48,7 +48,7 @@ typedef struct s_xdfile {
 	xrecord_t *recs;
 	long nrec;
 	long dstart, dend;
-	char *rchg;
+	bool *changed;
 	long *rindex;
 	long nreff;
 } xdfile_t;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 332982b509..ed65c222e6 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -425,8 +425,8 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
 		return -1;
 
-	memcpy(diff_env->xdf1.rchg + line1 - 1, env.xdf1.rchg, count1);
-	memcpy(diff_env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
+	memcpy(diff_env->xdf1.changed + line1 - 1, env.xdf1.changed, count1);
+	memcpy(diff_env->xdf2.changed + line2 - 1, env.xdf2.changed, count2);
 
 	xdl_free_env(&env);
 
-- 
gitgitgadget
