Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D640BCB6
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679776; cv=none; b=o/jUkJqhEtBFzoDE/Zo4iS6euAGQlqbMxm9cYMin9FCInWRd3Q5vRaDRzmOcfPffCN95MMKjdpIZLgxsiAywrbBLGJIip0NoWtxIc99PvUxKiCBtm+OOOrA4CYdFdKlause4VZVraJOL/529zxbvK5MqfR2Vv2P8jJDKE7S7V/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679776; c=relaxed/simple;
	bh=QqZqQcN1C2qF4s/ga8ms6mmCYJ15GrpblA4VwBy5vzM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iyE4g3aTYsyaGFq+DznICQekzrqJb6s/0gEf4tKZlceplUl5KEWGnThxTqZy+R+FMAdRqJKY0xkVU5u8n4fgc3cJt9xioFYNyGn6A9HXysIndTWCz/C8V345tRb2XbJ2U/LF0l/S5Xs8a82luPuijj5ZSGzuVbldBrt+othOkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n7f4FiKT; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7f4FiKT"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2c8f43aaso5456131cf.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783679772; x=1784284572; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a2E/zotN3YG5PXpGQF0F9OKROEj4Ni/gXFX5txIa118=;
        b=n7f4FiKTUeimFDOiWUOtYhsR7mrmr1qTGxPGTmOFM90Tl3STci+ZpC1B9eb2DpNacB
         busNAcq4jsrEQmiaCeL0vFF6iTLhga7ksCC0nHyq6rFUHwseywtqXy9Q34ZgJwgKTVxR
         UhlJcqWub9I5usr7DKR4eZceNnh48tF2daZQhy1vwpPQwvg6wM2rWd6E35DDcIkxKm3i
         3nIaqqCrQItAFOCG+A9SUr5oNTbihR3CIUoM0ItGPGZCcs1pqsDSjNdn0L+IXMpW/RLT
         v+8bVtNXKFg5khnw+z00KEYZRCvk0jiSsFz7RGREs+xA1F8gW7oty2ToeHLA5E+sLRn3
         7KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679772; x=1784284572;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a2E/zotN3YG5PXpGQF0F9OKROEj4Ni/gXFX5txIa118=;
        b=L7Aqm/7tyUZEiC11xzEZhueAXV/pdYY1N15CDbRqDrc3Yt5wGgbROm2rlZPFqg0BSB
         EQhfaIBBoLU3MkIslOkNhDmu3rPrtoWS1eu4HOkmKAiARHUo73pojSFot8bRLeUDfyiv
         g5D/6EfotyC908riJtwl6ENYmSSZB+fq6cly1sGg89dRshya7RKKqYr9X1MU/ubXbnGa
         gzYCTlL3jLupUYG8sxJwRWB+DZUKTOdNUj4RChYu7PRUvR8A2MUdh5GGNG8soJf9tdR6
         ywzy4yWWXpAO3jVkaYRSU/W8ttPLCj3IhFfKQ6xCqSyY8dVvfgLQbHHhZzB6Pt0RvRoK
         bhaQ==
X-Gm-Message-State: AOJu0Yz5D5MW64TFo6z1o9PjclrW9GN6xA3F2Zgo4efQt1tPA+QR2LVo
	wQgbMjimb7pAGncWq5c9+G2p1XoC4oycurMwEoZtPB5LmhdN4orUPTravdbO6g==
