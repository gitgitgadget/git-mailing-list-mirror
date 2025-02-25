Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5B25A326
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475777; cv=none; b=EuWUPrZOyivwrnkCkHgVuTtVpXOdThacMqfJ6o0BwP7eD9gjYioF0iO35exzsKXBVLwNGtWPBg79B/tyWW3IxCJfYF7bq3lX7B4nqmsugj2Bg2FQRIB5+fpgOjkXaIEeEYg/i9zM/lrviBZo9PW44HcmDmvn4KWkcqYLcSZqDOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475777; c=relaxed/simple;
	bh=TGp0iyGaH+OzmddfN5/WALZN5SsP93fAXBRDNfVO+Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dw8hLe78KSt9JLPeVGojJa8v2MGQrGrqKaecJwDS61OHhcIbR8TnOrIK+uKuVtQo/jGyqB29LtVcz9m4EgnMWGLCBxMSqcjf5b6ILhcFry2nd8Zw5f26r4NL5ga2HWCwE+QZmVZDM6BbIXgiDtpkMhfWVh8+7+cncxDYTYVvOgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMA8A/2O; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMA8A/2O"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso826627266b.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 01:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740475773; x=1741080573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbXt8tJashaNsUx9xxu2Pbh+eLfB21GqvkRR99DUOrA=;
        b=LMA8A/2Oro+tA6xqiwp2ibsa2qqq1nKCiIHtiFgKl342fsAgKY23ue0TpB+eiWZKjv
         kshK6B//a8oTIPrqZ6lvDgP6DxBPGr9hTD7n6n7qIYZnUmRNNfCFzWMD244AUH4QFw+g
         H927+xZmZ8tNaB4K3pndejxMFNBHJb9PUIxWVle3xrlFpOV5lbHP4ukYtJnAVV/qyGUU
         Hsgnq4CtGLDciH8K0IN1TLjRvDEWtvmifrZ+gXjywPlY+ACZBw8RNf26ixlicIKAhV8d
         olXqKbaE8ImCOnCPZzJJcS02wQw4kIAu7rt+wVYAxNrUzNO5LA5+Mch+6qxnfyhlYmJz
         NFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475773; x=1741080573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbXt8tJashaNsUx9xxu2Pbh+eLfB21GqvkRR99DUOrA=;
        b=BIkg98FLq/U7Lbjl8uMiqGPMDaWL0l/9/+e0noV1PUC33x+N4OgZeRb+FxNCxdZ7HF
         t1UNWs2++mjFYol8VTI/nsmjgannUKt+ORXenfOb29rzdCyRgwy05MKyxakMALV84LvL
         M164zX+LiBTWuDEoLAi6B6FJd1yWRLsS0xbtjn3QasC3opvMzEuMkd8TxwQgSk083TEY
         P6KXweVh0NHcizqx1v432PnPmDKBFQpiymJvj9oV1qo6xVwGMcbyScpZEdgM3FdrIOf1
         3eTttOBlJDjO1psc0EImkMbF3nFB37WPL+5pa5DzbLEFtA4SHLjj6qPFKsJV0PNX/KVK
         FoyQ==
X-Gm-Message-State: AOJu0YxOQYKetvEVZKEOyVHt+h1pd75lObsxIJP9BcJXPeWV1e582w4w
	POp656BjW/pIuCE7JNdEIZ/bO6NWO3Ce2f0yBAzpQjHp4ijpkHD3
X-Gm-Gg: ASbGncsXUk/hSVVyvm1Zz16tWCh3/tIp6LucDXlEV3YPg3CdlQV1bPxP1cWC9w3771m
	6CLRM9M3gsuWGuJZbPUSbp1m/UjZl/gpeuw/R3MQkFhviAMfltZXfqzsOV5r3x6LaJU0PousCB+
	AQlB518H8PdWHSwFWrNVIC/lvlb6cieFZMNC3gXZ9AD52wB9CRF4Bvay+9MnRCsICe+beNE0hr6
	BLzf6veRDap45IINfJBA2K+TD9GyFJkJqo3S3Dh3yfdz7BYr8uAcNtSpx0RtjWPTO6Hchmk7iby
	hS40SBcEduFokdMfrVKpXbLn6lTYE6mE
X-Google-Smtp-Source: AGHT+IGY1PUMYDCw8JFKK1pNsXhQzmn/R9fDbqwZC1YyRqbqfbexblDfFFgHisPUPFAZhfklfdEzgA==
X-Received: by 2002:a17:907:c22:b0:ab7:b6cb:b633 with SMTP id a640c23a62f3a-abc09b2b7e2mr1682330266b.34.1740475773037;
        Tue, 25 Feb 2025 01:29:33 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:20c2:4ab6:a193:5b8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd561esm111944466b.19.2025.02.25.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:29:32 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 25 Feb 2025 10:29:09 +0100
