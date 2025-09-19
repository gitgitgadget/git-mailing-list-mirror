Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60B31960A
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295012; cv=none; b=PtK2JCKeRbkviVs84zz6AA0FQKvpfRMt2CUZ9ynVB6qSIbZJo9CNN9ZfwfnWcNi8JyVJzvL+Uh9vbEhAccNWIbdm9g8ZXjx3pWd/5l6ghIarDyChPQzB5VamJ65fUAhDox0zeLTjg5vfv27dFSVKX4qCMfVHT7A2ay7mKFACLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295012; c=relaxed/simple;
	bh=ZYwVZtRuyymZRFzUTvSI9ayoYOtg20yDpO+AD0TYF0E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=HzKat876ZHKIycp0/G3ukxae0PFS+FqI1EVKdjGR246pH6ey3lyXG1JKgjHbiJ44kLVTrX5g5Bqc+wQ1HOed6KYeoPoWlLL23shBQUhAHr6pq9zCpUksWqk/szRptLW+j9bWMwClVXsfM374OptRSDJI38F+/kNup9iaE7ZKwq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3yDbPXF; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3yDbPXF"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-4248b13dc1eso666225ab.3
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758295008; x=1758899808; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=297YI4mkBVCHi0yE1THPH7YD29Nl/IRrMoLXpzFaBP8=;
        b=J3yDbPXF5+QggZcDRBLpaa3i1LFag/bJhz6cJOyPDw4FQhePo0c+dHwf5PCgoxL86b
         R319N6t/pTcpP9b3SmDvg/mrGkC0mQ3eKpzRWz3KiXV3KD8JxP78PFBJuMr8s0kHohMK
         nKrhOlQ3UE2HipQRggdXusIxjnOr9LOFgkYALjRvFt5Z31420Lwu3/n14jCLX7WHbZRT
         uB8zgJJVxnr+IK3DF1CiTOByxgdV83UsJAi/JZXTSfZ1ygZO8h9PqNMZEMtXu6nJQtjd
         QaYy6Hd7ARNKuZuQrx8IlFSIVoaAmQziUnic72rS/9pVwswAiufpUuWJZd+xns/fU+Y7
         NAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295008; x=1758899808;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=297YI4mkBVCHi0yE1THPH7YD29Nl/IRrMoLXpzFaBP8=;
        b=nUH7H7HzJC3/MbsPkmTBgOm05ZevuvDiQvx741TB/1llJBJBVBUz6a2+VVch5qa6mu
         7+HPIk/vSW7VrvjcTUhQZVgkdAXewjFIvZyJvrkClFVzrOsTfX5nTrlNKyIbu5u4AOQr
         f4OFFoXZvVdlE279iETNLXSMbV40G7uu4l9IGbI+tpFgGu/HIeSjfLvbbYlOe7HXNrua
         KS7c7n1FNVQGcaEbu2GI2UnhlN3uSMtwq0ntEm2oWocY9CNyPM8wFFVXuvsMupQtv/8+
         7J3x0fb62d+cjnykWdvsb0aRLzUthiiyQyE5meL7Dio7T++9FM76ZnxEHPJ8nHNI3Dua
         mRVQ==
X-Gm-Message-State: AOJu0YxuTGxniKkBV+Q7v4dOULHS1jqiYa7G6cBOYjjpq1FXyKIY/9Od
	O52npDdR+mIwh9pAHZFsa/4wl4nVAP+xo2DLJCPwlIiTuNZesGBjLlDQpHKftKbr
