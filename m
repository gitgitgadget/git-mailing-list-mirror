Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0322539F
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471059; cv=none; b=qRYcgbtPiKNbgGpzF7UnCKRJgblsFE6QQpvdmPGO2WHf01bFV0BkCeBV5OmNXMSqz3nizJM6RSgHc1u7/lmKOTSy/hB5xZjaQzrBwkyyaBR38Q/2fJT2yZiJTkDZok/S2bqLlUXuqXw03mIe8MVOTzp5JDOC1E2ugw93ytMWkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471059; c=relaxed/simple;
	bh=bTnrxjZPZ5o3O4xRzTZx9xLENVbARL4KdNnkaI+v3IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbe+30RnxiGWw3ZcqxiWBt+/sEDs7gVW1bJqDjB3Ylf8zyoBXz4Z5eDDkEFzG0yiSizTBm0vwUXsCVfGTpUwEElkByT4EWVFHW4Kt9NfKgob0CQ+bZ9WMTrCKSUzic/tNp1KbXLpp+dtnzk3K9sbkRfMOtpttxt4GtuM7pzbDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5Oo6up5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5Oo6up5"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbb12bea54so151702066b.0
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 04:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742471054; x=1743075854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4L6J8UEtZh6zUMxpPr7DpqpuZAwJLqH4ciiDqsuP7kc=;
        b=X5Oo6up5B9+BoKQ+FAZKkMwh1VoQH1kHd8ldSfKJ9EbA9nkoanmAiPhTBZZqY2Ppf4
         vEhtrA+0RGrmNSYYPPCrgUx3ozLjE+ETX+L9pq2awZgBC2rKeJMjqf2mbiXVfIogjk39
         eGrH3ZWC9rJ+b46jY42lmdPpCZhjjufSfYQA+AGa2DLOXWTgbSMmSWdJp9JUPD2FCm/n
         Z7rINGiBcPrY/kl66oeq3VOq659XKesATH7FEAyOkhVw0z89c7mgzT+WHCpRr8OuZjP7
         3UHNmUraCHGuvYyNni7YUoa48Q/DoEKuoIZR/A1pRmwFAyRXCGMOdg2u+IZFpsQLQttS
         xj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471054; x=1743075854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4L6J8UEtZh6zUMxpPr7DpqpuZAwJLqH4ciiDqsuP7kc=;
        b=A2twaXJrkro07tY4Y1WRAsHnkFkE84KU8QKrwlfDBIWI3hr7NqD7BSnH4TR44mr3pk
         R0mUTv8lqsp3GSCWeXI/MD0/QefmRZeyr8aA80zcuFhqRyOMfkFYOY4Z02KyqDcuUc9q
         GKio7zvoR53roqkOqV+fc/oXSWCy7jGaWh863ghnRAj2tZAcqujumTuCgJJVKJu6r4lw
         O6pk/gm0KuLsmRnJs4xx+NX1gcjBIzTMU/KryWqxRN57DngncY8epvs3D0bVLUwhYJzD
         +f3KhHqdk4W+hikNgtuLqwome3+KMRpu//6/5EtDF6mA0kRPfHglE56+59qCXKH4xgBE
         ByNg==
X-Gm-Message-State: AOJu0YwIIC1WmkUWPfqHGPFXnQxdP29gAUSRAUsIUnHo9msSppotbjfA
	fEKY25y5xlwrlHRRYr4wUoG/kuuT2GGKUB5YVc6DvnIeckdClYiT
X-Gm-Gg: ASbGncvUYn57FOG9iLTc8KgXQQxMW64CG1mFv5ynQptH/POoXAFQBysVEBcIbivM0o7
	ys8migD0FSXX2H00ie15GxuohgKTsA8BNINDLdVvCaWOpahWbFx34ToY8cHB9Yxm8kzzQECLXO3
	uu9yOomSOnbMm+B5UgWRJ85Wt3cqgIygMLb3WH/bt44uLoCBIbUNlPEb5yPF/wAtao/62dhVS4P
	cY3rBgzYd28DZ/YhYic+g7VYnfKHRyooQRdJpZrxz2gTi3ERac54Sa/n1MY8jtiCUOam8t+qZzM
	UHdqOtBME9q/pFtDpZ8ZvwnAo5xkIb1nV6auzQxO9C56jY2bEx4=
X-Google-Smtp-Source: AGHT+IEtHVci0FYdyvSix9o2FBHcMvizu76AnWaFbo0uLwNbxuvgKocJGZC7FKWjnyLVq+RDuCntfg==
X-Received: by 2002:a17:907:7d93:b0:ac2:a473:4186 with SMTP id a640c23a62f3a-ac3b7e80d51mr632580466b.34.1742471054159;
        Thu, 20 Mar 2025 04:44:14 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b4f3:1c64:be3f:2632])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0077sm1167298866b.93.2025.03.20.04.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:44:13 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 20 Mar 2025 12:44:01 +0100