Subject: [PATCH v2 6/7] refs: implement partial reference transaction
 support
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-245-partially-atomic-ref-updates-v2-6-cfa3236895d7@gmail.com>
References: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
In-Reply-To: <20250225-245-partially-atomic-ref-updates-v2-0-cfa3236895d7@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10778;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=TGp0iyGaH+OzmddfN5/WALZN5SsP93fAXBRDNfVO+Yk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGe9jXZncw9Srn91aYGKiIDlwBZDv64xvVgS6
 8/mt7oFqbfxJYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnvY12AAoJED7VnySO
 Rox/TMQL/3VrN5pk51Crah9JkbfdAvy9GX/pJjU/f+hp5U5Ft/N6c7TUS7oZejovS5raoq5q2du
 o32W1dkRNN/w3IGH359nRyFPkFdfnDOMj5OdwFf4BrCYP3sdaS6Lm8mXBgKkrAse2amsqCLYagh
 OedefzO4AjP4qzvhnAa8YT/pTXjeRuXNPOuzjqsyNko5jsF6qZr7fx5AwsKHLcrWVO2VOqoy3oI
 XN6sLQZDk58tP3J2nVAvKGKeREnm6enChTkhBH3hKiLLlT7rlSzhwAoApqBdF5GfTcH2MrPmdvL
 1WBTo5R2ZvohsiFZPm33qCJBGJt1c7Rg7USWVKBdwgFgCjN3qHsgUCDvMABAlsi+BzZ9OIOYEyN
 H68MVuAt3oGUlFgZhMFrbl66DW95C3zoDzJHkjT28jCdSVk6K6TOf3Q+MR3PQZpMh8CGI6w+bh6
 +5XzvY6rCzPl705c4JeRG7TmNyG2+16m+64sknQ3UvGewJo6ihgWWPHBzg1Fny0QqKcXicl9f76
 ls=
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
rejected while permitting other updates to proceed. Non-system-related
errors include issues caused by user-provided input values, whereas
system-related errors, such as I/O failures or memory issues, continue
to result in a full transaction failure. This approach enhances
flexibility while preserving transactional integrity where necessary.

The implementation introduces several key components:

  - Add 'rejection_err' field to struct `ref_update` to track failed
    updates with failure reason.

  - Modify reference backends (files, packed, reftable) to handle
    partial transactions by using `ref_transaction_set_rejected()`
    instead of failing the entire transaction when
    `REF_TRANSACTION_ALLOW_PARTIAL` is set.

  - Add `ref_transaction_for_each_rejected_update()` to let callers
    examine which updates were rejected and why.

This foundational change enables partial transaction support throughout
the reference subsystem. The next commit will expose this capability to
users by adding a `--allow-partial` flag to 'git-update-ref(1)',
providing both a user-facing feature and a testable implementation.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 31 +++++++++++++++++++++++++++++++
 refs.h                  | 22 ++++++++++++++++++++++
 refs/files-backend.c    | 12 +++++++++++-
 refs/packed-backend.c   | 30 ++++++++++++++++++++++++++++--
 refs/refs-internal.h    | 13 +++++++++++++
 refs/reftable-backend.c | 12 +++++++++++-
 6 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index f989a46a5a..243c09c368 100644
--- a/refs.c
+++ b/refs.c
@@ -1211,6 +1211,15 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
+void ref_transaction_set_rejected(struct ref_transaction *transaction,
+				  size_t update_idx,
+				  enum transaction_error err)
+{
+	if (update_idx >= transaction->nr)
+		BUG("trying to set rejection on invalid update index");
+	transaction->updates[update_idx]->rejection_err = err;
+}
+
 struct ref_update *ref_transaction_add_update(
 		struct ref_transaction *transaction,
 		const char *refname, unsigned int flags,
@@ -1236,6 +1245,7 @@ struct ref_update *ref_transaction_add_update(
 	transaction->updates[transaction->nr++] = update;
 
 	update->flags = flags;
+	update->rejection_err = TRANSACTION_OK;
 
 	update->new_target = xstrdup_or_null(new_target);
 	update->old_target = xstrdup_or_null(old_target);
@@ -2726,6 +2736,27 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
 	}
 }
 