X-Gm-Gg: ASbGncsO/RWW7UVBnF8+yXgPPAb+mt4LWFbnN9vPxP+6hg4lqUbySNHL0PnGsJvdseI
	0Fab5uym/GxeajWjRyNzUfXwA2COVfkhJzq55zTQZFcBeARYdPjXx+OeBMHKlvRu3nXTSipFDCj
	TOvkd9xu5TWyiJkn6kJaSuIh2qrnCwlYhTF1dEp1RZZlw6rW6f+WAnKUMRJrc7tSIBNMTvNwMdD
	eDUBiT1losam6RJEVrUSVEkj8YvsQyZu05AU4nkN0j+tEr6Ntd6GqvV9ICKrWtP/4dIXtVesDaS
	9e5jKL72ZOqrvNuMe2wQJK/6+glCECLry/uz/THBrM7Rc9w/MdeyEGeQzFulrhtSUyDU/KPLHM8
	/C8P24yVJXMuD+gOxmFzR8cCCfA==
X-Google-Smtp-Source: AGHT+IGowdiVj9ZhqPJuhaP1lS4hX8m0x61WmSHyT2Cuw2POnCeVRfui0UzgdAliLDRfku2IAXyDBg==
X-Received: by 2002:a05:6e02:1807:b0:413:9e81:7a99 with SMTP id e9e14a558f8ab-424818f7f29mr52744385ab.1.1758295007925;
        Fri, 19 Sep 2025 08:16:47 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.65])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244a493b40sm22253315ab.12.2025.09.19.08.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:16:46 -0700 (PDT)
Message-Id: <fae26d2a0438cd0c6ca6d9f26cbcae11fdf0a4bb.1758294992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
	<pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Sep 2025 15:16:30 +0000
Subject: [PATCH v3 08/10] xdiff: delete chastore from xdfile_t
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

xdfile_t currently uses chastore_t which is an arena allocator. I
think that xrecord_t used to be a linked list and recs didn't exist
originally. When recs was added I think they forgot to remove
xdfile_t.next, but was overlooked. This dual data structure setup
makes the code somewhat confusing.

Additionally the C type chastore_t isn't FFI friendly, and provides
little to no performance benefit over using realloc to grow an array.

Performance impact of deleting fields from xdfile_t:
Deleting ha is about 5% slower.
Deleting cha is about 5% faster.

Delete ha, but keep cha
  time hyperfine --warmup 3 -L exe build_v2.51.0/git,build_delete_ha/git '{exe} log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null'
  Benchmark 1: build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
    Time (mean ± σ):      1.269 s ±  0.017 s    [User: 1.135 s, System: 0.128 s]
    Range (min … max):    1.249 s …  1.286 s    10 runs

  Benchmark 2: build_delete_ha/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
    Time (mean ± σ):      1.339 s ±  0.017 s    [User: 1.234 s, System: 0.099 s]
    Range (min … max):    1.320 s …  1.358 s    10 runs

  Summary
    build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null ran
      1.06 ± 0.02 times faster than build_delete_ha/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null

Delete cha, but keep ha
  time hyperfine --warmup 3 -L exe build_v2.51.0/git,build_delete_chastore/git '{exe} log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null'
  Benchmark 1: build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
    Time (mean ± σ):      1.290 s ±  0.001 s    [User: 1.154 s, System: 0.130 s]
    Range (min … max):    1.288 s …  1.292 s    10 runs

  Benchmark 2: build_delete_chastore/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
    Time (mean ± σ):      1.232 s ±  0.017 s    [User: 1.105 s, System: 0.121 s]
    Range (min … max):    1.205 s …  1.249 s    10 runs

  Summary
    build_delete_chastore/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null ran
      1.05 ± 0.01 times faster than build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null

Delete ha AND chastore
  time hyperfine --warmup 3 -L exe build_v2.51.0/git,build_delete_ha_and_chastore/git '{exe} log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null'
  Benchmark 1: build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
    Time (mean ± σ):      1.291 s ±  0.002 s    [User: 1.156 s, System: 0.129 s]
    Range (min … max):    1.287 s …  1.295 s    10 runs

  Benchmark 2: build_delete_ha_and_chastore/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null
    Time (mean ± σ):      1.306 s ±  0.001 s    [User: 1.195 s, System: 0.105 s]
    Range (min … max):    1.305 s …  1.308 s    10 runs

  Summary
    build_v2.51.0/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null ran
      1.01 ± 0.00 times faster than build_delete_ha_and_chastore/git log --oneline --shortstat --diff-algorithm=myers -3000 v2.39.1 >/dev/null

