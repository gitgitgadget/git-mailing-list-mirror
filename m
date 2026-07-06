Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F2376467
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344965; cv=none; b=WC0KVhgijvCFzA7kU/z5kCQVz/kepwDu3VfF/FLrGeZlGq3KcuY1wYGPcPDt9dX+6cCO2aVlJY337qdkcsHobftulPFDx56xMlg67SaQX0oj+qr1gYKMVJeHIh+g3HSinXzU8Dyou86HEug91kn6AIry01yz7OMk7Jm9J665jqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344965; c=relaxed/simple;
	bh=a60T8i6f1m34kWixuj/uyLm2hPbx3MW5vNJQHkkWgpg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LcByfXITHbBbDN6NxYo6DGDJ7iGIEyXouMdozrqDKSWrxEx5s1F9R/tYSMlhkqKu17W21Oc761fOkJ+mvS9eZl/6N0rFwvI/3nbMvy+MJxKjHOhOKcMqPU/NwatVjC4IYj9bYiJsKy3ihmZDK1K/zsXCcBaKwhj9i/TK4z8uqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqKt2Gbh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqKt2Gbh"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc97653887so12780915ad.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344963; x=1783949763; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Clrir/QyEPMvsgYcJA1+iEYYBGOHo5nqzVjNWyzaWaM=;
        b=dqKt2Gbh5KbuNSMTI+L5fPWLhf9fR0dEavuSuIvGv/j/424LH8ARC7WYZ+5J8yARqs
         QlNtOHPPC4OCFB1mR5mIjEDXWAsv4D4CFxwqJmpEDx/wtb7Tn23LD9s592nkAMTiqMZV
         ZKWOC+CyJTMjEkwfun4DprBaWdvJKHv4QSw/26k1AG2hlWYLW8McK21E0EnlSMFGIjve
         eMnbhJHmGgQpcZJNqIoL14B+W1L8nvqva13U13M4xyuUQPjtk1+Ds8ILp6RkuiEfggSH
         sE55UB2HlufnaW6B2jm0ou5LmoMY4RTxgR7wivcjJImsYT/pcg9cA1N67+h/tyk1KsZj
         yCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344963; x=1783949763;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Clrir/QyEPMvsgYcJA1+iEYYBGOHo5nqzVjNWyzaWaM=;
        b=g2rf4mjrzB/dyW4mM77U2FUwZK3eiFw05k6xd6JviadVDtJHwoWHtimLi7ZaxhCE6D
         Xrw3kfkwH5cgAGxd4cjaUqizc0KrZhckD5hp9lNnskT6zRTDXysXgxfnc8wTgbc/VIyD
         fC2qEg1hlqazLKbkx1ph7sQ2yP6fgkZ3QtNo910U32A6EgqO8g24EsDRoB6QM3l4bwwj
         0KSQzqSK3ZC4ywHbpOMYm2BEYu/h6tMRgaIxvhwPoZwMBtlygcE7E8jGl3BcUrN420Z4
         Y87V8lI993vSFB/WPHQGs7oG8KxmAhNC6pJikTiRByFHCOHPMUkyY6VqL9azl3RjU0q/
         cXOg==
X-Gm-Message-State: AOJu0Yx7wIMPgQZS1OCuseA++d3x9cGBQwgEOkrhIPNcuZ7vWUONg5YK
	TOtcLGRXGJE/fofYmg/MRPJe+tv2j6Bg4nGTPuRAdCCUd1UKL4F2W+5LcpNgcA==
