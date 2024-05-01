Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A81165FA9
	for <git@vger.kernel.org>; Wed,  1 May 2024 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714594961; cv=none; b=bkRhnYx6SGZr1nxAX5SPe3f3CB7vdTI3HLPTkBS5Oq4M6TbbyB4WED1StBwERDwpDkb/r+WsezjR5RJMYeCwefgU8JR9TG2AjnxTetWL/pbABCzD+uurDGgvq+97L1oimp8B4Km6WCWJZgcEjeoTIr5pZlFPDO1nroGknLzeg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714594961; c=relaxed/simple;
	bh=hPE9u1jHV/ZlJc6bi7GdWIOTGe+hVR5vsr75Ayi1pb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNeVOn+yrBiVAwluhHDcY1AzvhyYkruR8wb1+62IRQcUqBRA2N/RX6jD0n2tm8J6dwMxSgGPbHGYrb12KEiPwPbPDCOSJOr64pYvBDIyDjah5jpIA56jG3MOHHdcdhgErCgW47P0YEOerQteTZNTyJBEyuV5tWkr/zDi3jYI1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlNjqpUT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlNjqpUT"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5966ea4fafso32997566b.0
        for <git@vger.kernel.org>; Wed, 01 May 2024 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714594957; x=1715199757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1SCUSkwYr2VwsaLLLA5lCN9sztYheV4W4nqiY+4kUE=;
        b=OlNjqpUTVBpoajVqG1r4Yn48aagw+jzKe6hKsj+kzfmm9ku6KJXBa2PnQi+jZ+a0CP
         VW2PKa4ZxFwiqcAe3Pf1ETR9I1Xl90m4OMwDXL/jhIXG0CIl0D/eVaeeqzPGTrv4gtzV
         7Vc1kcwu8QcUBKKRDDW5RC5y98QA2tk2JaRofaClsAAUMXrYNep+5hhGTt7GP6i+NNRD
         Ta6QTzKxQKIw1aSQUgZ5/7aZ7mcTaIZb3K5DbyAA1PaR+EvNycDZZKT1e2zneixtnW+k
         0QoY0J9o9YPb0supasF19uRDN+COMDb7PAqjhfo04qd8tAbhWop1DCq9GMQaaKbgo6Sp
         1mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714594957; x=1715199757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1SCUSkwYr2VwsaLLLA5lCN9sztYheV4W4nqiY+4kUE=;
        b=g1yWgnwm/+aM1QApZWFoJxJxxsGRqeO/oC6S/VtIoMs/g+xGLdsL/MIfXak427Dhx2
         c+CeESLJ07wQei9XeXJk4KNi87AaDsjjQL1UrPT9bZUt4Nu0812vVc12Armc7OtsB0v0
         qOHfscHjrc9XS4RIwYkKq4+eHRI94VZOct22Mo2zAWBCwBXZogY5aZSqBfx98Zj38it7
         5sdxtSU6Wire6E/flUX/6hUJET65GAYXo9XoFp7EusYnNb7K46BCqCYAhK6/O9/+TtOG
         Lwixjz+N6TwpfQLrcVuClenHea1EhPfklqMZMHBsmqfQ6g9lIbdwiVHsQGTUK9VXKAJe
         LFag==
X-Forwarded-Encrypted: i=1; AJvYcCVkBuZAWaH2vwjAy0A+CGCn/gkawf+1rw8E/+JJq4Og1uVBRtoV6eXW2FTzA8vcE8VX2uGqMn7YftW5EvZiou04P4Hn
X-Gm-Message-State: AOJu0YxZr2ETgRi9KRFq0gQf6wSgAPCR5LZzDuZoEJ2x6yrIJ6PElibr
	CgLJoT++DnDT64YqwjTYp8NKGU18LAwO8KLoQDy1v3kNnq92VHIPNN1r8g==
X-Google-Smtp-Source: AGHT+IEUscNws2tas3tPAnmu1nEa125z3d/zbTBHWffNX4XQcFWDqtxy2/i+eg/zGHWrrR3FtbzbLg==
X-Received: by 2002:a17:907:1047:b0:a4e:24e6:9880 with SMTP id oy7-20020a170907104700b00a4e24e69880mr465045ejb.33.1714594957319;
        Wed, 01 May 2024 13:22:37 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8270:9642:2bfa:e177])
        by smtp.gmail.com with ESMTPSA id hg25-20020a170906f35900b00a58eec6f5acsm5290686ejb.102.2024.05.01.13.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:22:36 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 4/7] refs: add support for transactional symref updates
