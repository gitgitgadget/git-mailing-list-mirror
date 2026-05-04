Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8B3E4C7F
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916664; cv=none; b=Jv+/U3nL+53iXrXPsqbM9G2M2yEx92O/GBxgPs77b185yufrxrLJv1ZyR6hZ4ZUIEMx3oNMfss5r/IVagomXT+lelSjTGIMkzdCH0qFM413zD3s1tRo8HccrpHBOoG6wdL/RMC93RxCVsSpwWlOZPPJgdcrB7p4FT+7XGl536RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916664; c=relaxed/simple;
	bh=k9svHdq0lQSCWEh45LT4YsUdrz3nCE3ahcL9UGuSFXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZxqnlBAJQqNa+INS3//JvwXvwyt0yelc2LA9zGB09tiG0FGirOT/0Jj2r/V+MT6ai4qMORh31bAPXoVONEPJQrRHBYzffjG19ODXxl5fvMfOs4SGrxWakAb9XK1CSEaDFb/5+0H3hnuZ0KPMkTozuUbCgbYfLZLDK4Y/ecje8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHqpvJnG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHqpvJnG"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so42133295e9.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916660; x=1778521460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/bjrW73Qp936EmsDjfTk6kXpsbUOP4FCBt8ieStDys=;
        b=bHqpvJnG/7Xxocq3WAN3wMvP57+ttrdime7UGIWnuR9srkrhBkuxKjIm6OAn3fzqFV
         ZSOhZ7e+8TTpmAF0zktOrIopLRWp3vBsPNXUrHeypN2WzEhgF6L/8Qa9c6nJ0WilXPla
         LdeyfqTWBXU7c2/QhrVccFkuhMSNnI8sztAevAWxbl2mWgDVBdZMMAodXGxCUIYEVMwh
         LbwK2YAVd308mTQ8fWV0AM8EEGK7sFsx30JiHtFono2AOZnLoYoM8oYuhs/WameAXwV4
         4V97Asv+6WuV4YGCZdhs7mdnT+Cklg2XIg+P3vezkuSjnnlfWtr3yOFryE5mZ0UOPbCe
         viPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916660; x=1778521460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q/bjrW73Qp936EmsDjfTk6kXpsbUOP4FCBt8ieStDys=;
        b=dOVfd50Cl84o75PKzPcKAxUvV71ZiWnzpmpVA/z3XLYBzxSHstSp9ZWGO9Ei7qRPGc
         PMZxh/2hCMREQHIi8bzH7AXlc15Qh7ekuH584KwIXGykVkZcoT19Av2ExOjDy15Abhw/
         KGcSo+t2S+LHdGJT8NwCtdK5ePxM3YIPGqysyLzhd+GRV4hIzuvFURrh5HAqR3qmxaUM
         Yt2rnvsC5+7coo3pmQWcIAy17Yp3kazw9aDtP96yKDE4DEO/HxRae9q5ewyb1umfs8wY
         /KRrkaHC5siGDQkdDRvGJ772OffNqb/zAaLtjHRnUmqG1iHwXWk2wqC422NI0jfbE2fq
         9obw==
X-Gm-Message-State: AOJu0YwAIvwT9++faY4AGrPu9mwu1npY51c9F471OfPlruXo/79t+J7l
	oWXm5j8mTvTPBrOBWSE15pVsXDWvvgQOCD8aRMql18LWdjjHr2AelzEZ
X-Gm-Gg: AeBDievQ/SwKcN4ocn4SjKXF1zuu8ow/95NNQ0DUMVfh0iKxfcaDYGnZPkZskrMzKUc
	/H1Ir7tGReJX6JnmInIjFlRQvPoO4K6Kv8nzktZ6rbu4RrLUE4o7Nve9oXuWaRmEljOPZMn9Bo7
	xV0AXmeYXO2F9ihvxZPmrUzBHNWkI9Y31Sa4mNbTBe+Ow9pWrofARFzTf1BUhe8BbpvR8GY5mPW
	WgE70M3GYU6rjPoDc5BudPMH4mhVOhZ8V0xvZsr36OwsAYDGhCG1q5FB4bUl0dte2hTwEm+onHK
	d5oKUg73tgW0XfNOCqLPwNfucdn9FtHnXh/kCA5mohgbjCUjLwF3YixHFAER4oIKfNlkBbsPlEK
	8ITPQbEKWSvaaHfHW4Vn9kMCGoFpLlaEhnKX7CT+/FTKsSMlB6MSuTuB4d7OByyrbTG2duEl0at
	Im2bpf5o/qCr3XbhhfXp90nLNjVdxIBFtE9CJqTibl
X-Received: by 2002:a05:600c:a30a:b0:489:1cda:bbb7 with SMTP id 5b1f17b1804b1-48a986737f4mr127659455e9.25.1777916660441;
        Mon, 04 May 2026 10:44:20 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1f8b:93fc:106a:20a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm299297675e9.7.2026.05.04.10.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:44:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 04 May 2026 19:44:12 +0200
