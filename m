Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B3264FBF
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102295; cv=none; b=cPXgWrfONXt7+UaLoDG1qzclfu6KYcYaaC0do0+wijVlf8W0R5JMrMTJO/WHCHL4bulWojJVeUDniuDKUeax70doloQ3jPjElkpAE8W2+hy17MfGm4HzIIaY+iQW/ljb34NIySbNhPtXXG3/Io3dL1ytB2mo/o4YtprEo8euj7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102295; c=relaxed/simple;
	bh=UM/HroVHy22hooAgswXx1SK1tiPU/84gVkaE6FAIEvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhJ9VRwaa4MS6uhHpRMxuJCNSICEk2pfFXDWTJn9gd77UTGvOU88TTbtnCIQvqVc1c26qZLkdiSRLS7RLih3iCHkqbG/MddKPHg318pg21DmSmihEftIBK6uV+aeiK/7oGi6srn5KLLOQtLeW/1jL2Mt5FV8hd9Y04L/yA1jE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Li272KaL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li272KaL"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so8296946a12.3
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102290; x=1744707090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqfvu/l5oTsK7EkTSAgjq4l96XpsQFoUM2Bbv4DoduY=;
        b=Li272KaL5VAxpw2KxRudzYDeK7bAL5sp3BQXO4YMgMLrP3fdodZjjw004TQKpmhTT6
         Q89xMEtXKdI6aVcYtybaApHTV2zWkfu73UwwnGfSG1HI938dpKzi5K2aexpL+901QpKJ
         4n/kCpC/nH7PNo/60fmeDzKkb5y/HY+OYuE2WuaVmT+B3V+aZ891yQvkZHfAHrI3mW+d
         7HY+5f1IkSr8+GwxvtrNDCO33VqrvNYmLM/KHSCt5Iymd9iA0euA0NeQ8V5sAc3gUTOm
         izlFdiCi8aKpATnDyh5Jq0Qkuh/nu6Ihh+OEAWOI/R7rTGULe8/cUJmqnaOrakAOuCA6
         8S8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102290; x=1744707090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqfvu/l5oTsK7EkTSAgjq4l96XpsQFoUM2Bbv4DoduY=;
        b=NqJPQ4YbDR5JNlYP4CHnzi3c9AE15R2fKeO+6/FHmwLlxP5x7iBK9fIFA50PImcuC2
         wvWZkuJFzIDtdJr+kqIOE8eTDokhyJAEKWlciG5i7Yos5lChiqVlBf3eNrBCh70oRI43
         C/GJc0Pz/3bE7UujV2+L0Y1sb4mDAKt3kwpojPDmsgzPsqEXiYycWvUTbc5YVB3ctRMG
         3gRc3BQSYX18GNeeZsJmSsqU+7leaFtHguuj2wZeFA/BE0Pgj6O0C9vLisEuwJJxUqTW
         9ipZUmGR/mx67RyJuK57lf2/zrL0QLiwferva7Hkz9ysnwtJNzm9iD3uU3DIUWwVE7aV
         Fafg==
X-Gm-Message-State: AOJu0YwI8LihjpPZbIOMLo49Rjh23k5Cb1+XGELVPE7cZWHNYsBsl++2
	ATuTr74hSnRDOZ+Bg0wx68w8SFsRMRr1QDesdxFPksFb5voaYJsO
X-Gm-Gg: ASbGncvt7IkNDIPsSS2H99OX2Sb9oaPMeb4chzLbnJmqP+I1MNe8UdWeddBqu2lFtat
	DFBLyKcK1btikbPCVII6L3vUBcCLWbhC9lD0MgTWBxJIlBXrS6rud7JNOuYsE6Nwav3BA50mgc+
	ZNwOF3+5ow8K25rEiEKQiUUSAta7njLVaOaGCjDMsRHLAsCTWn+EkwpdsNnTEgr78oj7ZzlbTsO
	9NwRHqp4/zKpLeZy/yri3UoGqdivapghgtOsxANsSvvQ3fk+yQ67tEwSvglFg9+R71BuMsJy1S8
	MCqILb3tq8Jqk0e+2hE4kvLMR6CGF40auUQdJd3ZfWUTjDG4SQhh1Co7gA==
X-Google-Smtp-Source: AGHT+IHOnxl43hqfZBR4KJADgKbYytvGEMw+xE1AGh+GqX9RTzo3MW7ThMdu5NCC6KkU5i57qkZ6UA==
X-Received: by 2002:a17:907:db11:b0:ac7:d7f3:86c6 with SMTP id a640c23a62f3a-ac7d7f38826mr1165324866b.9.1744102289495;
        Tue, 08 Apr 2025 01:51:29 -0700 (PDT)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c804sm890801366b.15.2025.04.08.01.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:51:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	ps@pks.im,
	jn.avila@free.fr,
	gitster@pobox.com