Date: Wed,  1 May 2024 22:22:26 +0200
Message-ID: <20240501202229.2695774-5-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501202229.2695774-1-knayak@gitlab.com>
References: <20240426152449.228860-1-knayak@gitlab.com>
 <20240501202229.2695774-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The reference backends currently support transactional reference
updates. While this is exposed to users via 'git-update-ref' and its
'--stdin' mode, it is also used internally within various commands.

However, we never supported transactional updates of symrefs. Let's add
support for symrefs in both the 'files' and the 'reftable' backend.

Here, we add and use `ref_update_is_null_new_value()`, a helper function
which is used to check if there is a new_value in a reference update.
The new value could either be a symref target `new_target` or a OID
`new_oid`.

With this, now transactional updates (verify, create, delete, update)
can be used for:
- regular refs
- symbolic refs
- conversion of regular to symbolic refs and vice versa

This also allows us to expose this to users via new commands in
'git-update-ref' in the future.

We do not add reflog for dangling symref updates, because currently
'git-symbolic-ref' doesn't add reflog for dangling symref updates and it
would be best to keep this behavior consistent as we would move it to
start using transaction based updates in the following commit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  17 +++++-
 refs/files-backend.c    | 112 +++++++++++++++++++++++++++++++++++-----
 refs/refs-internal.h    |   7 +++
 refs/reftable-backend.c |  71 +++++++++++++++++++------
 4 files changed, 176 insertions(+), 31 deletions(-)

diff --git a/refs.c b/refs.c
index 5dfe93060a..a4dca08244 100644
--- a/refs.c
+++ b/refs.c
@@ -1217,6 +1217,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
+		free((char *)transaction->updates[i]->new_target);
+		free((char *)transaction->updates[i]->old_target);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -1247,10 +1249,15 @@ struct ref_update *ref_transaction_add_update(
 
 	update->flags = flags;
 
-	if (flags & REF_HAVE_NEW)
+	if (new_target)
+		update->new_target = xstrdup(new_target);
+	if (old_target)
+		update->old_target = xstrdup(old_target);
+	if (new_oid && flags & REF_HAVE_NEW)
 		oidcpy(&update->new_oid, new_oid);
-	if (flags & REF_HAVE_OLD)
+	if (old_oid && flags & REF_HAVE_OLD)
 		oidcpy(&update->old_oid, old_oid);
+
 	update->msg = normalize_reflog_message(msg);
 	return update;
 }
@@ -1286,6 +1293,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
 
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
+	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_target,
@@ -2810,3 +2818,8 @@ int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg
 {
 	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
+
+int ref_update_is_null_new_value(struct ref_update *update)
+{
+	return !update->new_target && is_null_oid(&update->new_oid);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 878601ced0..85c4af7e89 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2426,6 +2426,36 @@ static const char *original_update_refname(struct ref_update *update)
 	return update->refname;
 }
 
+/*
+ * Check whether the old_target values stored in update are consistent
+ * with current_target, which is the symbolic reference's current value.
+ * If everything is OK, return 0; otherwise, write an error message to
+ * err and return -1.
+ */
+static int check_old_target(struct ref_update *update,
+			    const char *current_target,
+			    struct strbuf *err)
+{
+	if (!update->old_target)
+		BUG("called without old_target set");
+
+	if (!strcmp(update->old_target, current_target))
+		return 0;
+
+	if (!strcmp(current_target, ""))
+		strbuf_addf(err, "cannot lock ref '%s': "
+			    "reference is missing but expected %s",
+			    original_update_refname(update),
+			    update->old_target);
+	else
+		strbuf_addf(err, "cannot lock ref '%s': "
+			    "is at %s but expected %s",
+			    original_update_refname(update),
+			    current_target, update->old_target);
+
+	return -1;
+}
+
 /*
  * Check whether the REF_HAVE_OLD and old_oid values stored in update
  * are consistent with oid, which is the reference's current value. If
@@ -2486,7 +2516,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
 
-	if ((update->flags & REF_HAVE_NEW) && is_null_oid(&update->new_oid))
+	if ((update->flags & REF_HAVE_NEW) && ref_update_is_null_new_value(update))
 		update->flags |= REF_DELETING;
 
 	if (head_ref) {
@@ -2529,7 +2559,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto out;
 				}
-			} else if (check_old_oid(update, &lock->old_oid, err)) {
+			}
+
+			if (update->old_target) {
+				if (check_old_target(update, referent.buf, err)) {
+					ret = TRANSACTION_GENERIC_ERROR;
+					goto out;
+				}
+			} else if  (check_old_oid(update, &lock->old_oid, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto out;
 			}
@@ -2550,7 +2587,17 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	} else {
 		struct ref_update *parent_update;
 
-		if (check_old_oid(update, &lock->old_oid, err)) {
+		/*
+		 * Even if the ref is a regular ref, if `old_target` is set, we
+		 * check the referent value. Ideally `old_target` should only
+		 * be set for symrefs, but we're strict about its usage.
+		 */
+		if (update->old_target) {
+			if (check_old_target(update, referent.buf, err)) {
+				ret = TRANSACTION_GENERIC_ERROR;
+				goto out;
+			}
+		} else if  (check_old_oid(update, &lock->old_oid, err)) {
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
 		}
@@ -2568,9 +2615,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		}
 	}
 
