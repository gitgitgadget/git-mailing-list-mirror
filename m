Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56455223336
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921376; cv=none; b=NLWfDNAPjh3L/SKqeSm64I+sVc5FFbU5hFjh5M9cVTm4zoHVR60S/f5iP8O/Mb62r488J1FDxIcoGamKk3vw69yuOcEIlzvfees6lpwgI0A7YG46YGRXlSb2JJKdQLH2tImEnBz1XqILO1UfvxdEj6Jormm1h5Lboe+gI05SVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921376; c=relaxed/simple;
	bh=9t9Hna98dmwRqQ0FVo8Ow1V/f6TsL0TwPDFvtJ0SsRM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PdzypDjyA01wJkxVH9G5i4ST+iDjeNWP00IJP46cRXOpHLWOtoFyn2aRF8EmotDGL6X0apbsrkPG8Pp61U54RyuqFF7fF9ktBSB9RDUq1opdUbwFN3cjKIN2x17zsOuKwGsN31FfkizGNhMep4d4vYtuLUxE6PC28BrCrZ/fefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bn5zMjtk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bn5zMjtk"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso22039575e9.3
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921372; x=1756526172; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcG7uNbYyLNTFU3VjBXoP9JsFwTH3wvxJ5Oc8iwIyNE=;
        b=bn5zMjtk3tYbQ8OuBJJnl5GC6+Hpa6+749Ltdq4tOn5Ct2nG/uHTJVjizJhTESlFUQ
         V9JClrTSsNcgzT/tjpzDm4kG/2fuXws1jGFKIN7Dgv8GomqQT4CZTb6sE/+AOISYEjPv
         0YCzRFtWTk2Hy0/A4yBQjDAaqszKqFgpMt+vFh+/k/lBQVuSxo411cihq63yMWlBxbIQ
         UbiXPdGkT5noLqNl9rXfBtn2HVHFV0Za5BK7dcfqhx3EJx6xWk5cz+K4VFYVl0R07bqA
         ayJspdy+u9OgI9KRpP+oYlexqqJRPF3LMFMJplGdFrZp7x0RcoXhO1Gprgs5a4rd+nU2
         fFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921372; x=1756526172;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcG7uNbYyLNTFU3VjBXoP9JsFwTH3wvxJ5Oc8iwIyNE=;
        b=qMcP9FoapFfDb3obPHx03WWSpuoS6DcFi7XXX8h3S5dVoGbeI4V8Kay/59kl8oOnB+
         vEImkg3SYebAIJ2q5PQgAVVTw+0vfCV/uKXxaqPmix/fgCfBNy0Q/eMPtEOatqKj0/sZ
         2dMVL16HUz2TtSFHe2NtkUQaal9G2Ke3Mjk/3+GaZhCATN340M85e98Mm17Oag+XjipK
         n0SALlDkW0nfa9+RFWntmrcuMD9GTjo5HMa2FP8zhE4ZOJxaP9AmeveEDwo1LRY1zBRh
         gpw5OyB5woouWqDrVrX9UKK+OyMeiJpkbdmpYG+FqZe/Q5YBOP0rHmOJIRKka6xrRObR
         srYw==
X-Gm-Message-State: AOJu0YxJMbdQ0j1rWy+/rHfedP6bjAcNlt5XdNwR+i2PKSHH+9sUfpv1
	a3EZ/gESaC7h2VQOiuCfJFoccqnAmj8GbU/IWsF68aH5CNDQ/5ZzjKE1dWrMVA==
X-Gm-Gg: ASbGncvcF95IK7sp32Sk1Zywg1SrmSrzEF+TI48BGdXUq4Z+m0SxrO63BVh15wIEDHu
	/cKQFvwrv4qGMTTUnLQaV4aCOvADdzqBZHzc1RkOFkMLUAKZ1e+pkbLj9TKoRm09yjadpfDiGS9
	B/IdR6IV3Lbivk5vr3aIGDAJOrum9DjugKhtogMGPjW5HMEa4v3xyKiORZ2kqx2RJhNp7lvQufI
	E8Ibe9ors7sWZY2Fi8lESvOcloAdkq9TTdIzrNUWshyIY7mMOuPY9aufv9yt6tCZRUiXfd3fzeu
	a/9fqSdirdUrj4WoyhMIs9tak6fTNbXXgNZhKbtGhGAmOpPhQCerm6aXDiQoP0MqFo4pQgHbp+5
	c3fOeXrcvUHobmdoIsxlc7E2y8cWvedNfkG7wmA==