Subject: [PATCH v6 5/8] refs: introduce enum-based transaction error types
Date: Tue,  8 Apr 2025 10:51:09 +0200
Message-ID: <20250408085120.614893-6-karthik.188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408085120.614893-1-karthik.188@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250408085120.614893-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace preprocessor-defined transaction errors with a strongly-typed
enum `ref_transaction_error`. This change:

  - Improves type safety and function signature clarity.
  - Makes error handling more explicit and discoverable.
  - Maintains existing error cases, while adding new error cases for
    common scenarios.

This refactoring paves the way for more comprehensive error handling
which we will utilize in the upcoming commits to add batch reference
update support.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c         |   2 +-
 refs.c                  |  49 +++++-----
 refs.h                  |  48 ++++++----
 refs/files-backend.c    | 202 ++++++++++++++++++++--------------------
 refs/packed-backend.c   |  23 +++--
 refs/refs-internal.h    |   5 +-
 refs/reftable-backend.c |  64 ++++++-------
 7 files changed, 207 insertions(+), 186 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95fd0018b9..7615c17faf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -687,7 +687,7 @@ static int s_update_ref(const char *action,
 		switch (ref_transaction_commit(our_transaction, &err)) {
 		case 0:
 			break;
-		case TRANSACTION_NAME_CONFLICT:
+		case REF_TRANSACTION_ERROR_NAME_CONFLICT:
 			ret = STORE_REF_ERROR_DF_CONFLICT;
 			goto out;
 		default:
diff --git a/refs.c b/refs.c
index 61bed9672a..3d0b53d56e 100644
--- a/refs.c
+++ b/refs.c
@@ -2271,7 +2271,7 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 					   REF_NO_DEREF, logmsg, &err))
 			goto error_return;
 		prepret = ref_transaction_prepare(transaction, &err);
-		if (prepret && prepret != TRANSACTION_CREATE_EXISTS)
+		if (prepret && prepret != REF_TRANSACTION_ERROR_CREATE_EXISTS)
 			goto error_return;
 	} else {
 		if (ref_transaction_update(transaction, ref, NULL, NULL,
@@ -2289,7 +2289,7 @@ int refs_update_symref_extended(struct ref_store *refs, const char *ref,
 		}
 	}
 
-	if (prepret == TRANSACTION_CREATE_EXISTS)
+	if (prepret == REF_TRANSACTION_ERROR_CREATE_EXISTS)
 		goto cleanup;
 
 	if (ref_transaction_commit(transaction, &err))
@@ -2425,7 +2425,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 
 	string_list_sort(&transaction->refnames);
 	if (ref_update_reject_duplicates(&transaction->refnames, err))
-		return TRANSACTION_GENERIC_ERROR;
+		return REF_TRANSACTION_ERROR_GENERIC;
 
 	ret = refs->be->transaction_prepare(refs, transaction, err);
 	if (ret)
@@ -2497,19 +2497,19 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	return ret;
 }
 
-int refs_verify_refnames_available(struct ref_store *refs,
-				   const struct string_list *refnames,
-				   const struct string_list *extras,
-				   const struct string_list *skip,
-				   unsigned int initial_transaction,
-				   struct strbuf *err)
+enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs,
+					  const struct string_list *refnames,
+					  const struct string_list *extras,
+					  const struct string_list *skip,
+					  unsigned int initial_transaction,
+					  struct strbuf *err)
 {
 	struct strbuf dirname = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct string_list_item *item;
 	struct ref_iterator *iter = NULL;
 	struct strset dirnames;
-	int ret = -1;
+	int ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 
 	/*
 	 * For the sake of comments in this function, suppose that
@@ -2625,12 +2625,13 @@ int refs_verify_refnames_available(struct ref_store *refs,
 	return ret;
 }
 
-int refs_verify_refname_available(struct ref_store *refs,
-				  const char *refname,
-				  const struct string_list *extras,
-				  const struct string_list *skip,
-				  unsigned int initial_transaction,
-				  struct strbuf *err)
+enum ref_transaction_error refs_verify_refname_available(
+	struct ref_store *refs,
+	const char *refname,
+	const struct string_list *extras,
+	const struct string_list *skip,
+	unsigned int initial_transaction,
+	struct strbuf *err)
 {
 	struct string_list_item item = { .string = (char *) refname };
 	struct string_list refnames = {
@@ -2818,8 +2819,9 @@ int ref_update_has_null_new_value(struct ref_update *update)
 	return !update->new_target && is_null_oid(&update->new_oid);
 }
 
-int ref_update_check_old_target(const char *referent, struct ref_update *update,
-				struct strbuf *err)
+enum ref_transaction_error ref_update_check_old_target(const char *referent,
+						       struct ref_update *update,
+						       struct strbuf *err)
 {
 	if (!update->old_target)
 		BUG("called without old_target set");
@@ -2827,17 +2829,18 @@ int ref_update_check_old_target(const char *referent, struct ref_update *update,
 	if (!strcmp(referent, update->old_target))
 		return 0;
 
-	if (!strcmp(referent, ""))
+	if (!strcmp(referent, "")) {
 		strbuf_addf(err, "verifying symref target: '%s': "
 			    "reference is missing but expected %s",
 			    ref_update_original_update_refname(update),
 			    update->old_target);
-	else
-		strbuf_addf(err, "verifying symref target: '%s': "
-			    "is at %s but expected %s",
+		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
+	}
+
+	strbuf_addf(err, "verifying symref target: '%s': is at %s but expected %s",
 			    ref_update_original_update_refname(update),
 			    referent, update->old_target);
-	return -1;
+	return REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
 }
 
 struct migration_data {
diff --git a/refs.h b/refs.h
index 240e2d8537..f009cdae7d 100644
--- a/refs.h
+++ b/refs.h
@@ -16,6 +16,23 @@ struct worktree;
 enum ref_storage_format ref_storage_format_by_name(const char *name);
 const char *ref_storage_format_to_name(enum ref_storage_format ref_storage_format);
 
+enum ref_transaction_error {
+	/* Default error code */
+	REF_TRANSACTION_ERROR_GENERIC = -1,
+	/* Ref name conflict like A vs A/B */
+	REF_TRANSACTION_ERROR_NAME_CONFLICT = -2,
+	/* Ref to be created already exists */
+	REF_TRANSACTION_ERROR_CREATE_EXISTS = -3,
+	/* ref expected but doesn't exist */
+	REF_TRANSACTION_ERROR_NONEXISTENT_REF = -4,
+	/* Provided old_oid or old_target of reference doesn't match actual */
+	REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE = -5,
+	/* Provided new_oid or new_target is invalid */
+	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
+	/* Expected ref to be symref, but is a regular ref */
+	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
+};
+
 /*
  * Resolve a reference, recursively following symbolic references.
  *
@@ -117,24 +134,24 @@ int refs_read_symbolic_ref(struct ref_store *ref_store, const char *refname,
  *
  * extras and skip must be sorted.
  */