Best-viewed-with: --color-words
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c     | 24 ++++++++++----------
 xdiff/xemit.c      |  6 ++---
 xdiff/xhistogram.c |  2 +-
 xdiff/xmerge.c     | 56 +++++++++++++++++++++++-----------------------
 xdiff/xpatience.c  | 10 ++++-----
 xdiff/xprepare.c   | 19 ++++++----------
 xdiff/xtypes.h     |  3 +--
 xdiff/xutils.c     | 12 +++++-----
 8 files changed, 63 insertions(+), 69 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 11cd090b53..a66125d44a 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -24,7 +24,7 @@
 
 static unsigned long get_hash(xdfile_t *xdf, long index)
 {
-	return xdf->recs[xdf->rindex[index]]->ha;
+	return xdf->recs[xdf->rindex[index]].ha;
 }
 
 #define XDL_MAX_COST_MIN 256
@@ -489,13 +489,13 @@ static void measure_split(const xdfile_t *xdf, long split,
 		m->indent = -1;
 	} else {
 		m->end_of_file = 0;
-		m->indent = get_indent(xdf->recs[split]);
+		m->indent = get_indent(&xdf->recs[split]);
 	}
 
 	m->pre_blank = 0;
 	m->pre_indent = -1;
 	for (i = split - 1; i >= 0; i--) {
-		m->pre_indent = get_indent(xdf->recs[i]);
+		m->pre_indent = get_indent(&xdf->recs[i]);
 		if (m->pre_indent != -1)
 			break;
 		m->pre_blank += 1;
@@ -508,7 +508,7 @@ static void measure_split(const xdfile_t *xdf, long split,
 	m->post_blank = 0;
 	m->post_indent = -1;
 	for (i = split + 1; i < xdf->nrec; i++) {
-		m->post_indent = get_indent(xdf->recs[i]);
+		m->post_indent = get_indent(&xdf->recs[i]);
 		if (m->post_indent != -1)
 			break;
 		m->post_blank += 1;
@@ -752,7 +752,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
 static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->end < xdf->nrec &&
-	    recs_match(xdf->recs[g->start], xdf->recs[g->end])) {
+	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
 		xdf->rchg[g->start++] = 0;
 		xdf->rchg[g->end++] = 1;
 
@@ -773,7 +773,7 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->start > 0 &&
-	    recs_match(xdf->recs[g->start - 1], xdf->recs[g->end - 1])) {
+	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
 		xdf->rchg[--g->start] = 1;
 		xdf->rchg[--g->end] = 0;
 
@@ -988,16 +988,16 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 
 	for (xch = xscr; xch; xch = xch->next) {
 		int ignore = 1;
-		xrecord_t **rec;
+		xrecord_t *rec;
 		long i;
 
 		rec = &xe->xdf1.recs[xch->i1];
 		for (i = 0; i < xch->chg1 && ignore; i++)
-			ignore = xdl_blankline(rec[i]->ptr, rec[i]->size, flags);
+			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
 
 		rec = &xe->xdf2.recs[xch->i2];
 		for (i = 0; i < xch->chg2 && ignore; i++)
-			ignore = xdl_blankline(rec[i]->ptr, rec[i]->size, flags);
+			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
 
 		xch->ignore = ignore;
 	}
@@ -1021,7 +1021,7 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
 	xdchange_t *xch;
 
 	for (xch = xscr; xch; xch = xch->next) {
-		xrecord_t **rec;
+		xrecord_t *rec;
 		int ignore = 1;
 		long i;
 
@@ -1033,11 +1033,11 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
 
 		rec = &xe->xdf1.recs[xch->i1];
 		for (i = 0; i < xch->chg1 && ignore; i++)
-			ignore = record_matches_regex(rec[i], xpp);
+			ignore = record_matches_regex(&rec[i], xpp);
 
 		rec = &xe->xdf2.recs[xch->i2];
 		for (i = 0; i < xch->chg2 && ignore; i++)
-			ignore = record_matches_regex(rec[i], xpp);
+			ignore = record_matches_regex(&rec[i], xpp);
 
 		xch->ignore = ignore;
 	}
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index b3793e81e2..79c14f8b4c 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -24,7 +24,7 @@
 
 static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
 {
-	xrecord_t *rec = xdf->recs[ri];
+	xrecord_t *rec = &xdf->recs[ri];
 
 	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0) {
 		return -1;
@@ -110,7 +110,7 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
 static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 			   char *buf, long sz)
 {
-	xrecord_t *rec = xdf->recs[ri];
+	xrecord_t *rec = &xdf->recs[ri];
 
 	if (!xecfg->find_func)
 		return def_ff(rec->ptr, rec->size, buf, sz);
@@ -150,7 +150,7 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
-	xrecord_t *rec = xdf->recs[ri];
+	xrecord_t *rec = &xdf->recs[ri];
 	long i = 0;
 
 	for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 040d81e0bc..4d857e8ae2 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -86,7 +86,7 @@ struct region {
 	((LINE_MAP(index, ptr))->cnt)
 
 #define REC(env, s, l) \
-	(env->xdf##s.recs[l - 1])
+	(&env->xdf##s.recs[l - 1])
 
 static int cmp_recs(xrecord_t *r1, xrecord_t *r2)
 {
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index af40c88a5b..fd600cbb5d 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -97,12 +97,12 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 		int line_count, long flags)
 {
 	int i;
-	xrecord_t **rec1 = xe1->xdf2.recs + i1;
-	xrecord_t **rec2 = xe2->xdf2.recs + i2;
+	xrecord_t *rec1 = xe1->xdf2.recs + i1;
+	xrecord_t *rec2 = xe2->xdf2.recs + i2;
 
 	for (i = 0; i < line_count; i++) {
-		int result = xdl_recmatch(rec1[i]->ptr, rec1[i]->size,
-			rec2[i]->ptr, rec2[i]->size, flags);
+		int result = xdl_recmatch(rec1[i].ptr, rec1[i].size,
+			rec2[i].ptr, rec2[i].size, flags);
 		if (!result)
 			return -1;
 	}
@@ -111,7 +111,7 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 
 static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int needs_cr, int add_nl, char *dest)
 {
-	xrecord_t **recs;
+	xrecord_t *recs;
 	int size = 0;
 
 	recs = (use_orig ? xe->xdf1.recs : xe->xdf2.recs) + i;
@@ -119,12 +119,12 @@ static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int nee
 	if (count < 1)
 		return 0;
 
-	for (i = 0; i < count; size += recs[i++]->size)
+	for (i = 0; i < count; size += recs[i++].size)
 		if (dest)
-			memcpy(dest + size, recs[i]->ptr, recs[i]->size);
+			memcpy(dest + size, recs[i].ptr, recs[i].size);
 	if (add_nl) {
-		i = recs[count - 1]->size;
-		if (i == 0 || recs[count - 1]->ptr[i - 1] != '\n') {
+		i = recs[count - 1].size;
+		if (i == 0 || recs[count - 1].ptr[i - 1] != '\n') {
 			if (needs_cr) {
 				if (dest)
 					dest[size] = '\r';
@@ -160,22 +160,22 @@ static int is_eol_crlf(xdfile_t *file, int i)
 
 	if (i < file->nrec - 1)
 		/* All lines before the last *must* end in LF */
-		return (size = file->recs[i]->size) > 1 &&
-			file->recs[i]->ptr[size - 2] == '\r';
+		return (size = file->recs[i].size) > 1 &&
+			file->recs[i].ptr[size - 2] == '\r';
 	if (!file->nrec)
 		/* Cannot determine eol style from empty file */
 		return -1;
-	if ((size = file->recs[i]->size) &&
-			file->recs[i]->ptr[size - 1] == '\n')
+	if ((size = file->recs[i].size) &&
+			file->recs[i].ptr[size - 1] == '\n')
 		/* Last line; ends in LF; Is it CR/LF? */
 		return size > 1 &&
-			file->recs[i]->ptr[size - 2] == '\r';
+			file->recs[i].ptr[size - 2] == '\r';
 	if (!i)
 		/* The only line has no eol */
 		return -1;
 	/* Determine eol from second-to-last line */
-	return (size = file->recs[i - 1]->size) > 1 &&
-		file->recs[i - 1]->ptr[size - 2] == '\r';
+	return (size = file->recs[i - 1].size) > 1 &&
+		file->recs[i - 1].ptr[size - 2] == '\r';
 }
 
 static int is_cr_needed(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m)
@@ -334,22 +334,22 @@ static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
 static void xdl_refine_zdiff3_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 		xpparam_t const *xpp)
 {
-	xrecord_t **rec1 = xe1->xdf2.recs, **rec2 = xe2->xdf2.recs;
+	xrecord_t *rec1 = xe1->xdf2.recs, *rec2 = xe2->xdf2.recs;
 	for (; m; m = m->next) {
 		/* let's handle just the conflicts */
 		if (m->mode)
 			continue;
 
 		while(m->chg1 && m->chg2 &&
-		      recmatch(rec1[m->i1], rec2[m->i2], xpp->flags)) {
+		      recmatch(&rec1[m->i1], &rec2[m->i2], xpp->flags)) {
 			m->chg1--;
 			m->chg2--;
 			m->i1++;
 			m->i2++;
 		}
 		while (m->chg1 && m->chg2 &&
-		       recmatch(rec1[m->i1 + m->chg1 - 1],
-				rec2[m->i2 + m->chg2 - 1], xpp->flags)) {
+		       recmatch(&rec1[m->i1 + m->chg1 - 1],
+				&rec2[m->i2 + m->chg2 - 1], xpp->flags)) {
 			m->chg1--;
 			m->chg2--;
 		}
@@ -381,12 +381,12 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 		 * This probably does not work outside git, since
 		 * we have a very simple mmfile structure.
 		 */
-		t1.ptr = (char *)xe1->xdf2.recs[m->i1]->ptr;
-		t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1]->ptr
-			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1]->size - t1.ptr;
-		t2.ptr = (char *)xe2->xdf2.recs[m->i2]->ptr;
-		t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1]->ptr
-			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1]->size - t2.ptr;
+		t1.ptr = (char *)xe1->xdf2.recs[m->i1].ptr;
+		t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
+			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1].size - t1.ptr;
+		t2.ptr = (char *)xe2->xdf2.recs[m->i2].ptr;
+		t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1].ptr
+			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1].size - t2.ptr;
 		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
 			return -1;
 		if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
@@ -440,8 +440,8 @@ static int line_contains_alnum(const char *ptr, long size)
 static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
 {
 	for (; chg; chg--, i++)
-		if (line_contains_alnum(xe->xdf2.recs[i]->ptr,
-				xe->xdf2.recs[i]->size))
+		if (line_contains_alnum(xe->xdf2.recs[i].ptr,
+				xe->xdf2.recs[i].size))
 			return 1;
 	return 0;
 }
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 77dc411d19..bf69a58527 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -88,9 +88,9 @@ static int is_anchor(xpparam_t const *xpp, const char *line)
 static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 			  int pass)
 {
-	xrecord_t **records = pass == 1 ?
+	xrecord_t *records = pass == 1 ?
 		map->env->xdf1.recs : map->env->xdf2.recs;
-	xrecord_t *record = records[line - 1];
+	xrecord_t *record = &records[line - 1];
 	/*
 	 * After xdl_prepare_env() (or more precisely, due to
 	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
@@ -121,7 +121,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 		return;
 	map->entries[index].line1 = line;
 	map->entries[index].hash = record->ha;
-	map->entries[index].anchor = is_anchor(xpp, map->env->xdf1.recs[line - 1]->ptr);
+	map->entries[index].anchor = is_anchor(xpp, map->env->xdf1.recs[line - 1].ptr);
 	if (!map->first)
 		map->first = map->entries + index;
 	if (map->last) {
@@ -246,8 +246,8 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 
 static int match(struct hashmap *map, int line1, int line2)
 {
-	xrecord_t *record1 = map->env->xdf1.recs[line1 - 1];
-	xrecord_t *record2 = map->env->xdf2.recs[line2 - 1];
+	xrecord_t *record1 = &map->env->xdf1.recs[line1 - 1];
+	xrecord_t *record2 = &map->env->xdf2.recs[line2 - 1];
 	return record1->ha == record2->ha;
 }
 
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 43cebf6721..5c7e858b6b 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -130,7 +130,6 @@ static void xdl_free_ctx(xdfile_t *xdf)
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
 	xdl_free(xdf->recs);
-	xdl_cha_free(&xdf->rcha);
 }
 
 
@@ -145,8 +144,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 	xdf->rchg = NULL;
 	xdf->recs = NULL;
 
-	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
-		goto abort;
 	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
 		goto abort;
 
@@ -157,12 +154,10 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			hav = xdl_hash_record(&cur, top, xpp->flags);
 			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
-			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
-				goto abort;
+			crec = &xdf->recs[xdf->nrec++];
 			crec->ptr = prev;
 			crec->size = (long) (cur - prev);
 			crec->ha = hav;
-			xdf->recs[xdf->nrec++] = crec;
 			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
@@ -262,7 +257,7 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
 	long i, nm, nreff, mlim;
-	xrecord_t **recs;
+	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	char *dis, *dis1, *dis2;
 	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
@@ -275,7 +270,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
-		rcrec = cf->rcrecs[(*recs)->ha];
+		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len2 : 0;
 		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
@@ -283,7 +278,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
-		rcrec = cf->rcrecs[(*recs)->ha];
+		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len1 : 0;
 		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
@@ -319,13 +314,13 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
  */
 static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 	long i, lim;
-	xrecord_t **recs1, **recs2;
+	xrecord_t *recs1, *recs2;
 
 	recs1 = xdf1->recs;
 	recs2 = xdf2->recs;
 	for (i = 0, lim = XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
 	     i++, recs1++, recs2++)
-		if ((*recs1)->ha != (*recs2)->ha)
+		if (recs1->ha != recs2->ha)
 			break;
 
 	xdf1->dstart = xdf2->dstart = i;
@@ -333,7 +328,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 	recs1 = xdf1->recs + xdf1->nrec - 1;
 	recs2 = xdf2->recs + xdf2->nrec - 1;
 	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
-		if ((*recs1)->ha != (*recs2)->ha)
+		if (recs1->ha != recs2->ha)
 			break;
 
 	xdf1->dend = xdf1->nrec - i - 1;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 85848f1685..3d26cbf1ec 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -45,10 +45,9 @@ typedef struct s_xrecord {
 } xrecord_t;
 
 typedef struct s_xdfile {
-	chastore_t rcha;
+	xrecord_t *recs;
 	long nrec;
 	long dstart, dend;
-	xrecord_t **recs;
 	char *rchg;
 	long *rindex;
 	long nreff;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 444a108f87..332982b509 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -416,12 +416,12 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 	mmfile_t subfile1, subfile2;
 	xdfenv_t env;
 
-	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1]->ptr;
-	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2]->ptr +
-		diff_env->xdf1.recs[line1 + count1 - 2]->size - subfile1.ptr;
-	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1]->ptr;
-	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2]->ptr +
-		diff_env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
+	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1].ptr;
+	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2].ptr +
+		diff_env->xdf1.recs[line1 + count1 - 2].size - subfile1.ptr;
+	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1].ptr;
+	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2].ptr +
+		diff_env->xdf2.recs[line2 + count2 - 2].size - subfile2.ptr;
 	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
 		return -1;
 
-- 
gitgitgadget

