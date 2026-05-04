Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF023E4C72
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916663; cv=none; b=AEG9yuQn8gLDrRQ8TQavUYJ4pWTLneHlxhhrHf8o2e/bjm0sq8uCpgN0kqAbPjrbYtjbaKHbSh+4Llfodzia5OOudNNopXYWVRUn8VZrU+xlDA2+W26h0CDb+me7AHh9YwdNamK5HnJ1HBSkUS8250cM2lpUFHDRBCpl7uT+Z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916663; c=relaxed/simple;
	bh=vHuE9xcmJvA8OVWyC/C6XRdm6hcM9u6JOXER3fQVavE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5KV4ZKXvEYjYoFTJaC2er4F0eyMSlbmCF2gQGjemXL1Im9W8Wo0TKXBXuXNwHL528DpuGBtSERrv75zEz/i4x3T6f5YuUP0nkzV3I8J+5OWXCYh+IKVPvBVHGsaQMHfs0M3IM3d0AG35nT2nwPvcQBpW41KZanKaOY8FlZPqsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt8dpEjJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt8dpEjJ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso36367175e9.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916659; x=1778521459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8hZYT1OLW7iSEmHmP7RSx2w6+SC2ir3sIq8N1bcmxI=;
        b=Zt8dpEjJM+NqfRozFAN+HN5cz7BlmtPwLNjQy8eXXhjG6cOKEAWYHBoFhKL1k8qJ9p
         N48EnOv499W9MX3YcbrISmOj/Ba6hfzRFoqLaqjySnmyQ2kBu1ocmO55dMFslsa/PPbb
         nQLBqY0tWnaX1/tygqkIIkccnirSKyvIAkIL6tet5wuMD9bS9QfZZhOtIHUSCyv0Gd42
         ZIR/glAbB/vonrnqEu+GDoSOHqgiIYKuH3gdIH4ixlPMvavIWl7mH/Qq9K6FH3vSfqbm
         cDkYoE7UEaDOGddGabQzoPUnibFLSkC2GTQqMfdCrSJ4GVEt3v7w8OJKhCnxbHAF3B6z
         XZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916659; x=1778521459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y8hZYT1OLW7iSEmHmP7RSx2w6+SC2ir3sIq8N1bcmxI=;
        b=PKAI6k0yjML6WP64Xge+vRYcZWTUFHcwBchsTHLsOPlx0Loqz2rjhPZklmM6C/bSmz
         iNYXrD0x1Pel6I53iwpOTk2KF0W8f9PrNpR8ubsjOPgOimANt6BUgHPdiErpk6HsFVFW
         3JnsWampOmg3PSlZIQbgwqxecFBOdA42Uy6cvZfd2tTzFIr0uu24TnSVsvPTeLHrP8bz
         yX5iV55kO8kBPPZdl/2IBBCniEJXlrx39XaXhWoJ7MtleR9O94nTyzYhlzyCqb/gNGyp
         POyTof2p5LYhLb+fLyizGmUWodVoT0lXrL6YkiWYnCyKWqubB+PJC2k6/sTM62tBTkR9
         3TuA==
X-Gm-Message-State: AOJu0Yxz8yetgArXrhUYha5R3uMDQHok5GVqtTP/S/9wk7E43DbrwHHP
	GtMQd7TpNXZczn21jYOgOkW/1xr5r2LUbq03OrMUIEp6oL7bc+ZtfDCZ
X-Gm-Gg: AeBDievZy34kJR3GlfAnRa13HD0MWMmutFtR9alvUl1+oqQEnPkaGcMc6YTm8DVTqzY
	K0t65wUSuoeU03Qr5x/qO1WAMZAgiYeT1AW+XReg0TMVBBl/8za8yR2FwvNMzbizjY/uC42jho/
	WBp6ILxQNNUAcnEXWLhBYvta7bMc9ung7awUgRRwpSCLapyfFCDK6JpAuSaKiaZcWLv+lXJPwbZ
	imBAjKi4/5qPg+uE889Z8GzAkJGufCP4I1YDbA4EBxSavoYn4oVbSyFExviwtu3oizjG24U9I78
	YrXaNAo9EnTEKMcJSLr3GKSbeexnEuyJnkbhZkYqpKzPdFjhX660l8bBShK1Ge4lUgLkPejmCSa
	VolfFfYC+YdrxJJQ/vMAk4Vj+GiVw7jZfBd25/dJZ6/ZtGGj+f195vXaD8yLeZeIHPBtMxblUPT
	MfnmtFQPEp9Qbi5ugJxlZ33WWytD881x3MXMPshHJu
