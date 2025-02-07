Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C91A76DA
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913837; cv=none; b=bErd420RMIDRYtR5NzD9212Ch7o15JYSSKEBBXWRWw4Upteb30SfsxqMcYXTocO4UbaYe34qN36wv1h+C3L+tF4g+mvTl6tHPkB5PaqOC4DR8tZQx1VT8nVsY6m0hCA3/coQ7leDCUyuyEoKREkKNOWSbB3e3tL97PdptC0ngRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913837; c=relaxed/simple;
	bh=8KO6JLLgnSt4/pEIUCAwehohejZEpruazEGuJAKD4cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XR9audvZl1R+FYq1k43yF67ZzrHrMSfAqtiy23SOeVJ2wI7D9vHcCewrK6v2Qxk4O2K+iZpQpo0Io1OXnvTDQXyqw8g0qNF0yGOhU84Lnm11jqmLGKUST6m6284K4lZURzq9XInKCWJBcrxQsyPKFWUVqlplkbaXnlCQIOHsOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqGNaNWW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqGNaNWW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21634338cfdso43131015ad.2
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 23:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738913835; x=1739518635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYM49T1CDiI0W8ah27wSJFisbd8NjikRgzTr+rQqP3k=;
        b=CqGNaNWW6ZL71v11+saoZCbDvnmQHbk0myQSWdtc/jLxodpOXADPe8qv7BuRy3Ng+V
         Onu33HmTVuxKlqF1rZyAWlFhB7oZ1I6Ia+rCojiBMaTd9ApUPDO3SSBVTlstowfn3aYT
         PbrSni84xm21KOmdA0hvvIUo5fBt7L+9mgEoOcWAxJ/YPFCHHxXGNK1GSCym9Ao+Y0+e
         iQ/D6U1PhB/xsCe/itzj8Pmxj+NPZ7gB2Gxy3RfOAMsjCX3o9Vi0nZTiQEvJycxZ5WM5
         BPZu8ckAkZLCaNFGn7yMRxjnk08Fos/SHkLxYjTzjFgNA+maKuX+Ll9H3nIo+WS3inyC
         Irog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913835; x=1739518635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYM49T1CDiI0W8ah27wSJFisbd8NjikRgzTr+rQqP3k=;
        b=r//U/V5WOks3Pqu1s3kPBzzRK4enRjuLp9Di6eroYNr755tUYqR4iWAum4xCQ1g43A
         SSV+XtAl4SHsou4x3d7m2vsLQHBzdja1DcgKZfYUtPmoaXm1/zYkX/5Ei9wB7qh2ZqQE
         do4Kk+9VxVwZPydnCD3XVMHSwyEnGASq1ysH91ld10sFgpMAYeBCJGmaaPgsRJZin9Es
         MqVDj519PLcvHyghyAQpruYkWv0Z/RVnQIsc+XcuIYW8VJ5Nw4Plbd4C6aZ8aDnhmTpJ
         PrirHLhjyubG6Yd97nK0ZXolQugt4+w/CqDLLtF0HT/42+75CDrqmqMkTpvlvlTmU+SC
         zG2A==
X-Gm-Message-State: AOJu0YyRy3BkhOuBBI6JzcPia5et7U4a0/qIDGolNjcD+CsMfa1egjJx
	WIDaT04iBRc3aMKoq+EN0Tx5U5+/30JO50w9+SwnwIm7jPpq5FlkGxjVoulZ
X-Gm-Gg: ASbGncuWit/d/AjRsUe79x4kaPaV47J8UmjOduNab6XaAC31aCjVSvm/MVwT/JJQKMd
	3zbu+RcQ3upqtyFN3o3cwfcLiFSiLqtYo/TCG5KQD/y74mnwP6HsWyIWD4YpxYhSIly4t+fyJSv
	z5EtjHZ9cgWiQEJ0A9t9dna8W1TsCS0/u3nzXUH9s1rxM1hDHayiAWv8052trGyYP4jROrbwvOI
	dB5yJ3uu+WJNvlhRQFKc74WfaAXXgsjSxQzYnMkSz+4bAAXFcguyQwl84AV7gSNhWLLVDpot7pd
	KSrngmO91AuAy2jVP9Bebw==
X-Google-Smtp-Source: AGHT+IEuK7XpAF7G0BzB9zau/IVhn18iFUPQmu1QsGqct1unSf4/jeW3zxHSWtnTD2GouvE7HgdPJA==
X-Received: by 2002:a05:6a00:807:b0:725:f282:1f04 with SMTP id d2e1a72fcca58-7305d4eff53mr4226404b3a.18.1738913834718;
        Thu, 06 Feb 2025 23:37:14 -0800 (PST)
