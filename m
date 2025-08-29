Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD8253B59
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496562; cv=none; b=dfOHuQnp3UJw9qn8bCHibr2ClSBzRy9m2+1VymfdgfFWf9CO3cE8wPxNaR3MVqXPlblAiZT6wVlURuV9VAijW66PVWVV3Xv/s9Mn2HKIr9yV6LzJmxWyELOmzWRW9Ox1wS1T81DsSkJTYTjq8lTvcpXavMjdtDxjxSXFx/HfDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496562; c=relaxed/simple;
	bh=Qh/OLJ3l0DUgHEdQLqWtTaDiGDygYFflZqMJvTEFnEk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PCJV1NRbv0Y/IbzojuJy5Hoc1zDVxXN3I5xtJH80/zwrLNPe75duHI9k7krIa+fAxG+LcM5kVmnhZo3J6hI9JY9vgivOveLYqm0VBgtKHR16NJ1u+ITSS6XwJG/OGCI9reBE9ChQNqS++glc2EiWo2Q24Z/5KnwjY74g3zzS5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRMqM6mf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRMqM6mf"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7722e0ca299so774640b3a.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496559; x=1757101359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv/e9YF3Qqq6oxmu6FPL16zwoH+AgaVi4IFv63OGuKs=;
        b=GRMqM6mfjcSjZvlBhoyybZoWBV6ZXEWMMsLdN0jUoDJIY629jzNq66Kk3m+L+IRMZB
         0/p3m8QiNeQI+IleDHwwK1Tpqf6RzocnHLbpuXW+oLSoR2Pqg4tAMjai4tgxi+cAnX9O
         mhdxL5Fu69VwwNog9hVaY67NWelKGEbfkESgxTnb/cEoEDJfOmD76oJDr7pDVIjPJIZQ
         6qCuSWm6nnB8M5PDXOnAEYFE7g0akkjH50Lk8rfUKcDqge/qEEKDJuFjdohDjHr2xdYL
         /T8bpaJgTM/qtf585mswYkLvFEmAWRvunOLRjxY59KIPmDml7wBUg1w9YsfBGcH1/fjC
         tmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496559; x=1757101359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv/e9YF3Qqq6oxmu6FPL16zwoH+AgaVi4IFv63OGuKs=;
        b=R6fnn6rPzA7gzIsSGwCM4f1lsQZ6uQNoOmnZV+A6WR4MtZ/4dGkTuMyOATkCR+5kui
         Uz/cNfD7WctDfl0dQWu1zumhe9drLNEDNaAHIoku6gKpBqmuR2nAEmtyWR3FwNstWI/k
         JaP5HNpmqQmwH801AEu9FpkX2yWH+lGCfDsNCRHh4mTGmpSK7iB5n2tIbMSGrRajgixx
         l9+h3z5Ouw/XOcWx1b2G4UwOTRg3CSRoD4QAPdsgQdgCeNUpOowSf70eVb6ax1qYhs+j
         7oJRt5+f9eHxJZZYueAJ7MkMdPDHvGohIc98ePwGtiG6MOwFbTdY65v7Jm2jcHHCrDwQ
         TkPg==
X-Gm-Message-State: AOJu0YzyyekzQMi2d6itVZGse5J+5Ptxywzttkra24njXwYkSscoJN8/
	8lnP8YVKm2MQ9ds/rOrYgDXCNdOn9aiCEOEW1/UbSmeEGw1aJx4suQY+nIFIDg==
X-Gm-Gg: ASbGncvNsozbDSi2wU2DsyHBsOa6fxprm/fNAv5IGhmAK7LctqRZkTTbxfSCwWzmgNn
	13buV+h2uexKItk3gSvyWkfbRDeeS6VFGUNj56izBxXjP5QsCjQgkmalYBpgYZdlS1nORoqA9g9
	zueoR05Ac6AmmbTtLg9S38HUNjkktsrqVIYuZtug1IvuqOlN5tPBqOJTfvGkmx1Fi3Xcp1Gu6qq
	40UmhmKFVWC9ze4BzDUVsKkb/ACFX+SHPbRXMwSg7JPJUEQ2/9NQYC6MINaDpp+kL5Dk/9IR5RH
	+OJjSYTftNMA3nQ+ER2qF7JBMvEv+4i6gdvJ5mqrIdwuy9/4ZAD7N5kHcwkcNtwAjIaaecxXveO
	hOszR42gfDOj/BInnNjhZ511KPgqpZVzShUfbyQ==