-	if ((update->flags & REF_HAVE_NEW) &&
-	    !(update->flags & REF_DELETING) &&
-	    !(update->flags & REF_LOG_ONLY)) {
+	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
+		if (create_symref_lock(refs, lock, update->refname, update->new_target)) {
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
+		}
+
+		if (close_ref_gently(lock)) {
+			strbuf_addf(err, "couldn't close '%s.lock'",
+				    update->refname);
+			ret = TRANSACTION_GENERIC_ERROR;
+			goto out;
+		}
+
+		/*
+		 * Once we have created the symref lock, the commit
+		 * phase of the transaction only needs to commit the lock.
+		 */
+		update->flags |= REF_NEEDS_COMMIT;
+	} else if ((update->flags & REF_HAVE_NEW) &&
+		   !(update->flags & REF_DELETING) &&
+		   !(update->flags & REF_LOG_ONLY)) {
 		if (!(update->type & REF_ISSYMREF) &&
 		    oideq(&lock->old_oid, &update->new_oid)) {
 			/*
@@ -2863,12 +2928,26 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
-			if (files_log_ref_write(refs,
-						lock->ref_name,
-						&lock->old_oid,
-						&update->new_oid,
-						update->msg, update->flags,
-						err)) {
+			int create_reflog = 1;
+
+			if (update->new_target) {
+				/*
+				 * We want to get the resolved OID for the target, to ensure
+				 * that the correct value is added to the reflog.
+				 */
+				if (!refs_resolve_ref_unsafe(&refs->base, update->new_target,
+							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
+					/* for dangling symrefs we skip creating a reflog entry. */
+					create_reflog = 0;
+				}
+			}
+
+			if (create_reflog && files_log_ref_write(refs,
+								 lock->ref_name,
+								 &lock->old_oid,
+								 &update->new_oid,
+								 update->msg, update->flags,
+								 err)) {
 				char *old_msg = strbuf_detach(err, NULL);
 
 				strbuf_addf(err, "cannot update the ref '%s': %s",
@@ -2880,6 +2959,15 @@ static int files_transaction_finish(struct ref_store *ref_store,
 				goto cleanup;
 			}
 		}
+
+		/*
+		 * We try creating a symlink, if that succeeds we continue to the
+		 * next update. If not, we try and create a regular symref.
+		 */
+		if (update->new_target && prefer_symlink_refs)
+			if (!create_ref_symlink(lock, update->new_target))
+				continue;
+
 		if (update->flags & REF_NEEDS_COMMIT) {
 			clear_loose_ref_cache(refs);
 			if (commit_ref(lock)) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 108f4ec419..9578665243 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -749,4 +749,11 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
  */
 struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store);
 
+/*
+ * Helper function to check if the new value is null, this
+ * takes into consideration that the update could be a regular
+ * ref or a symbolic ref.
+ */
+int ref_update_is_null_new_value(struct ref_update *update);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6104471199..5e8a696d40 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -856,7 +856,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			 * There is no need to write the reference deletion
 			 * when the reference in question doesn't exist.
 			 */
-			 if (u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) {
+			 if (u->flags & REF_HAVE_NEW && !ref_update_is_null_new_value(u)) {
 				 ret = queue_transaction_update(refs, tx_data, u,
 								&current_oid, err);
 				 if (ret)
@@ -907,8 +907,10 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 * intertwined with the locking in files-backend.c.
 				 */
 				new_update = ref_transaction_add_update(
-						transaction, referent.buf, new_flags,
-						&u->new_oid, &u->old_oid, NULL, NULL, u->msg);
+					transaction, referent.buf, new_flags,
+					&u->new_oid, &u->old_oid, u->new_target,
+					u->old_target, u->msg);
+
 				new_update->parent_update = u;
 
 				/*
@@ -938,7 +940,22 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		 * individual refs. But the error messages match what the files
 		 * backend returns, which keeps our tests happy.
 		 */
-		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
+		if (u->old_target) {
+			if (strcmp(referent.buf, u->old_target)) {
+				if (!strcmp(referent.buf, ""))
+					strbuf_addf(err, "verifying symref target: '%s': "
+						    "reference is missing but expected %s",
+						    original_update_refname(u),
+						    u->old_target);
+				else
+					strbuf_addf(err, "verifying symref target: '%s': "
+						    "is at %s but expected %s",
+						    original_update_refname(u),
+						    referent.buf, u->old_target);
+				ret = -1;
+				goto done;
+			}
+		} else if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
 			if (is_null_oid(&u->old_oid))
 				strbuf_addf(err, _("cannot lock ref '%s': "
 					    "reference already exists"),
@@ -1043,7 +1060,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		 * - `core.logAllRefUpdates` tells us to create the reflog for
 		 *   the given ref.
 		 */
-		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
+		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && ref_update_is_null_new_value(u)) {
 			struct reftable_log_record log = {0};
 			struct reftable_iterator it = {0};
 
@@ -1084,24 +1101,44 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			   (u->flags & REF_FORCE_CREATE_REFLOG ||
 			    should_write_log(&arg->refs->base, u->refname))) {
 			struct reftable_log_record *log;
+			int create_reflog = 1;
 
-			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
-			log = &logs[logs_nr++];
-			memset(log, 0, sizeof(*log));
-
-			fill_reftable_log_record(log);
-			log->update_index = ts;
-			log->refname = xstrdup(u->refname);
-			memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
-			memcpy(log->value.update.old_hash, tx_update->current_oid.hash, GIT_MAX_RAWSZ);
-			log->value.update.message =
-				xstrndup(u->msg, arg->refs->write_options.block_size / 2);
+			if (u->new_target)
+				if (!refs_resolve_ref_unsafe(&arg->refs->base, u->new_target,
+							     RESOLVE_REF_READING, &u->new_oid, NULL))
+					/* for dangling symrefs we skip creating reflog */
+					create_reflog = 0;
+
+			if (create_reflog) {
+				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
+				log = &logs[logs_nr++];
+				memset(log, 0, sizeof(*log));
+
+				fill_reftable_log_record(log);
+				log->update_index = ts;
+				log->refname = xstrdup(u->refname);
+				memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
+				memcpy(log->value.update.old_hash, tx_update->current_oid.hash, GIT_MAX_RAWSZ);
+				log->value.update.message =
+					xstrndup(u->msg, arg->refs->write_options.block_size / 2);
+			}
 		}
 
 		if (u->flags & REF_LOG_ONLY)
 			continue;
 
-		if (u->flags & REF_HAVE_NEW && is_null_oid(&u->new_oid)) {
+		if (u->flags & REF_HAVE_NEW && u->new_target) {
+			struct reftable_ref_record ref = {
+				.refname = (char *)u->refname,
+				.value_type = REFTABLE_REF_SYMREF,
+				.value.symref = (char *)u->new_target,
+				.update_index = ts,
+			};
+
+			ret = reftable_writer_add_ref(writer, &ref);
+			if (ret < 0)
+				goto done;
+		} else if (u->flags & REF_HAVE_NEW && ref_update_is_null_new_value(u)) {
 			struct reftable_ref_record ref = {
 				.refname = (char *)u->refname,
 				.update_index = ts,
-- 
2.43.GIT

