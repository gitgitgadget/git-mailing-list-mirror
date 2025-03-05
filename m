Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34C251786
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196363; cv=none; b=nc0AnFoXz7UjG0Q/8qs+IoN++yOVG6gHGryWX+RlwycbfQTg3QI9NPvzgEyd2YoeclJnLcXOq9INIIChTjTSaVazgT68SJqh4CfACQ2wZj1Umskigozp5aZdoz4h3ps9IkWq7sqt14b4cmlUe+YcQA5cSa2myzI+7pHDs7+EMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196363; c=relaxed/simple;
	bh=xEMGtcZCkzsiOVL2YQegKM1zvYjh6+zLbvI7pT6WNH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tSVhYAVji03t3lyVI+ps/X8jlecvDn/Irce40rIaZEO2dCVqWZArsFRcDisVRtRtLDfs1hGHjkpukqmWmgtKFrrSIqgaExvdc7OdcEyHGMpOdrAtkMMgKFdplWNEvwLupPdBZ7AY6r9bAZF64CXo31nfYmDm5ReArL08iQtYJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caoP+sfE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caoP+sfE"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e52c1c3599so6310402a12.2
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 09:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196359; x=1741801159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RWgYJRmtIDJ3s5njXrfG/f68DzSe9+cEYdzPpp5ITs=;
        b=caoP+sfEOGiiX+LP7NvogNUhaAgw9DsWKn/ni0Iz7rRK81XeXx0ceHBc3Ytii7w/TD
         667pRMsLSLmZxXEN6QcVO8QAykco4BYsiHUmTFKdscCOVJy77xGMqWbkOY94Xl9gQ9zW
         6LHWHvetidG2sVSkEyqSfjP07qos4qZ5yXTdaTQILhX1PyI4jJ/etK26z04aa/RGS1Il
         V8MkaZdYZT0+yORiBCFLniZGi5SxFDIuY7/dbpTRhV5fVAtTCoxWCU91RtpBkSwgBcZK
         W2qW8HUZXfBeR1jCKUcUaOYcP45ja09xNnxtKrug/j3q1wkBUyMo3ZT4L2T/Z2ngr/FG
         sF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196359; x=1741801159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RWgYJRmtIDJ3s5njXrfG/f68DzSe9+cEYdzPpp5ITs=;
        b=YvON26CLLgA1fdeTn0SSLUrywpmte1iZE0crvRqQ2qm10+2dJWc6AZ0WlUu/Biw/DG
         2blKGZpx4RoQJhD4iNtkhsrVIT18IT1K/pyGMK31ABiCMnSmHKP2/zCkubcr9n41BPnd
         SQOSz3pFP/Ba/tQr0uBLDWFpN5Hm18OV5+ju6q9g2qWiW2xZOYU11Nj43DTz/mtFaJn2
         FO4fxHTe1rAlWFc/ZArVwbQ0zyrogrwCIoMZWlkQ87EWz5sWIfitO4GyJAhdokETKSGg
         KUlYCsMxtuJH7VFFVr4YjghDib/RWlG3/0QEb25WldjWjdwrxyMYHkZV+lu+GwIEtrEW
         mWyg==
X-Gm-Message-State: AOJu0YwWet+N9NkPqWUpZ0hRVZ+eBc/27Xeb1uDIke4ab88IdrLVp7eL
	AVConLHwOJRrXUKmJb/zAw1reM6VhFpCGSj+/B+iQp0zctSmFfJXv9lSQ3LL
X-Gm-Gg: ASbGncvpA2adorV0WBya2/egP6/qEr8bcFO3mLbvhOpjJKoueHceGJcO4BM05sV9pkr
	BF04uO2EbWnU/D87YrApgZ2W4bQDT6eS+SNWzSmXz/ToQEhaqxkNpF+e2zaEN2fja9QDgy5wKUP
	S8/mVed3Q10weJiPnZrcDhAIn52DHo3TYBg5ytrfbPSs9LNR+Sdcx6sQXavOMrPnefeRWFLW+cq
	ZjAJ0EWHDEDr+O1l4OtWmcWuVvCfekJuStHUFZiijmhAuUwjIJDLgzqZzoeHyNk1BqFPq1nU5an
	5ylxUnvYTet9R+g0Rpzp1TrvZLjRauteeH5+/MCkhcTKuCx18A==