X-Google-Smtp-Source: AGHT+IFcieYpwAlbfNc/FJfvxEGwRiLELtOl8v548f9oCh470gOUTKCAoY54temQhivQVu9QONeWrQ==
X-Received: by 2002:a05:600c:4ecf:b0:459:d3ce:2cea with SMTP id 5b1f17b1804b1-45b5179947cmr48818045e9.6.1755921372157;
        Fri, 22 Aug 2025 20:56:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b506bdd9csm38523775e9.3.2025.08.22.20.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:11 -0700 (PDT)
Message-Id: <0cfc6cf26b75d32df676c65b1645c54d2df35002.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:53 +0000
Subject: [PATCH v3 12/15] xdiff: delete nrec field from xdfile_t
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

Because of the data structure cleanup in the previous commit, the nrec
field is no longer necessary. Use record.length in place of nrec.

This commit is best viewed with --color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c    | 10 +++++-----
 xdiff/xemit.c     | 20 ++++++++++----------
 xdiff/xmerge.c    | 10 +++++-----
 xdiff/xpatience.c |  2 +-
 xdiff/xprepare.c  | 34 ++++++++++++++++------------------
 xdiff/xtypes.h    |  1 -
 6 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 3b364c61f671..bcab2d7ae516 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -496,7 +496,7 @@ static void measure_split(const xdfile_t *xdf, long split,
 {
 	long i;
 
-	if (split >= xdf->nrec) {
+	if (split >= (long) xdf->record.length) {
 		m->end_of_file = 1;
 		m->indent = -1;
 	} else {
@@ -519,7 +519,7 @@ static void measure_split(const xdfile_t *xdf, long split,
 
 	m->post_blank = 0;
 	m->post_indent = -1;
-	for (i = split + 1; i < xdf->nrec; i++) {
+	for (i = split + 1; i < (long) xdf->record.length; i++) {
 		m->post_indent = get_indent(xdf->recs[i]);
 		if (m->post_indent != -1)
 			break;
@@ -730,7 +730,7 @@ static void group_init(xdfile_t *xdf, struct xdlgroup *g)
  */
 static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
 {
-	if (g->end == xdf->nrec)
+	if (g->end == (long) xdf->record.length)
 		return -1;
 
 	g->start = g->end + 1;
@@ -763,7 +763,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
  */
 static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
-	if (g->end < xdf->nrec &&
+	if (g->end < (long) xdf->record.length &&
 	    recs_match(xdf->recs[g->start], xdf->recs[g->end])) {
 		xdf->rchg[g->start++] = 0;
 		xdf->rchg[g->end++] = 1;
@@ -950,7 +950,7 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
 	/*
 	 * Trivial. Collects "groups" of changes and creates an edit script.
 	 */
-	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
+	for (i1 = xe->xdf1.record.length, i2 = xe->xdf2.record.length; i1 >= 0 || i2 >= 0; i1--, i2--)
 		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
 			for (l1 = i1; rchg1[i1 - 1]; i1--);
 			for (l2 = i2; rchg2[i2 - 1]; i2--);
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index bbf7b7f8c862..11c2823ecab5 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -147,7 +147,7 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 	buf = func_line ? func_line->buf : dummy;
 	size = func_line ? sizeof(func_line->buf) : sizeof(dummy);
 
-	for (l = start; l != limit && 0 <= l && l < xe->xdf1.nrec; l += step) {
+	for (l = start; l != limit && 0 <= l && l < (long) xe->xdf1.record.length; l += step) {
 		long len = match_func_rec(&xe->xdf1, xecfg, l, buf, size);
 		if (len >= 0) {
 			if (func_line)
@@ -191,14 +191,14 @@ pre_context_calculation:
 			long fs1, i1 = xch->i1;
 
 			/* Appended chunk? */
-			if (i1 >= xe->xdf1.nrec) {
+			if (i1 >= (long) xe->xdf1.record.length) {
 				long i2 = xch->i2;
 
 				/*
 				 * We don't need additional context if
 				 * a whole function was added.
 				 */
-				while (i2 < xe->xdf2.nrec) {
+				while (i2 < (long) xe->xdf2.record.length) {
 					if (is_func_rec(&xe->xdf2, xecfg, i2))
 						goto post_context_calculation;
 					i2++;
@@ -208,7 +208,7 @@ pre_context_calculation:
 				 * Otherwise get more context from the
 				 * pre-image.
 				 */
-				i1 = xe->xdf1.nrec - 1;
+				i1 = xe->xdf1.record.length - 1;
 			}
 
 			fs1 = get_func_line(xe, xecfg, NULL, i1, -1);
@@ -240,8 +240,8 @@ pre_context_calculation:
 
  post_context_calculation:
 		lctx = xecfg->ctxlen;
-		lctx = XDL_MIN(lctx, xe->xdf1.nrec - (xche->i1 + xche->chg1));
-		lctx = XDL_MIN(lctx, xe->xdf2.nrec - (xche->i2 + xche->chg2));
+		lctx = XDL_MIN(lctx, (long) xe->xdf1.record.length - (xche->i1 + xche->chg1));
+		lctx = XDL_MIN(lctx, (long) xe->xdf2.record.length - (xche->i2 + xche->chg2));
 
 		e1 = xche->i1 + xche->chg1 + lctx;
 		e2 = xche->i2 + xche->chg2 + lctx;
@@ -249,13 +249,13 @@ pre_context_calculation:
 		if (xecfg->flags & XDL_EMIT_FUNCCONTEXT) {
 			long fe1 = get_func_line(xe, xecfg, NULL,
 						 xche->i1 + xche->chg1,
-						 xe->xdf1.nrec);
+						 xe->xdf1.record.length);
 			while (fe1 > 0 && is_empty_rec(&xe->xdf1, fe1 - 1))
 				fe1--;
 			if (fe1 < 0)
-				fe1 = xe->xdf1.nrec;
+				fe1 = xe->xdf1.record.length;
 			if (fe1 > e1) {
-				e2 = XDL_MIN(e2 + (fe1 - e1), xe->xdf2.nrec);
+				e2 = XDL_MIN(e2 + (fe1 - e1), (long) xe->xdf2.record.length);
 				e1 = fe1;
 			}
 
@@ -266,7 +266,7 @@ pre_context_calculation:
 			 */
 			if (xche->next) {
 				long l = XDL_MIN(xche->next->i1,
-						 xe->xdf1.nrec - 1);
+						 (long) xe->xdf1.record.length - 1);
 				if (l - xecfg->ctxlen <= e1 ||
 				    get_func_line(xe, xecfg, NULL, l, e1) < 0) {
 					xche = xche->next;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 6fa6ea61a208..f48549605d09 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -158,11 +158,11 @@ static int is_eol_crlf(xdfile_t *file, int i)
 {
 	long size;
 
-	if (i < file->nrec - 1)
+	if (i < (isize) file->record.length - 1)
 		/* All lines before the last *must* end in LF */
 		return (size = file->recs[i]->size) > 1 &&
 			file->recs[i]->ptr[size - 2] == '\r';
-	if (!file->nrec)
+	if (!file->record.length)
 		/* Cannot determine eol style from empty file */
 		return -1;
 	if ((size = file->recs[i]->size) &&
@@ -317,7 +317,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 			continue;
 		i = m->i1 + m->chg1;
 	}
-	size += xdl_recs_copy(xe1, i, xe1->xdf2.nrec - i, 0, 0,
+	size += xdl_recs_copy(xe1, i, (int) xe1->xdf2.record.length - i, 0, 0,
 			      dest ? dest + size : NULL);
 	return size;
 }
@@ -622,7 +622,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 			changes = c;
 		i0 = xscr1->i1;
 		i1 = xscr1->i2;
-		i2 = xscr1->i1 + xe2->xdf2.nrec - xe2->xdf1.nrec;
+		i2 = xscr1->i1 + xe2->xdf2.record.length - xe2->xdf1.record.length;
 		chg0 = xscr1->chg1;
 		chg1 = xscr1->chg2;
 		chg2 = xscr1->chg1;
@@ -637,7 +637,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 		if (!changes)
 			changes = c;
 		i0 = xscr2->i1;
-		i1 = xscr2->i1 + xe1->xdf2.nrec - xe1->xdf1.nrec;
+		i1 = xscr2->i1 + xe1->xdf2.record.length - xe1->xdf1.record.length;
 		i2 = xscr2->i2;
 		chg0 = xscr2->chg1;
 		chg1 = xscr2->chg1;
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 986a3a3f749a..e1ce9a399fbf 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -370,5 +370,5 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 
 int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env)
 {
-	return patience_diff(xpp, env, 1, env->xdf1.nrec, 1, env->xdf2.nrec);
+	return patience_diff(xpp, env, 1, env->xdf1.record.length, 1, env->xdf2.record.length);
 }
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 3b33186c15a3..9b46523afe97 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -138,7 +138,7 @@ static void xdl_free_ctx(xdfile_t *xdf) {
 }
 
 
-static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
+static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	long bsize;
 	unsigned long hav;
@@ -148,7 +148,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
 	xdf->recs = NULL;
-	xdf->nrec = 0;
 	IVEC_INIT(xdf->record);
 
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
@@ -164,7 +163,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	}
 	ivec_shrink_to_fit(&xdf->record);
 
-	xdf->nrec = (long) xdf->record.length;
 	if (!XDL_ALLOC_ARRAY(xdf->recs, xdf->record.length))
 		goto abort;
 	for (usize i = 0; i < xdf->record.length; i++) {
@@ -173,21 +171,21 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		xdf->recs[i] = &xdf->record.ptr[i];
 	}
 
-	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
+	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->record.length + 2))
 		goto abort;
 
 	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
 	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
-		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->rindex, xdf->record.length + 1))
 			goto abort;
-		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->nrec + 1))
+		if (!XDL_ALLOC_ARRAY(xdf->ha, xdf->record.length + 1))
 			goto abort;
 	}
 
 	xdf->rchg += 1;
 	xdf->nreff = 0;
 	xdf->dstart = 0;
-	xdf->dend = xdf->nrec - 1;
+	xdf->dend = xdf->record.length - 1;
 
 	return 0;
 
@@ -274,12 +272,12 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	char *dis, *dis1, *dis2;
 	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
 
-	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
+	if (!XDL_CALLOC_ARRAY(dis, xdf1->record.length + xdf2->record.length + 2))
 		return -1;
 	dis1 = dis;
-	dis2 = dis1 + xdf1->nrec + 1;
+	dis2 = dis1 + xdf1->record.length + 1;
 
-	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = xdl_bogosqrt(xdf1->record.length)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[(*recs)->ha];
@@ -287,7 +285,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
 
-	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = xdl_bogosqrt(xdf2->record.length)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[(*recs)->ha];
@@ -334,21 +332,21 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 
 	recs1 = xdf1->recs;
 	recs2 = xdf2->recs;
-	for (i = 0, lim = XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
+	for (i = 0, lim = XDL_MIN(xdf1->record.length, xdf2->record.length); i < lim;
 	     i++, recs1++, recs2++)
 		if ((*recs1)->ha != (*recs2)->ha)
 			break;
 
 	xdf1->dstart = xdf2->dstart = i;
 
-	recs1 = xdf1->recs + xdf1->nrec - 1;
-	recs2 = xdf2->recs + xdf2->nrec - 1;
+	recs1 = xdf1->recs + xdf1->record.length - 1;
+	recs2 = xdf2->recs + xdf2->record.length - 1;
 	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
 		if ((*recs1)->ha != (*recs2)->ha)
 			break;
 
-	xdf1->dend = xdf1->nrec - i - 1;
-	xdf2->dend = xdf2->nrec - i - 1;
+	xdf1->dend = xdf1->record.length - i - 1;
+	xdf2->dend = xdf2->record.length - i - 1;
 
 	return 0;
 }
@@ -388,12 +386,12 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
 		return -1;
 
-	if (xdl_prepare_ctx(1, mf1, enl1, xpp, &cf, &xe->xdf1) < 0) {
+	if (xdl_prepare_ctx(1, mf1, xpp, &cf, &xe->xdf1) < 0) {
 
 		xdl_free_classifier(&cf);
 		return -1;
 	}
-	if (xdl_prepare_ctx(2, mf2, enl2, xpp, &cf, &xe->xdf2) < 0) {
+	if (xdl_prepare_ctx(2, mf2, xpp, &cf, &xe->xdf2) < 0) {
 
 		xdl_free_ctx(&xe->xdf1);
 		xdl_free_classifier(&cf);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 5028a70b2675..c322e62fbf06 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -48,7 +48,6 @@ DEFINE_IVEC_TYPE(xrecord_t, xrecord);
 
 typedef struct s_xdfile {
 	struct ivec_xrecord record;
-	long nrec;
 	long dstart, dend;
 	xrecord_t **recs;
 	char *rchg;
-- 
gitgitgadget