Received: from [127.0.0.2] ([2401:4900:33b7:4cb0:4dd3:85f0:5c4b:b677])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aee79casm2115063a12.44.2025.02.06.23.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:37:14 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 07 Feb 2025 08:34:40 +0100
Subject: [PATCH 5/6] refs: implement partial reference transaction support
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-245-partially-atomic-ref-updates-v1-5-e6a3690ff23a@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
In-Reply-To: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10840;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=8KO6JLLgnSt4/pEIUCAwehohejZEpruazEGuJAKD4cg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeluBu7beVH660nOoWKktK4/05yoldUMiBuN
 EWYliKdJaWg+okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnpbgbAAoJED7VnySO
 Rox/iQML/2MGog05l1TnSMHm5X5KYAWuP8Bvp7o3xbHbfvNtjcCz1SuwSdJ68DMvEJjVE/x1Uyr
 /8+cW8qaJPrO6mtivFEeAt+AzTmjWew2IRBlBzY88V8oPk9n37xAmOVrASVZ74CApp8M7t1qUgD
 WH/5oTd1EVQ90X01jaAfoQ+e8lXkGDBiEQ0YCfqfuPjlisnIpmxnZtYtpYZzcRAm7qiA2Mts1qy
 R3zPEjBQ1Xjs7KJXd3q/s6NGfEwhwGfX1RvYxFwsF525s+asXRifAdRYGU5mtSqDfcxaahwVRYU
 JYm2hhQqftKHlYB3H5lPASxmFTeIoMXzTr+8QmE3MXlEUujABESZVpiVC58ExK5HnNLLzSpBUJC
 8mcSiRPzYV5p6geDa+e3g0633IF99XRoaq0SK+5q2xtPjmbcSl0qzYdynQXTyDkhIURo9/jGfc9
 fkldFy2JBxYEHd/MbNGH4OP0WrCDeVx9yALjyZWOBsXJuTFhyjsJs3WybCJJgFGgpcD6AZ5X8l5
 wQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Git's reference transactions are all-or-nothing: either all updates
succeed, or none do. While this atomic behavior is generally desirable,
it can be suboptimal when using the reftable backend, where batching
multiple reference updates into a single transaction is more efficient
than performing them sequentially.

Introduce partial transaction support through a new flag
`REF_TRANSACTION_ALLOW_PARTIAL`. When this flag is set, individual
reference updates that would normally fail the entire transaction are
instead marked as rejected while allowing other updates to proceed. This
provides more flexibility while maintaining transactional integrity
where needed.

The implementation introduces several key components:

  - Add 'rejected' and 'rejection_err' fields to struct `ref_update` to
    track failed updates and their failure reasons.

  - Modify reference backends (files, packed, reftable) to handle
    partial transactions by using `ref_transaction_add_rejection()`
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
 refs.c                  | 32 ++++++++++++++++++++++++++++++++
 refs.h                  | 22 ++++++++++++++++++++++
 refs/files-backend.c    | 12 +++++++++++-
 refs/packed-backend.c   | 26 ++++++++++++++++++++++++--
 refs/refs-internal.h    | 15 +++++++++++++++
 refs/reftable-backend.c | 12 +++++++++++-
 6 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index b420a120102b3793168598b885bba68e4f5f5f03..75dbd84acbc41658d4b8b6b5e7763c04e78d0061 100644
--- a/refs.c
+++ b/refs.c
@@ -1204,6 +1204,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 		free(transaction->updates[i]->committer_info);
 		free((char *)transaction->updates[i]->new_target);
 		free((char *)transaction->updates[i]->old_target);
+		strbuf_release(&transaction->updates[i]->rejection_err);
 		free(transaction->updates[i]);
 	}
 	string_list_clear(&transaction->refnames, 0);
