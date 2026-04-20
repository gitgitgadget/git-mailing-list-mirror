Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4903939CE
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679959; cv=none; b=UOkc/REmXCrB1rZNXraREcPE+CBd/KScHwqxpGMGu01gM+I/FbyhON9weyRukpIkGF11KO2ZkQrL5pGJWNhz3DXYKe2xT8+NH4hFpJpV3XCLIUS2SqjzTm2lEANVEfTnVyDefzEQwmpkMuvrZNw0WbKIF0ZswmOqwO5ZfBh6ip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679959; c=relaxed/simple;
	bh=0R5pEsVxKQPpjtT5+Od1Zdn+c7c0gFqLPfwhTDcR21o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I9KgyCzpZMg6J+cNF4vO+7VnzGY3dV8mzQBGfOS0+kHPFVpYLF2uYGSO5u/mbv4Gig8LzvkyA9ZJnNOkcQ1w7m2mHslclLsISYD1VlJ/hKzkHrkXiYsg8VF7psRXMyBXC3vTxJKldBzqZ4mj7jz1SY8oL1gKFlgBHoBZGdmm4gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDW1HAv1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDW1HAv1"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43fe608cb92so1854175f8f.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776679954; x=1777284754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjLzEi+ePEqU4pFh1HpqZLW3Qu54X1ENkWnqc6NtYOw=;
        b=nDW1HAv18Cf/4CYK6QtEjqra4vfRnOKn5rqwZZKVId5M9U6+mG9wN8fw9YSqc3E/a6
         +adz1ItDT8x66SozcJ3IBVZ31TCmFZiZPA6tGxxk2OS+XyuP9E/ekaSOGkGqpzTLZMfX
         jOZuVfhXdx8Swigl9d0XmHS1FEHjuQE2XyVUAXUPxT1RvTi+szJaTNDWgu/VrJzdr7KE
         bInJ00H0w7MhCq1KzwUJx5sw70iJuyt897WwDUAacD86aK1n+DqlM6FUzFuiDHMvIStm
         7jreQ0YGc0AsdnFOIP/mnHCHCy3PGcHgoD4AicC7YEFzFadlTqV+QSEllz+4YbkylbuH
         pm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776679954; x=1777284754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjLzEi+ePEqU4pFh1HpqZLW3Qu54X1ENkWnqc6NtYOw=;
        b=kqY8lUkRyEloVEpT4Xe0DUI/jNEcu1p/mJLTOvEjZvjAKqxaWxKa2tLbLVw1PNc/a7
         EkUz8f7CULhEuZXIQufwyPPu69fHYj3SbMBlCb7sWnUPbRa+sPvINcDvd78ANxvEMTXD
         PXmaqPVz07lgU6so9HWLOiRlgyxo5J+GKeKuOc8puvYC4UkJ/BfMlghgyX7tPryyk/wn
         p9V59FAYnS8xbB3bfhwB9utxb+2qyt4K4dSfe7f1y+YqPT8SQvQGyYpFZLvskSt84T9O
         6QIQwfwgE+xqJnP5uVcXxN79NyspnBIIORqKJG9j08oJSCYlYzUiYh2NSh9WBcMAJoHR
         Flzg==
X-Gm-Message-State: AOJu0Yzd5eWtWMAF7GgQeyhU/sD0/iNBaWlNvUZuW5P50T754b/LWhg7
	Xkkr8Pis1KpSpjTMX0who1isHwvSiiewLPp421VaqMhZH9SsqUmo+9qxyq4URg==
X-Gm-Gg: AeBDietxjYhmjGhjzvkFQl4PjLSmS9x/AkQDL5a6irDmF3bUyS7UMLPGgh8CxMuRwvj
	GmVxYqBzMRsutvhwvcEC4cgNHYQVzIpxvm8YyHnoM2EMlvFcK3HKazeUslxYyr1/H3wC32mQCRl
	4peHmkZDQGtKNf9PHN4JvTJJuAJAh0v/qKT42l6aFAIKB0+nZSOMMS1rt1yZWJOId1vHbiqRGIb
	ZChu9JSZOUGPAQXI4IzVUFVH15/qjV0MXO3+Gla56R9Bnmj9RYTVlj1Ze2VRnO+nVVbdlllq5i9
	FzJ9d6mffQl364DTXqxd9BYTsVIGMb9nArYftjwLL6Hx3NU3pCRCFiwN79LkNPvL0T/LoMR8GEc
	J7DtKn3eOowpieGxn1JpIdKA449Vw/UHrX4P+Ut2FumSyb0xovvb0SbChZh47YMneON5voPiC1k
	D1+pihpUwiYErmiPmfrJYIUxQ8TkkzB5GNYlvll3E=
X-Received: by 2002:a05:6000:25c7:b0:43c:f0c0:c571 with SMTP id ffacd0b85a97d-43fe3e12b2bmr20789293f8f.47.1776679953877;
        Mon, 20 Apr 2026 03:12:33 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:293:ab4d:327e:e6dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc375dsm25424997f8f.14.2026.04.20.03.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:12:32 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Apr 2026 12:12:05 +0200
Subject: [PATCH 7/8] refs: add peeled object ID to the `ref_update` struct
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-refs-move-to-generic-layer-v1-7-513e354f376b@gmail.com>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8667; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=0R5pEsVxKQPpjtT5+Od1Zdn+c7c0gFqLPfwhTDcR21o=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnl/AEcR41sGANVrN33ZixL76tJQhfkQomQV
 aOlbSmybtBtS4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp5fwBAAoJED7VnySO
 Rox/dgAL/j9c3jqkb+FcFkHMI1SOoF/8qFraki7+LM2BcZ+boDnFDMYd4rVCVwSrRhR/Ysvw1Gz
 OjEC2vGamX9flFWOh7Dd1OIMoGZJIAK/vUz1MxKdg3MEUFdtxyJOPUXQ1oB82eAlwNguZEJt5jU
 5A3uX0hZmxOZaE0otrKbu0HOXzFTVr0TNXDMr5Dh5Ashw8pny20R9RGrwTABALNqwl0D1U9MYKO
 oKm+6BU8iw5GLl/zugTeM1lz4SlPJplNuHl+uDmSMwt28L3P+NgyE3LbnrLLV+X/9fXTkQuv+Mx
 2XDyrFnnLLXiYwkwhyPWlMaEasJg0tz/NvL+a+OtpDIjzgOY7/X16A58cqY/FR/5L1qq8zBT5s0
 ic4YRNj4iHwOpCf5MjwIavAFAKjwGdJS5bpIWnxchagDqRg6Z6IBbYjKymsaycTK7NBCSpfxhy+
 zzxEkU2NaTqkeC5qz+7qPRPSxb1v+H0rSuyHqz+gdp/lV6E2eWVcRY7vPJabieY+AXj1XjKMDo6
 tU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Certain reference backend {packed, reftable}, have the ability to also
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
index bbe19155f4..63a54c460e 100644
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
index 0e2bbe37a0..c7292a3c17 100644
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
index eed13af4eb..620aeb8320 100644
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
index fdf7336c0f..7416bb72fa 100644
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

