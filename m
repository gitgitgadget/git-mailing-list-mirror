Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680493DF018
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933650; cv=none; b=rQk5fRfmmkAo54mMWCd1Ip/SgyIPn+zoMrCgYCgfiRYQ9qo4VT8sNbItWOiXa7bkiCoCh++AJ9JFn5KQFuBb+UviaG1oFOmSnB4XNWc3I2/yXiJ/v1GuqZAEAYq3sTakpFUWxcOM2KQHNK5cTOV1U1Ky+nUpodxsUUvnsqH5EjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933650; c=relaxed/simple;
	bh=+6xfeucJTyAyMPTK23uW/8Pybtf95KjbKdD39noq2Lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5L9pucEJZ+8+vBEUdGPwN0fqF4aCIMsl/f1T/WXu8SwVJuu9xddpt+LbJtbn3YjCuK0n/yF2o7JfqVMFGiw74S6KRj6E1o6gIAMq21Lx9Fwc+dD5NBDqtEO1sky4sY3HksZYHvNQjcb8fofJ1KH0IKMt8aP9ojO2HZcrDSVRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmeXoEfD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmeXoEfD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b150559bso50569085e9.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933646; x=1777538446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4am7IpxoiTWi/FyJU7Bcrl4lb0EAkznvQR4vPkWnqY=;
        b=hmeXoEfDeN3c2NDvKt6xxeUiRGkNxR0iaDDdCy/TtO2PBsMq8WFZVYs8Bfn8dZ+jVR
         g4JqfeaDRmkc7fSWj2QLRg7u+fdWvpOAB/KKB4EsVqxIpk5shOO36Dz2zw3vvkMXqT7A
         Gust9Udr1dMuxeGjE1xmES49pxgwza/ENB1Mht0BKJLgbQ5kQz9C75BX2/iw47VvG1WB
         wVth4eFKv1WxdhPioQnXBsnvHYwedTm8O4SQFMmWuIBLeS+S6aeO3agsdCSfIyWuwglf
         4p1+dQA/ZztjK+KecoSlpjimt+twNALnFuhzcLgnFkRDxwBJ/I1srttF1RkxAA2QRmX8
         qgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933646; x=1777538446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c4am7IpxoiTWi/FyJU7Bcrl4lb0EAkznvQR4vPkWnqY=;
        b=rxXmDaLeE3f82gA/Ox70h48FZ7c2tZB8NPKl+5oRKO47ibjuolWqcoK15PGrPqEjSO
         xMoiAIQuckpYVPvtlRz85Vs02BnosXlM2W46P1nZMMMzgFDI8JoVLiSZBTBZIns1MzBK
         S45rBtnwg77HXcAhc4rB2sNF6QM6lmpB4T2I8w27Gma8BnLgMKD+LDQyEYwWrZmQZ8GD
         zYYY9dxZWksddT27C4qwULIurKmtar0j4LeTW63hNvHoTkQ3ayJfOOVw07n9Aqn80ZnD
         p5zN7h/9R4c4dvlJS+Aqw8jrOiWPKg5Ca2ts672oT5VQKdgLnrqJ8lw8+G9P+cayU1p4
         xPtw==
X-Gm-Message-State: AOJu0YxRV1b5lUB3EppKqhBIsmmKNmU8fYuooKeb8HukydbErjEhIPQj
	wu5li5zllKzqgrFIWL1QO3Xo0Ek3RjpseiUWCGQQkXSxvoVsm3czg2OF52jvzA==
X-Gm-Gg: AeBDiesUE2oxthESVG0wt5Zf/Ewz88JptsflRSgnhRiVUHp26tzhMAFSdbCcPpTClMm
	YbhMuquHl2moaYVzPPNwViGrq9A3eBO3Y4+/b8e3XAsrdt3u5vBaZz/cXAi0i0aSqugiJb6oALi
	tq19rWIbqvBeSqv/LmMOTGRNAGDFT2jCTiPSdUuMgwjA+YOU4hwKn7uQPiYbIEAiHCoCG9pNOBt
	UdVsSsWYkZ+tKovYsIk8qSWibSZDzq891Y9GV+hBGhSOYKLKTtimF+Tf033Tk7fDgNv4EC+3BaU
	XWhjzSe2TKYUURPA/vFZm7oPFbUsGDr7+KH1jTrZ1IbpkGcKnRGa6LK0o8rBQNK2fw3md0cB+bD
	49TOZMB4K+pqbCsHSvR98gAAJRqms9p4jMcZrrH1PCsr1afaehvKZ5Lwbo0q2J8TfcK2/p63/RR
	Fx60y0m2T2AE7D33WJkGWan/T0oSbuzGFpX1Dpw2UX
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488fb7880camr373818815e9.23.1776933646339;
        Thu, 23 Apr 2026 01:40:46 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1cda:f096:cc8c:a0e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm234286785e9.11.2026.04.23.01.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:40:45 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 23 Apr 2026 10:40:36 +0200