-int refs_verify_refname_available(struct ref_store *refs,
-				  const char *refname,
-				  const struct string_list *extras,
-				  const struct string_list *skip,
-				  unsigned int initial_transaction,
-				  struct strbuf *err);
+enum ref_transaction_error refs_verify_refname_available(struct ref_store *refs,
+						 const char *refname,
+						 const struct string_list *extras,
+						 const struct string_list *skip,
+						 unsigned int initial_transaction,
+						 struct strbuf *err);
 
 /*
  * Same as `refs_verify_refname_available()`, but checking for a list of
  * refnames instead of only a single item. This is more efficient in the case
  * where one needs to check multiple refnames.
  */
-int refs_verify_refnames_available(struct ref_store *refs,
-				   const struct string_list *refnames,
-				   const struct string_list *extras,
-				   const struct string_list *skip,
-				   unsigned int initial_transaction,
-				   struct strbuf *err);
+enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs,
+					  const struct string_list *refnames,
+					  const struct string_list *extras,
+					  const struct string_list *skip,
+					  unsigned int initial_transaction,
+					  struct strbuf *err);
 
 int refs_ref_exists(struct ref_store *refs, const char *refname);
 
@@ -830,13 +847,6 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 			   unsigned int flags,
 			   struct strbuf *err);
 
-/* Naming conflict (for example, the ref names A and A/B conflict). */
-#define TRANSACTION_NAME_CONFLICT -1
-/* When only creation was requested, but the ref already exists. */
-#define TRANSACTION_CREATE_EXISTS -2
-/* All other errors. */
-#define TRANSACTION_GENERIC_ERROR -3
-
 /*
  * Perform the preparatory stages of committing `transaction`. Acquire
  * any needed locks, check preconditions, etc.; basically, do as much
diff --git a/refs/files-backend.c b/refs/files-backend.c
index ea023a59fc..4f27f7652c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -663,7 +663,7 @@ static void unlock_ref(struct ref_lock *lock)
  * broken, lock the reference anyway but clear old_oid.
  *
  * Return 0 on success. On failure, write an error message to err and
- * return TRANSACTION_NAME_CONFLICT or TRANSACTION_GENERIC_ERROR.
+ * return REF_TRANSACTION_ERROR_NAME_CONFLICT or REF_TRANSACTION_ERROR_GENERIC.
  *
  * Implementation note: This function is basically
  *
@@ -676,19 +676,20 @@ static void unlock_ref(struct ref_lock *lock)
  *   avoided, namely if we were successfully able to read the ref
  * - Generate informative error messages in the case of failure
  */