X-Gm-Gg: AfdE7cnwMl4H7YCtPNbUiJo30hH2v/HdRAQOa2vypbnMKbuQHf30bOT5qnyvsEJTXWv
	KitLC+onzheemxukbDf+q25NAB+j7+Q44bKEBKxxqwCkRse7oUZck58KFANEb2/o9Jx9zBzlgPp
	TOTJfyT9hTFP7qfJdYRhhuCum+/a8T4qxFqDE4Wt+ZepuDkDhdCShXeHAjwL3VNyH3idwv6RJ2+
	Q+DA9/VYq3xVtTUv05Dht5JpnOeBnP/NrSG00kBQzdm6/buz6rRUDYWeh4AUTPSfJTXH1QttGWK
	jYXmbuHOjSKuiIMLY3nMDQBWOleP8xDHsPAKEKYw3TGejodIOLXNchDvxvlvG9/Tu8v4jyL20zT
	BC4qj9L7Wxf3G17xs/IVsXdN2w5Qaf2wUaXWemZKOQnjdz4AyF/uHjyb8ICDu25qPj9xAauHWRH
	VFhG8ajH+XnNYcsPs=
X-Received: by 2002:ac8:7f0f:0:b0:51a:8c97:938e with SMTP id d75a77b69052e-51c8b567866mr117185111cf.69.1783679771973;
        Fri, 10 Jul 2026 03:36:11 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.134.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caa99a194sm13082471cf.0.2026.07.10.03.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:36:11 -0700 (PDT)
Message-Id: <4fdcec84406431d56b7a7e593fd8e843c3b1ad52.1783679767.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2166.v3.git.1783679767.gitgitgadget@gmail.com>
References: <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
	<pull.2166.v3.git.1783679767.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 10:36:07 +0000
Subject: [PATCH v3 2/2] reftable: fix quadratic behavior in the presence of
 tombstones
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

When many tombstones are present in a reftable, operations that need
to look up or iterate over refs exhibit quadratic behavior.  With
8000 refs deleted and re-created, update-ref takes ~15s, quadrupling
for each doubling of input size.

The root cause is the merged iterator's suppress_deletions flag.
When set, merged_iter_next_void() silently consumes tombstone records
in a tight internal loop before returning to the caller.  This
prevents higher-level code from checking iteration bounds (such as
prefix or refname comparisons) until after all tombstones have been
scanned.

This affects any code path that seeks into a range containing
tombstones, including:

 - refs_verify_refnames_available() seeks to "refs/tags/foo-1/" to
   check for D/F conflicts and must scan through all subsequent
   tombstones before the caller can see that they are past the prefix
   of interest.

 - reftable_backend_read_ref() seeks to a specific refname and must
   scan through all subsequent tombstones before returning "not
   found", because the merged iterator skips the matching tombstone
   and searches for the next live record.

Fix this by making suppress_deletions configurable via
reftable_stack_options instead of unconditionally enabling it.  Git
no longer sets the flag, so tombstones are now returned to callers in
the reftable backend, which skip them after their existing bounds
checks.  This allows iteration to terminate as soon as a tombstone
past the relevant bound is encountered.

Downstream users of the reftable library (e.g. libgit2) can still
enable suppress_deletions through the stack options to retain the
previous behavior.

This also requires adding deletion checks to the log iteration paths,
since suppress_deletions applied to both ref and log iterators.

Both tests in p1401 go from ~13s to ~0.2s with this change.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 refs/reftable-backend.c   | 54 +++++++++++++++++++++++++++++++--------
 reftable/reftable-stack.h |  2 ++
 reftable/stack.c          |  2 +-
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 212408c769..028f0211af 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -84,7 +84,8 @@ static int reftable_backend_read_ref(struct reftable_backend *be,
 	if (ret)
 		goto done;
 
-	if (strcmp(ref.refname, refname)) {
+	if (strcmp(ref.refname, refname) ||
+	    reftable_ref_record_is_deletion(&ref)) {
 		ret = 1;
 		goto done;
 	}
@@ -110,7 +111,6 @@ static int reftable_backend_read_ref(struct reftable_backend *be,
 		oidread(oid, reftable_ref_record_val1(&ref),
 			&hash_algos[hash_id]);
 	} else {
-		/* We got a tombstone, which should not happen. */
 		BUG("unhandled reference value type %d", ref.value_type);
 	}
 
@@ -652,6 +652,9 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			break;
 		}
 
+		if (iter->ref.value_type == REFTABLE_REF_DELETION)
+			continue;
+
 		if (iter->exclude_patterns && should_exclude_current_ref(iter))
 			continue;
 
@@ -1532,6 +1535,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 					ret = 0;
 					break;
 				}