Subject: [PATCH v4 8/9] refs: add peeled object ID to the `ref_update`
 struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-refs-move-to-generic-layer-v4-8-936ac2f0b1a3@gmail.com>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
In-Reply-To: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8668; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=k9svHdq0lQSCWEh45LT4YsUdrz3nCE3ahcL9UGuSFXQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGn42urVn776HhsBhRSyp81uMmyQb3cBIy1Gp
 9uIBgo1g2Htb4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp+NrqAAoJED7VnySO
 Rox/NDsL/AizId6A3NcC+KZJfsIxAUEWOHr9q+YOLxka70GlL0uqo8iAXHLpDHG9v52PTTvKSGO
 ugclBWLAfLaW3pWd/zoIMvSy2wC/9qsSTfRMXWeD+YB/853oFo14IBP6jKCWtnWn9sJcYgc4WKF
 9eG7WdGq+x6N1v/+kKi2URL7fLwyWaZ32j5cgBPrsHxNB0JD928zOAiPujrtYTl4qKxCD6hn3G2
 9PVE9G3BK/iFs7aW85MSp+G4q6F5SHH2nzoyeYjXkF2aHzvD8EF7x7oaGrAKO8jpwrlbEEIftIS
 0Jz0nNoVteSM7s9PZ0Zn6raxv04Lgqzac+f/mrtHCiiLHzAuvkFqbB54L3WEIO+w8mfyeO4JwYT
 kYCNvaP78LLD50t9lwJsfdR89H19QK0pp6PUlt3Yx9OLUryWfLyJkqu+ZhFap3MU+Hpunj42Kim
 I+YY75NplVDxDXAQLKPP9kU3mUyY0JM3hMrQ5cyPiy6+lIK+LWMYpHluTrY3moDTodKiQ+yKMs7
 Tc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Certain reference backends {packed, reftable}, have the ability to also
store the peeled object ID for a reference pointing to a tag object.
This has the added benefit that during retrieval of such references, we
also obtain the peeled object ID without having to use the ODB.

To provide this functionality, each backend independently calls the ODB
to obtain the peeled OID. To move this functionality to the generic
layer, there must be support infrastructure to pass in a peeled OID for
reference updates.

Add a `peeled` field to the `ref_update` structure and modify
`ref_transaction_add_update()` to receive and copy this object ID to the
`ref_update` structure. Finally, modify `ref_transaction_update()` to
peel tag objects and pass the peeled OID to
`ref_transaction_add_update()`.

Update all callers of these functions with the new function parameters.
Callers which only add reflog updates, need to only pass in NULL, since
for reflogs, we don't store peeled OIDs. Reference deletions also only
need to pass in NULL. For others, pass along the peeled OID if
available.

In a following commit, we'll modify the backends to use this peeled OID
instead of parsing it themselves.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 15 +++++++++++++--
 refs/files-backend.c    | 20 ++++++++++++--------
 refs/refs-internal.h    | 14 ++++++++++++++
 refs/reftable-backend.c |  6 +++---
 4 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 662a9e6f9e..0648df2b6c 100644
--- a/refs.c
+++ b/refs.c
@@ -1307,6 +1307,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
+		const struct object_id *peeled,
 		const char *new_target, const char *old_target,
 		const char *committer_info,
 		const char *msg)
@@ -1339,6 +1340,8 @@ struct ref_update *ref_transaction_add_update(
 		update->committer_info = xstrdup_or_null(committer_info);
 		update->msg = normalize_reflog_message(msg);
 	}