Subject: [PATCH v2 7/9] refs: move object parsing to the generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-refs-move-to-generic-layer-v2-7-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8419; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=+6xfeucJTyAyMPTK23uW/8Pybtf95KjbKdD39noq2Lg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnp2wSoZH5W24oPnuJEaVakS0n8F7Oz5CZuT
 Ku5lnZxG8GqAokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp6dsEAAoJED7VnySO
 Rox/zpEL/RH9dzXRnpglV1rd/bQnsLXKlUpSIKCbO1juJDwVqIh6ofYAHivCDM45MraKFvSCEb1
 yFTXCixZajy43dnNKtKzU5LejWBWa1G9XRmjFx8GTI4ulJX00XIiHLLjJNIhelD2X1DvRmHUYKC
 E8Cd0QybjfiUdgR3uXN4NNutZViRtYTcOPq5SgGdYQiVyaqgXWjcnAeY3tG+UxSOfZsJ83EqkpU
 ohN2Ivqv6iPOoEo/mUo9aFvGFDmPtHERWQa2V3yEtutJyY1+8uSASeR0zzCXkgufqpM6hvOqHEu
 yUSvT3sxSQXxUi1nPqcTz0lNdqVsSc5HYHU8XKmxi9yC5eYEPWEFTBONydpEVrGENqTqDSOmp/R
 vQ8wJfOqcTuSGxCawPkAtc4HpG71QT8yZYfJ+6Wfcmo8BMjnABhAiF1hKnA6gxZ9wQZizh53pt8
 UBj/ihymgCrPHvFEKBYY95xpu4wQ/V+vDiqQLMqswZyzdJPErJQX2SyaxLqKiqobxAWyVPdGVQ5
 Wc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Regular reference updates made via reference transactions validate that
the provided object ID exists in the object database, which is done by
calling 'parse_object()'. This check is done independently by the
backends which leads to duplicated logic.

Let's move this to the generic layer, ensuring the backends only have to
care about reference storage and not about validation of the object IDs.
With this also remove the 'REF_TRANSACTION_ERROR_INVALID_NEW_VALUE'
error type as its no longer used.

Since we don't iterate over individual references in
`ref_transaction_prepare()`, we add this check to
`ref_transaction_update()`. This means that the validation is done as
soon as an update is queued, without needing to prepare the
transaction. It can be argued that this is more ideal, since this
validation has no dependency on the reference transaction being
prepared.

It must be noted that the change in behavior means that this error
cannot be ignored even with usage of batched updates, since this happens
when the update is being added to the transaction. But since the caller
gets specific error codes, they can either abort the transaction or
continue adding other updates to the transaction.

Modify 'builtin/receive-pack.c' to now capture the error type so that
the error propagated to the client stays the same. Also remove two of
the tests which validates batch-updates with invalid new_oid.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c  | 22 +++++++++++++---------
 refs.c                  | 18 ++++++++++++++++++
 refs/files-backend.c    | 28 ++--------------------------
 refs/reftable-backend.c | 19 -------------------
 4 files changed, 33 insertions(+), 54 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 878aa7f0ed..0fb3d57de8 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1641,8 +1641,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			ret = NULL; /* good */
 		}
 		strbuf_release(&err);
-	}
-	else {
+	} else {
+		enum ref_transaction_error err_type;
 		struct strbuf err = STRBUF_INIT;
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si)) {
@@ -1650,14 +1650,18 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			goto out;
 		}
 
