Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D96015E5D2
	for <git@vger.kernel.org>; Tue,  7 May 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086751; cv=none; b=j37yIEpbZ2tWDy0uCoHEly9Ez5NP834CNkFl1SurQQbIguAL8UMKw+Zmw8O6g6HotA9NZJZWmbGikNWCGBSp6aUa8uTCHH2z2g8v3BGxHG9Vfba8+E32UNwgXobuB7qDhoCltNN5mApx/6BP8HwPDnXFH2xup9lBd/gkrKOU+P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086751; c=relaxed/simple;
	bh=f63aLFAfxvITfIqKNnxurAtMwcJDunzkc46n3lwi7zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZS8yhv+9r1x4UUm1xx0SVe3yNPv89qN/P0bdAXCTIsOg+zyblPrjYwy3YehTKEUg67sbdCnCsyc8P7NWFQcMsJ2hLmyKxjpgrIh/CsoALhfTd8RoQgXaUwe1Ra8ZQ6Ks5S6cylT6cd3bT7z8vFTGvHuOpqqPn1Zes/j36yfzsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qzo0daKw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qzo0daKw"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34e040ed031so2192972f8f.0
        for <git@vger.kernel.org>; Tue, 07 May 2024 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715086747; x=1715691547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjAsHcpfQImSf1m2MF6Jhk4PIEDytTUMWXyPfwsc678=;
        b=Qzo0daKw54J2yXAQsBebElQbtCCRuDkQjpoF7iOZ+nNmH/Jy0UukRpDQeJgwAJ0nJ6
         ORb+/CaNoIHsqX54xeWqVsut8BcB+W5em8cqf/tkWJh6BDOHkxBQes3ls3rE6+MQ95LR
         CHUZ0z38kKakEY9iqtr8ECiQIelQuyEfw5jjDcBS3NT64INL0pWlBNxWvLBMuzEhAFHx
         pVjmZErIIDM4/Zgq0i9cT2HCEIPqKoD4IptvPbj5KX8wl2AVLkJwjRG+nCdbPNLPoaUa
         tZRam5UhrUcMFnN2jFNmFFtVawmknAea6rJbp2dxRJ+/5ODp+kYG3jWzbsJCuZthondT
         k10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715086747; x=1715691547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjAsHcpfQImSf1m2MF6Jhk4PIEDytTUMWXyPfwsc678=;
        b=TjXqHR217NdkHfVJov4T9IHziwLO3i0JujL9y4D176u+8Rp2ba7mvo+zlz71TAE9fY
         ckmV/NvnZZZZNvzNedw5KFrzfeWMdaazwBzCp15JAYKQDz5RQeCqrAizesy6MP6HdTO4
         3WkTwDI8Wap64vvOULkM3XjaLrBiFqkU7aZ9tQLwpkN6uVMSE78e2hx4fVKMMpdria6X
         v86IEA9lJqOValfPJseWtxNaaGOs55Ma5rj5q12iyCABmukMViOBTDRbh/3dxoRRfoMo
         WRm7Ifckov7o/Oa29kEj52Si3KC1w77xYPp5MQS7KDIY3jS9nXF6bEPCcPrTsqczLJlo
         15IA==
X-Gm-Message-State: AOJu0Yz7FeCv84wc9F8bArH+sK6Vo3Td47e2mjxJ7MUTrtJja7qutvwF
	ix/PTv1HKpb9Lv4BEf0hVa9a1Gi/Fs16MU2sWeZoTdDugBo9vp1w
X-Google-Smtp-Source: AGHT+IEEOTUpXbtALYSP0t++7zQEgEhaq9pOnnc807E+GBJrmJDvIQFfHhjNA1mJsFkfhYUNm+poQg==
X-Received: by 2002:adf:e850:0:b0:349:d810:9974 with SMTP id d16-20020adfe850000000b00349d8109974mr8091001wrn.17.1715086746969;
        Tue, 07 May 2024 05:59:06 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e6d6:a83d:4d4b:8baa])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0034f5925edacsm3507566wrr.30.2024.05.07.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:59:06 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v8 0/8] refs: add support for transactional symref updates