-static int lock_raw_ref(struct files_ref_store *refs,
-			const char *refname, int mustexist,
-			struct string_list *refnames_to_check,
-			const struct string_list *extras,
-			struct ref_lock **lock_p,
-			struct strbuf *referent,
-			unsigned int *type,
-			struct strbuf *err)
-{
+static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
+					       const char *refname,
+					       int mustexist,
+					       struct string_list *refnames_to_check,
+					       const struct string_list *extras,
+					       struct ref_lock **lock_p,
+					       struct strbuf *referent,
+					       unsigned int *type,
+					       struct strbuf *err)
+{
+	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
 	struct ref_lock *lock;
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
-	int ret = TRANSACTION_GENERIC_ERROR;
 	int failure_errno;
 
 	assert(err);
@@ -728,13 +729,14 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				strbuf_reset(err);
 				strbuf_addf(err, "unable to resolve reference '%s'",
 					    refname);
+				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 			} else {
 				/*
 				 * The error message set by
 				 * refs_verify_refname_available() is
 				 * OK.
 				 */
-				ret = TRANSACTION_NAME_CONFLICT;
+				ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 			}
 		} else {
 			/*
@@ -788,6 +790,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				/* Garden variety missing reference. */
 				strbuf_addf(err, "unable to resolve reference '%s'",
 					    refname);
+				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 				goto error_return;
 			} else {
 				/*
@@ -820,6 +823,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 				/* Garden variety missing reference. */
 				strbuf_addf(err, "unable to resolve reference '%s'",
 					    refname);
+				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 				goto error_return;
 			} else if (remove_dir_recursively(&ref_file,
 							  REMOVE_DIR_EMPTY_ONLY)) {
@@ -830,7 +834,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 					 * The error message set by
 					 * verify_refname_available() is OK.
 					 */
-					ret = TRANSACTION_NAME_CONFLICT;
+					ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 					goto error_return;
 				} else {
 					/*
@@ -1517,10 +1521,11 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 	return ret;
 }
 
-static int write_ref_to_lockfile(struct files_ref_store *refs,
-				 struct ref_lock *lock,
-				 const struct object_id *oid,
-				 int skip_oid_verification, struct strbuf *err);
+static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
+							struct ref_lock *lock,
+							const struct object_id *oid,
+							int skip_oid_verification,
+							struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
 			     const struct object_id *oid, const char *logmsg,
@@ -1926,10 +1931,11 @@ static int files_log_ref_write(struct files_ref_store *refs,
  * Write oid into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and return -1.
  */
-static int write_ref_to_lockfile(struct files_ref_store *refs,
-				 struct ref_lock *lock,
-				 const struct object_id *oid,
-				 int skip_oid_verification, struct strbuf *err)
+static enum ref_transaction_error write_ref_to_lockfile(struct files_ref_store *refs,
+							struct ref_lock *lock,
+							const struct object_id *oid,
+							int skip_oid_verification,
+							struct strbuf *err)
 {
 	static char term = '\n';
 	struct object *o;
@@ -1943,7 +1949,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 				"trying to write ref '%s' with nonexistent object %s",
 				lock->ref_name, oid_to_hex(oid));
 			unlock_ref(lock);
-			return -1;
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
 		}
 		if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
 			strbuf_addf(
@@ -1951,7 +1957,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 				"trying to write non-commit object %s to branch '%s'",
 				oid_to_hex(oid), lock->ref_name);
 			unlock_ref(lock);
-			return -1;
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
 		}
 	}
 	fd = get_lock_file_fd(&lock->lk);
@@ -1962,7 +1968,7 @@ static int write_ref_to_lockfile(struct files_ref_store *refs,
 		strbuf_addf(err,
 			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
 		unlock_ref(lock);
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	}
 	return 0;
 }
@@ -2376,9 +2382,10 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
  * If update is a direct update of head_ref (the reference pointed to
  * by HEAD), then add an extra REF_LOG_ONLY update for HEAD.
  */
