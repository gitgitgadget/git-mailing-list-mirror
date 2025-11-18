Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A66305972
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505277; cv=none; b=f0gSVaBJYdZTM53xX/ilVVTDxqcfQuc8iQrK7WUwOstZtIt4VxqrSxTLKTaZz4Id/cb5/Qxmlt+hKG1PO0rnC2p4LLjMxnIZjn9pQjLQHE4ZXEw9VkVAFFED3w80JAqzVkeDah9hja5SBjS8Kuy6ILGKpgWf+ofNsJ2ZGTpP15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505277; c=relaxed/simple;
	bh=rCJJKO/ono8RGWW3qYZyqEzequcq7FfHdqZJU6pAIKY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ONj8IOTal5jl4pawC/5h53VmMLMu6Q42UoAOxfnSU08/2KKgwuRlbnlQe7EnHMooC6uA31a7SKEDFp+xBgwdTdLbP6KXlppRvohGWMX/21qJTEt/8YqJZioAo3t++xtvNPd45yTQ1TGPEnbSQwu4gg/0G+BaEQkRVbxJfMESBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fzg6vyrx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzg6vyrx"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso2419657b3a.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505273; x=1764110073; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AMGwgoAdFF1hGPTDdaq6bsme3JCGeTekWuZDm7uNqU=;
        b=Fzg6vyrxT8riJhmZpDQS8u42os635+jpkujdnYHxgwcUszbnu9Psg+Rpdvdc2HXzUh
         RKKuQKclKJ8J2Zu+HgW+isIpqaN2L2atzxZXBecIePhw/sptoF6leIFSDpmvJ2J7OCu1
         uXSOoIwQP+HLphOc8N/pRTXr50oJtRKFtb5BFIsTTf4ZmjB4bVgrgf6arXPYo/HJ8Fvg
         r/iloSRYC1W1G3T+p6xaSGL0JHEbkdmHVt/Rg5ckZSdoTmKYJntoJsmCNvJQx4uWFMXX
         C9UqhovyjMNq7W17BTAscJAoxw5PhVmQ4MJfJnR3o8utRYjIhQuRhstAlt5jO5uvKLp5
         5PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505273; x=1764110073;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2AMGwgoAdFF1hGPTDdaq6bsme3JCGeTekWuZDm7uNqU=;
        b=Ktq+GdOZoMjeaosuTq4cB25L2twVaYrXk15bih+oAVKgIjxA+oTd+oGN+Dto45DSlx
         drWrsMvYnTd9Bja5mfsY12MlkadMbKQqF55lVb0kHqFm1Z8nFVqK45X4oHcDpMwxhpLh
         hGZweKLDdEUxt6LtFP1MndpkwpE+kD3HQPsISZNue+KiyypGsp3dr8WsLvm6oNYEEtn0
         vMfbJn1KLNLiBS2SqCKZCYNyIpz2/z+Ga4ag+vgIpU2fiHJoID23VMGXp7rMeObiiAOD
         aoirx6UY5GaNZ6IjQVp2PIsv83oJ/4W+jSvIO3fR1cfU3pHVXL7YaEy/BioaDNoYM2MW
         sQ3A==
X-Gm-Message-State: AOJu0YzdKM3HxgZ8LD9wjEOWZdX7P+s7e4COXPtOOjnyl53D6Ken3TB+
	vqjp2NNiTRK22SY0VRbz+mhG1ABLtU1lqiAT0Syrb4NRyzXhXV9ucK8g4RiWjw==
X-Gm-Gg: ASbGncu/EunvWIy2ezyjNWwe58bn0Nb3t/GCRI+e6mD4vugenHykywhE2yLhsbLb9Mz
	jYxMxjPnfPPUf1Bi7uv6k3n8yH+SVAoHXkuaeGXpvkrWFCm08xNXEhSKOgsQW3IvehdbMTRmI5U
	6CvlvbQWBQrDkIsFUczve97Xx4pomV+ikt3iXO595F+/G53lRua5b9pDMrWl7Ol2rKvJks3m7zb
	lOmyqwVGZkE4fti22qSUULIe1ToD6inVecBun4VemnGa9kpdCaNfzD+F40dSWRqDo8HjRq7dZ1U
	kWu/pXjaUSfxrqiU6NSPIUDPgt7HzK2N+MsK1Xv3mLQT0KTFu+zzeQ2oim5j/X65FoD0zlmIMmc
	sQk6LVq3juiDaM0u4t4T9WxW6Je2wurW/tqX/U1MTdJZeiXm/qFqM3algNWdfcnMybJvfawjVE7
	awfwcvRGxBeRqTFeQV1/Xtd8I=
