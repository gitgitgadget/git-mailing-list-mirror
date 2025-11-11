Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AAE3328EE
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890164; cv=none; b=iss/hx4frDlwvtcn5xrvuC70O8EIwxpOTxvCHSDfLJh1y43J+3EYbDDiCxzl7Jr38y2/9yfCK1hYAi9GmPO4xqk8qd2qG4fT8j1ZfZWSuq2RDlHOXBwlzjJ7dHqlo+mixgJuDjkMDnktDvywr8zp3/mshnI/1SoGlpJNl3htSts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890164; c=relaxed/simple;
	bh=KJ/AbZC/RoBoIkySB9znqMwkF07Xi38lVVIDtP1xqFU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WGpgkkNHKLiFPEIFlrUJ6KRUFPZK6q+XpQ4hmmRuPOd3uBc6iINvnAINVxS938mq+8esIuuggI7cEDlamrpR7uXrS0LjzkXASh8kAswG9i9ISSbNMgLUb+ARXXRHRH1asNJ81jK2IzzyrziU0j7t4LgjI5YGwVzp4SNaJHgdKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPdrq0ts; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPdrq0ts"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b23b6d9f11so11343885a.3
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 11:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890161; x=1763494961; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+WkdGu5Yb/0Zlet1wRvBhExcZoglUuzT3SuX9Lx5Bo=;
        b=mPdrq0tsodiXkTsQS8OzIlxorewcWcznE+kdAq7qsdjkHF0XCZaOj8nqI4uoOeoSU0
         vKSWZzb6PV3A0IQ9vlyK0dTcKgXB4tst6IO+rA5YvIJDXwfYmh0pCA2ZJKHM/HXqkDnC
         HAg0HomQbfG0k/phdBRyCKR/YxTHEE5nijtgrx3UCnHArPInKjc2RIBG2BxvzSJyiGTf
         Ol9o5205LN1cNFbv38N/0Viy10j7GAGgKnxIV8MFp3G3XeUMkOVkhSdmPOkSpJF6iTMa
         Y+W5jM0P2mO2nL26rMmKNfoTEjl9EYGv83juWGyS051y0CwgXqvA3bgvDA9hDv9P0bQw
         L3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890161; x=1763494961;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+WkdGu5Yb/0Zlet1wRvBhExcZoglUuzT3SuX9Lx5Bo=;
        b=FofW+OPi4dSpQfZe4Hj7JIEAta9RVQE9WpPQQAw/HppL+gudL8tUVQf0uG0macM0WW
         Imr8focHelTyaaidIZqGc6u/M5ioSmRItZqg8+/ydb3KSF2n1JblvxcK4E5jvDkyozZA
         5M9y7XTJ7hax7K2fxSHS/6/PmUbvdRXI2Q8GwfoAnq4QcbnwYGSUvgf66j33k3C1Ts9z
         tPAMWJrj4iexEb7dxwhRzXh40X0tSG6/iTdARzzG0xJyKxyV1GImv0qtGZImgipm0Ux6
         H26lfvPJg+AemIueQqJTtyG/3moWaSMjoArF5ao3sTKE1Dh10lB2pkIuerPbfH+cakmX
         z2EQ==
X-Gm-Message-State: AOJu0YwoAGtfen9mquSc5a9gB8T99E2LC32AXa7yErf4G2Ixwmc3nnkS
	GhE/fdFzWPA8yQh2UolagAttsVM4mt9qE2Q61bPwCgT1SAKcRkoeKBhX7mzY7A==
X-Gm-Gg: ASbGnct5DuqN4Ly17cubYNQuU06FvamjsjV3hZwYS7lmwJ1Qj6oEN1JhUTkS6X3SqB5
	dJlwlC0JjG7peGDBn78yzp0WS1yuKYpHsqn8JEIvQ36HRB86zIZ+PlcksY/PHKsJXCL6pq73vz4
	lbsE+RROVqIUfe6f/sdnoOHm+ZOluvzFt6kGFjj2b57IMrQGnGvjl4C68c8vjDmAgiYT2RsvMK0
	IdCDYVEu80isdk3pq/4QQi1P/ljQrZ3viRWJGQD5uBnnBaw9QP/xl/+XRSb4S4IdDpwQZDDmYjH
	BWbUzNxE39Jf07uTPUnNu39lCulSoC0OBsqeUorIiu4Jv372thA8dcq7H68Dk9UARZjwhooT6iq
	GgtGsTLviDlCnKhY4et+/qKMNtKHvjhMMOzI+xqSOPzd0RREinr3at/fQxsYAwTKY01zZumQMjK
	jOt28=
X-Google-Smtp-Source: AGHT+IGHnPx44cYdniSK3cFWqxclDHi2SR7TC9xpikkX/pbgFUrn7tJZ/ah+rTzF/LzgkVvPHihytg==
X-Received: by 2002:a05:620a:710a:b0:8a2:473c:39cf with SMTP id af79cd13be357-8b29b84ff46mr54822385a.54.1762890161346;
        Tue, 11 Nov 2025 11:42:41 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9ff16fsm41116185a.41.2025.11.11.11.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:42:40 -0800 (PST)
Message-Id: <3834ea8f9becc9d6e1b407679e8a95dc6c9d56de.1762890152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 19:42:28 +0000
Subject: [PATCH v3 06/10] xdiff: split xrecord_t.ha into line_hash and
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
    index an array. This also this avoids ` as usize` casts on the Rust
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
index edd05466df..436c34697d 100644
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
index 88b1fe4649..742b81bf3b 100644
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

