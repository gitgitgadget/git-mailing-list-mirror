Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EBB30E837
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505276; cv=none; b=bq//fT4yWxIVxsoQ8czM0ruvRgpgFKo8hhnjnUAknDUhia0/5EKX0VdnNWOR7ghBrXln9A/xkqgk+UOavCqWXmQSPBeNZ5u/EGiz6WKbx7nBeeKOOoQi0mUw4BwugOql1ul+wCAIfLasUnjItYPypSfy+zB9SCfpKErH3AXZcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505276; c=relaxed/simple;
	bh=HvUPF7hiUqYeLlA2IqwlMq1o4+wWtiiSIYTUVtmx5mU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VILno1h02nP1ftJ91VsANHtVPc5doDtk90kP6QeDQS6A5KxjhP3rimzWbXrAaYXsuKuw1FmTPjYBnxL9TJymK/1k/+4IB69FAs/8UZwT93hpzrruasTUuasBjBcknXsowxqNpbI6GCqRf/qN2tYQdQkAA6l18MUOJvQrkBpO5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYpVT7cX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYpVT7cX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso283025b3a.0
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505272; x=1764110072; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmby6Fxb/hlT4AOS66XvpCh9AAKfjI87hB+Pjtjnzog=;
        b=gYpVT7cXdqKhbOBrH0aABaimyfYe5/dVwtYVOb1u4BDfaw3EX/F8+JAqnUmUk406o8
         448LfTF3sI1fGOf+aMEAVxjYPnRjNvD5ckR5Klv5m14+dewYt/kjyJYJckz7QukhHSHU
         R1mxoXY1EXF7lrO0ctYI64lEw8bmPo9L7iysCueh2wZHMRZpl9fXzSjpVSa57TIgw9O8
         YUUzzbUVWvWGbCikLq8HC3g+QlIkWMCRlrxC/tWiye18jHS/UhXIeDak95EfZvIh19uA
         YfTKtxAw0xfX/Vw5+wmcMk8nbBWLDn+NYBRdjc5q7DyUFKwS3TCC3G98eQ8CLBpRVqpo
         Y+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505272; x=1764110072;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bmby6Fxb/hlT4AOS66XvpCh9AAKfjI87hB+Pjtjnzog=;
        b=LBvvHrUzv0hYAx7pxJhxR6U7M+DrejloXGmv3d0E7mxFYRWK+MiBsX5p4kjVt1sAEX
         OkQ5IJ+XNIJJW6SbYSBpvSPqns+tsR5XmEHg1IOf5Sj8qokCS3Uc/Kqg4EGaWShTuYEx
         NMBj5siFoALQEUaxxcgIVGK0uXgxQRO5ELWJJIcprUvU5GCdhrI0rcFSZeZe/jSZYo79
         efT7h0et640UcjtVegwWAcvFfQzxYuwm7FhZdiv643sG9nug0wjuNmIx4MfCu2opelYm
         uLxdJ9TfQFvan8Ynixd2o2h0pgrJZX6JQ9Cd9iy84Wa7EfKpKnR/9o4PeJU5ZbraimP9
         WGEQ==
X-Gm-Message-State: AOJu0YySHZiagiFRUcHpj2otrGchQ56ixE9ogLRmV9cztHfCVaU2dh46
	08fkuGYCB6HTwoD9pY3NZeYIBviKguf98k6uzkvQW4bWV3H6Vai3e6X5LHY2fA==
X-Gm-Gg: ASbGncsroBC1VIV5tuUGeBHRVvL5tfSYouWH6LHJh78WoNYilOlfYW8AOjnvRDe9swu
	nmz46DCGc1JUMu46epAEyDTQ9SzDOYVfXn2oLqjd3vq7pAWoEZooowKkrf8XJs1/58mco+u/EAx
	xXmu7tvkI6z+5JEPZZ/Zq3BxICiP2pdjtGLPIN8eZRgR0hAMqqQiIISrDZdqJpXFyZwa8kZTtQA
	cm/qtWwksu3nw/UMHtCHazoyl3xD/6xDDAwx6V2lXvuRrcF4zCDqiF37Gy0N7H4NA66Jgj+dUzu
	yXa2hSbzk2BRgscN7vb5z6DSnc+xb7Ajznvy/VWLqZ81fFCbmVUy1T2K9Ta48axZvIO3cMg85KD
	C3YJCOaBScZhiCZAhdobEhtvew+qM6UNwSP8wzKlQVZ3S1t0KCJksKonx7uRbNSTbb0DHpUimuM
	UwsxYONAKTK1bR1X/YNr2czOk=