X-Gm-Gg: AfdE7ckA+vZsG40cl7BjTwne+91Ief0te7/4jhKmln8ORcIJIvW1/ufk8YuFU6MIKVq
	WEFBFxAcHRsWH96RYbFqZsGAzy3WIUXhUVqmHF/F4yDO2tkgE7oGEXqVb3JYCZfDqCOl5klIPpG
	oxxTlNgNJhpNrc/ac3kHmetbwG5YzLXqcSwbFs16swjLWnHtaNKOL2R9qr+VyEhOorRdLb3kCrz
	0CRCC0aJHnStmRK8vlsRq18aG3USZrO12pseLTeFkGtF3Iy4DxCT1wrWJQwb7Lv/CTmtb97dfBu
	YDyaZ0jBvEwV/vOWJKeRwL1K31Ao3EXCmhkVv/yRvMuPIfgDvSTHxVq0GqSWYvMW9P1sLGwFX4e
	Lht8Ctv+4fpzi8kRj5LQJOmVzN1XSZWzU05V6jAWU5SE6XU2ZgWGzeed6EMxGyR/L9LieeWkhS0
	JaIS/d6e7vFiNY
X-Received: by 2002:a17:903:32d1:b0:2c9:b01a:fbd4 with SMTP id d9443c01a7336-2ccbe6266fcmr5618985ad.16.1783344963260;
        Mon, 06 Jul 2026 06:36:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.42.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad789424esm50517295ad.76.2026.07.06.06.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:36:01 -0700 (PDT)
Message-Id: <1459371d3ab2f237152e20040987b4cb6a5eca77.1783344957.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 13:35:56 +0000
Subject: [PATCH 2/2] reftable: fix quadratic behavior when re-creating deleted
 refs
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

When many refs are deleted and then re-created, update-ref exhibits
quadratic behavior.  With 8000 refs deleted and re-created, the
runtime is ~15s, quadrupling for each doubling of input size.

The root cause is the merged iterator's suppress_deletions flag.
When set, merged_iter_next_void() silently consumes tombstone records
in a tight internal loop before returning to the caller.  This
prevents higher-level code from checking iteration bounds (such as
prefix or refname comparisons) until after all tombstones have been
scanned.

This affects two code paths during ref creation:

 - refs_verify_refnames_available() seeks to "refs/tags/foo-1/" to
   check for D/F conflicts and must scan through all subsequent
   tombstones before the caller can see that they are past the prefix
   of interest.

 - reftable_backend_read_ref() seeks to a specific refname and must
   scan through all subsequent tombstones before returning "not
   found", because the merged iterator skips the matching tombstone
   and searches for the next live record.

Fix this by removing suppress_deletions from the merged iterator and
instead handling deletion records at each call site in the reftable
backend, where prefix and refname bounds are available.  Tombstones
are now returned to callers, which skip them after their existing
bounds checks.  This allows iteration to terminate as soon as a
tombstone past the relevant bound is encountered.

This also requires adding deletion checks to the log iteration paths,
since suppress_deletions applied to both ref and log iterators.

Both tests in p1401 go from ~14s to ~0.2s with this change.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 refs/reftable-backend.c | 54 ++++++++++++++++++++++++++++++++---------
 reftable/merged.c       | 12 +--------
 reftable/merged.h       |  4 ---
 reftable/stack.c        |  1 -
 4 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4ae22922de..8c4f119ff1 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -86,7 +86,8 @@ static int reftable_backend_read_ref(struct reftable_backend *be,
 	if (ret)
 		goto done;
 
-	if (strcmp(ref.refname, refname)) {
+	if (strcmp(ref.refname, refname) ||
+	    reftable_ref_record_is_deletion(&ref)) {
 		ret = 1;
 		goto done;
 	}
@@ -112,7 +113,6 @@ static int reftable_backend_read_ref(struct reftable_backend *be,
 		oidread(oid, reftable_ref_record_val1(&ref),
 			&hash_algos[hash_id]);
 	} else {
-		/* We got a tombstone, which should not happen. */
 		BUG("unhandled reference value type %d", ref.value_type);
 	}
 
@@ -633,6 +633,9 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			break;
 		}
 
+		if (iter->ref.value_type == REFTABLE_REF_DELETION)
+			continue;
+
 		if (iter->exclude_patterns && should_exclude_current_ref(iter))
 			continue;
 
@@ -1492,6 +1495,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 					ret = 0;
 					break;
 				}