-static int split_head_update(struct ref_update *update,
-			     struct ref_transaction *transaction,
-			     const char *head_ref, struct strbuf *err)
+static enum ref_transaction_error split_head_update(struct ref_update *update,
+						    struct ref_transaction *transaction,
+						    const char *head_ref,
+						    struct strbuf *err)
 {
 	struct ref_update *new_update;
 
@@ -2402,7 +2409,7 @@ static int split_head_update(struct ref_update *update,
 			    "multiple updates for 'HEAD' (including one "
 			    "via its referent '%s') are not allowed",
 			    update->refname);
-		return TRANSACTION_NAME_CONFLICT;
+		return REF_TRANSACTION_ERROR_NAME_CONFLICT;
 	}
 
 	new_update = ref_transaction_add_update(
@@ -2430,10 +2437,10 @@ static int split_head_update(struct ref_update *update,
  * Note that the new update will itself be subject to splitting when
  * the iteration gets to it.
  */
-static int split_symref_update(struct ref_update *update,
-			       const char *referent,
-			       struct ref_transaction *transaction,
-			       struct strbuf *err)
+static enum ref_transaction_error split_symref_update(struct ref_update *update,
+						      const char *referent,
+						      struct ref_transaction *transaction,
+						      struct strbuf *err)
 {
 	struct ref_update *new_update;
 	unsigned int new_flags;
@@ -2450,7 +2457,7 @@ static int split_symref_update(struct ref_update *update,
 			    "multiple updates for '%s' (including one "
 			    "via symref '%s') are not allowed",
 			    referent, update->refname);
-		return TRANSACTION_NAME_CONFLICT;
+		return REF_TRANSACTION_ERROR_NAME_CONFLICT;
 	}
 
 	new_flags = update->flags;
@@ -2491,11 +2498,10 @@ static int split_symref_update(struct ref_update *update,
  * everything is OK, return 0; otherwise, write an error message to
  * err and return -1.
  */
-static int check_old_oid(struct ref_update *update, struct object_id *oid,
-			 struct strbuf *err)
+static enum ref_transaction_error check_old_oid(struct ref_update *update,
+						struct object_id *oid,
+						struct strbuf *err)
 {
-	int ret = TRANSACTION_GENERIC_ERROR;
-
 	if (!(update->flags & REF_HAVE_OLD) ||
 		   oideq(oid, &update->old_oid))
 		return 0;
@@ -2504,21 +2510,20 @@ static int check_old_oid(struct ref_update *update, struct object_id *oid,
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference already exists",
 			    ref_update_original_update_refname(update));
-		ret = TRANSACTION_CREATE_EXISTS;
-	}
-	else if (is_null_oid(oid))
+		return REF_TRANSACTION_ERROR_CREATE_EXISTS;
+	} else if (is_null_oid(oid)) {
 		strbuf_addf(err, "cannot lock ref '%s': "
 			    "reference is missing but expected %s",
 			    ref_update_original_update_refname(update),
 			    oid_to_hex(&update->old_oid));
-	else
-		strbuf_addf(err, "cannot lock ref '%s': "
-			    "is at %s but expected %s",
-			    ref_update_original_update_refname(update),
-			    oid_to_hex(oid),
-			    oid_to_hex(&update->old_oid));
+		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
+	}
 
-	return ret;
+	strbuf_addf(err, "cannot lock ref '%s': is at %s but expected %s",
+		    ref_update_original_update_refname(update), oid_to_hex(oid),
+		    oid_to_hex(&update->old_oid));
+
+	return REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
 }
 
 struct files_transaction_backend_data {
@@ -2540,17 +2545,17 @@ struct files_transaction_backend_data {
  * - If it is an update of head_ref, add a corresponding REF_LOG_ONLY
  *   update of HEAD.
  */
-static int lock_ref_for_update(struct files_ref_store *refs,
-			       struct ref_update *update,
-			       struct ref_transaction *transaction,
-			       const char *head_ref,
-			       struct string_list *refnames_to_check,
-			       struct strbuf *err)
+static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *refs,
+						      struct ref_update *update,
+						      struct ref_transaction *transaction,
+						      const char *head_ref,
+						      struct string_list *refnames_to_check,
+						      struct strbuf *err)
 {
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = ref_update_expects_existing_old_ref(update);
 	struct files_transaction_backend_data *backend_data;
-	int ret = 0;
+	enum ref_transaction_error ret = 0;
 	struct ref_lock *lock;
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
@@ -2602,22 +2607,17 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
 						    ref_update_original_update_refname(update));
-					ret = TRANSACTION_GENERIC_ERROR;
+					ret = REF_TRANSACTION_ERROR_GENERIC;
 					goto out;
 				}
 			}
 
-			if (update->old_target) {
-				if (ref_update_check_old_target(referent.buf, update, err)) {
-					ret = TRANSACTION_GENERIC_ERROR;
-					goto out;
-				}
-			} else {
+			if (update->old_target)
+				ret = ref_update_check_old_target(referent.buf, update, err);
+			else
 				ret = check_old_oid(update, &lock->old_oid, err);
-				if  (ret) {
-					goto out;
-				}
-			}
+			if (ret)
+				goto out;
 		} else {
 			/*
 			 * Create a new update for the reference this
@@ -2644,7 +2644,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					   "but is a regular ref"),
 				    ref_update_original_update_refname(update),
 				    update->old_target);
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_EXPECTED_SYMREF;
 			goto out;
 		} else {
 			ret = check_old_oid(update, &lock->old_oid, err);
@@ -2668,14 +2668,14 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
 		if (create_symref_lock(lock, update->new_target, err)) {
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_GENERIC;
 			goto out;
 		}
 
 		if (close_ref_gently(lock)) {
 			strbuf_addf(err, "couldn't close '%s.lock'",
 				    update->refname);
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_GENERIC;
 			goto out;
 		}
 
@@ -2693,25 +2693,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * The reference already has the desired
 			 * value, so we don't need to write it.
 			 */
-		} else if (write_ref_to_lockfile(
-				   refs, lock, &update->new_oid,
-				   update->flags & REF_SKIP_OID_VERIFICATION,
-				   err)) {
-			char *write_err = strbuf_detach(err, NULL);
-
-			/*
-			 * The lock was freed upon failure of
-			 * write_ref_to_lockfile():
-			 */
-			update->backend_data = NULL;
-			strbuf_addf(err,
-				    "cannot update ref '%s': %s",
-				    update->refname, write_err);
-			free(write_err);
-			ret = TRANSACTION_GENERIC_ERROR;
-			goto out;
 		} else {
-			update->flags |= REF_NEEDS_COMMIT;
+			ret = write_ref_to_lockfile(
+				refs, lock, &update->new_oid,
+				update->flags & REF_SKIP_OID_VERIFICATION,
+				err);
+			if (ret) {
+				char *write_err = strbuf_detach(err, NULL);
+
+				/*
+				 * The lock was freed upon failure of
+				 * write_ref_to_lockfile():
+				 */
+				update->backend_data = NULL;
+				strbuf_addf(err,
+					    "cannot update ref '%s': %s",
+					    update->refname, write_err);
+				free(write_err);
+				goto out;
+			} else {
+				update->flags |= REF_NEEDS_COMMIT;
+			}
 		}
 	}
 	if (!(update->flags & REF_NEEDS_COMMIT)) {
@@ -2723,7 +2725,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		if (close_ref_gently(lock)) {
 			strbuf_addf(err, "couldn't close '%s.lock'",
 				    update->refname);
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_GENERIC;
 			goto out;
 		}
 	}