X-Google-Smtp-Source: AGHT+IE5vSnTwunIxTapkBJ3ZLN/fl5aA2uHmq8aSe8wpPG49dM3u/XuphIRcxDaksFDH4h74jRijw==
X-Received: by 2002:a05:6a20:6a1f:b0:2cb:519b:33fe with SMTP id adf61e73a8af0-3612edd07cfmr187645637.21.1763505271760;
        Tue, 18 Nov 2025 14:34:31 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c2a486167asm275636b3a.31.2025.11.18.14.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:34:31 -0800 (PST)
Message-Id: <78af0f16f4a1c3af0b8474169ceb75bda2b94b49.1763505262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 22:34:18 +0000
Subject: [PATCH v5 06/10] xdiff: split xrecord_t.ha into line_hash and
 minimal_perfect_hash
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

The ha field is serving two different purposes, which makes the code
harder to read. At first glance, it looks like many places assume
there could never be hash collisions between lines of the two input
files. In reality, line_hash is used together with xdl_recmatch() to
ensure correct comparisons of lines, even when collisions occur.

To make this clearer, the old ha field has been split:
  * line_hash: a straightforward hash of a line, independent of any
    external context. Its type is uint64_t, as it comes from a fixed
    width hash function.
  * minimal_perfect_hash: Not a new concept, but now a separate
    field. It comes from the classifier's general-purpose hash table,
    which assigns each line a unique and minimal hash across the two
    files. A size_t is used here because it's meant to be used to
    index an array. This also avoids ` as usize` casts on the Rust
    side when using it to index a slice.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c     |  6 +++---
 xdiff/xhistogram.c |  4 ++--
 xdiff/xpatience.c  | 10 +++++-----
 xdiff/xprepare.c   | 18 +++++++++---------
 xdiff/xtypes.h     |  3 ++-
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index cb8e412c7b..8d96074414 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -22,9 +22,9 @@
 
 #include "xinclude.h"
 
-static unsigned long get_hash(xdfile_t *xdf, long index)
+static size_t get_hash(xdfile_t *xdf, long index)
 {
-	return xdf->recs[xdf->rindex[index]].ha;
+	return xdf->recs[xdf->rindex[index]].minimal_perfect_hash;
 }
 
 #define XDL_MAX_COST_MIN 256
@@ -385,7 +385,7 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 
 static int recs_match(xrecord_t *rec1, xrecord_t *rec2)
 {
-	return (rec1->ha == rec2->ha);
+	return rec1->minimal_perfect_hash == rec2->minimal_perfect_hash;
 }
 
 /*
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index 6dc450b1fe..5ae1282c27 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -90,7 +90,7 @@ struct region {
 
 static int cmp_recs(xrecord_t *r1, xrecord_t *r2)
 {
-	return r1->ha == r2->ha;
+	return r1->minimal_perfect_hash == r2->minimal_perfect_hash;
 
 }
 
@@ -98,7 +98,7 @@ static int cmp_recs(xrecord_t *r1, xrecord_t *r2)
 	(cmp_recs(REC(i->env, s1, l1), REC(i->env, s2, l2)))
 
 #define TABLE_HASH(index, side, line) \
-	XDL_HASHLONG((REC(index->env, side, line))->ha, index->table_bits)
+	XDL_HASHLONG((REC(index->env, side, line))->minimal_perfect_hash, index->table_bits)
 
 static int scanA(struct histindex *index, int line1, int count1)
 {
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index bb61354f22..cc53266f3b 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -48,7 +48,7 @@
 struct hashmap {
 	int nr, alloc;
 	struct entry {
-		unsigned long hash;
+		size_t minimal_perfect_hash;
 		/*
 		 * 0 = unused entry, 1 = first line, 2 = second, etc.
 		 * line2 is NON_UNIQUE if the line is not unique
@@ -101,10 +101,10 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 	 * So we multiply ha by 2 in the hope that the hashing was
 	 * "unique enough".
 	 */