X-Google-Smtp-Source: AGHT+IEYO0wT2l85XOfHK56ehHdNsS9+gBxwV3YL72wRfWpSY4K2qd2u+hcGbebXDPntXngVwthK/A==
X-Received: by 2002:a17:907:868b:b0:abe:fffb:f1ef with SMTP id a640c23a62f3a-ac20d9e816amr393023266b.20.1741196359031;
        Wed, 05 Mar 2025 09:39:19 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:8a90:b290:3a5b:4dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf3a8e2f53sm946851866b.115.2025.03.05.09.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:39:18 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 05 Mar 2025 18:39:01 +0100
Subject: [PATCH v3 6/8] refs: implement partial reference transaction
 support
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13328;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=xEMGtcZCkzsiOVL2YQegKM1zvYjh6+zLbvI7pT6WNH8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfIjEDbPGtxAz+Y3COAIPKqupFr3s1ECwROM
 Sk8lp0K/jrGyIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnyIxAAAoJED7VnySO
 Rox/iRIMAIWoMU0Yn4lJoyrsjkNULxJrCQ5xJpFS2rTStOoqiVK6sI9nLZmGzxgIVb+S+8soHbG
 gryHAU9EC9TCZiaM6AkXNzNKfkZwrH73o0cYgzOu7rsyGahvluDw37IcgFmXpLECoSb83zeGKpb
 REr6REpW7Cpl6ChBMRrPNuO+xfHl+d41GmEMZhb2Ft302zlGBrdB/odjzUMdtfVs4CxLw2xzMlL
 7tyuxAAk5VUqp5noYjFbAn0pA2jCuj4yoQAWW0srHAqF5XeiuRlivfulGp6hEg+im6wvTzdZ3je
 lPEbPq3AOa6ulor3pSCWWVkD6DumOuEbmTB7wNqnZyBxBbKZWXxkvr2zGJMaPlzu/N+k4oUBhh/
 4bxcQxgjyiUtkBc6RnNLh1bmy/BWh2lTCCmjTtEpnITCkuNGhqFjOlbrSe+OjdYH4K5s6Lh9eBa
 mQa8TWRueDSoRRKfezPcbwwmj7NoTjp3q8Io8Eh4PVlxlVfEJgZKu56He9TxgO1xPCjbAs5ZbV6
 bU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git's reference transactions are all-or-nothing: either all updates
succeed, or none do. While this atomic behavior is generally desirable,
it can be suboptimal especially when using the reftable backend, where
batching multiple reference updates into a single transaction is more
efficient than performing them sequentially.

Introduce partial transaction support with a new flag,
'REF_TRANSACTION_ALLOW_PARTIAL'. When enabled, this flag allows
individual reference updates that would typically cause the entire
transaction to fail due to non-system-related errors to be marked as
rejected while permitting other updates to proceed. System errors
referred by 'REF_TRANSACTION_ERROR_GENERIC' continue to result in the
entire transaction failing. This approach enhances flexibility while
preserving transactional integrity where necessary.

The implementation introduces several key components:

  - Add 'rejection_err' field to struct `ref_update` to track failed
    updates with failure reason.

  - Add a new struct `ref_transaction_rejections` and a field within
    `ref_transaction` to this struct to allow quick iteration over
    rejected updates.

  - Modify reference backends (files, packed, reftable) to handle
    partial transactions by using `ref_transaction_set_rejected()`
    instead of failing the entire transaction when
    `REF_TRANSACTION_ALLOW_PARTIAL` is set.

  - Add `ref_transaction_for_each_rejected_update()` to let callers
    examine which updates were rejected and why.

This foundational change enables partial transaction support throughout
the reference subsystem. A following commit will expose this capability
to users by adding a `--allow-partial` flag to 'git-update-ref(1)',
providing both a user-facing feature and a testable implementation.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h                  | 22 ++++++++++++++++++
 refs/files-backend.c    | 12 +++++++++-
 refs/packed-backend.c   | 27 ++++++++++++++++++++--
 refs/refs-internal.h    | 25 ++++++++++++++++++++
 refs/reftable-backend.c | 12 +++++++++-
 6 files changed, 155 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 63b8050ce2..b735510c3b 100644
--- a/refs.c
+++ b/refs.c
@@ -1176,6 +1176,10 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 	tr->ref_store = refs;
 	tr->flags = flags;
 	string_list_init_dup(&tr->refnames);
+
+	if (flags & REF_TRANSACTION_ALLOW_PARTIAL)
+		CALLOC_ARRAY(tr->rejections, 1);
+
 	return tr;
 }
 
