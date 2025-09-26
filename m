Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96959298CC7
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926536; cv=none; b=UvXoYfmTSwOJDRsTSMqTKi+oyJlXzzOvV1VcqGwVPks8JuZPs/gGELk7vTFyh/6KNXZ6XhGQwwjJ+mPAbl6lcg5Y5I4Bj0nVKcJ+DCVWcdJiTN4lH1CtRMJjCLAS0BH8v2lfg+Q42l53N5fIL0//ltKYGiV9v8XHKAkG84L/E4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926536; c=relaxed/simple;
	bh=b9fAaWK0nJ4UB4ZzJhLSNRLF0u0Pad6W2uUbkxa+jKU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZtIv98bCXOoQLxfoBvWVYcZZ2Wtt8jcdzsNFBgbkWwu6FKtoAf0zQysl+CetFjcZGHnSyU6RaqDtvjxe9hGGleNAKclEtm+88df8Xs9Az91O20SBrCfUmB1kXMPrmQrXZGiRRaaDg335Sw2lsmb3XxV2Diu6XuxM1v5Qxf5Nme0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZBLdu6W; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZBLdu6W"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33067909400so2028777a91.2
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926533; x=1759531333; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Rl/DcLjm6ZN1Q30bEqvUFiszOabARyt7YIgU8YZEhE=;
        b=jZBLdu6WTYeHTm4vT8Lyka8DSo+c4BB6wi6LSbxItogzj8OwiO+Xw2uK/g5Butxb1i
         qcHcUGrDVT7/2acLVzkKEt/QPWVPRjntzhX9Sw01VPD+DFYlLqlNSvhhM1Y8y5xwgXj1
         lu/FbZO3eifHz71Y0eQhBzQytgIv2+/9ax7dk3+sWG7oCJnzk/9+M7bGszZsSAEd6Vdq
         C3RPh3jOCBVCwz893Rrco9UG7tj5VYqykkV8MgC/McjP3OoGs9khFtj4K/hRmYjnrTwD
         7SwVpBEUFPlZ5RcSpsb7v9zi7LLB9/R1+0tWwfamz70FgLhsavWodGsWVsl4m959Pu7E
         ogUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926533; x=1759531333;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Rl/DcLjm6ZN1Q30bEqvUFiszOabARyt7YIgU8YZEhE=;
        b=j0QClCGI85WlZEJePa6edTzcVlLt3PagmfFDLllSO1N0KZZz5GXOKJUhM3Jn0SonGD
         RzH4CW1WonZdkCQT61VSO9akx1Q33xML6KK1UXnCIlz71TUjodIEBJhXOe1ZRgQUMcPS
         Cdg6LTJz/+c9bXeWugq/RVAAkTb8GaPjISWGPfn8MX3BuzGYy9uOVPdRmWfg2kTEKszV
         F0d02XMTOutWr4/kV7vfj25Rb50S7iSYFMkM+3J4dyLMjUKxMVdAUxwCPWtGam6Iv33p
         HUvzV6DK/XqgcaSJnE0O0NAnlOpKtzxfkXe5tJuUU/iUAu+V6/RrGjClNvmX3GrCKySW
         j7WA==
X-Gm-Message-State: AOJu0Yw87B7jE3z8rQRJ77axOEc1Ma31LhvtnQFZc8Wbu/eXdzGgHzbJ
	htuTFQX3EN9v3x7zuM3JHmg8t8UTyX9I2ptQgXVplfx5wBRfR+PKgTlOcQn8GM7p
X-Gm-Gg: ASbGnct4ttuj0CRZCUyPOGMFdv6/ZVC+jLFbzjjJdt6fjjM51VjgTaoz/bC1i+QfABL
	pr6h8SoLM+cWoJ+dNzlV3Zo2U5HMOZFuF3axOL0uWlF2Whnse5qF5xnh4ceaf89BTL9DHagIECC
	NNmGvzvgER6hShSwmY0AVlriqdU8Kh6cOUwYGbS5MTlny32zNbrzbi1vgoyirxTTDb1oLrzLYeg
	/JebnyG9E+errNCKjjmbb7gaLd1fkGaQtwBmYEXy4QWmS1cLRy9pUJgxhyWy3LHscJXsJoJ5pdP
	5ix66yGQEWGP/ohdvDw5L2WoskZgrt77Mi5rpCJNuX07V86Tgag2xT8oo1n8a+yNe8dkN6UcesI
	HX7LwvOLrinZanRG/uaC/dL9E
X-Google-Smtp-Source: AGHT+IGS0fI2HHXLLnxCJQ72xPNQqqZmsYgDyyXfafOi9vT4LW1deIfBne8euWat0HKR2CRyPwL6aQ==
X-Received: by 2002:a17:90b:1b12:b0:32e:3686:830e with SMTP id 98e67ed59e1d1-334302782a8mr8820963a91.23.1758926533482;
        Fri, 26 Sep 2025 15:42:13 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53b97a7sm5547234a12.8.2025.09.26.15.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:12 -0700 (PDT)
Message-Id: <5702ca6912c7f1d300bcfc5b7b99c9ca5ef295ab.1758926520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:57 +0000
Subject: [PATCH v6 10/12] xdiff: rename rchg -> changed in xdfile_t
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