@@ -2865,7 +2867,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 						refs->packed_ref_store,
 						transaction->flags, err);
 				if (!packed_transaction) {
-					ret = TRANSACTION_GENERIC_ERROR;
+					ret = REF_TRANSACTION_ERROR_GENERIC;
 					goto cleanup;
 				}
 
@@ -2897,13 +2899,13 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 */
 	if (refs_verify_refnames_available(refs->packed_ref_store, &refnames_to_check,
 					   &transaction->refnames, NULL, 0, err)) {
-		ret = TRANSACTION_NAME_CONFLICT;
+		ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 		goto cleanup;
 	}
 
 	if (packed_transaction) {
 		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_GENERIC;
 			goto cleanup;
 		}
 		backend_data->packed_refs_locked = 1;
@@ -2934,7 +2936,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			 */
 			backend_data->packed_transaction = NULL;
 			if (ref_transaction_abort(packed_transaction, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
+				ret = REF_TRANSACTION_ERROR_GENERIC;
 				goto cleanup;
 			}
 		}
@@ -3035,7 +3037,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,
 							 transaction->flags, err);
 	if (!packed_transaction) {
-		ret = TRANSACTION_GENERIC_ERROR;
+		ret = REF_TRANSACTION_ERROR_GENERIC;
 		goto cleanup;
 	}
 
@@ -3058,7 +3060,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 			if (!loose_transaction) {
 				loose_transaction = ref_store_transaction_begin(&refs->base, 0, err);
 				if (!loose_transaction) {
-					ret = TRANSACTION_GENERIC_ERROR;
+					ret = REF_TRANSACTION_ERROR_GENERIC;
 					goto cleanup;
 				}
 			}
@@ -3083,19 +3085,19 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	}
 
 	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
+		ret = REF_TRANSACTION_ERROR_GENERIC;
 		goto cleanup;
 	}
 
 	if (refs_verify_refnames_available(&refs->base, &refnames_to_check,
 					   &affected_refnames, NULL, 1, err)) {
 		packed_refs_unlock(refs->packed_ref_store);
-		ret = TRANSACTION_NAME_CONFLICT;
+		ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 		goto cleanup;
 	}
 
 	if (ref_transaction_commit(packed_transaction, err)) {
-		ret = TRANSACTION_GENERIC_ERROR;
+		ret = REF_TRANSACTION_ERROR_GENERIC;
 		goto cleanup;
 	}
 	packed_refs_unlock(refs->packed_ref_store);
@@ -3103,7 +3105,7 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
 	if (loose_transaction) {
 		if (ref_transaction_prepare(loose_transaction, err) ||
 		    ref_transaction_commit(loose_transaction, err)) {
-			ret = TRANSACTION_GENERIC_ERROR;
+			ret = REF_TRANSACTION_ERROR_GENERIC;
 			goto cleanup;
 		}
 	}
@@ -3152,7 +3154,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
 			if (parse_and_write_reflog(refs, update, lock, err)) {
-				ret = TRANSACTION_GENERIC_ERROR;
+				ret = REF_TRANSACTION_ERROR_GENERIC;
 				goto cleanup;
 			}
 		}
@@ -3171,7 +3173,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 				strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 				unlock_ref(lock);
 				update->backend_data = NULL;
-				ret = TRANSACTION_GENERIC_ERROR;
+				ret = REF_TRANSACTION_ERROR_GENERIC;
 				goto cleanup;
 			}
 		}