+	if (flags & REF_HAVE_PEELED)
+		oidcpy(&update->peeled, peeled);
 
 	/*
 	 * This list is generally used by the backends to avoid duplicates.
@@ -1392,6 +1395,8 @@ enum ref_transaction_error ref_transaction_update(struct ref_transaction *transa
 						  unsigned int flags, const char *msg,
 						  struct strbuf *err)
 {
+	struct object_id peeled;
+
 	assert(err);
 
 	if ((flags & REF_FORCE_CREATE_REFLOG) &&
@@ -1432,10 +1437,16 @@ enum ref_transaction_error ref_transaction_update(struct ref_transaction *transa
 				    oid_to_hex(new_oid), refname);
 			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
 		}
+
+		if (o->type == OBJ_TAG) {
+			if (!peel_object(transaction->ref_store->repo, new_oid, &peeled,
+					 PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE))
+				flags |= REF_HAVE_PEELED;
+		}
 	}
 
 	ref_transaction_add_update(transaction, refname, flags,
-				   new_oid, old_oid, new_target,
+				   new_oid, old_oid, &peeled, new_target,
 				   old_target, NULL, msg);
 
 	return 0;
@@ -1462,7 +1473,7 @@ int ref_transaction_update_reflog(struct ref_transaction *transaction,
 		return -1;
 
 	update = ref_transaction_add_update(transaction, refname, flags,
-					    new_oid, old_oid, NULL, NULL,
+					    new_oid, old_oid, NULL, NULL, NULL,
 					    committer_info, msg);
 	update->index = index;
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f20f580fbc..d0896d0e37 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1325,7 +1325,8 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	ref_transaction_add_update(
 			transaction, r->name,
 			REF_NO_DEREF | REF_HAVE_NEW | REF_HAVE_OLD | REF_IS_PRUNING,
-			null_oid(the_hash_algo), &r->oid, NULL, NULL, NULL, NULL);
+			null_oid(the_hash_algo), &r->oid, NULL, NULL, NULL,
+			NULL, NULL);
 	if (ref_transaction_commit(transaction, &err))
 		goto cleanup;
 
@@ -2468,7 +2469,7 @@ static enum ref_transaction_error split_head_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, "HEAD",
 			update->flags | REF_LOG_ONLY | REF_NO_DEREF | REF_LOG_VIA_SPLIT,
-			&update->new_oid, &update->old_oid,
+			&update->new_oid, &update->old_oid, &update->peeled,
 			NULL, NULL, update->committer_info, update->msg);
 	new_update->parent_update = update;
 
@@ -2530,8 +2531,8 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
 			transaction, referent, new_flags,
 			update->new_target ? NULL : &update->new_oid,
 			update->old_target ? NULL : &update->old_oid,
-			update->new_target, update->old_target, NULL,
-			update->msg);
+			&update->peeled, update->new_target, update->old_target,
+			NULL, update->msg);
 
 	new_update->parent_update = update;
 
@@ -2994,7 +2995,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			ref_transaction_add_update(
 					packed_transaction, update->refname,
 					REF_HAVE_NEW | REF_NO_DEREF,
-					&update->new_oid, NULL,
+					&update->new_oid, NULL, NULL,
 					NULL, NULL, NULL, NULL);
 		}
 	}
@@ -3200,19 +3201,22 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 			if (update->flags & REF_LOG_ONLY)
 				ref_transaction_add_update(loose_transaction, update->refname,
 							   update->flags, &update->new_oid,
-							   &update->old_oid, NULL, NULL,
+							   &update->old_oid, &update->peeled,
+							   NULL, NULL,
 							   update->committer_info, update->msg);
 			else
 				ref_transaction_add_update(loose_transaction, update->refname,
 							   update->flags & ~REF_HAVE_OLD,
 							   update->new_target ? NULL : &update->new_oid, NULL,
-							   update->new_target, NULL, update->committer_info,
+							   &update->peeled, update->new_target,
+							   NULL, update->committer_info,
 							   NULL);
 		} else {
 			ref_transaction_add_update(packed_transaction, update->refname,
 						   update->flags & ~REF_HAVE_OLD,
 						   &update->new_oid, &update->old_oid,
-						   NULL, NULL, update->committer_info, NULL);
+						   &update->peeled, NULL, NULL,
+						   update->committer_info, NULL);
 		}
 	}
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d103387ebf..307dcb277b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -39,6 +39,13 @@ struct ref_transaction;
  */
 #define REF_LOG_ONLY (1 << 7)
 
+/*
+ * The reference contains a peeled object ID. This is used when the
+ * new_oid is pointing to a tag object and the reference backend
+ * wants to also store the peeled value for optimized retrieval.
+ */
+#define REF_HAVE_PEELED (1 << 15)
+
 /*
  * Return the length of time to retry acquiring a loose reference lock
  * before giving up, in milliseconds:
@@ -92,6 +99,12 @@ struct ref_update {
 	 */
 	struct object_id old_oid;
 
+	/*
+	 * If the new_oid points to a tag object, set this to the peeled
+	 * object ID for optimized retrieval without needed to hit the odb.
+	 */
+	struct object_id peeled;
+
 	/*
 	 * If set, point the reference to this value. This can also be
 	 * used to convert regular references to become symbolic refs.
@@ -169,6 +182,7 @@ struct ref_update *ref_transaction_add_update(
 		const char *refname, unsigned int flags,
 		const struct object_id *new_oid,
 		const struct object_id *old_oid,
+		const struct object_id *peeled,
 		const char *new_target, const char *old_target,
 		const char *committer_info,
 		const char *msg);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 444b0c24e5..b0c010387d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1107,8 +1107,8 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 		ref_transaction_add_update(
 			transaction, "HEAD",
 			u->flags | REF_LOG_ONLY | REF_NO_DEREF,
-			&u->new_oid, &u->old_oid, NULL, NULL, NULL,
-			u->msg);
+			&u->new_oid, &u->old_oid, &u->peeled, NULL, NULL,
+			NULL, u->msg);
 	}
 
 	ret = reftable_backend_read_ref(be, rewritten_ref,
@@ -1194,7 +1194,7 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 				transaction, referent->buf, new_flags,
 				u->new_target ? NULL : &u->new_oid,
 				u->old_target ? NULL : &u->old_oid,
-				u->new_target, u->old_target,
+				&u->peeled, u->new_target, u->old_target,
 				u->committer_info, u->msg);
 
 			new_update->parent_update = u;

-- 
2.53.GIT