-		if (ref_transaction_update(transaction,
-					   namespaced_name,
-					   new_oid, old_oid,
-					   NULL, NULL,
-					   0, "push",
-					   &err)) {
+		err_type = ref_transaction_update(transaction,
+						  namespaced_name,
+						  new_oid, old_oid,
+						  NULL, NULL,
+						  0, "push",
+						  &err);
+		if (err_type) {
 			rp_error("%s", err.buf);
-			ret = "failed to update ref";
+			if (err_type == REF_TRANSACTION_ERROR_GENERIC)
+				ret = "failed to update ref";
+			else
+				ret = ref_transaction_error_msg(err_type);
 		} else {
 			ret = NULL; /* good */
 		}
diff --git a/refs.c b/refs.c
index efa16b739d..662a9e6f9e 100644
--- a/refs.c
+++ b/refs.c
@@ -1416,6 +1416,24 @@ enum ref_transaction_error ref_transaction_update(struct ref_transaction *transa
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
 
+	if ((flags & REF_HAVE_NEW) && !new_target && !is_null_oid(new_oid) &&
+	    !(flags & REF_SKIP_OID_VERIFICATION) && !(flags & REF_LOG_ONLY)) {
+		struct object *o = parse_object(transaction->ref_store->repo, new_oid);
+
+		if (!o) {
+			strbuf_addf(err,
+				    _("trying to write ref '%s' with nonexistent object %s"),
+				    refname, oid_to_hex(new_oid));
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
+		}
+
+		if (o->type != OBJ_COMMIT && is_branch(refname)) {
+			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
+				    oid_to_hex(new_oid), refname);
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
+		}
+	}
+
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_target,
 				   old_target, NULL, msg);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9b1fa955f8..6da0cb4f1b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -19,7 +19,6 @@
 #include "../iterator.h"
 #include "../dir-iterator.h"
 #include "../lockfile.h"
-#include "../object.h"
 #include "../path.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
@@ -1589,7 +1588,6 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
 							struct ref_lock *lock,
 							const struct object_id *oid,
-							int skip_oid_verification,
 							struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
@@ -1737,7 +1735,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(refs, lock, &orig_oid, 0, &err) ||
+	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, logmsg, 0, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
@@ -1755,7 +1753,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto rollbacklog;
 	}
 
-	if (write_ref_to_lockfile(refs, lock, &orig_oid, 0, &err) ||
+	if (write_ref_to_lockfile(refs, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, REF_SKIP_CREATE_REFLOG, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1999,32 +1997,11 @@ static int files_log_ref_write(struct files_ref_store *refs,
 static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
 							struct ref_lock *lock,
 							const struct object_id *oid,
-							int skip_oid_verification,
 							struct strbuf *err)
 {
 	static char term = '\n';
-	struct object *o;
 	int fd;
 
-	if (!skip_oid_verification) {
-		o = parse_object(refs->base.repo, oid);
-		if (!o) {
-			strbuf_addf(
-				err,
-				"trying to write ref '%s' with nonexistent object %s",
-				lock->ref_name, oid_to_hex(oid));
-			unlock_ref(lock);
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-		if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
-			strbuf_addf(
-				err,
-				"trying to write non-commit object %s to branch '%s'",
-				oid_to_hex(oid), lock->ref_name);
-			unlock_ref(lock);
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-	}
 	fd = get_lock_file_fd(&lock->lk);
 	if (write_in_full(fd, oid_to_hex(oid), refs->base.repo->hash_algo->hexsz) < 0 ||
 	    write_in_full(fd, &term, 1) < 0 ||
@@ -2828,7 +2805,6 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 		} else {
 			ret = write_ref_to_lockfile(
 				refs, lock, &update->new_oid,
-				update->flags & REF_SKIP_OID_VERIFICATION,
 				err);
 			if (ret) {
 				char *write_err = strbuf_detach(err, NULL);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 93374d25c2..444b0c24e5 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1081,25 +1081,6 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 		return 0;
 	}
 
-	/* Verify that the new object ID is valid. */
-	if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
-	    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
-	    !(u->flags & REF_LOG_ONLY)) {
-		struct object *o = parse_object(refs->base.repo, &u->new_oid);
-		if (!o) {
-			strbuf_addf(err,
-				    _("trying to write ref '%s' with nonexistent object %s"),
-				    u->refname, oid_to_hex(&u->new_oid));
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-
-		if (o->type != OBJ_COMMIT && is_branch(u->refname)) {
-			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
-				    oid_to_hex(&u->new_oid), u->refname);
-			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
-		}
-	}
-
 	/*
 	 * When we update the reference that HEAD points to we enqueue
 	 * a second log-only update for HEAD so that its reflog is

-- 
2.53.GIT

