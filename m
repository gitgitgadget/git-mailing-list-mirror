Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A856152510
	for <git@vger.kernel.org>; Fri,  3 May 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714740082; cv=none; b=PDpgyrh65IVbP7VWqpSjCdQb7+7zJAwcbnqsUQAxOf12cAK2d516HazTMQCAwlAA9uWPs0e6g09Emr1hCphAv8wt+NGmvu/tpD+GkQJOCiU6SZXLTHUCBW9FZafC+yHjy+Czg0mn1PXZ9kfi87LoRE6wNDoYTpDw4DtRyswvHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714740082; c=relaxed/simple;
	bh=/c3GKmSWtdbEksQ3+FzZFxQpPVWU8prMIIDuJjK2nWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmgMhAvP6Re/Cv4dEBN4ZHz6f00m6xMkUW4iZDXlGzYbfTG7wf0qj8/v7fFp1LqHPUbu6FDQS+hOQliKPuWDHFsdZZvGvKkZAM2yYHuztyMpFWYkx4Ef5CHYURWneAXlxIfC5PbRbhW2u/9hS4uqPJn+hVmZYy0/eJnuxo1N7Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnMwVLbR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnMwVLbR"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a597de5a715so293218766b.2
        for <git@vger.kernel.org>; Fri, 03 May 2024 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714740078; x=1715344878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/WecHsZ//fc/3GfUAXBgY4oZLNsc9on0LQGzHjY898=;
        b=BnMwVLbREQkBoijbebtF3ICzCSqXA3JECa6J5IoGuoSjfZih0W/oteEXOSCki1w1Q+
         oJZ9wIOWEJCspgdvGmDfTxVjGcmCvvxQl2YgKD3iXZMEDyEsFzwuBhQ4F48zP7xlEqR6
         RmC9B5D2ScWc5bK7lw/UECnhd0W1Y7np9BMACpkm893odEqo0LujeTb9aWkMxBfYUu4a
         Cfa+7LEjittPKYQW+xrjZt+iUwQFXL251CFHTpxADm97KXUDn8d3S2azz60PrcdG36oj
         B8qTaOavJPyYaFkRFiYkwrj0jIY1rH5XZNIgufsTgWFBLISTtQR6gHl5JPyjFzF8wVeh
         Je0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714740078; x=1715344878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/WecHsZ//fc/3GfUAXBgY4oZLNsc9on0LQGzHjY898=;
        b=bHVy7U5c0vxkGtJZqK5SHRgX8tNf8e+zj8eXVwqi6jjCDyTpqUfDOSV1wOp9lowdVg
         1A0bSMqR8n5s6p20yyHxHn2Yx4FDDymFNMVp7w+K270nZzU5DpTpklg9Xve3eSYN/eeg
         JBnepomnASbJhIhOwLVLFehw7DdqFN3LKgE3An9WSJiNZTSp+qnJCRqKMDpV3ngVsqo+
         Me8x4f5l3hDRP1FBMzYz7wslcrh2/zaYOIPqtHFuirXOwL9B/yV5P0Klywqjc6vkXdBX
         kk8x/vQF+4AD2qsPwd9EHbNhC/7DPrFnNNDvlEYqs06utvlYpxyBVqUr8bzaWc6pXtfy
         OZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCVwRh8OD95abkO+k+lYuFBllgjjDgoSpihIpQaU7zUlgFW3EmkqTIk6SVWQRa2I5q7+++fDBLuMbTETyngnLx2Nk0Bt
X-Gm-Message-State: AOJu0YzMo08Q8n5KN+MftNWncODYHJbqAJCQuH8r2XxgRUY+88xWaJ3Q
	qTVz4pFmF39j0caJQbpHGFEKdYhnjGIj/+uk+kKYlTunfqxwhSUV
X-Google-Smtp-Source: AGHT+IHagFLz3PMZgDx5vNTErC73w0y1bG6XfLSGn+vKHwGSwjaEsi1qerMLsyIGVxmsyjAb1P+NWA==
X-Received: by 2002:a17:906:5a84:b0:a59:9db2:d988 with SMTP id l4-20020a1709065a8400b00a599db2d988mr301190ejq.50.1714740077848;
        Fri, 03 May 2024 05:41:17 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id ot38-20020a170906cce600b00a5994c5c948sm533323ejb.133.2024.05.03.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:41:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v6 0/7] refs: add support for transactional symref updates