X-Google-Smtp-Source: AGHT+IFB2tntLZmJto8dMXf82OzYRbe3nYENr36qqblJtwvM/zR7S6TzChleFLi9WhhspgLIcFLI9Q==
X-Received: by 2002:a05:6a20:1584:b0:243:d3d3:61d4 with SMTP id adf61e73a8af0-243d3d36446mr972204637.16.1756496559390;
        Fri, 29 Aug 2025 12:42:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772300a3e84sm2391125b3a.40.2025.08.29.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:38 -0700 (PDT)
Message-Id: <15c2854a327c2bab8ddee067a2763b3a7488280e.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:17 +0000
Subject: [PATCH 13/15] xdiff: delete recs field from xdfile_t
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Because of the change from chastore to ivec a few commits ago,
recs now points to record's elements in a 1:1 mapping.
Since both recs and record are vectors, this additional mapping is
superfluous. Remove recs.

This commit is best viewed with --color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c     | 30 ++++++++++++------------
 xdiff/xemit.c      |  4 ++--
 xdiff/xhistogram.c |  2 +-
 xdiff/xmerge.c     | 58 +++++++++++++++++++++++-----------------------
 xdiff/xpatience.c  | 14 +++++------
 xdiff/xprepare.c   | 37 +++++++++++++----------------
 xdiff/xtypes.h     |  1 -
 xdiff/xutils.c     | 12 +++++-----
 8 files changed, 76 insertions(+), 82 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index bcab2d7ae5..ebdb724322 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -501,13 +501,13 @@ static void measure_split(const xdfile_t *xdf, long split,
 		m->indent = -1;
 	} else {
 		m->end_of_file = 0;
-		m->indent = get_indent(xdf->recs[split]);
+		m->indent = get_indent(&xdf->record.ptr[split]);
 	}
 
 	m->pre_blank = 0;
 	m->pre_indent = -1;
 	for (i = split - 1; i >= 0; i--) {
-		m->pre_indent = get_indent(xdf->recs[i]);
+		m->pre_indent = get_indent(&xdf->record.ptr[i]);
 		if (m->pre_indent != -1)
 			break;
 		m->pre_blank += 1;
@@ -520,7 +520,7 @@ static void measure_split(const xdfile_t *xdf, long split,
 	m->post_blank = 0;
 	m->post_indent = -1;
 	for (i = split + 1; i < (long) xdf->record.length; i++) {
-		m->post_indent = get_indent(xdf->recs[i]);
+		m->post_indent = get_indent(&xdf->record.ptr[i]);
 		if (m->post_indent != -1)
 			break;
 		m->post_blank += 1;
@@ -764,7 +764,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
 static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->end < (long) xdf->record.length &&
-	    recs_match(xdf->recs[g->start], xdf->recs[g->end])) {
+	    recs_match(&xdf->record.ptr[g->start], &xdf->record.ptr[g->end])) {
 		xdf->rchg[g->start++] = 0;
 		xdf->rchg[g->end++] = 1;
 
@@ -785,7 +785,7 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
 static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
 {
 	if (g->start > 0 &&
-	    recs_match(xdf->recs[g->start - 1], xdf->recs[g->end - 1])) {
+	    recs_match(&xdf->record.ptr[g->start - 1], &xdf->record.ptr[g->end - 1])) {
 		xdf->rchg[--g->start] = 1;
 		xdf->rchg[--g->end] = 0;
 
@@ -1000,16 +1000,16 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
 
 	for (xch = xscr; xch; xch = xch->next) {
 		int ignore = 1;
-		xrecord_t **rec;
+		xrecord_t *rec;
 		long i;
 
-		rec = &xe->xdf1.recs[xch->i1];
+		rec = &xe->xdf1.record.ptr[xch->i1];
 		for (i = 0; i < xch->chg1 && ignore; i++)
-			ignore = xdl_blankline((const char*) rec[i]->ptr, rec[i]->size, flags);
+			ignore = xdl_blankline((const char*) rec[i].ptr, rec[i].size, flags);
 
-		rec = &xe->xdf2.recs[xch->i2];
+		rec = &xe->xdf2.record.ptr[xch->i2];
 		for (i = 0; i < xch->chg2 && ignore; i++)
-			ignore = xdl_blankline((const char*)rec[i]->ptr, rec[i]->size, flags);
+			ignore = xdl_blankline((const char*)rec[i].ptr, rec[i].size, flags);
 
 		xch->ignore = ignore;
 	}
@@ -1033,7 +1033,7 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
 	xdchange_t *xch;
 
 	for (xch = xscr; xch; xch = xch->next) {
-		xrecord_t **rec;
+		xrecord_t *rec;
 		int ignore = 1;
 		long i;
 
@@ -1043,13 +1043,13 @@ static void xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
 		if (xch->ignore)
 			continue;
 
-		rec = &xe->xdf1.recs[xch->i1];
+		rec = &xe->xdf1.record.ptr[xch->i1];
 		for (i = 0; i < xch->chg1 && ignore; i++)
-			ignore = record_matches_regex(rec[i], xpp);
+			ignore = record_matches_regex(&rec[i], xpp);
 
-		rec = &xe->xdf2.recs[xch->i2];
+		rec = &xe->xdf2.record.ptr[xch->i2];
 		for (i = 0; i < xch->chg2 && ignore; i++)
-			ignore = record_matches_regex(rec[i], xpp);
+			ignore = record_matches_regex(&rec[i], xpp);
 
 		xch->ignore = ignore;
 	}
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 11c2823eca..0c9a12a5e8 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -24,9 +24,9 @@
 
 static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
 
-	*rec = (char const*) xdf->recs[ri]->ptr;
+	*rec = (char const*) xdf->record.ptr[ri].ptr;
 
-	return xdf->recs[ri]->size;
+	return xdf->record.ptr[ri].size;
 }
 
 
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 040d81e0bc..643d1c8b70 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -86,7 +86,7 @@ struct region {
 	((LINE_MAP(index, ptr))->cnt)
 
 #define REC(env, s, l) \
-	(env->xdf##s.recs[l - 1])
+	(&env->xdf##s.record.ptr[l - 1])
 
 static int cmp_recs(xrecord_t *r1, xrecord_t *r2)
 {
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index f48549605d..0a3e0f28ab 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -97,12 +97,12 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 		int line_count, long flags)
 {
 	int i;
-	xrecord_t **rec1 = xe1->xdf2.recs + i1;
-	xrecord_t **rec2 = xe2->xdf2.recs + i2;
+	xrecord_t *rec1 = xe1->xdf2.record.ptr + i1;
+	xrecord_t *rec2 = xe2->xdf2.record.ptr + i2;
 
 	for (i = 0; i < line_count; i++) {
-		int result = xdl_recmatch((const char*) rec1[i]->ptr, rec1[i]->size,
-			(const char*) rec2[i]->ptr, rec2[i]->size, flags);
+		int result = xdl_recmatch((const char*) rec1[i].ptr, rec1[i].size,
+			(const char*) rec2[i].ptr, rec2[i].size, flags);
 		if (!result)
 			return -1;
 	}
@@ -111,20 +111,20 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
 
 static int xdl_recs_copy_0(int use_orig, xdfenv_t *xe, int i, int count, int needs_cr, int add_nl, char *dest)
 {
-	xrecord_t **recs;
+	xrecord_t *recs;
 	int size = 0;
 
-	recs = (use_orig ? xe->xdf1.recs : xe->xdf2.recs) + i;
+	recs = (use_orig ? xe->xdf1.record.ptr : xe->xdf2.record.ptr) + i;
 
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
 
 	if (i < (isize) file->record.length - 1)
 		/* All lines before the last *must* end in LF */
-		return (size = file->recs[i]->size) > 1 &&
-			file->recs[i]->ptr[size - 2] == '\r';
+		return (size = file->record.ptr[i].size) > 1 &&
+			file->record.ptr[i].ptr[size - 2] == '\r';
 	if (!file->record.length)
 		/* Cannot determine eol style from empty file */
 		return -1;
-	if ((size = file->recs[i]->size) &&
-			file->recs[i]->ptr[size - 1] == '\n')
+	if ((size = file->record.ptr[i].size) &&
+			file->record.ptr[i].ptr[size - 1] == '\n')
 		/* Last line; ends in LF; Is it CR/LF? */
 		return size > 1 &&
-			file->recs[i]->ptr[size - 2] == '\r';
+			file->record.ptr[i].ptr[size - 2] == '\r';
 	if (!i)
 		/* The only line has no eol */
 		return -1;
 	/* Determine eol from second-to-last line */
-	return (size = file->recs[i - 1]->size) > 1 &&
-		file->recs[i - 1]->ptr[size - 2] == '\r';
+	return (size = file->record.ptr[i - 1].size) > 1 &&
+		file->record.ptr[i - 1].ptr[size - 2] == '\r';
 }
 
 static int is_cr_needed(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m)
@@ -334,22 +334,22 @@ static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
 static void xdl_refine_zdiff3_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 		xpparam_t const *xpp)
 {
-	xrecord_t **rec1 = xe1->xdf2.recs, **rec2 = xe2->xdf2.recs;
+	xrecord_t *rec1 = xe1->xdf2.record.ptr, *rec2 = xe2->xdf2.record.ptr;
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
-			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1]->size - (u8 const*) t1.ptr;
-		t2.ptr = (char *)xe2->xdf2.recs[m->i2]->ptr;
-		t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1]->ptr
-			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1]->size - (u8 const*) t2.ptr;
+		t1.ptr = (char *)xe1->xdf2.record.ptr[m->i1].ptr;
+		t1.size = xe1->xdf2.record.ptr[m->i1 + m->chg1 - 1].ptr
+			+ xe1->xdf2.record.ptr[m->i1 + m->chg1 - 1].size - (u8 const*) t1.ptr;
+		t2.ptr = (char *)xe2->xdf2.record.ptr[m->i2].ptr;
+		t2.size = xe2->xdf2.record.ptr[m->i2 + m->chg2 - 1].ptr
+			+ xe2->xdf2.record.ptr[m->i2 + m->chg2 - 1].size - (u8 const*) t2.ptr;
 		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
 			return -1;
 		if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
@@ -440,8 +440,8 @@ static int line_contains_alnum(const char *ptr, long size)
 static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
 {
 	for (; chg; chg--, i++)
-		if (line_contains_alnum((char const*) xe->xdf2.recs[i]->ptr,
-				xe->xdf2.recs[i]->size))
+		if (line_contains_alnum((char const*) xe->xdf2.record.ptr[i].ptr,
+				xe->xdf2.record.ptr[i].size))
 			return 1;
 	return 0;
 }
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index e1ce9a399f..31b819ec58 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -88,9 +88,9 @@ static int is_anchor(xpparam_t const *xpp, const char *line)
 static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 			  int pass)
 {
-	xrecord_t **records = pass == 1 ?
-		map->env->xdf1.recs : map->env->xdf2.recs;
-	xrecord_t *record = records[line - 1];
+	xrecord_t *records = pass == 1 ?
+		map->env->xdf1.record.ptr : map->env->xdf2.record.ptr;
+	xrecord_t *record = &records[line - 1];
 	/*
 	 * After xdl_prepare_env() (or more precisely, due to
 	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
@@ -121,7 +121,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 		return;
 	map->entries[index].line1 = line;
 	map->entries[index].hash = record->ha;
-	map->entries[index].anchor = is_anchor(xpp, (const char*) map->env->xdf1.recs[line - 1]->ptr);
+	map->entries[index].anchor = is_anchor(xpp, (const char*) map->env->xdf1.record.ptr[line - 1].ptr);
 	if (!map->first)
 		map->first = map->entries + index;
 	if (map->last) {
@@ -246,9 +246,9 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 
 static int match(struct hashmap *map, int line1, int line2)
 {
-	xrecord_t *record1 = map->env->xdf1.recs[line1 - 1];
-	xrecord_t *record2 = map->env->xdf2.recs[line2 - 1];
-	return record1->ha == record2->ha;
+	u64 mph1 = map->env->xdf1.record.ptr[line1 - 1].ha;
+	u64 mph2 = map->env->xdf2.record.ptr[line2 - 1].ha;
+	return mph1 == mph2;
 }
 
 static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 9b46523afe..93370f1c6d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -134,7 +134,6 @@ static void xdl_free_ctx(xdfile_t *xdf) {
 	xdl_free(xdf->rindex);
 	xdl_free(xdf->rchg - 1);
 	xdl_free(xdf->ha);
-	xdl_free(xdf->recs);
 }
 
 
@@ -147,7 +146,6 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, xpparam_t const *xpp
 	xdf->ha = NULL;
 	xdf->rindex = NULL;
 	xdf->rchg = NULL;
-	xdf->recs = NULL;
 	IVEC_INIT(xdf->record);
 
 	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
@@ -163,12 +161,9 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, xpparam_t const *xpp
 	}
 	ivec_shrink_to_fit(&xdf->record);
 
-	if (!XDL_ALLOC_ARRAY(xdf->recs, xdf->record.length))
-		goto abort;
 	for (usize i = 0; i < xdf->record.length; i++) {
 		if (xdl_classify_record(pass, cf, &xdf->record.ptr[i]) < 0)
 			goto abort;
-		xdf->recs[i] = &xdf->record.ptr[i];
 	}
 
 	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->record.length + 2))
@@ -267,7 +262,7 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
 	long i, nm, nreff, mlim;
-	xrecord_t **recs;
+	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	char *dis, *dis1, *dis2;
 	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
@@ -279,38 +274,38 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 
 	if ((mlim = xdl_bogosqrt(xdf1->record.length)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
-		rcrec = cf->rcrecs[(*recs)->ha];
+	for (i = xdf1->dstart, recs = &xdf1->record.ptr[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
+		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len2 : 0;
 		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
 
 	if ((mlim = xdl_bogosqrt(xdf2->record.length)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
-	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
-		rcrec = cf->rcrecs[(*recs)->ha];
+	for (i = xdf2->dstart, recs = &xdf2->record.ptr[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
+		rcrec = cf->rcrecs[recs->ha];
 		nm = rcrec ? rcrec->len1 : 0;
 		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
 	}
 
-	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
+	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->record.ptr[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
 		if (dis1[i] == 1 ||
 		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
 			xdf1->rindex[nreff] = i;
-			xdf1->ha[nreff] = (*recs)->ha;
+			xdf1->ha[nreff] = recs->ha;
 			nreff++;
 		} else
 			xdf1->rchg[i] = 1;
 	}
 	xdf1->nreff = nreff;
 
-	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
+	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->record.ptr[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
 		if (dis2[i] == 1 ||
 		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
 			xdf2->rindex[nreff] = i;
-			xdf2->ha[nreff] = (*recs)->ha;
+			xdf2->ha[nreff] = recs->ha;
 			nreff++;
 		} else
 			xdf2->rchg[i] = 1;
@@ -328,21 +323,21 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
  */
 static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 	long i, lim;
-	xrecord_t **recs1, **recs2;
+	xrecord_t *recs1, *recs2;
 
-	recs1 = xdf1->recs;
-	recs2 = xdf2->recs;
+	recs1 = xdf1->record.ptr;
+	recs2 = xdf2->record.ptr;
 	for (i = 0, lim = XDL_MIN(xdf1->record.length, xdf2->record.length); i < lim;
 	     i++, recs1++, recs2++)
-		if ((*recs1)->ha != (*recs2)->ha)
+		if (recs1->ha != recs2->ha)
 			break;
 
 	xdf1->dstart = xdf2->dstart = i;
 
-	recs1 = xdf1->recs + xdf1->record.length - 1;
-	recs2 = xdf2->recs + xdf2->record.length - 1;
+	recs1 = xdf1->record.ptr + xdf1->record.length - 1;
+	recs2 = xdf2->record.ptr + xdf2->record.length - 1;
 	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
-		if ((*recs1)->ha != (*recs2)->ha)
+		if (recs1->ha != recs2->ha)
 			break;
 
 	xdf1->dend = xdf1->record.length - i - 1;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index c322e62fbf..849f218b32 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -49,7 +49,6 @@ DEFINE_IVEC_TYPE(xrecord_t, xrecord);
 typedef struct s_xdfile {
 	struct ivec_xrecord record;
 	long dstart, dend;
-	xrecord_t **recs;
 	char *rchg;
 	long *rindex;
 	long nreff;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 10e4f20b7c..eed88ee6cb 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -416,12 +416,12 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
 	mmfile_t subfile1, subfile2;
 	xdfenv_t env;
 
-	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1]->ptr;
-	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2]->ptr +
-		diff_env->xdf1.recs[line1 + count1 - 2]->size - (u8 const*) subfile1.ptr;
-	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1]->ptr;
-	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2]->ptr +
-		diff_env->xdf2.recs[line2 + count2 - 2]->size - (u8 const*) subfile2.ptr;
+	subfile1.ptr = (char *)diff_env->xdf1.record.ptr[line1 - 1].ptr;
+	subfile1.size = diff_env->xdf1.record.ptr[line1 + count1 - 2].ptr +
+		diff_env->xdf1.record.ptr[line1 + count1 - 2].size - (u8 const*) subfile1.ptr;
+	subfile2.ptr = (char *)diff_env->xdf2.record.ptr[line2 - 1].ptr;
+	subfile2.size = diff_env->xdf2.record.ptr[line2 + count2 - 2].ptr +
+		diff_env->xdf2.record.ptr[line2 + count2 - 2].size - (u8 const*) subfile2.ptr;
 	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
 		return -1;
 
-- 
gitgitgadget