+void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
+					      ref_transaction_for_each_rejected_update_fn cb,
+					      void *cb_data)
+{
+	if (!(transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL))
+		return;
+
+	for (size_t i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
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
index 8e9ead174c..e4a6a8218f 100644
--- a/refs.h
+++ b/refs.h
@@ -675,6 +675,13 @@ enum ref_transaction_flag {
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
@@ -905,6 +912,21 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
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
+							 enum transaction_error err,
+							 void *cb_data);
+void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
+					      ref_transaction_for_each_rejected_update_fn cb,
+					      void *cb_data);
+
 /*
  * Free `*transaction` and all associated data.
  */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3b0adf8bb2..d0a53c9ace 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2851,8 +2851,18 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		ret = lock_ref_for_update(refs, update, transaction,
 					  head_ref, &refnames_to_check,
 					  err);
-		if (ret)
+		if (ret) {
+			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL &&
+			    ret != TRANSACTION_GENERIC_ERROR) {
+				ref_transaction_set_rejected(transaction, i, ret);
+
+				strbuf_setlen(err, 0);
+				ret = TRANSACTION_OK;
+
+				continue;
+			}
 			goto cleanup;
+		}
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 75e1ebf67d..0857204213 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1324,10 +1324,11 @@ static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
  * remain locked when it is done.
  */
 static enum transaction_error write_with_updates(struct packed_ref_store *refs,
-						 struct string_list *updates,
+						 struct ref_transaction *transaction,
 						 struct strbuf *err)
 {
 	enum transaction_error ret = TRANSACTION_GENERIC_ERROR;
+	struct string_list *updates = &transaction->refnames;
 	struct ref_iterator *iter = NULL;
 	size_t i;
 	int ok;
@@ -1408,6 +1409,14 @@ static enum transaction_error write_with_updates(struct packed_ref_store *refs,
 						    "reference already exists",
 						    update->refname);
 					ret = TRANSACTION_CREATE_EXISTS;
+
+					if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
+						ref_transaction_set_rejected(transaction, i, ret);
+						strbuf_setlen(err, 0);
+						ret = 0;
+						continue;
+					}
+
 					goto error;
 				} else if (!oideq(&update->old_oid, iter->oid)) {
 					strbuf_addf(err, "cannot update ref '%s': "
@@ -1416,6 +1425,14 @@ static enum transaction_error write_with_updates(struct packed_ref_store *refs,
 						    oid_to_hex(iter->oid),
 						    oid_to_hex(&update->old_oid));
 					ret = TRANSACTION_INCORRECT_OLD_VALUE;
+
+					if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
+						ref_transaction_set_rejected(transaction, i, ret);
+						strbuf_setlen(err, 0);
+						ret = 0;
+						continue;
+					}
+
 					goto error;
 				}
 			}
@@ -1453,6 +1470,14 @@ static enum transaction_error write_with_updates(struct packed_ref_store *refs,
 					    update->refname,
 					    oid_to_hex(&update->old_oid));
 				return TRANSACTION_NONEXISTENT_REF;
+
+				if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
+					ref_transaction_set_rejected(transaction, i, ret);
+					strbuf_setlen(err, 0);
+					ret = 0;
+					continue;
+				}
+
 				goto error;
 			}
 		}
@@ -1518,6 +1543,7 @@ static enum transaction_error write_with_updates(struct packed_ref_store *refs,
 write_error:
 	strbuf_addf(err, "error writing to %s: %s",
 		    get_tempfile_path(refs->tempfile), strerror(errno));
+	ret = TRANSACTION_GENERIC_ERROR;
 
 error:
 	ref_iterator_free(iter);
@@ -1676,7 +1702,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 		data->own_lock = 1;
 	}
 
-	ret = write_with_updates(refs, &transaction->refnames, err);
+	ret = write_with_updates(refs, transaction, err);
 	if (ret)
 		goto failure;
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c97045fbed..7196f2d880 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -123,6 +123,11 @@ struct ref_update {
 	 */
 	uint64_t index;
 
+	/*
+	 * Used in partial transactions to mark if a given update was rejected.
+	 */
+	enum transaction_error rejection_err;
+
 	/*
 	 * If this ref_update was split off of a symref update via
 	 * split_symref_update(), then this member points at that
@@ -142,6 +147,14 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
 
+/*
+ * Mark a given update as rejected with a given reason. To be used in conjuction
+ * with the `REF_TRANSACTION_ALLOW_PARTIAL` flag to allow partial transactions.
+ */
+void ref_transaction_set_rejected(struct ref_transaction *transaction,
+				  size_t update_idx,
+				  enum transaction_error err);
+
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e1fd9c2de2..83cf8d582b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1374,8 +1374,18 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					    transaction->updates[i],
 					    &refnames_to_check, head_type,
 					    &head_referent, &referent, err);
-		if (ret)
+		if (ret) {
+			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL &&
+			    ret != TRANSACTION_GENERIC_ERROR) {
+				ref_transaction_set_rejected(transaction, i, ret);
+
+				strbuf_setlen(err, 0);
+				ret = TRANSACTION_OK;
+
+				continue;
+			}
 			goto done;
+		}
 	}
 
 	string_list_sort(&refnames_to_check);

-- 
2.47.2