+				if (reftable_log_record_is_deletion(&log))
+					continue;
 
 				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 				tombstone = &logs[logs_nr++];
@@ -1929,6 +1934,8 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&old_log))
+			continue;
 
 		free(old_log.refname);
 
@@ -2061,6 +2068,9 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		if (iter->err)
 			break;
 
+		if (reftable_log_record_is_deletion(&iter->log))
+			continue;
+
 		/*
 		 * We want the refnames that we have reflogs for, so we skip if
 		 * we've already produced this name. This could be faster by
@@ -2220,6 +2230,8 @@ static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log))
+			continue;
 
 		ret = yield_log_record(refs, &log, fn, cb_data);
 		if (ret)
@@ -2272,6 +2284,10 @@ static int reftable_be_for_each_reflog_ent(struct ref_store *ref_store,
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log)) {
+			reftable_log_record_release(&log);
+			continue;
+		}
 
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		logs[logs_nr++] = log;
@@ -2318,18 +2334,26 @@ static int reftable_be_reflog_exists(struct ref_store *ref_store,
 		goto done;
 
 	/*
-	 * Check whether we get at least one log record for the given ref name.
-	 * If so, the reflog exists, otherwise it doesn't.
+	 * Check whether we get at least one non-deleted log record for the
+	 * given ref name.  If so, the reflog exists, otherwise it doesn't.
 	 */
-	ret = reftable_iterator_next_log(&it, &log);
-	if (ret < 0)
-		goto done;
-	if (ret > 0) {
-		ret = 0;
-		goto done;
+	while (1) {
+		ret = reftable_iterator_next_log(&it, &log);
+		if (ret < 0)
+			goto done;
+		if (ret > 0) {
+			ret = 0;
+			goto done;
+		}
+		if (strcmp(log.refname, refname)) {
+			ret = 0;
+			goto done;
+		}
+		if (!reftable_log_record_is_deletion(&log))
+			break;
 	}
 
-	ret = strcmp(log.refname, refname) == 0;
+	ret = 1;
 
 done:
 	reftable_iterator_destroy(&it);
@@ -2442,6 +2466,8 @@ static int write_reflog_delete_table(struct reftable_writer *writer, void *cb_da
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log))
+			continue;
 
 		tombstone.refname = (char *)arg->refname;
 		tombstone.value_type = REFTABLE_LOG_DELETION;
@@ -2625,6 +2651,10 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 			reftable_log_record_release(&log);
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log)) {
+			reftable_log_record_release(&log);
+			continue;
+		}
 
 		oidread(&old_oid, log.value.update.old_hash,
 			ref_store->repo->hash_algo);
@@ -2791,6 +2821,8 @@ static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
 		report.path = refname.buf;
 
 		switch (ref.value_type) {
+		case REFTABLE_REF_DELETION:
+			continue;
 		case REFTABLE_REF_VAL1:
 		case REFTABLE_REF_VAL2: {
 			struct object_id oid;
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 11f9963f4f..5d22d84e80 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -42,6 +42,8 @@ struct reftable_stack_options {
 	 */
 	void (*on_reload)(void *payload);
 	void *on_reload_payload;
+
+	int suppress_deletions;
 };
 
 /* open a new reftable stack. The tables along with the table list will be
diff --git a/reftable/stack.c b/reftable/stack.c
index ab12926708..caaedf24d6 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -337,7 +337,7 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	/* Update the stack to point to the new tables. */
 	if (st->merged)
 		reftable_merged_table_free(st->merged);
-	new_merged->suppress_deletions = 1;
+	new_merged->suppress_deletions = st->opts.suppress_deletions;
 	st->merged = new_merged;
 
 	if (st->tables)
-- 
gitgitgadget