Date: Fri,  3 May 2024 14:41:08 +0200
Message-ID: <20240503124115.252413-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501202229.2695774-1-knayak@gitlab.com>
References: <20240501202229.2695774-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The patch series takes over from the existing patch series, wherein we
introduced symref-* commands to git-update-ref. Since there was a ton of
discussions on the UX of the patch series and its application, I thought it
would be best to shorten the series and split it into multiple smaller series.

This series adds transactional support for symrefs in the reference db. Then
we switch refs_create_symref() to start using transactions for symref updates.
This allows us to deprecate the create_symref code in the ref_storage_be
interface and remove all associated code which is no longer used.

The split was primarily done so we can merge the non-user facing parts of the
previous series. While pertaining the user facing components into another set
of patches wherein deeper discussion on the UX can be held without worrying
about the internal implementation. Also by using this new functionality in a
pre-existing command, we can leverage the existing tests to catch any
inconsistencies. One of which was how 'git-symbolic-ref' doesn't add reflog for
dangling symrefs, which I've modified my patch to do the same.

We also modify the reference transaction hook to support symrefs. For any symref
update the reference transaction hook will output the value with a 'ref:' prefix.

Previous versions:
V1: https://lore.kernel.org/git/20240330224623.579457-1-knayak@gitlab.com/
V2: https://lore.kernel.org/git/20240412095908.1134387-1-knayak@gitlab.com/
V3: https://lore.kernel.org/git/20240423212818.574123-1-knayak@gitlab.com/
V4: https://lore.kernel.org/r/20240426152449.228860-1-knayak@gitlab.com
V5: https://lore.kernel.org/r/20240501202229.2695774-1-knayak@gitlab.com

Changes over v5 are:
- More user friendly error messages.
- `create_symref_lock` now writes to an err buf, instead of directly to stderr.
- Refactor code to make it easier to read around logical operations.
- Cleanup commit message and fix typos.

Thanks to all reviewers!

Range diff:

1:  a354190905 = 1:  a354190905 refs: accept symref values in `ref_transaction_update()`
2:  7dff21dbef ! 2:  0d9c5b9804 files-backend: extract out `create_symref_lock()`
    @@ refs/files-backend.c: static void update_symref_reflog(struct files_ref_store *r
     -				const char *target, const char *logmsg)
     +static int create_symref_lock(struct files_ref_store *refs,
     +			      struct ref_lock *lock, const char *refname,
    -+			      const char *target)
    ++			      const char *target, struct strbuf *err)
      {
    -+	if (!fdopen_lock_file(&lock->lk, "w"))
    -+		return error("unable to fdopen %s: %s",
    ++	if (!fdopen_lock_file(&lock->lk, "w")) {
    ++		strbuf_addf(err, "unable to fdopen %s: %s",
     +			     get_lock_file_path(&lock->lk), strerror(errno));
    ++		return -1;
    ++	}
     +
    -+	if (fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target) < 0)
    -+		return error("unable to fprintf %s: %s",
    ++	if (fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target) < 0) {
    ++		strbuf_addf(err, "unable to write to %s: %s",
     +			     get_lock_file_path(&lock->lk), strerror(errno));
    ++		return -1;
    ++	}
    ++
     +	return 0;
     +}
     +
    @@ refs/files-backend.c: static void update_symref_reflog(struct files_ref_store *r
     +				    struct ref_lock *lock, const char *refname,
     +				    const char *target, const char *logmsg)
     +{
    ++	struct strbuf err = STRBUF_INIT;
     +	int ret;
     +
      	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
    @@ refs/files-backend.c: static void update_symref_reflog(struct files_ref_store *r
     -	if (!fdopen_lock_file(&lock->lk, "w"))
     -		return error("unable to fdopen %s: %s",
     -			     get_lock_file_path(&lock->lk), strerror(errno));
    -+	ret = create_symref_lock(refs, lock, refname, target);
    ++	ret = create_symref_lock(refs, lock, refname, target, &err);
     +	if (!ret) {
     +		update_symref_reflog(refs, lock, refname, target, logmsg);
      
    @@ refs/files-backend.c: static void update_symref_reflog(struct files_ref_store *r
     +		if (commit_ref(lock) < 0)
     +			return error("unable to write symref for %s: %s", refname,
     +				     strerror(errno));
    ++	} else {
    ++		return error("%s", err.buf);
     +	}
      
     -	/* no error check; commit_ref will check ferror */
3:  901a586683 ! 3:  e0219ffd31 refs: support symrefs in 'reference-transaction' hook
    @@ refs.c: static int run_transaction_hook(struct ref_transaction *transaction,
     -			    oid_to_hex(&update->new_oid),
     -			    update->refname);
     +
    -+		if (update->flags & REF_HAVE_OLD && update->old_target)
    ++		if (!(update->flags & REF_HAVE_OLD))
    ++			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid()));
    ++		else if (update->old_target)
     +			strbuf_addf(&buf, "ref:%s ", update->old_target);
     +		else
     +			strbuf_addf(&buf, "%s ", oid_to_hex(&update->old_oid));
     +
    -+		if (update->flags & REF_HAVE_NEW && update->new_target)
    ++		if (!(update->flags & REF_HAVE_NEW))
    ++			strbuf_addf(&buf, "%s ", oid_to_hex(null_oid()));
    ++		else if (update->new_target)
     +			strbuf_addf(&buf, "ref:%s ", update->new_target);
     +		else
     +			strbuf_addf(&buf, "%s ", oid_to_hex(&update->new_oid));
4:  6c97f6a660 ! 4:  b22c59c722 refs: add support for transactional symref updates
    @@ Commit message
         However, we never supported transactional updates of symrefs. Let's add
         support for symrefs in both the 'files' and the 'reftable' backend.
     
    -    Here, we add and use `ref_update_is_null_new_value()`, a helper function
    -    which is used to check if there is a new_value in a reference update.
    -    The new value could either be a symref target `new_target` or a OID
    -    `new_oid`.
    +    Here, we add and use `ref_update_has_null_new_value()`, a helper
    +    function which is used to check if there is a new_value in a reference
    +    update. The new value could either be a symref target `new_target` or a
    +    OID `new_oid`.
     
         With this, now transactional updates (verify, create, delete, update)
         can be used for:
    @@ Commit message
         This also allows us to expose this to users via new commands in
         'git-update-ref' in the future.
     
    -    We do not add reflog for dangling symref updates, because currently
    -    'git-symbolic-ref' doesn't add reflog for dangling symref updates and it
    -    would be best to keep this behavior consistent as we would move it to
    -    start using transaction based updates in the following commit.
    +    Note that a dangling symref update does not record a new reflog entry,
    +    which is unchanged before and after this commit.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ refs.c: struct ref_update *ref_transaction_add_update(
      	update->flags = flags;
      
     -	if (flags & REF_HAVE_NEW)
    -+	if (new_target)
    -+		update->new_target = xstrdup(new_target);
    -+	if (old_target)
    -+		update->old_target = xstrdup(old_target);
    -+	if (new_oid && flags & REF_HAVE_NEW)
    ++	update->new_target = xstrdup_or_null(new_target);
    ++	update->old_target = xstrdup_or_null(old_target);
    ++	if ((flags & REF_HAVE_NEW) && new_oid)
      		oidcpy(&update->new_oid, new_oid);
     -	if (flags & REF_HAVE_OLD)
    -+	if (old_oid && flags & REF_HAVE_OLD)
    ++	if ((flags & REF_HAVE_OLD) && old_oid)
      		oidcpy(&update->old_oid, old_oid);
     +
      	update->msg = normalize_reflog_message(msg);
    @@ refs.c: int copy_existing_ref(const char *oldref, const char *newref, const char
      	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
      }
     +
    -+int ref_update_is_null_new_value(struct ref_update *update)
    ++int ref_update_has_null_new_value(struct ref_update *update)
     +{
     +	return !update->new_target && is_null_oid(&update->new_oid);
     +}
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
      	files_assert_main_repository(refs, "lock_ref_for_update");
      
     -	if ((update->flags & REF_HAVE_NEW) && is_null_oid(&update->new_oid))
    -+	if ((update->flags & REF_HAVE_NEW) && ref_update_is_null_new_value(update))
    ++	if ((update->flags & REF_HAVE_NEW) && ref_update_has_null_new_value(update))
      		update->flags |= REF_DELETING;
      
      	if (head_ref) {
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
     -	    !(update->flags & REF_DELETING) &&
     -	    !(update->flags & REF_LOG_ONLY)) {
     +	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
    -+		if (create_symref_lock(refs, lock, update->refname, update->new_target)) {
    ++		if (create_symref_lock(refs, lock, update->refname, update->new_target, err)) {
     +			ret = TRANSACTION_GENERIC_ERROR;
     +			goto out;
     +		}
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
      		if (!(update->type & REF_ISSYMREF) &&
      		    oideq(&lock->old_oid, &update->new_oid)) {
      			/*
    +@@ refs/files-backend.c: static int files_transaction_prepare(struct ref_store *ref_store,
    + 	return ret;
    + }
    + 
    ++static int parse_and_write_reflog(struct files_ref_store *refs,
    ++				  struct ref_update *update,
    ++				  struct ref_lock *lock,
    ++				  struct strbuf *err)
    ++{
    ++	if (update->new_target) {
    ++		/*
    ++		 * We want to get the resolved OID for the target, to ensure
    ++		 * that the correct value is added to the reflog.
    ++		 */
    ++		if (!refs_resolve_ref_unsafe(&refs->base, update->new_target,
    ++					     RESOLVE_REF_READING,
    ++					     &update->new_oid, NULL)) {
    ++			/*
    ++			 * TODO: currently we skip creating reflogs for dangling
    ++			 * symref updates. It would be nice to capture this as
    ++			 * zero oid updates however.
    ++			 */
    ++			return 0;
    ++		}
    ++	}
    ++
    ++	if (files_log_ref_write(refs, lock->ref_name, &lock->old_oid,
    ++				&update->new_oid, update->msg, update->flags, err)) {
    ++		char *old_msg = strbuf_detach(err, NULL);
    ++
    ++		strbuf_addf(err, "cannot update the ref '%s': %s",
    ++			    lock->ref_name, old_msg);
    ++		free(old_msg);
    ++		unlock_ref(lock);
    ++		update->backend_data = NULL;
    ++		return -1;
    ++	}
    ++
    ++	return 0;
    ++}
    ++
    + static int files_transaction_finish(struct ref_store *ref_store,
    + 				    struct ref_transaction *transaction,
    + 				    struct strbuf *err)
     @@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_store,
      
      		if (update->flags & REF_NEEDS_COMMIT ||
    @@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_
     -						&update->new_oid,
     -						update->msg, update->flags,
     -						err)) {
    -+			int create_reflog = 1;
    -+
    -+			if (update->new_target) {
    -+				/*
    -+				 * We want to get the resolved OID for the target, to ensure
    -+				 * that the correct value is added to the reflog.
    -+				 */
    -+				if (!refs_resolve_ref_unsafe(&refs->base, update->new_target,
    -+							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
    -+					/* for dangling symrefs we skip creating a reflog entry. */
    -+					create_reflog = 0;
    -+				}
    -+			}
    -+
    -+			if (create_reflog && files_log_ref_write(refs,
    -+								 lock->ref_name,
    -+								 &lock->old_oid,
    -+								 &update->new_oid,
    -+								 update->msg, update->flags,
    -+								 err)) {
    - 				char *old_msg = strbuf_detach(err, NULL);
    - 
    - 				strbuf_addf(err, "cannot update the ref '%s': %s",
    -@@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_store,
    +-				char *old_msg = strbuf_detach(err, NULL);
    +-
    +-				strbuf_addf(err, "cannot update the ref '%s': %s",
    +-					    lock->ref_name, old_msg);
    +-				free(old_msg);
    +-				unlock_ref(lock);
    +-				update->backend_data = NULL;
    ++			if (parse_and_write_reflog(refs, update, lock, err)) {
    + 				ret = TRANSACTION_GENERIC_ERROR;
      				goto cleanup;
      			}
      		}
    @@ refs/refs-internal.h: void base_ref_store_init(struct ref_store *refs, struct re
     + * takes into consideration that the update could be a regular
     + * ref or a symbolic ref.
     + */
    -+int ref_update_is_null_new_value(struct ref_update *update);
    ++int ref_update_has_null_new_value(struct ref_update *update);
     +
      #endif /* REFS_REFS_INTERNAL_H */
     
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      			 * when the reference in question doesn't exist.
      			 */
     -			 if (u->flags & REF_HAVE_NEW && !is_null_oid(&u->new_oid)) {
    -+			 if (u->flags & REF_HAVE_NEW && !ref_update_is_null_new_value(u)) {
    ++			 if ((u->flags & REF_HAVE_NEW) && !ref_update_has_null_new_value(u)) {
      				 ret = queue_transaction_update(refs, tx_data, u,
      								&current_oid, err);
      				 if (ret)
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
     +				ret = -1;
     +				goto done;
     +			}
    -+		} else if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
    ++		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
      			if (is_null_oid(&u->old_oid))
      				strbuf_addf(err, _("cannot lock ref '%s': "
      					    "reference already exists"),
    @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
      		 *   the given ref.
      		 */
     -		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
    -+		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && ref_update_is_null_new_value(u)) {
    ++		if ((u->flags & REF_HAVE_NEW) && !(u->type & REF_ISSYMREF) && ref_update_has_null_new_value(u)) {
      			struct reftable_log_record log = {0};
      			struct reftable_iterator it = {0};
      
    @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
      			    should_write_log(&arg->refs->base, u->refname))) {
      			struct reftable_log_record *log;
     +			int create_reflog = 1;
    ++
    ++			if (u->new_target) {
    ++				if (!refs_resolve_ref_unsafe(&arg->refs->base, u->new_target,
    ++							     RESOLVE_REF_READING, &u->new_oid, NULL)) {
    ++					/*
    ++					 * TODO: currently we skip creating reflogs for dangling
    ++					 * symref updates. It would be nice to capture this as
    ++					 * zero oid updates however.
    ++					 */
    ++					create_reflog = 0;
    ++				}
    ++			}
      
     -			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
     -			log = &logs[logs_nr++];
    @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
     -			memcpy(log->value.update.old_hash, tx_update->current_oid.hash, GIT_MAX_RAWSZ);
     -			log->value.update.message =
     -				xstrndup(u->msg, arg->refs->write_options.block_size / 2);
    -+			if (u->new_target)
    -+				if (!refs_resolve_ref_unsafe(&arg->refs->base, u->new_target,
    -+							     RESOLVE_REF_READING, &u->new_oid, NULL))
    -+					/* for dangling symrefs we skip creating reflog */
    -+					create_reflog = 0;
    -+
     +			if (create_reflog) {
     +				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
     +				log = &logs[logs_nr++];
    @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
      			continue;
      
     -		if (u->flags & REF_HAVE_NEW && is_null_oid(&u->new_oid)) {
    -+		if (u->flags & REF_HAVE_NEW && u->new_target) {
    ++		if (u->new_target) {
     +			struct reftable_ref_record ref = {
     +				.refname = (char *)u->refname,
     +				.value_type = REFTABLE_REF_SYMREF,
    @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
     +			ret = reftable_writer_add_ref(writer, &ref);
     +			if (ret < 0)
     +				goto done;
    -+		} else if (u->flags & REF_HAVE_NEW && ref_update_is_null_new_value(u)) {
    ++		} else if ((u->flags & REF_HAVE_NEW) && ref_update_has_null_new_value(u)) {
      			struct reftable_ref_record ref = {
      				.refname = (char *)u->refname,
      				.update_index = ts,
5:  5b55406430 ! 5:  636bf5ce98 refs: use transaction in `refs_create_symref()`
    @@ Commit message
         target. To do this, it uses a ref-backend specific function
         `create_symref()`.
     
    -    In this previous commit, we introduce symref support in transactions.
    -    This means we can now use transactions to perform symref updates and not
    -    have to resort to `create_symref()`. Doing this allows us to remove and
    -    cleanup `create_symref()`, which we will do in the following commit.
    +    In the previous commits, we introduced symref support in transactions.
    +    This means we can now use transactions to perform symref updates and
    +    don't have to resort to `create_symref()`. Doing this allows us to
    +    remove and cleanup `create_symref()`, which we will do in the following
    +    commit.
     
         Modify the expected error message for a test in
    -    't/t0610-reftable-basics.sh', since the error is now thrown from the
    +    't/t0610-reftable-basics.sh', since the error is now thrown from
         'refs.c'. This is because in transactional updates, F/D conflicts are
         caught before we're in the reference backend.
     
    @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'interleaving hook calls s
     +	git symbolic-ref refs/heads/symref refs/heads/main &&
     +
     +	cat >expect <<-EOF &&
    -+		prepared
    -+		$ZERO_OID ref:refs/heads/main refs/heads/symref
    -+		committed
    -+		$ZERO_OID ref:refs/heads/main refs/heads/symref
    ++	prepared
    ++	$ZERO_OID ref:refs/heads/main refs/heads/symref
    ++	committed
    ++	$ZERO_OID ref:refs/heads/main refs/heads/symref
     +	EOF
     +
     +	test_cmp expect actual
6:  9e25816e68 = 6:  07fb23374f refs: rename `refs_create_symref()` to `refs_update_symref()`
7:  3836e25932 ! 7:  5c05813bcc refs: remove `create_symref` and associated dead code
    @@ Commit message
         transactions to perform symref updates. Earlier `refs_create_symref()`
         used `create_symref()` to do the same.
     
    -    This means, we can now remove `create_symref()` and any code associated
    -    with it which is no longer used. We remove `create_symref()` code from
    -    all the reference backends and also remove it entirely from the
    -    `ref_storage_be` struct.
    +    We can now remove `create_symref()` and any code associated with it
    +    which is no longer used. We remove `create_symref()` code from all the
    +    reference backends and also remove it entirely from the `ref_storage_be`
    +    struct.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ refs/files-backend.c: static int create_ref_symlink(struct ref_lock *lock, const
     -
      static int create_symref_lock(struct files_ref_store *refs,
      			      struct ref_lock *lock, const char *refname,
    - 			      const char *target)
    + 			      const char *target, struct strbuf *err)
     @@ refs/files-backend.c: static int create_symref_lock(struct files_ref_store *refs,
      	return 0;
      }
    @@ refs/files-backend.c: static int create_symref_lock(struct files_ref_store *refs
     -				    struct ref_lock *lock, const char *refname,
     -				    const char *target, const char *logmsg)
     -{
    +-	struct strbuf err = STRBUF_INIT;
     -	int ret;
     -
     -	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
    @@ refs/files-backend.c: static int create_symref_lock(struct files_ref_store *refs
     -		return 0;
     -	}
     -
    --	ret = create_symref_lock(refs, lock, refname, target);
    +-	ret = create_symref_lock(refs, lock, refname, target, &err);
     -	if (!ret) {
     -		update_symref_reflog(refs, lock, refname, target, logmsg);
     -
     -		if (commit_ref(lock) < 0)
     -			return error("unable to write symref for %s: %s", refname,
     -				     strerror(errno));
    +-	} else {
    +-		return error("%s", err.buf);
     -	}
     -
     -	return ret;


Karthik Nayak (7):
  refs: accept symref values in `ref_transaction_update()`
  files-backend: extract out `create_symref_lock()`
  refs: support symrefs in 'reference-transaction' hook
  refs: add support for transactional symref updates
  refs: use transaction in `refs_create_symref()`
  refs: rename `refs_create_symref()` to `refs_update_symref()`
  refs: remove `create_symref` and associated dead code

 Documentation/githooks.txt       |  14 +-
 branch.c                         |   2 +-
 builtin/branch.c                 |   2 +-
 builtin/fast-import.c            |   5 +-
 builtin/fetch.c                  |   2 +-
 builtin/receive-pack.c           |   1 +
 builtin/replace.c                |   2 +-
 builtin/tag.c                    |   1 +
 builtin/update-ref.c             |   1 +
 builtin/worktree.c               |   2 +-
 refs.c                           |  89 +++++++++----
 refs.h                           |  20 ++-
 refs/debug.c                     |  13 --
 refs/files-backend.c             | 213 +++++++++++++++++++------------
 refs/packed-backend.c            |   1 -
 refs/refs-internal.h             |  26 +++-
 refs/reftable-backend.c          | 165 +++++++++---------------
 sequencer.c                      |   9 +-
 t/helper/test-ref-store.c        |   2 +-
 t/t0610-reftable-basics.sh       |   2 +-
 t/t1416-ref-transaction-hooks.sh |  23 ++++
 walker.c                         |   2 +-
 22 files changed, 351 insertions(+), 246 deletions(-)

-- 
2.43.GIT