X-Google-Smtp-Source: AGHT+IHfiWpy33QVBV5aYTlm3tj5GJTIolOWRNwBxheSvPEC+7Q1GNmGxVrSCVMYRohhttwHswv23A==
X-Received: by 2002:a05:6a00:2e9a:b0:7a2:7a93:f8c9 with SMTP id d2e1a72fcca58-7ba3be8449bmr18734923b3a.27.1763505272986;
        Tue, 18 Nov 2025 14:34:32 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9251d31c8sm17225062b3a.30.2025.11.18.14.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:34:32 -0800 (PST)
Message-Id: <5c19f9ded397272da5a42e00b7ccd4f9cd484ee8.1763505262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 22:34:19 +0000
Subject: [PATCH v5 07/10] xdiff: make xdfile_t.nrec a size_t instead of long
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

size_t is used because nrec describes the number of elements for both
recs, and for 'changed' + 2.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c    |  8 ++++----
 xdiff/xemit.c     | 20 ++++++++++----------
 xdiff/xmerge.c    |  8 ++++----
 xdiff/xpatience.c |  2 +-
 xdiff/xprepare.c  | 12 ++++++------
 xdiff/xtypes.h    |  2 +-
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 8d96074414..21d06bce96 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -483,7 +483,7 @@ static void measure_split(const xdfile_t *xdf, long split,
 {
 	long i;
 
-	if (split >= xdf->nrec) {
+	if (split >= (long)xdf->nrec) {
 		m->end_of_file = 1;
 		m->indent = -1;
 	} else {
@@ -506,7 +506,7 @@ static void measure_split(const xdfile_t *xdf, long split,
 
 	m->post_blank = 0;
 	m->post_indent = -1;
-	for (i = split + 1; i < xdf->nrec; i++) {
+	for (i = split + 1; i < (long)xdf->nrec; i++) {
 		m->post_indent = get_indent(&xdf->recs[i]);
 		if (m->post_indent != -1)
 			break;
@@ -717,7 +717,7 @@ static void group_init(xdfile_t *xdf, struct xdlgroup *g)
  */
 static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
 {
-	if (g->end == xdf->nrec)
+	if (g->end == (long)xdf->nrec)
 		return -1;
 
 	g->start = g->end + 1;
@@ -750,7 +750,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
  */
 static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
-	if (g->end < xdf->nrec &&
+	if (g->end < (long)xdf->nrec &&
 	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
 		xdf->changed[g->start++] = false;
 		xdf->changed[g->end++] = true;
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 2f8007753c..04f7e9193b 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -137,7 +137,7 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 	buf = func_line ? func_line->buf : dummy;
 	size = func_line ? sizeof(func_line->buf) : sizeof(dummy);
 
-	for (l = start; l != limit && 0 <= l && l < xe->xdf1.nrec; l += step) {
+	for (l = start; l != limit && 0 <= l && l < (long)xe->xdf1.nrec; l += step) {
 		long len = match_func_rec(&xe->xdf1, xecfg, l, buf, size);
 		if (len >= 0) {
 			if (func_line)
@@ -179,14 +179,14 @@ pre_context_calculation:
 			long fs1, i1 = xch->i1;
 
 			/* Appended chunk? */
-			if (i1 >= xe->xdf1.nrec) {
+			if (i1 >= (long)xe->xdf1.nrec) {
 				long i2 = xch->i2;
 
 				/*
 				 * We don't need additional context if
 				 * a whole function was added.
 				 */
-				while (i2 < xe->xdf2.nrec) {
+				while (i2 < (long)xe->xdf2.nrec) {
 					if (is_func_rec(&xe->xdf2, xecfg, i2))
 						goto post_context_calculation;
 					i2++;
@@ -196,7 +196,7 @@ pre_context_calculation:
 				 * Otherwise get more context from the
 				 * pre-image.
 				 */
-				i1 = xe->xdf1.nrec - 1;
+				i1 = (long)xe->xdf1.nrec - 1;
 			}
 
 			fs1 = get_func_line(xe, xecfg, NULL, i1, -1);
@@ -228,8 +228,8 @@ pre_context_calculation:
 
  post_context_calculation:
 		lctx = xecfg->ctxlen;
-		lctx = XDL_MIN(lctx, xe->xdf1.nrec - (xche->i1 + xche->chg1));
-		lctx = XDL_MIN(lctx, xe->xdf2.nrec - (xche->i2 + xche->chg2));
+		lctx = XDL_MIN(lctx, (long)xe->xdf1.nrec - (xche->i1 + xche->chg1));
+		lctx = XDL_MIN(lctx, (long)xe->xdf2.nrec - (xche->i2 + xche->chg2));
 
 		e1 = xche->i1 + xche->chg1 + lctx;
 		e2 = xche->i2 + xche->chg2 + lctx;
@@ -237,13 +237,13 @@ pre_context_calculation:
 		if (xecfg->flags & XDL_EMIT_FUNCCONTEXT) {
 			long fe1 = get_func_line(xe, xecfg, NULL,
 						 xche->i1 + xche->chg1,
-						 xe->xdf1.nrec);
+						 (long)xe->xdf1.nrec);
 			while (fe1 > 0 && is_empty_rec(&xe->xdf1, fe1 - 1))
 				fe1--;
 			if (fe1 < 0)
-				fe1 = xe->xdf1.nrec;
+				fe1 = (long)xe->xdf1.nrec;
 			if (fe1 > e1) {
-				e2 = XDL_MIN(e2 + (fe1 - e1), xe->xdf2.nrec);
+				e2 = XDL_MIN(e2 + (fe1 - e1), (long)xe->xdf2.nrec);
 				e1 = fe1;
 			}
 
@@ -254,7 +254,7 @@ pre_context_calculation:
 			 */
 			if (xche->next) {
 				long l = XDL_MIN(xche->next->i1,
-						 xe->xdf1.nrec - 1);
+						 (long)xe->xdf1.nrec - 1);
 				if (l - xecfg->ctxlen <= e1 ||
 				    get_func_line(xe, xecfg, NULL, l, e1) < 0) {
 					xche = xche->next;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 0dd4558a32..29dad98c49 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -158,7 +158,7 @@ static int is_eol_crlf(xdfile_t *file, int i)
 {
 	size_t size;
 
-	if (i < file->nrec - 1)
+	if (i < (long)file->nrec - 1)
 		/* All lines before the last *must* end in LF */
 		return (size = file->recs[i].size) > 1 &&
 			file->recs[i].ptr[size - 2] == '\r';
@@ -317,7 +317,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
 			continue;
 		i = m->i1 + m->chg1;
 	}
-	size += xdl_recs_copy(xe1, i, xe1->xdf2.nrec - i, 0, 0,
+	size += xdl_recs_copy(xe1, i, (int)xe1->xdf2.nrec - i, 0, 0,
 			      dest ? dest + size : NULL);
 	return size;
 }
@@ -622,7 +622,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 			changes = c;
 		i0 = xscr1->i1;
 		i1 = xscr1->i2;
-		i2 = xscr1->i1 + xe2->xdf2.nrec - xe2->xdf1.nrec;
+		i2 = xscr1->i1 + (long)xe2->xdf2.nrec - (long)xe2->xdf1.nrec;
 		chg0 = xscr1->chg1;
 		chg1 = xscr1->chg2;
 		chg2 = xscr1->chg1;
@@ -637,7 +637,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 		if (!changes)
 			changes = c;
 		i0 = xscr2->i1;
-		i1 = xscr2->i1 + xe1->xdf2.nrec - xe1->xdf1.nrec;
+		i1 = xscr2->i1 + (long)xe1->xdf2.nrec - (long)xe1->xdf1.nrec;
 		i2 = xscr2->i2;
 		chg0 = xscr2->chg1;
 		chg1 = xscr2->chg1;
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index cc53266f3b..a0b31eb5d8 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -370,5 +370,5 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
 
 int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env)
 {
-	return patience_diff(xpp, env, 1, env->xdf1.nrec, 1, env->xdf2.nrec);
+	return patience_diff(xpp, env, 1, (int)env->xdf1.nrec, 1, (int)env->xdf2.nrec);
 }
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index bea0992b5e..705ddd1ae0 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -153,7 +153,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 		for (top = blk + bsize; cur < top; ) {
 			prev = cur;
 			hav = xdl_hash_record(&cur, top, xpp->flags);
-			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
+			if (XDL_ALLOC_GROW(xdf->recs, (long)xdf->nrec + 1, narec))
 				goto abort;
 			crec = &xdf->recs[xdf->nrec++];
 			crec->ptr = prev;
@@ -287,7 +287,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	/*
 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
 	 */
-	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
@@ -295,7 +295,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
 
-	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
+	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
 		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
@@ -348,7 +348,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 
 	recs1 = xdf1->recs;
 	recs2 = xdf2->recs;
-	for (i = 0, lim = XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
+	for (i = 0, lim = (long)XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
 	     i++, recs1++, recs2++)
 		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
@@ -361,8 +361,8 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
 
-	xdf1->dend = xdf1->nrec - i - 1;
-	xdf2->dend = xdf2->nrec - i - 1;
+	xdf1->dend = (long)xdf1->nrec - i - 1;
+	xdf2->dend = (long)xdf2->nrec - i - 1;
 
 	return 0;
 }
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index d4e9cd2e76..4c4d9bd147 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -47,7 +47,7 @@ typedef struct s_xrecord {
 
 typedef struct s_xdfile {
 	xrecord_t *recs;
-	long nrec;
+	size_t nrec;
 	ptrdiff_t dstart, dend;
 	bool *changed;
 	long *rindex;
-- 
gitgitgadget