@@ -3227,7 +3229,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 				strbuf_reset(&sb);
 				files_ref_path(refs, &sb, lock->ref_name);
 				if (unlink_or_msg(sb.buf, err)) {
-					ret = TRANSACTION_GENERIC_ERROR;
+					ret = REF_TRANSACTION_ERROR_GENERIC;
 					goto cleanup;
 				}
 			}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 19220d2e99..d90bd815a3 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1326,10 +1326,11 @@ static int packed_ref_store_remove_on_disk(struct ref_store *ref_store,
  * The packfile must be locked before calling this function and will
  * remain locked when it is done.
  */
-static int write_with_updates(struct packed_ref_store *refs,
-			      struct string_list *updates,
-			      struct strbuf *err)
+static enum ref_transaction_error write_with_updates(struct packed_ref_store *refs,
+						     struct string_list *updates,
+						     struct strbuf *err)
 {
+	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
 	struct ref_iterator *iter = NULL;
 	size_t i;
 	int ok;
@@ -1353,7 +1354,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 		strbuf_addf(err, "unable to create file %s: %s",
 			    sb.buf, strerror(errno));
 		strbuf_release(&sb);
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	}
 	strbuf_release(&sb);
 
@@ -1409,6 +1410,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 					strbuf_addf(err, "cannot update ref '%s': "
 						    "reference already exists",
 						    update->refname);
+					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
 					goto error;
 				} else if (!oideq(&update->old_oid, iter->oid)) {
 					strbuf_addf(err, "cannot update ref '%s': "
@@ -1416,6 +1418,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 						    update->refname,
 						    oid_to_hex(iter->oid),
 						    oid_to_hex(&update->old_oid));
+					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
 					goto error;
 				}
 			}
@@ -1452,6 +1455,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 					    "reference is missing but expected %s",
 					    update->refname,
 					    oid_to_hex(&update->old_oid));
+				ret = REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 				goto error;
 			}
 		}
@@ -1509,7 +1513,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 			    strerror(errno));
 		strbuf_release(&sb);
 		delete_tempfile(&refs->tempfile);
-		return -1;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	}
 
 	return 0;
@@ -1521,7 +1525,7 @@ static int write_with_updates(struct packed_ref_store *refs,
 error:
 	ref_iterator_free(iter);
 	delete_tempfile(&refs->tempfile);
-	return -1;
+	return ret;
 }
 
 int is_packed_transaction_needed(struct ref_store *ref_store,
@@ -1654,7 +1658,7 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
 			"ref_transaction_prepare");
 	struct packed_transaction_backend_data *data;
-	int ret = TRANSACTION_GENERIC_ERROR;
+	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
 
 	/*
 	 * Note that we *don't* skip transactions with zero updates,
@@ -1675,7 +1679,8 @@ static int packed_transaction_prepare(struct ref_store *ref_store,
 		data->own_lock = 1;
 	}
 
-	if (write_with_updates(refs, &transaction->refnames, err))
+	ret = write_with_updates(refs, &transaction->refnames, err);
+	if (ret)
 		goto failure;
 
 	transaction->state = REF_TRANSACTION_PREPARED;
@@ -1707,7 +1712,7 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 			ref_store,
 			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
 			"ref_transaction_finish");
-	int ret = TRANSACTION_GENERIC_ERROR;
+	int ret = REF_TRANSACTION_ERROR_GENERIC;
 	char *packed_refs_path;
 
 	clear_snapshot(refs);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 6d3770d0cc..3f1d19abd9 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -770,8 +770,9 @@ int ref_update_has_null_new_value(struct ref_update *update);
  * If everything is OK, return 0; otherwise, write an error message to
  * err and return -1.
  */
-int ref_update_check_old_target(const char *referent, struct ref_update *update,
-				struct strbuf *err);
+enum ref_transaction_error ref_update_check_old_target(const char *referent,
+						       struct ref_update *update,
+						       struct strbuf *err);
 
 /*
  * Check if the ref must exist, this means that the old_oid or
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 786df11a03..bd6b042103 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1069,20 +1069,20 @@ static int queue_transaction_update(struct reftable_ref_store *refs,
 	return 0;
 }
 
-static int prepare_single_update(struct reftable_ref_store *refs,
-				 struct reftable_transaction_data *tx_data,
-				 struct ref_transaction *transaction,
-				 struct reftable_backend *be,
-				 struct ref_update *u,
-				 struct string_list *refnames_to_check,
-				 unsigned int head_type,
-				 struct strbuf *head_referent,
-				 struct strbuf *referent,
-				 struct strbuf *err)
+static enum ref_transaction_error prepare_single_update(struct reftable_ref_store *refs,
+							struct reftable_transaction_data *tx_data,
+							struct ref_transaction *transaction,
+							struct reftable_backend *be,
+							struct ref_update *u,
+							struct string_list *refnames_to_check,
+							unsigned int head_type,
+							struct strbuf *head_referent,
+							struct strbuf *referent,
+							struct strbuf *err)
 {
+	enum ref_transaction_error ret = 0;
 	struct object_id current_oid = {0};
 	const char *rewritten_ref;
-	int ret = 0;
 
 	/*
 	 * There is no need to reload the respective backends here as
@@ -1093,7 +1093,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 	 */
 	ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
 	if (ret)
-		return ret;
+		return REF_TRANSACTION_ERROR_GENERIC;
 
 	/* Verify that the new object ID is valid. */
 	if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