X-Received: by 2002:a05:600c:4f42:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-48a9852cc26mr187239175e9.2.1777916659492;
        Mon, 04 May 2026 10:44:19 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1f8b:93fc:106a:20a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm299297675e9.7.2026.05.04.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:44:18 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 04 May 2026 19:44:11 +0200
Subject: [PATCH v4 7/9] refs: move object parsing to the generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-refs-move-to-generic-layer-v4-7-936ac2f0b1a3@gmail.com>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
In-Reply-To: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9567; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=vHuE9xcmJvA8OVWyC/C6XRdm6hcM9u6JOXER3fQVavE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGn42urDEmhenCAy4/puZOmREs+CtwAD1Knl9
 uQdwR6GxKyMbokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp+NrqAAoJED7VnySO
 Rox/CYYL/25xMAvTgTZRnJWm54gdSgDKHmuBBSxzXrv6+XdrwNNZGwfbtBDa98lgJ0UosygJ2cf
 714xWO3+/h90kAKYEO1JgMeOobUQQPndbnCcmEymA3qISpdKSUP+H3PF8kPbgrEye1Ayp3E4lKo
 fYVlduVJKtLkQMarrzngLGC3DEZU8zXfM22yUkOkP10W9qd8eeQUU46cWhaYJXkYoEuDTF62o+E
 I1ylaskNFPYvyIwcPxAeP+ZLUPcp4rk4jgG1iViCcwj/JJHFtuve9MiIt4mGhfD45Cgooet++zn
 S2WLt4l5eOFjAborAfF1aq9CR8DjH9OHTlNj9bc58Gt1Or4Au8Gn7sYxyHtG0IHlJrXfjge6hwA
 O4cu3Awr1QrUQRoPfW/RdUHoqX6GxDIoWs0PnoxINUqCRDFsHXLo/duLurPiqGA+V9Ed2I+L9da
 7UayP8M2U65M0rgtvsTcQV8yIS053JfXKJYAvOo57CetMofKO9ToUgNeOgVydLGLF4xI8SD9gC6
 Ks=
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
 t/t1400-update-ref.sh   | 14 ++++++++++++++
 5 files changed, 47 insertions(+), 54 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 878aa7f0ed..376e755e97 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1641,8 +1641,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			ret = NULL; /* good */
 		}
 		strbuf_release(&err);
-	}
-	else {
+	} else {
+		enum ref_transaction_error tx_err;
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
+		tx_err = ref_transaction_update(transaction,
+						  namespaced_name,
+						  new_oid, old_oid,
+						  NULL, NULL,
+						  0, "push",
+						  &err);
+		if (tx_err) {
 			rp_error("%s", err.buf);
-			ret = "failed to update ref";
+			if (tx_err == REF_TRANSACTION_ERROR_GENERIC)
+				ret = "failed to update ref";
+			else
+				ret = ref_transaction_error_msg(tx_err);
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
index 4b2faf4777..f20f580fbc 100644
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
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b2858a9061..1015f335e3 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1196,6 +1196,20 @@ test_expect_success 'stdin -z create ref fails with empty new value' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
+test_expect_success 'stdin -z create ref fails with non commit object' '
+	printf $F "create $c" "$(test_oid 001)" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: trying to write ref ${SQ}$c${SQ} with nonexistent object" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success 'stdin -z update ref fails with non commit object' '
+	printf $F "update $b" "$(test_oid 001)" "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: trying to write ref ${SQ}$b${SQ} with nonexistent object" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
 test_expect_success 'stdin -z update ref works with right old value' '
 	printf $F "update $b" "$m~1" "$m" >stdin &&
 	git update-ref -z --stdin <stdin &&

-- 
2.53.GIT

