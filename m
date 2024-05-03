Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2111C15358C
	for <git@vger.kernel.org>; Fri,  3 May 2024 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740086; cv=none; b=h8AjMnN0RX1uD2bCTnFG8i2KiQRxvi3YIAr6H7S/igwJPohGCCyoIYm34nG8XL7WtYMp0VSdPM1jxr6SITayt/6SflMlaDNuTLvt4OuDpS3sbZ3hp3CMav298FssNZFVENBqHcZqf7DgsfRglBjwbhjN0n6y33QtidPslVzWj7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740086; c=relaxed/simple;
	bh=Kdac1qCpv3UB/wooFqvLJSxfaEvGVimfD4bjGpIcbB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/qxa9aj4T6CYoNAKw1AAFa36ooxP22fV7XODG2PreRn2NGaML4KvIcuaOtu7Yi9wnbwKcS3DyblDtaWJwkYdWD/GY1yrramg7LlWbBL+3soWv2ngzFG1usJwjriGa6o+FIrsBMQZNqiqI+k5Tvlcix690GhMDu8pA4kfMPVyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1ghAnMi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1ghAnMi"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a58fc650f8fso848455166b.1
        for <git@vger.kernel.org>; Fri, 03 May 2024 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714740082; x=1715344882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqLqPassxpwBAxYFxgDxSiwECD7TJs4WuXQZV6qmn3Y=;
        b=Y1ghAnMiKecbtwM/Q85PZRb7t0KPrffkUfTVqDq4vP1CUJP5DW/CNkDjvUHn/67+Zd
         JCLF+Ya2VmnlsIyrnZMvNNjStYPMb3Du+zb6NS1tTVTP8QDUrrFhHd8o/YlJnR8Wok5i
         x/wOixdRawi3Gg9+DZK0+pvSnx5WD7hMKZXbZ/wrIQ6mrZE/6L8NWDbg1SvBIcDlYdo4
         cJmiRDZ1XwI5WJtSKBRckDCKq+tBbmVkRR+4EYcfyGkIq/A7eR9nx7kW3blnyj9PkC4J
         joCvXLidCfMOm3DDWwP3HAJ9rW5quFL6K18FTDVPglHVGvZrPiza0MIYoUqnekae75aJ
         x4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740082; x=1715344882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqLqPassxpwBAxYFxgDxSiwECD7TJs4WuXQZV6qmn3Y=;
        b=hqDBqmGoEo8KlRC95Qqv4g5RRwol5VHD166JCkhLZwKCiDsvIdFllGOvBNpVznXLLM
         9tzCL//3G2r2gALVh5kxn+p4wL5p478mx6HAVhRmNbe9jzF+lMk3CJF6KO21Hs8tA9Bv
         9edQGHm0ol+NWK75acqD2JzaPHYAJngcc9Ht1+2MWoWuhvYq6vL+0YnQlgq8asm3fzGZ
         QdyDpo1siW7MpRxtvTrxt1bo6JY1MgE/aTv7VzqKvUlRClZNdUZRLOHz39yqTul43Lwx
         eSBAbBnBlAwCVjruypDSNQUPl2ldrZf2LriUxYn5v7G8/HJ3w80Ov1Di877mwKnN9fvt
         cYrA==
X-Forwarded-Encrypted: i=1; AJvYcCXw4YVoa2R8FQsrS/SvPKpC8+1PsiFEodDB0Q6dXE5L7tzOKlirj2cW4xp/kOar9+MAna6RubdchCNWq03016IMuOUJ
X-Gm-Message-State: AOJu0YxN0ZqXgksHEb/xMhiftNyiv/ZzH3K4UU3fJH6mYiaxAphVjEo8
	vc/d0KP/pGzadMI8eHAk3H46/0HBp4PN/CLOkDdrtR1/hlKJs0e4
X-Google-Smtp-Source: AGHT+IEyImSp96s1kOgn9IutfwbWS4qqMATw7msuLcd+8lubxnFwsCZ2N3ZPwhDvOia7F3d7Vy+j7Q==
X-Received: by 2002:a17:907:762f:b0:a59:9c4d:da39 with SMTP id jy15-20020a170907762f00b00a599c4dda39mr420856ejc.45.1714740082272;
        Fri, 03 May 2024 05:41:22 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id ot38-20020a170906cce600b00a5994c5c948sm533323ejb.133.2024.05.03.05.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:41:21 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v6 4/7] refs: add support for transactional symref updates
Date: Fri,  3 May 2024 14:41:12 +0200
Message-ID: <20240503124115.252413-5-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240503124115.252413-1-knayak@gitlab.com>
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
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

Here, we add and use `ref_update_has_null_new_value()`, a helper
function which is used to check if there is a new_value in a reference
update. The new value could either be a symref target `new_target` or a
OID `new_oid`.

With this, now transactional updates (verify, create, delete, update)
can be used for:
- regular refs
- symbolic refs
- conversion of regular to symbolic refs and vice versa

This also allows us to expose this to users via new commands in
'git-update-ref' in the future.

Note that a dangling symref update does not record a new reflog entry,
which is unchanged before and after this commit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  |  15 ++++-
 refs/files-backend.c    | 137 ++++++++++++++++++++++++++++++++++------
 refs/refs-internal.h    |   7 ++
 refs/reftable-backend.c |  77 +++++++++++++++++-----
 4 files changed, 198 insertions(+), 38 deletions(-)