The field rchg (now 'changed') declares if a line in a file is changed
or not. A later commit will change it's type from 'char' to 'bool'
to make its purpose even more clear.

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c     | 30 +++++++++++++++---------------
 xdiff/xhistogram.c |  8 ++++----
 xdiff/xpatience.c  |  8 ++++----
 xdiff/xprepare.c   | 12 ++++++------
 xdiff/xtypes.h     |  2 +-
 xdiff/xutils.c     |  4 ++--
 6 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index a66125d44a..bd5b31c664 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
 	 */
 	if (off1 == lim1) {
 		for (; off2 < lim2; off2++)
-			xdf2->rchg[xdf2->rindex[off2]] = 1;
+			xdf2->changed[xdf2->rindex[off2]] = 1;
 	} else if (off2 == lim2) {
 		for (; off1 < lim1; off1++)
-			xdf1->rchg[xdf1->rindex[off1]] = 1;
+			xdf1->changed[xdf1->rindex[off1]] = 1;
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
-		xdf->rchg[g->start++] = 0;
-		xdf->rchg[g->end++] = 1;
+		xdf->changed[g->start++] = 0;
+		xdf->changed[g->end++] = 1;
 
-		while (xdf->rchg[g->end])
+		while (xdf->changed[g->end])
 			g->end++;
 
 		return 0;
@@ -774,10 +774,10 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->start > 0 &&
 	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
-		xdf->rchg[--g->start] = 1;
-		xdf->rchg[--g->end] = 0;
+		xdf->changed[--g->start] = 1;
+		xdf->changed[--g->end] = 0;
 
-		while (xdf->rchg[g->start - 1])
+		while (xdf->changed[g->start - 1])
 			g->start--;
 
 		return 0;
@@ -932,16 +932,16 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
 	xdchange_t *cscr = NULL, *xch;
-	char *rchg1 = xe->xdf1.rchg, *rchg2 = xe->xdf2.rchg;
+	char *changed1 = xe->xdf1.changed, *changed2 = xe->xdf2.changed;
 	long i1, i2, l1, l2;
 
 	/*
 	 * Trivial. Collects "groups" of changes and creates an edit script.
 	 */
 	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
-		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
-			for (l1 = i1; rchg1[i1 - 1]; i1--);
-			for (l2 = i2; rchg2[i2 - 1]; i2--);
+		if (changed1[i1 - 1] || changed2[i2 - 1]) {
+			for (l1 = i1; changed1[i1 - 1]; i1--);
+			for (l2 = i2; changed2[i2 - 1]; i2--);
 
 			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
 				xdl_free_script(cscr);
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 4d857e8ae2..15ca15f6b0 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -318,11 +318,11 @@ redo:
 
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.changed[line2++ - 1] = 1;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.changed[line1++ - 1] = 1;
 		return 0;
 	}
 
@@ -335,9 +335,9 @@ redo:
 	else {
 		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
 			while (count1--)
-				env->xdf1.rchg[line1++ - 1] = 1;
+				env->xdf1.changed[line1++ - 1] = 1;
 			while (count2--)
-				env->xdf2.rchg[line2++ - 1] = 1;
+				env->xdf2.changed[line2++ - 1] = 1;
 			result = 0;
 		} else {
 			result = histogram_diff(xpp, env,
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index bf69a58527..14092ffb86 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -331,11 +331,11 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* trivial case: one side is empty */
 	if (!count1) {
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.changed[line2++ - 1] = 1;
 		return 0;
 	} else if (!count2) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.changed[line1++ - 1] = 1;
 		return 0;
 	}
 
@@ -347,9 +347,9 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 	/* are there any matching lines at all? */
 	if (!map.has_matches) {
 		while(count1--)
-			env->xdf1.rchg[line1++ - 1] = 1;
+			env->xdf1.changed[line1++ - 1] = 1;
 		while(count2--)
-			env->xdf2.rchg[line2++ - 1] = 1;
+			env->xdf2.changed[line2++ - 1] = 1;
 		xdl_free(map.entries);
 		return 0;
 	}
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 27c5a4d636..b9b19c36de 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -126,7 +126,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 static void xdl_free_ctx(xdfile_t *xdf)
 {
 	xdl_free(xdf->rindex);
-	xdl_free(xdf->rchg - 1);
+	xdl_free(xdf->changed - 1);
 	xdl_free(xdf->recs);
 }
 
@@ -139,7 +139,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	xrecord_t *crec;
 
 	xdf->rindex = NULL;
-	xdf->rchg = NULL;
+	xdf->changed = NULL;
 	xdf->recs = NULL;
 
 	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
@@ -161,7 +161,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		}
 	}
 
-	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
+	if (!XDL_CALLOC_ARRAY(xdf->changed, xdf->nrec + 2))
 		goto abort;
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
@@ -170,7 +170,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			goto abort;
 	}
 
-	xdf->rchg += 1;
+	xdf->changed += 1;
 	xdf->nreff = 0;
 	xdf->dstart = 0;
 	xdf->dend = xdf->nrec - 1;
@@ -287,7 +287,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->rindex[nreff++] = i;
 		} else
-			xdf1->rchg[i] = 1;
+			xdf1->changed[i] = 1;
 	}
 	xdf1->nreff = nreff;
 
@@ -297,7 +297,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->rindex[nreff++] = i;
 		} else
-			xdf2->rchg[i] = 1;
+			xdf2->changed[i] = 1;
 	}
 	xdf2->nreff = nreff;
 
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 3d26cbf1ec..c4b5d2d8fa 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -48,7 +48,7 @@ typedef struct s_xdfile {
 	xrecord_t *recs;
 	long nrec;
 	long dstart, dend;
-	char *rchg;
+	char *changed;
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