-	int index = (int)((record->ha << 1) % map->alloc);
+	int index = (int)((record->minimal_perfect_hash << 1) % map->alloc);
 
 	while (map->entries[index].line1) {
-		if (map->entries[index].hash != record->ha) {
+		if (map->entries[index].minimal_perfect_hash != record->minimal_perfect_hash) {
 			if (++index >= map->alloc)
 				index = 0;
 			continue;
@@ -120,7 +120,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
 	if (pass == 2)
 		return;
 	map->entries[index].line1 = line;
-	map->entries[index].hash = record->ha;
+	map->entries[index].minimal_perfect_hash = record->minimal_perfect_hash;
 	map->entries[index].anchor = is_anchor(xpp, (const char *)map->env->xdf1.recs[line - 1].ptr);
 	if (!map->first)
 		map->first = map->entries + index;
@@ -248,7 +248,7 @@ static int match(struct hashmap *map, int line1, int line2)
 {
 	xrecord_t *record1 = &map->env->xdf1.recs[line1 - 1];
 	xrecord_t *record2 = &map->env->xdf2.recs[line2 - 1];
-	return record1->ha == record2->ha;
+	return record1->minimal_perfect_hash == record2->minimal_perfect_hash;
 }
 
 static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 85e56021da..bea0992b5e 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -93,12 +93,12 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
 
 
 static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
-	long hi;
+	size_t hi;
 	xdlclass_t *rcrec;
 
-	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
+	hi = XDL_HASHLONG(rec->line_hash, cf->hbits);
 	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
-		if (rcrec->rec.ha == rec->ha &&
+		if (rcrec->rec.line_hash == rec->line_hash &&
 				xdl_recmatch((const char *)rcrec->rec.ptr, (long)rcrec->rec.size,
 					(const char *)rec->ptr, (long)rec->size, cf->flags))
 			break;
@@ -120,7 +120,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
 
 	(pass == 1) ? rcrec->len1++ : rcrec->len2++;
 
-	rec->ha = (unsigned long) rcrec->idx;
+	rec->minimal_perfect_hash = (size_t)rcrec->idx;
 
 	return 0;
 }
@@ -158,7 +158,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			crec = &xdf->recs[xdf->nrec++];
 			crec->ptr = prev;
 			crec->size = cur - prev;
-			crec->ha = hav;
+			crec->line_hash = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
 				goto abort;
 		}
@@ -290,7 +290,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->ha];
+		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len2 : 0;
 		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
@@ -298,7 +298,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
 		mlim = XDL_MAX_EQLIMIT;
 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
-		rcrec = cf->rcrecs[recs->ha];
+		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
 		nm = rcrec ? rcrec->len1 : 0;
 		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
 	}
@@ -350,7 +350,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 	recs2 = xdf2->recs;
 	for (i = 0, lim = XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
 	     i++, recs1++, recs2++)
-		if (recs1->ha != recs2->ha)
+		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
 
 	xdf1->dstart = xdf2->dstart = i;
@@ -358,7 +358,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 	recs1 = xdf1->recs + xdf1->nrec - 1;
 	recs2 = xdf2->recs + xdf2->nrec - 1;
 	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
-		if (recs1->ha != recs2->ha)
+		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
 			break;
 
 	xdf1->dend = xdf1->nrec - i - 1;
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 354349b523..d4e9cd2e76 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -41,7 +41,8 @@ typedef struct s_chastore {
 typedef struct s_xrecord {
 	uint8_t const *ptr;
 	size_t size;
-	unsigned long ha;
+	uint64_t line_hash;
+	size_t minimal_perfect_hash;
 } xrecord_t;
 
 typedef struct s_xdfile {
-- 
gitgitgadget