@@ -1206,11 +1210,45 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		free((char *)transaction->updates[i]->old_target);
 		free(transaction->updates[i]);
 	}
+
+	if (transaction->rejections)
+		free(transaction->rejections->update_indices);
+	free(transaction->rejections);
+
 	string_list_clear(&transaction->refnames, 0);
 	free(transaction->updates);
 	free(transaction);
 }
 
+int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
+				       size_t update_idx,
+				       enum ref_transaction_error err)
+{
+	if (update_idx >= transaction->nr)
+		BUG("trying to set rejection on invalid update index");
+
+	if (!(transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL))
+		return 0;
+
+	if (!transaction->rejections)
+		BUG("transaction not inititalized with partial support");
+
+	/*
+	 * Don't accept generic errors, since these errors are not user
+	 * input related.
+	 */
+	if (err == REF_TRANSACTION_ERROR_GENERIC)
+		return 0;
+
+	transaction->updates[update_idx]->rejection_err = err;
+	ALLOC_GROW(transaction->rejections->update_indices,
+		   transaction->rejections->nr + 1,
+		   transaction->rejections->alloc);
+	transaction->rejections->update_indices[transaction->rejections->nr++] = update_idx;
+
+	return 1;
+}
+
 struct ref_update *ref_transaction_add_update(
 		struct ref_transaction *transaction,
 		const char *refname, unsigned int flags,
@@ -1236,6 +1274,7 @@ struct ref_update *ref_transaction_add_update(
 	transaction->updates[transaction->nr++] = update;
 
 	update->flags = flags;
+	update->rejection_err = 0;
 
 	update->new_target = xstrdup_or_null(new_target);
 	update->old_target = xstrdup_or_null(old_target);
@@ -2727,6 +2766,28 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
 	}
 }
 
+void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
+					      ref_transaction_for_each_rejected_update_fn cb,
+					      void *cb_data)
+{
+	if (!transaction->rejections)
+		return;
+
+	for (size_t i = 0; i < transaction->rejections->nr; i++) {
+		size_t update_index = transaction->rejections->update_indices[i];
+		struct ref_update *update = transaction->updates[update_index];
+
+		if (!update->rejection_err)
+			continue;
+
+		cb(update->refname,
+		   (update->flags & REF_HAVE_OLD) ? &update->old_oid : NULL,
+		   (update->flags & REF_HAVE_NEW) ? &update->new_oid : NULL,
+		   update->old_target, update->new_target,
+		   update->rejection_err, cb_data);
+	}
+}
+
 int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 		     struct string_list *refnames, unsigned int flags)
 {
diff --git a/refs.h b/refs.h
index 1b9213f9ce..5e5ff9e57d 100644
--- a/refs.h
+++ b/refs.h
@@ -673,6 +673,13 @@ enum ref_transaction_flag {
 	 * either be absent or null_oid.
 	 */
 	REF_TRANSACTION_FLAG_INITIAL = (1 << 0),
+
+	/*
+	 * The transaction mechanism by default fails all updates if any conflict
+	 * is detected. This flag allows transactions to partially apply updates
+	 * while rejecting updates which do not match the expected state.
+	 */
+	REF_TRANSACTION_ALLOW_PARTIAL = (1 << 1),
 };
 
 /*
@@ -903,6 +910,21 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
 					    ref_transaction_for_each_queued_update_fn cb,
 					    void *cb_data);
 
+/*
+ * Execute the given callback function for each of the reference updates which
+ * have been rejected in the given transaction.
+ */
+typedef void ref_transaction_for_each_rejected_update_fn(const char *refname,
+							 const struct object_id *old_oid,
+							 const struct object_id *new_oid,
+							 const char *old_target,
+							 const char *new_target,
+							 enum ref_transaction_error err,
+							 void *cb_data);
+void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
+					      ref_transaction_for_each_rejected_update_fn cb,
+					      void *cb_data);
+
 /*
  * Free `*transaction` and all associated data.
  */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1e1663f44b..c2fdee6013 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2852,8 +2852,15 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		ret = lock_ref_for_update(refs, update, transaction,
 					  head_ref, &refnames_to_check,
 					  err);
-		if (ret)
+		if (ret) {
+			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+				strbuf_setlen(err, 0);
+				ret = 0;
+
+				continue;
+			}
 			goto cleanup;