Date: Tue,  7 May 2024 14:58:51 +0200
Message-ID: <20240507125859.132116-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507060035.28602-1-knayak@gitlab.com>
References: <20240507060035.28602-1-knayak@gitlab.com>
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
V1: https://lore.kernel.org/git/20240330224623.579457-1-knayak@gitlab.com
V2: https://lore.kernel.org/git/20240412095908.1134387-1-knayak@gitlab.com
V3: https://lore.kernel.org/git/20240423212818.574123-1-knayak@gitlab.com
V4: https://lore.kernel.org/r/20240426152449.228860-1-knayak@gitlab.com
V5: https://lore.kernel.org/r/20240501202229.2695774-1-knayak@gitlab.com
V6: https://lore.kernel.org/r/20240503124115.252413-1-knayak@gitlab.com
V7: https://lore.kernel.org/r/20240507060035.28602-1-knayak@gitlab.com

Thanks for all the reviews!

Changes since v7:
* I had rebased v7 on next. I've rebased v8 on master. That's the only difference
between the two versions.

Junio, this might cause conflicts when merging, I think you resolved them for
v6 and hope its the same now. Let me know if I can help otherwise somehow. 

Changes since v6:
* Made the check for old/new oid & target more stricter by removing
the exception for null oid's.
* Extracted `ref_update_check_old_target` and `original_update_refname`
to refs.c
* ^This allowed us to generalize the error messages for non-matching
old_target values between files and reftable backend.
* Better line wrapping in code.
* Fixed some grammar in commit messages.

Range diff against v6:

1:  a354190905 ! 1:  defc1b3521 refs: accept symref values in `ref_transaction_update()`
    @@ refs.c: struct ref_update *ref_transaction_add_update(
      	if (transaction->state != REF_TRANSACTION_OPEN)
      		BUG("update called for transaction that is not open");
      
    -+	if (old_oid && !is_null_oid(old_oid) && old_target)
    ++	if (old_oid && old_target)
     +		BUG("only one of old_oid and old_target should be non NULL");
    -+	if (new_oid && !is_null_oid(new_oid) && new_target)
    ++	if (new_oid && new_target)
     +		BUG("only one of new_oid and new_target should be non NULL");
     +
      	FLEX_ALLOC_STR(update, refname, refname);
2:  0d9c5b9804 = 2:  54bb78a27c files-backend: extract out `create_symref_lock()`
3:  e0219ffd31 = 3:  c16b7c5da0 refs: support symrefs in 'reference-transaction' hook
-:  ---------- > 4:  2d268f12cc refs: move `original_update_refname` to 'refs.c'
4:  b22c59c722 ! 5:  7db3a2245f refs: add support for transactional symref updates
    @@ Commit message
         updates. While this is exposed to users via 'git-update-ref' and its
         '--stdin' mode, it is also used internally within various commands.
     
    -    However, we never supported transactional updates of symrefs. Let's add
    -    support for symrefs in both the 'files' and the 'reftable' backend.
    +    However, we do not support transactional updates of symrefs. This commit
    +    adds support for symrefs in both the 'files' and the 'reftable' backend.
     
         Here, we add and use `ref_update_has_null_new_value()`, a helper
         function which is used to check if there is a new_value in a reference
         update. The new value could either be a symref target `new_target` or a
         OID `new_oid`.
     
    -    With this, now transactional updates (verify, create, delete, update)
    -    can be used for:
    +    We also add another common function `ref_update_check_old_target` which
    +    will be used to check if the update's old_target corresponds to a
    +    reference's current target.
    +
    +    Now transactional updates (verify, create, delete, update) can be used
    +    for:
         - regular refs
         - symbolic refs
         - conversion of regular to symbolic refs and vice versa
    @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
      
      	ref_transaction_add_update(transaction, refname, flags,
      				   new_oid, old_oid, new_target,
    -@@ refs.c: int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg
    - {
    - 	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
    +@@ refs.c: const char *ref_update_original_update_refname(struct ref_update *update)
    + 	return update->refname;
      }
    -+
    + 
     +int ref_update_has_null_new_value(struct ref_update *update)
     +{
     +	return !update->new_target && is_null_oid(&update->new_oid);
     +}
    -
    - ## refs/files-backend.c ##
    -@@ refs/files-backend.c: static const char *original_update_refname(struct ref_update *update)
    - 	return update->refname;
    - }
    - 
    -+/*
    -+ * Check whether the old_target values stored in update are consistent
    -+ * with current_target, which is the symbolic reference's current value.
    -+ * If everything is OK, return 0; otherwise, write an error message to
    -+ * err and return -1.
    -+ */
    -+static int check_old_target(struct ref_update *update,
    -+			    const char *current_target,
    -+			    struct strbuf *err)
    ++
    ++int ref_update_check_old_target(const char *referent, struct ref_update *update,
    ++				struct strbuf *err)
     +{
     +	if (!update->old_target)
     +		BUG("called without old_target set");
     +
    -+	if (!strcmp(update->old_target, current_target))
    ++	if (!strcmp(referent, update->old_target))
     +		return 0;
     +
    -+	if (!strcmp(current_target, ""))
    -+		strbuf_addf(err, "cannot lock ref '%s': "
    ++	if (!strcmp(referent, ""))
    ++		strbuf_addf(err, "verifying symref target: '%s': "
     +			    "reference is missing but expected %s",
    -+			    original_update_refname(update),
    ++			    ref_update_original_update_refname(update),
     +			    update->old_target);
     +	else
    -+		strbuf_addf(err, "cannot lock ref '%s': "
    ++		strbuf_addf(err, "verifying symref target: '%s': "
     +			    "is at %s but expected %s",
    -+			    original_update_refname(update),
    -+			    current_target, update->old_target);
    -+
    ++			    ref_update_original_update_refname(update),
    ++			    referent, update->old_target);
     +	return -1;
     +}
    -+
    - /*
    -  * Check whether the REF_HAVE_OLD and old_oid values stored in update
    -  * are consistent with oid, which is the reference's current value. If
    +
    + ## refs/files-backend.c ##
    +@@ refs/files-backend.c: static int split_symref_update(struct ref_update *update,
    + 
    + 	new_update = ref_transaction_add_update(
    + 			transaction, referent, new_flags,
    +-			&update->new_oid, &update->old_oid,
    +-			NULL, NULL, update->msg);
    ++			update->new_target ? NULL : &update->new_oid,
    ++			update->old_target ? NULL : &update->old_oid,
    ++			update->new_target, update->old_target, update->msg);
    + 
    + 	new_update->parent_update = update;
    + 
     @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *refs,
      
      	files_assert_main_repository(refs, "lock_ref_for_update");
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
     +			}
     +
     +			if (update->old_target) {
    -+				if (check_old_target(update, referent.buf, err)) {
    ++				if (ref_update_check_old_target(referent.buf, update, err)) {
     +					ret = TRANSACTION_GENERIC_ERROR;
     +					goto out;
     +				}
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
     +		 * be set for symrefs, but we're strict about its usage.
     +		 */
     +		if (update->old_target) {
    -+			if (check_old_target(update, referent.buf, err)) {
    ++			if (ref_update_check_old_target(referent.buf, update, err)) {
     +				ret = TRANSACTION_GENERIC_ERROR;
     +				goto out;
     +			}
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
     -	    !(update->flags & REF_DELETING) &&
     -	    !(update->flags & REF_LOG_ONLY)) {
     +	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
    -+		if (create_symref_lock(refs, lock, update->refname, update->new_target, err)) {
    ++		if (create_symref_lock(refs, lock, update->refname,
    ++				       update->new_target, err)) {
     +			ret = TRANSACTION_GENERIC_ERROR;
     +			goto out;
     +		}
    @@ refs/files-backend.c: static int files_transaction_finish(struct ref_store *ref_
      			if (commit_ref(lock)) {
     
      ## refs/refs-internal.h ##
    -@@ refs/refs-internal.h: void base_ref_store_init(struct ref_store *refs, struct repository *repo,
    +@@ refs/refs-internal.h: struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_stor
       */
    - struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store);
    + const char *ref_update_original_update_refname(struct ref_update *update);
      
     +/*
     + * Helper function to check if the new value is null, this
    @@ refs/refs-internal.h: void base_ref_store_init(struct ref_store *refs, struct re
     + * ref or a symbolic ref.
     + */
     +int ref_update_has_null_new_value(struct ref_update *update);
    ++
    ++/*
    ++ * Check whether the old_target values stored in update are consistent
    ++ * with the referent, which is the symbolic reference's current value.
    ++ * If everything is OK, return 0; otherwise, write an error message to
    ++ * err and return -1.
    ++ */
    ++int ref_update_check_old_target(const char *referent, struct ref_update *update,
    ++				struct strbuf *err);
     +
      #endif /* REFS_REFS_INTERNAL_H */
     
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      		 */
     -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
     +		if (u->old_target) {
    -+			if (strcmp(referent.buf, u->old_target)) {
    -+				if (!strcmp(referent.buf, ""))
    -+					strbuf_addf(err, "verifying symref target: '%s': "
    -+						    "reference is missing but expected %s",
    -+						    original_update_refname(u),
    -+						    u->old_target);
    -+				else
    -+					strbuf_addf(err, "verifying symref target: '%s': "
    -+						    "is at %s but expected %s",
    -+						    original_update_refname(u),
    -+						    referent.buf, u->old_target);
    ++			if (ref_update_check_old_target(referent.buf, u, err)) {
     +				ret = -1;
     +				goto done;
     +			}
     +		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old_oid)) {
      			if (is_null_oid(&u->old_oid))
      				strbuf_addf(err, _("cannot lock ref '%s': "
    - 					    "reference already exists"),
    + 						   "reference already exists"),
     @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
      		 * - `core.logAllRefUpdates` tells us to create the reflog for
      		 *   the given ref.
      		 */
     -		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
    -+		if ((u->flags & REF_HAVE_NEW) && !(u->type & REF_ISSYMREF) && ref_update_has_null_new_value(u)) {
    ++		if ((u->flags & REF_HAVE_NEW) &&
    ++		    !(u->type & REF_ISSYMREF) &&
    ++		    ref_update_has_null_new_value(u)) {
      			struct reftable_log_record log = {0};
      			struct reftable_iterator it = {0};
      
    @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writ
     +				fill_reftable_log_record(log);
     +				log->update_index = ts;
     +				log->refname = xstrdup(u->refname);
    -+				memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
    -+				memcpy(log->value.update.old_hash, tx_update->current_oid.hash, GIT_MAX_RAWSZ);
    ++				memcpy(log->value.update.new_hash,
    ++				       u->new_oid.hash, GIT_MAX_RAWSZ);
    ++				memcpy(log->value.update.old_hash,
    ++				       tx_update->current_oid.hash, GIT_MAX_RAWSZ);
     +				log->value.update.message =
     +					xstrndup(u->msg, arg->refs->write_options.block_size / 2);
     +			}
5:  636bf5ce98 = 6:  354ebbe17f refs: use transaction in `refs_create_symref()`
6:  07fb23374f = 7:  c8a23b3454 refs: rename `refs_create_symref()` to `refs_update_symref()`
7:  5c05813bcc = 8:  fa1b8f445b refs: remove `create_symref` and associated dead code


Karthik Nayak (8):
  refs: accept symref values in `ref_transaction_update()`
  files-backend: extract out `create_symref_lock()`
  refs: support symrefs in 'reference-transaction' hook
  refs: move `original_update_refname` to 'refs.c'
  refs: add support for transactional symref updates
  refs: use transaction in `refs_create_symref()`
  refs: rename `refs_create_symref()` to `refs_update_symref()`
  refs: remove `create_symref` and associated dead code

 Documentation/githooks.txt       |  14 ++-
 branch.c                         |   2 +-
 builtin/branch.c                 |   2 +-
 builtin/fast-import.c            |   5 +-
 builtin/fetch.c                  |   2 +-
 builtin/receive-pack.c           |   1 +
 builtin/replace.c                |   2 +-
 builtin/tag.c                    |   1 +
 builtin/update-ref.c             |   1 +
 builtin/worktree.c               |   2 +-
 refs.c                           | 119 ++++++++++++++----
 refs.h                           |  20 ++-
 refs/debug.c                     |  13 --
 refs/files-backend.c             | 208 +++++++++++++++++--------------
 refs/packed-backend.c            |   1 -
 refs/refs-internal.h             |  40 +++++-
 refs/reftable-backend.c          | 183 +++++++++------------------
 sequencer.c                      |   9 +-
 t/helper/test-ref-store.c        |   2 +-
 t/t0610-reftable-basics.sh       |   2 +-
 t/t1416-ref-transaction-hooks.sh |  23 ++++
 walker.c                         |   2 +-
 22 files changed, 374 insertions(+), 280 deletions(-)

-- 
2.43.GIT