@@ -1104,13 +1104,13 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 			strbuf_addf(err,
 				    _("trying to write ref '%s' with nonexistent object %s"),
 				    u->refname, oid_to_hex(&u->new_oid));
-			return -1;
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
 		}
 
 		if (o->type != OBJ_COMMIT && is_branch(u->refname)) {
 			strbuf_addf(err, _("trying to write non-commit object %s to branch '%s'"),
 				    oid_to_hex(&u->new_oid), u->refname);
-			return -1;
+			return REF_TRANSACTION_ERROR_INVALID_NEW_VALUE;
 		}
 	}
 
@@ -1134,7 +1134,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 				    _("multiple updates for 'HEAD' (including one "
 				      "via its referent '%s') are not allowed"),
 				    u->refname);
-			return TRANSACTION_NAME_CONFLICT;
+			return REF_TRANSACTION_ERROR_NAME_CONFLICT;
 		}
 
 		ref_transaction_add_update(
@@ -1147,7 +1147,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 	ret = reftable_backend_read_ref(be, rewritten_ref,
 					&current_oid, referent, &u->type);
 	if (ret < 0)
-		return ret;
+		return REF_TRANSACTION_ERROR_GENERIC;
 	if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
 		/*
 		 * The reference does not exist, and we either have no
@@ -1168,7 +1168,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 			ret = queue_transaction_update(refs, tx_data, u,
 						       &current_oid, err);
 			if (ret)
-				return ret;
+				return REF_TRANSACTION_ERROR_GENERIC;
 		}
 
 		return 0;
@@ -1180,7 +1180,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 
 				   "unable to resolve reference '%s'"),
 			    ref_update_original_update_refname(u), u->refname);
-		return -1;
+		return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
 	}
 
 	if (u->type & REF_ISSYMREF) {
@@ -1196,7 +1196,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 			if (u->flags & REF_HAVE_OLD && !resolved) {
 				strbuf_addf(err, _("cannot lock ref '%s': "
 						   "error reading reference"), u->refname);
-				return -1;
+				return REF_TRANSACTION_ERROR_GENERIC;
 			}
 		} else {
 			struct ref_update *new_update;
@@ -1211,7 +1211,7 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 					    _("multiple updates for '%s' (including one "
 					      "via symref '%s') are not allowed"),
 					    referent->buf, u->refname);
-				return TRANSACTION_NAME_CONFLICT;
+				return REF_TRANSACTION_ERROR_NAME_CONFLICT;
 			}
 
 			/*
@@ -1255,31 +1255,32 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 					   "but is a regular ref"),
 				    ref_update_original_update_refname(u),
 				    u->old_target);
-			return -1;
+			return REF_TRANSACTION_ERROR_EXPECTED_SYMREF;
 		}
 
-		if (ref_update_check_old_target(referent->buf, u, err)) {
-			return -1;
-		}
+		ret = ref_update_check_old_target(referent->buf, u, err);
+		if (ret)
+			return ret;
 	} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
 		if (is_null_oid(&u->old_oid)) {
 			strbuf_addf(err, _("cannot lock ref '%s': "
 					   "reference already exists"),
 				    ref_update_original_update_refname(u));
-			return TRANSACTION_CREATE_EXISTS;
-		}
-		else if (is_null_oid(&current_oid))
+			return REF_TRANSACTION_ERROR_CREATE_EXISTS;
+		} else if (is_null_oid(&current_oid)) {
 			strbuf_addf(err, _("cannot lock ref '%s': "
 					   "reference is missing but expected %s"),
 				    ref_update_original_update_refname(u),
 				    oid_to_hex(&u->old_oid));
-		else
+			return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
+		} else {
 			strbuf_addf(err, _("cannot lock ref '%s': "
 					   "is at %s but expected %s"),
 				    ref_update_original_update_refname(u),
 				    oid_to_hex(&current_oid),
 				    oid_to_hex(&u->old_oid));
-		return TRANSACTION_NAME_CONFLICT;
+			return REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
+		}
 	}
 
 	/*
@@ -1296,8 +1297,8 @@ static int prepare_single_update(struct reftable_ref_store *refs,
 	if ((u->type & REF_ISSYMREF) ||
 	    (u->flags & REF_LOG_ONLY) ||
 	    (u->flags & REF_HAVE_NEW && !oideq(&current_oid, &u->new_oid)))
-		return queue_transaction_update(refs, tx_data, u,
-					       &current_oid, err);
+		if (queue_transaction_update(refs, tx_data, u, &current_oid, err))
+			return REF_TRANSACTION_ERROR_GENERIC;
 
 	return 0;
 }
@@ -1385,7 +1386,6 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	transaction->state = REF_TRANSACTION_PREPARED;
 
 done:
-	assert(ret != REFTABLE_API_ERROR);
 	if (ret < 0) {
 		free_transaction_data(tx_data);
 		transaction->state = REF_TRANSACTION_CLOSED;
-- 
2.48.1