@@ -1211,6 +1212,14 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
+void ref_transaction_add_rejection(struct ref_transaction *transaction,
+				   size_t update_idx, struct strbuf *err)
+{
+	struct ref_update *update = transaction->updates[update_idx];
+	update->rejected = 1;
+	strbuf_addbuf(&update->rejection_err, err);
+}
+
 struct ref_update *ref_transaction_add_update(
 		struct ref_transaction *transaction,
 		const char *refname, unsigned int flags,
@@ -1237,6 +1246,8 @@ struct ref_update *ref_transaction_add_update(
 
 	update->flags = flags;
 
+	strbuf_init(&update->rejection_err, 0);
+
 	update->new_target = xstrdup_or_null(new_target);
 	update->old_target = xstrdup_or_null(old_target);
 	if ((flags & REF_HAVE_NEW) && new_oid)
@@ -2676,6 +2687,27 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
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
+		if (!update->rejected)
+			continue;
+
+		cb(update->refname,
+		   (update->flags & REF_HAVE_OLD) ? &update->old_oid : NULL,
+		   (update->flags & REF_HAVE_NEW) ? &update->new_oid : NULL,
+		   update->old_target, update->new_target,
+		   &update->rejection_err, cb_data);
+	}
+}
+
 int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 		     struct string_list *refnames, unsigned int flags)
 {
diff --git a/refs.h b/refs.h
index a0cdd99250e8286b55808b697b0a94afac5d8319..a0f15fdea024527fcfdb478f78cbf6fd6568a25b 100644
--- a/refs.h
+++ b/refs.h
@@ -638,6 +638,13 @@ enum ref_transaction_flag {
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
@@ -889,6 +896,21 @@ void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
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
+							 const struct strbuf *reason,
+							 void *cb_data);
+void ref_transaction_for_each_rejected_update(struct ref_transaction *transaction,
+					      ref_transaction_for_each_rejected_update_fn cb,
+					      void *cb_data);
+
 /*
  * Free `*transaction` and all associated data.
  */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9fc5454678340dd7c72539bfa0f15ee7eb24b1ff..99ec29164fbd30635125cc2325aab3d300cf906c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2852,8 +2852,18 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 		ret = lock_ref_for_update(refs, update, transaction,
 					  head_ref, err);
-		if (ret)
+		if (ret) {
+			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
+				ref_transaction_add_rejection(transaction, i, err);
+
+				strbuf_setlen(err, 0);
+				ret = 0;
+
+				continue;
+			}
 			goto cleanup;
+		}
+
 
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6e7acb077e81435715a1ca3cc928550147c8c56a..cb9b6f0a620eaa59941f6fbc653600304f2bae8c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1313,9 +1313,10 @@ static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
  * remain locked when it is done.
  */
 static int write_with_updates(struct packed_ref_store *refs,
-			      struct string_list *updates,
+			      struct ref_transaction *transaction,
 			      struct strbuf *err)
 {
+	struct string_list *updates = &transaction->refnames;
 	struct ref_iterator *iter = NULL;
 	size_t i;
 	int ok;
@@ -1393,6 +1394,13 @@ static int write_with_updates(struct packed_ref_store *refs,
 					strbuf_addf(err, "cannot update ref '%s': "
 						    "reference already exists",
 						    update->refname);
+
+					if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
+						ref_transaction_add_rejection(transaction, i, err);
+						strbuf_setlen(err, 0);
+						continue;
+					}
+
 					goto error;
 				} else if (!oideq(&update->old_oid, iter->oid)) {
 					strbuf_addf(err, "cannot update ref '%s': "
@@ -1400,6 +1408,13 @@ static int write_with_updates(struct packed_ref_store *refs,
 						    update->refname,
 						    oid_to_hex(iter->oid),
 						    oid_to_hex(&update->old_oid));
+
+					if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
+						ref_transaction_add_rejection(transaction, i, err);
+						strbuf_setlen(err, 0);
+						continue;
+					}
+
 					goto error;
 				}
 			}
@@ -1434,6 +1449,13 @@ static int write_with_updates(struct packed_ref_store *refs,
 					    "reference is missing but expected %s",
 					    update->refname,
 					    oid_to_hex(&update->old_oid));
+
+				if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
+					ref_transaction_add_rejection(transaction, i, err);
+					strbuf_setlen(err, 0);
+					continue;
+				}
+
 				goto error;
 			}
 		}
@@ -1657,7 +1679,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 		data->own_lock = 1;
 	}
 
-	if (write_with_updates(refs, &transaction->refnames, err))
+	if (write_with_updates(refs, transaction, err))
 		goto failure;
 
 	transaction->state = REF_TRANSACTION_PREPARED;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 434362b6099a35f92906a04ddd65365140147572..6b8f5b2bd83baa22480083e1002daba9300f1b70 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -3,6 +3,7 @@
 
 #include "refs.h"
 #include "iterator.h"
+#include "strbuf.h"
 #include "string-list.h"
 
 struct fsck_options;
@@ -123,6 +124,13 @@ struct ref_update {
 	 */
 	unsigned int index;
 
+	/*
+	 * Used in partial transactions to mark a given update as rejected,
+	 * with rejection reason.
+	 */
+	unsigned int rejected;
+	struct strbuf rejection_err;
+
 	/*
 	 * If this ref_update was split off of a symref update via
 	 * split_symref_update(), then this member points at that
@@ -142,6 +150,13 @@ int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno);
 
+/*
+ * Mark a given update as rejected with a given reason. To be used in conjuction
+ * with the `REF_TRANSACTION_ALLOW_PARTIAL` flag to allow partial transactions.
+ */
+void ref_transaction_add_rejection(struct ref_transaction *transaction,
+				   size_t update_idx, struct strbuf *err);
+
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5533acfaf9027765d5a270abfce96225e42cc823..a2d86d1c5098b30bd212fc12a3708d2c0a60c677 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1364,8 +1364,18 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 					    transaction, be,
 					    transaction->updates[i], head_type,
 					    &head_referent, &referent, err);
-		if (ret)
+
+		if (ret) {
+			if (transaction->flags & REF_TRANSACTION_ALLOW_PARTIAL) {
+				ref_transaction_add_rejection(transaction, i, err);
+
+				strbuf_setlen(err, 0);
+				ret = 0;
+
+				continue;
+			}
 			goto done;
+		}
 	}
 
 	transaction->backend_data = tx_data;

-- 
2.47.0