Subject: [PATCH v4 6/8] refs: implement batch reference update support
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-245-partially-atomic-ref-updates-v4-6-3dcc1b311dc9@gmail.com>
References: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
In-Reply-To: <20250320-245-partially-atomic-ref-updates-v4-0-3dcc1b311dc9@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13606;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=bTnrxjZPZ5o3O4xRzTZx9xLENVbARL4KdNnkaI+v3IQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfb/4gzj86HdhBSg7RVOLNVuWQnCG6aHAeLf
 MO3d2AwQdR52YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn2/+IAAoJED7VnySO
 Rox/qRUL/21Ga2USUVmLs63kkrRyVi1Ct3zP9Bb+wRqJGV9jIduoWtI9z4wt8Qw/lN/IKZXxhOp
 2PGYZLvb2Zue/+fzLAmEHJXhdApQq3LC11kGmaYduzvUcSySobc/wq5lPUcvqeG7/bGMmhLvKFx
 snRQ3Q/rC+wvTD5ltuLRoF1wXNuS2iusCDkSTqN/vhNxO5sitHFyEzMkU4vfgW1QN2EWjmn4wXI
 97/FzWvVzL+hc+PuzypKzEsZ5v+pOZ8ChHPATy5XtPSZfWNohveFOChDKoOSNNTvWaKjJrWUkM4
 ISogNiNosf46ubKXW1VFvg6tS+ukUIqvmNkvZXU1C8yElB2/r3SFMTpx+QlhuidqKpXAhzjiPK2
 +dSsRTerlS8jHDGHSoXh+Pbwt+SWmv73wnPJtlRFqRj2gaFzDmAQE5oYUBgh30RLvo7YizWAVmr
 NhyuispqdM9O9JRIbse5dhaRDx8/4b02ipIN5eR7Bt1usLmrfvkH9MWQbRdJOoc9vRC4eIXOfe6
 U8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git supports making reference updates with or without transactions.
Updates with transactions are generally better optimized. But
transactions are all or nothing. This means, if a user wants to batch
updates to take advantage of the optimizations without the hard
requirement that all updates must succeed, there is no way currently to
do so. Particularly with the reftable backend where batching multiple
reference updates is more efficient than performing them sequentially.

Introduce batched update support with a new flag,
'REF_TRANSACTION_ALLOW_FAILURE'. Batched updates while different from
transactions, use the transaction infrastructure under the hood. When
enabled, this flag allows individual reference updates that would
typically cause the entire transaction to fail due to non-system-related
errors to be marked as rejected while permitting other updates to
proceed. System errors referred by 'REF_TRANSACTION_ERROR_GENERIC'
continue to result in the entire transaction failing. This approach
enhances flexibility while preserving transactional integrity where
necessary.

The implementation introduces several key components:

  - Add 'rejection_err' field to struct `ref_update` to track failed
    updates with failure reason.

  - Add a new struct `ref_transaction_rejections` and a field within
    `ref_transaction` to this struct to allow quick iteration over
    rejected updates.

  - Modify reference backends (files, packed, reftable) to handle
    partial transactions by using `ref_transaction_set_rejected()`
    instead of failing the entire transaction when
    `REF_TRANSACTION_ALLOW_FAILURE` is set.

  - Add `ref_transaction_for_each_rejected_update()` to let callers
    examine which updates were rejected and why.

This foundational change enables batched update support throughout the
reference subsystem. A following commit will expose this capability to
users by adding a `--batch-updates` flag to 'git-update-ref(1)',
providing both a user-facing feature and a testable implementation.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h                  | 22 ++++++++++++++++++
 refs/files-backend.c    | 12 +++++++++-
 refs/packed-backend.c   | 27 ++++++++++++++++++++--
 refs/refs-internal.h    | 26 +++++++++++++++++++++
 refs/reftable-backend.c | 12 +++++++++-
 6 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 3d0b53d56e..b34ec198f5 100644
--- a/refs.c
+++ b/refs.c
@@ -1176,6 +1176,10 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 	tr->ref_store = refs;
 	tr->flags = flags;
 	string_list_init_dup(&tr->refnames);
+
+	if (flags & REF_TRANSACTION_ALLOW_FAILURE)
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
+	if (!(transaction->flags & REF_TRANSACTION_ALLOW_FAILURE))
+		return 0;
+
+	if (!transaction->rejections)
+		BUG("transaction not inititalized with failure support");
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
@@ -2728,6 +2767,28 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
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
index dcd83e81e2..591b703d59 100644
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
+	REF_TRANSACTION_ALLOW_FAILURE = (1 << 1),
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
index 4f27f7652c..be758ffff5 100644
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
index d90bd815a3..7bf57ca948 100644
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
 				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
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
index 3f1d19abd9..73a5379b73 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -123,6 +123,12 @@ struct ref_update {
 	 */
 	uint64_t index;
 
+	/*
+	 * Used in batched reference updates to mark if a given update
+	 * was rejected.
+	 */
+	enum ref_transaction_error rejection_err;
+
 	/*
 	 * If this ref_update was split off of a symref update via
 	 * split_symref_update(), then this member points at that
@@ -142,6 +148,13 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
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
@@ -183,6 +196,18 @@ enum ref_transaction_state {
 	REF_TRANSACTION_CLOSED   = 2
 };
 
+/*
+ * Data structure to hold indices of updates which were rejected, for batched
+ * reference updates. While the updates themselves hold the rejection error,
+ * this structure allows a transaction to iterate only over the rejected
+ * updates.
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
@@ -195,6 +220,7 @@ struct ref_transaction {
 	size_t alloc;
 	size_t nr;
 	enum ref_transaction_state state;
+	struct ref_transaction_rejections *rejections;
 	void *backend_data;
 	unsigned int flags;
 	uint64_t max_index;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index bd6b042103..ed65225763 100644
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
 
 	ret = refs_verify_refnames_available(ref_store, &refnames_to_check,
@@ -1454,6 +1461,9 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
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