+		}
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
@@ -3151,6 +3158,9 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 		struct ref_lock *lock = update->backend_data;
 
+		if (update->rejection_err)
+			continue;
+
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
 			if (parse_and_write_reflog(refs, update, lock, err)) {
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 5458952624..bfc6135743 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1327,10 +1327,11 @@ static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
  * remain locked when it is done.
  */
 static enum ref_transaction_error write_with_updates(struct packed_ref_store *refs,
-						     struct string_list *updates,
+						     struct ref_transaction *transaction,
 						     struct strbuf *err)
 {
 	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
+	struct string_list *updates = &transaction->refnames;
 	struct ref_iterator *iter = NULL;
 	size_t i;
 	int ok;
@@ -1411,6 +1412,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 						    "reference already exists",
 						    update->refname);
 					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
+
+					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+						strbuf_setlen(err, 0);
+						ret = 0;
+						continue;
+					}
+
 					goto error;
 				} else if (!oideq(&update->old_oid, iter->oid)) {
 					strbuf_addf(err, "cannot update ref '%s': "
@@ -1419,6 +1427,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 						    oid_to_hex(iter->oid),
 						    oid_to_hex(&update->old_oid));
 					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
+
+					if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+						strbuf_setlen(err, 0);
+						ret = 0;
+						continue;
+					}
+
 					goto error;
 				}
 			}
@@ -1456,6 +1471,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 					    update->refname,
 					    oid_to_hex(&update->old_oid));
 				return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
+
+				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+					strbuf_setlen(err, 0);
+					ret = 0;
+					continue;
+				}
+
 				goto error;
 			}
 		}
@@ -1521,6 +1543,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 write_error:
 	strbuf_addf(err, "error writing to %s: %s",
 		    get_tempfile_path(refs->tempfile), strerror(errno));
+	ret = REF_TRANSACTION_ERROR_GENERIC;
 
 error:
 	ref_iterator_free(iter);
@@ -1679,7 +1702,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 		data->own_lock = 1;
 	}
 
-	ret = write_with_updates(refs, &transaction->refnames, err);
+	ret = write_with_updates(refs, transaction, err);
 	if (ret)
 		goto failure;
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3f1d19abd9..c417aec217 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -123,6 +123,11 @@ struct ref_update {
 	 */
 	uint64_t index;
 
+	/*
+	 * Used in partial transactions to mark if a given update was rejected.
+	 */
+	enum ref_transaction_error rejection_err;
+
 	/*
 	 * If this ref_update was split off of a symref update via
 	 * split_symref_update(), then this member points at that
@@ -142,6 +147,13 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
 
+/*
+ * Mark a given update as rejected with a given reason.
+ */
+int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
+				       size_t update_idx,
+				       enum ref_transaction_error err);
+
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
@@ -183,6 +195,18 @@ enum ref_transaction_state {
 	REF_TRANSACTION_CLOSED   = 2
 };
 
+/*
+ * Data structure to hold indices of updates which were rejected, when
+ * partial transactions where enabled. While the updates themselves hold
+ * the rejection error, this structure allows a transaction to iterate
+ * only over the rejected updates.
+ */
+struct ref_transaction_rejections {
+	size_t *update_indices;
+	size_t alloc;
+	size_t nr;
+};
+
 /*
  * Data structure for holding a reference transaction, which can
  * consist of checks and updates to multiple references, carried out
@@ -195,6 +219,7 @@ struct ref_transaction {
 	size_t alloc;
 	size_t nr;
 	enum ref_transaction_state state;
+	struct ref_transaction_rejections *rejections;
 	void *backend_data;
 	unsigned int flags;
 	uint64_t max_index;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 0132b8b06a..dd9912d637 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1371,8 +1371,15 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					    transaction->updates[i],
 					    &refnames_to_check, head_type,
 					    &head_referent, &referent, err);
-		if (ret)
+		if (ret) {
+			if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
+				strbuf_setlen(err, 0);
+				ret = 0;
+
+				continue;
+			}
 			goto done;
+		}
 	}
 
 	string_list_sort(&refnames_to_check);
@@ -1455,6 +1462,9 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		struct reftable_transaction_update *tx_update = &arg->updates[i];
 		struct ref_update *u = tx_update->update;
 
+		if (u->rejection_err)
+			continue;
+
 		/*
 		 * Write a reflog entry when updating a ref to point to
 		 * something new in either of the following cases:

-- 
2.48.1