+				if (reftable_log_record_is_deletion(&log))
+					continue;
 
 				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 				tombstone = &logs[logs_nr++];
@@ -1889,6 +1894,8 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&old_log))
+			continue;
 
 		free(old_log.refname);
 
@@ -2019,6 +2026,9 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		if (iter->err)
 			break;
 
+		if (reftable_log_record_is_deletion(&iter->log))
+			continue;
+
 		/*
 		 * We want the refnames that we have reflogs for, so we skip if
 		 * we've already produced this name. This could be faster by
@@ -2178,6 +2188,8 @@ static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log))
+			continue;
 
 		ret = yield_log_record(refs, &log, fn, cb_data);
 		if (ret)
@@ -2230,6 +2242,10 @@ static int reftable_be_for_each_reflog_ent(struct ref_store *ref_store,
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log)) {
+			reftable_log_record_release(&log);
+			continue;
+		}
 
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		logs[logs_nr++] = log;
@@ -2276,18 +2292,26 @@ static int reftable_be_reflog_exists(struct ref_store *ref_store,
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
@@ -2399,6 +2423,8 @@ static int write_reflog_delete_table(struct reftable_writer *writer, void *cb_da
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log))
+			continue;
 
 		tombstone.refname = (char *)arg->refname;
 		tombstone.value_type = REFTABLE_LOG_DELETION;
@@ -2580,6 +2606,10 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 			reftable_log_record_release(&log);
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log)) {
+			reftable_log_record_release(&log);
+			continue;
+		}
 
 		oidread(&old_oid, log.value.update.old_hash,
 			ref_store->repo->hash_algo);
@@ -2746,6 +2776,8 @@ static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
 		report.path = refname.buf;
 
 		switch (ref.value_type) {
+		case REFTABLE_REF_DELETION:
+			continue;
 		case REFTABLE_REF_VAL1:
 		case REFTABLE_REF_VAL2: {
 			struct object_id oid;
diff --git a/reftable/merged.c b/reftable/merged.c
index 733de07454..2f9a361234 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -26,7 +26,6 @@ struct merged_iter {
 	struct merged_subiter *subiters;
 	struct merged_iter_pqueue pq;
 	size_t subiters_len;
-	int suppress_deletions;
 	ssize_t advance_index;
 };
 
@@ -166,15 +165,7 @@ static int merged_iter_seek_void(void *it, struct reftable_record *want)
 
 static int merged_iter_next_void(void *p, struct reftable_record *rec)
 {
-	struct merged_iter *mi = p;
-	while (1) {
-		int err = merged_iter_next_entry(mi, rec);
-		if (err)
-			return err;
-		if (mi->suppress_deletions && reftable_record_is_deletion(rec))
-			continue;
-		return 0;
-	}
+	return merged_iter_next_entry(p, rec);
 }
 
 static struct reftable_iterator_vtable merged_iter_vtable = {
@@ -278,7 +269,6 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 		goto out;
 	}
 	mi->advance_index = -1;
-	mi->suppress_deletions = mt->suppress_deletions;
 	mi->subiters = subiters;
 	mi->subiters_len = mt->tables_len;
 
diff --git a/reftable/merged.h b/reftable/merged.h
index 4317e5f5f6..6fafd1d080 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -17,10 +17,6 @@ struct reftable_merged_table {
 	size_t tables_len;
 	enum reftable_hash hash_id;
 
-	/* If unset, produce deletions. This is useful for compaction. For the
-	 * full stack, deletions should be produced. */
-	int suppress_deletions;
-
 	uint64_t min;
 	uint64_t max;
 };
diff --git a/reftable/stack.c b/reftable/stack.c
index 1fba96ddb3..77aeac4715 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -337,7 +337,6 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	/* Update the stack to point to the new tables. */
 	if (st->merged)
 		reftable_merged_table_free(st->merged);
-	new_merged->suppress_deletions = 1;
 	st->merged = new_merged;
 
 	if (st->tables)
-- 
gitgitgadget