diff --git a/refs.c b/refs.c
index 203a101988..acb153b6f8 100644
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
@@ -1247,10 +1249,13 @@ struct ref_update *ref_transaction_add_update(
 
 	update->flags = flags;
 
-	if (flags & REF_HAVE_NEW)
+	update->new_target = xstrdup_or_null(new_target);
+	update->old_target = xstrdup_or_null(old_target);
+	if ((flags & REF_HAVE_NEW) && new_oid)
 		oidcpy(&update->new_oid, new_oid);
-	if (flags & REF_HAVE_OLD)
+	if ((flags & REF_HAVE_OLD) && old_oid)
 		oidcpy(&update->old_oid, old_oid);
+
 	update->msg = normalize_reflog_message(msg);
 	return update;
 }
@@ -1286,6 +1291,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
 
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
+	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_target,
@@ -2814,3 +2820,8 @@ int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg
 {
 	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
+
+int ref_update_has_null_new_value(struct ref_update *update)
+{
+	return !update->new_target && is_null_oid(&update->new_oid);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 74a713090c..e1f0ca74c0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2434,6 +2434,36 @@ static const char *original_update_refname(struct ref_update *update)
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
@@ -2494,7 +2524,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
 
-	if ((update->flags & REF_HAVE_NEW) && is_null_oid(&update->new_oid))
+	if ((update->flags & REF_HAVE_NEW) && ref_update_has_null_new_value(update))
 		update->flags |= REF_DELETING;
 
 	if (head_ref) {
@@ -2537,7 +2567,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2558,7 +2595,17 @@ static int lock_ref_for_update(struct files_ref_store *refs,
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
@@ -2576,9 +2623,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		}
 	}
 
-	if ((update->flags & REF_HAVE_NEW) &&
-	    !(update->flags & REF_DELETING) &&
-	    !(update->flags & REF_LOG_ONLY)) {
+	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
+		if (create_symref_lock(refs, lock, update->refname, update->new_target, err)) {
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
@@ -2841,6 +2906,43 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	return ret;
 }
 
+static int parse_and_write_reflog(struct files_ref_store *refs,
+				  struct ref_update *update,
+				  struct ref_lock *lock,
+				  struct strbuf *err)
+{
+	if (update->new_target) {
+		/*
+		 * We want to get the resolved OID for the target, to ensure
+		 * that the correct value is added to the reflog.
+		 */
+		if (!refs_resolve_ref_unsafe(&refs->base, update->new_target,
+					     RESOLVE_REF_READING,
+					     &update->new_oid, NULL)) {
+			/*
+			 * TODO: currently we skip creating reflogs for dangling
+			 * symref updates. It would be nice to capture this as
+			 * zero oid updates however.
+			 */
+			return 0;
+		}
+	}
+
+	if (files_log_ref_write(refs, lock->ref_name, &lock->old_oid,
+				&update->new_oid, update->msg, update->flags, err)) {
+		char *old_msg = strbuf_detach(err, NULL);
+
+		strbuf_addf(err, "cannot update the ref '%s': %s",
+			    lock->ref_name, old_msg);
+		free(old_msg);
+		unlock_ref(lock);
+		update->backend_data = NULL;
+		return -1;
+	}
+
+	return 0;
+}
+
 static int files_transaction_finish(struct ref_store *ref_store,
 				    struct ref_transaction *transaction,
 				    struct strbuf *err)
@@ -2871,23 +2973,20 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
-			if (files_log_ref_write(refs,
-						lock->ref_name,
-						&lock->old_oid,
-						&update->new_oid,
-						update->msg, update->flags,
-						err)) {
-				char *old_msg = strbuf_detach(err, NULL);
-
-				strbuf_addf(err, "cannot update the ref '%s': %s",
-					    lock->ref_name, old_msg);
-				free(old_msg);
-				unlock_ref(lock);
-				update->backend_data = NULL;
+			if (parse_and_write_reflog(refs, update, lock, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
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
index 108f4ec419..03eda70ea4 100644
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
+int ref_update_has_null_new_value(struct ref_update *update);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6104471199..54c4d8b771 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -856,7 +856,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			 * There is no need to write the reference deletion
 			 * when the reference in question doesn't exist.
 			 */
-			 if (u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) {
+			 if ((u->flags & REF_HAVE_NEW) && !ref_update_has_null_new_value(u)) {
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
+		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
 			if (is_null_oid(&u->old_oid))
 				strbuf_addf(err, _("cannot lock ref '%s': "
 					    "reference already exists"),
@@ -1043,7 +1060,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		 * - `core.logAllRefUpdates` tells us to create the reflog for
 		 *   the given ref.
 		 */
-		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
+		if ((u->flags & REF_HAVE_NEW) && !(u->type & REF_ISSYMREF) && ref_update_has_null_new_value(u)) {
 			struct reftable_log_record log = {0};
 			struct reftable_iterator it = {0};
 
@@ -1084,24 +1101,50 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			   (u->flags & REF_FORCE_CREATE_REFLOG ||
 			    should_write_log(&arg->refs->base, u->refname))) {
 			struct reftable_log_record *log;
+			int create_reflog = 1;
+
+			if (u->new_target) {
+				if (!refs_resolve_ref_unsafe(&arg->refs->base, u->new_target,
+							     RESOLVE_REF_READING, &u->new_oid, NULL)) {
+					/*
+					 * TODO: currently we skip creating reflogs for dangling
+					 * symref updates. It would be nice to capture this as
+					 * zero oid updates however.
+					 */
+					create_reflog = 0;
+				}
+			}
 
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
+		if (u->new_target) {
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
+		} else if ((u->flags & REF_HAVE_NEW) && ref_update_has_null_new_value(u)) {
 			struct reftable_ref_record ref = {
 				.refname = (char *)u->refname,
 				.update_index = ts,
-- 
2.43.GIT

