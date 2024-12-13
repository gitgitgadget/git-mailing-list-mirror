Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5A1B652B
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086216; cv=none; b=X/yFfz0Y953q7xx6chec6NwUfsnRS0DPhJLUbjS1MGDmSOrc7kOqYFqchl5J9Qk8P2r49JvNumHpEIxbrhz232AsPfnce5aqVSZeaEWGR5LpFfUcGDC6VDMWdi8CIO47l/W51vdZle/B2QbgIfb+vCZG1SOID9b2/hCIEeN7a0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086216; c=relaxed/simple;
	bh=buj4PE/moNptKODNI1HRKT82rOiHBvmwEdzgihaj6Wc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=IgVZxak9X6Lxj/wsYXno6p8sRiC86KpHtqALKmO65/yOC7n+T57nDVE31XRr2g1/Um0J/KR3xUlmAIFeO+PF+zxfb7fRPLyAq17yWYFvqYwNqPxPbEzIryPNlC4oOcZEMvFYB0xfdG80yboMjb3vfVfy/ycYsXRDz8iFJSUgL3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BErjYXup; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BErjYXup"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so323962566b.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2024 02:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734086211; x=1734691011; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlLGvpFY+AO44zN3oMcgDtVGxOtNUAG/JFHix+gKI2c=;
        b=BErjYXup3sDfKb121k0WXysvXe2SQ9ya8jrarFUJe3J3rVw1PxGX3bqufvnCCyROgr
         rTbcmgaMT583udpFoCoZ59lQZM6ev7agYqgzqJ2D8mTgIFn1/nsFnH92SfYCIPdfHfdH
         f0kD5A7Ns1uIYrtDUsnTfDzF06VmlD4EMUyru6Ho9PApqUHLflwpCfYzuhqojzwAPGLS
         hFmWYcJciS53g8856Oa8x0jP37hLMoinPFrELojV7hW5dOm1yRsBVypp6z7jcAFj/ZUa
         2p7WWDKl0/5Rqr0q9y4GhKDW92fPDMY16dKbJ2+zWhJpgOvy5qGb4CIaL/kRIZhKC6tB
         hTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734086211; x=1734691011;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NlLGvpFY+AO44zN3oMcgDtVGxOtNUAG/JFHix+gKI2c=;
        b=Np/09QPAaDC4TkiAgZ5m3P2smIh+b0so7PB0mZ6C9dGFsZxSunozxlVwRe0arnwtwC
         DappilbqqDzhQ8SQinoP/A6Luz/RgpkTioxno/VuBKzJKIEE/6OdsXwyvSKnToKgDxdI
         rPMaJLo1esvdBpkp9PPFHio/+frTRZxms2c6ymCQq/G2pKw8n8SI4ClVVRk7n5sVATUi
         pWdDdH0oIMtEaxrCh7ocmfp82ENo2EUbIyh+Lu6uTP5MP8ZTrS9uwQAqOKx3Fd/5ekM1
         H2CpClYRyrGNMGepwrEdUqLuarh8C5LFrptNhRk575Q1/rd9IxrYbjQjMigwHYuWx5iw
         fxmA==
X-Gm-Message-State: AOJu0YxeVidsoOZ0XM1JmWmFqrNnoBXoB7P3l6HKj9HrQvQqxlT87LFH
	MHaLaZYwrplOfLVXr55wEubefEWMh6zTI5lLHCatSl1KGYgsZghK
X-Gm-Gg: ASbGnct7Pk6DhY64ektxqbJV/EIYrBhS+rl+qOkiSNvZCP205Xx9gs7kyhZYHK/+re2
	I/vOsQlT1ru4z42nsBKHQsrK4biWu26dImkmpSe7JWaTNkArMdAzw9WhMmCUcqcStdTZonHmjjM
	bcMacLMhVWEbLY10fm5o08tYU2oNnrbQx2XHQp+mcD/engda22l1FLZKR/4fPzIlU2ZA7yMPM8h
	npXg6hgNQD/8U8naWNkw2n9UeDGVklllUbYj/FkDsSDgwXBkO7hP1SAiHBk+TlPBxoYOQ==
X-Google-Smtp-Source: AGHT+IHuVOWjdot/uwe24tuh9W7B0J1qbaC3JuBwxhnQO7sigzegNcZpGTFH2MLPxmiXifPKmlhD4Q==
X-Received: by 2002:a17:907:72cb:b0:aa6:af4b:7c88 with SMTP id a640c23a62f3a-aab77ec58cdmr240580266b.57.1734086211121;
        Fri, 13 Dec 2024 02:36:51 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6883f65c3sm686785266b.157.2024.12.13.02.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 02:36:50 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/8] refs: add reflog support to `git refs migrate`
Date: Fri, 13 Dec 2024 11:36:45 +0100
Message-Id: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD0OXGcC/32NwQ6CMBBEf4Xs2TWlRRRP/ofhUMu2bAKUtIRoS
 P/dgnfn9maSNxtECkwR7sUGgVaO7KcM8lSA6fXkCLnLDFLIqsxBJQU6XjCQjTiyC3qhHQbvIuq
 LIqVrY61pICvmPPD70D/bzD3HxYfP8baWe/sTS9H8F68lCuyql1FXolst7MONmoez8SO0KaUvL
 sC5wcgAAAA=
X-Change-ID: 20241111-320-git-refs-migrate-reflogs-a53e3a6cffc9
In-Reply-To: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15106;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=buj4PE/moNptKODNI1HRKT82rOiHBvmwEdzgihaj6Wc=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXA5AW4W8R1FkcysUj1PDNqSgNIEBSGSVZ2n8R
 6BF4z3FJVuJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1wOQAAKCRA+1Z8kjkaM
 f2UbC/94+z2fs3lh5bteGIEWPqLMq9NVXS5n5UaHHdEtEpmbXxHSFrsv5lT210wGDWCRxwx4SZp
 4NQPuApZiW4ta3iTHcC80VM6FZwYhWE5QgKXFsZ1T5MQTtiEYD5sgmglCQhdzl/YVgKHd6k5XIQ
 hSVt7wGA1it7PsEd3cMcf9W9AaQwC6lRQy3JZuQBfJmvh5nzq2wxUTgHGLD/K/O6d8Z7Pwwx5Px
 YnDRXC9zIPTxWPJkiGE4WDR/tdNxrZn/b+CjDdtapXL2ziS+d8xBEPS0Jr9DGSzz1TbyVRhPY2x
 vJ/w2tkEtvFYTBcT+SSx9lQeQgOQDAH1BF7F+B5DFxQttpTFWQqLEW86QB0mQdT7BFTvQcB8wC3
 NrNaYECh4WH0MoXf1cleaTSu/pWZ0DwFkCuAJaPppplTiJLPMuUjirmXjQn7HcK61EzOErEhHrO
 HGF6BKs1hngUcAj9h6jZMpyhCdn/UaTaY4/bvk3ej0taQCA7ZUPv0ca/pPSRnr8uXI50Y=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git refs migrate` command was introduced in
25a0023f28 (builtin/refs: new command to migrate ref storage formats,
2024-06-06) to support migrating from one reference backend to another.

One limitation of the feature was that it didn't support migrating
repositories which contained reflogs. This isn't a requirement on the
server side as repositories are stored as bare repositories (which do
not contain any reflogs). Clients however generally use reflogs and
until now couldn't use the `git refs migrate` command to migrate their
repositories to the new reftable format.

One of the issues for adding reflog support is that the ref transactions
don't support reflogs additions:
  1. While there is REF_LOG_ONLY flag, there is no function to utilize
  the flag and add reflogs.
  2. reference backends generally sort the updates by the refname. This
  wouldn't work for reflogs which need to ensure that they maintain the
  order of creation.
  3. In the files backend, reflog entries are added by obtaining locks
  on the refs themselves. This means each update in the transaction, will
  obtain a ref_lock. This paradigm fails to accompany the fact that there
  could be multiple reflog updates for a refname in a single transaction.
  4. The backends check for duplicate entries, which doesn't make sense
  in the context of adding multiple reflogs for a given refname.

We overcome these issue we make the following changes:
  - Update the ref_update structure to also include the committer
  information. Using this, we can add a new function which only adds
  reflog updates to the transaction.
  - Add an index field to the ref_update structure, this will help order
  updates in pre-defined order, this fixes #2.
  - While the ideal fix for #3 would be to actually introduce reflog
  locks, this wouldn't be possible without breaking backward
  compatibility. So we add a count field to the existing ref_lock. With
  this, multiple reflog updates can share a single ref_lock.

Overall, this series is a bit more involved, and I would appreciate it
if it receives a bit more scrutiny.

The series is based on top of e66fd72e97 (The fourteenth batch,
2024-12-06) with `kn/reftable-writer-log-write-verify` merged in.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v2:
- Split patch 5 into two separate patches. This should make it easier to
  review and reduce cognitive load in a single patch.
- In reftable backend, instead of using `strmapint` to ensure we have
  new update_indexes for reflogs with the same refname, we now use the
  already available `update->index` field to increment the update_index.
- Cleanup the code and follow some of the better practices.
- Add some clarity to the commit messages.
- Link to v1: https://lore.kernel.org/r/20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com

---
Karthik Nayak (8):
      refs: include committer info in `ref_update` struct
      refs: add `index` field to `struct ref_udpate`
      refs/files: add count field to ref_lock
      refs: extract out refname verification in transactions
      refs: add `committer_info` to `ref_transaction_add_update()`
      refs: introduce the `ref_transaction_update_reflog` function
      refs: allow multiple reflog entries for the same refname
      refs: add support for migrating reflogs

 Documentation/git-refs.txt |   2 -
 refs.c                     | 168 +++++++++++++++++++++++++++++++++------------
 refs.h                     |  12 ++++
 refs/files-backend.c       | 131 +++++++++++++++++++++++------------
 refs/refs-internal.h       |   9 +++
 refs/reftable-backend.c    |  53 +++++++++++---
 t/t1460-refs-migrate.sh    |  73 ++++++++++++++------
 7 files changed, 328 insertions(+), 120 deletions(-)
---

Range-diff versus v1:

1:  627104646c ! 1:  81a493ae20 refs: include committer info in `ref_update` struct
    @@ refs/files-backend.c: static int commit_ref_update(struct files_ref_store *refs,
      			struct strbuf log_err = STRBUF_INIT;
     -			if (files_log_ref_write(refs, "HEAD",
     -						&lock->old_oid, oid,
    +-						logmsg, flags, &log_err)) {
     +			if (files_log_ref_write(refs, "HEAD", &lock->old_oid,
    -+						oid, git_committer_info(0),
    - 						logmsg, flags, &log_err)) {
    ++						oid, NULL, logmsg, flags,
    ++						&log_err)) {
      				error("%s", log_err.buf);
      				strbuf_release(&log_err);
    + 			}
     @@ refs/files-backend.c: static int parse_and_write_reflog(struct files_ref_store *refs,
      	}
      
2:  7bc7c7cb1b = 2:  3c4d53de5c refs: add `index` field to `struct ref_udpate`
3:  807fff5d50 ! 3:  598ad493af refs/files: add count field to ref_lock
    @@ Commit message
     
         The upcoming patches will add support for reflog updates in ref
         transaction. This means, in a particular transaction we want to have ref
    -    updates and reflog updates. For refs, in a given transaction there can
    -    only be one update. But, we can theoretically have multiple reflog
    -    updates in a given transaction.
    +    updates and reflog updates. For a given ref in a given transaction there
    +    can be at most one update. But we can theoretically have multiple reflog
    +    updates for a given ref in a given transaction. A great example of this
    +    would be when migrating reflogs from one backend to another. There we
    +    would batch all the reflog updates for a given reference in a single
    +    transaction.
     
         The current flow does not support this, because currently refs & reflogs
         are treated as a single entity and capture the lock together. To
    @@ refs/files-backend.c: struct ref_lock {
      	char *ref_name;
      	struct lock_file lk;
      	struct object_id old_oid;
    -+	/* count keeps track of users of the lock */
    -+	unsigned int count;
    ++	unsigned int count; /* track users of the lock (ref update + reflog updates) */
      };
      
      struct files_ref_store {
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
     -		char *reason;
     +	lock = strmap_get(&backend_data->ref_locks, update->refname);
     +	if (lock) {
    -+		lock->count = lock->count + 1;
    ++		lock->count++;
     +	} else {
     +		ret = lock_raw_ref(refs, update->refname, mustexist,
     +				   affected_refnames,
4:  33473ad609 < -:  ---------- refs: extract out refname verification in transactions
5:  ae85d9e340 < -:  ---------- refs: introduce the `ref_transaction_update_reflog` function
-:  ---------- > 4:  64a3cbd91d refs: extract out refname verification in transactions
-:  ---------- > 5:  888f96facb refs: add `committer_info` to `ref_transaction_add_update()`
-:  ---------- > 6:  9253e1ceda refs: introduce the `ref_transaction_update_reflog` function
6:  b49872a6b5 ! 7:  6d12784851 refs: allow multiple reflog entries for the same refname
    @@ Metadata
      ## Commit message ##
         refs: allow multiple reflog entries for the same refname
     
    -    The reference transaction only allows a update for a given reference to
    -    avoid conflicts. This, however, isn't an issue for reflogs. There are no
    -    conflicts to be resolved in reflogs and when migrating reflogs between
    -    backends we'd have multiple reflog entries for the same refname.
    +    The reference transaction only allows a single update for a given
    +    reference to avoid conflicts. This, however, isn't an issue for reflogs.
    +    There are no conflicts to be resolved in reflogs and when migrating
    +    reflogs between backends we'd have multiple reflog entries for the same
    +    refname.
     
         So allow multiple reflog updates within a single transaction. Also the
         reflog creation logic isn't exposed to the end user. While this might
         change in the future, currently, this reduces the scope of issues to
         think about.
     
    -    This is required to add reflog migration support to `git refs migrate`
    -    which currently doesn't support it.
    +    In the reftable backend, the writer sorts all updates based on the
    +    update_index before writing to the block. When there are multiple
    +    reflogs for a given refname, it is essential that the order of the
    +    reflogs is maintained. So add the `index` value to the `update_index`.
    +    The `index` field is only be set when multiple reflog entries for a
    +    given refname are added and as such in most scenarios the old behavior
    +    remains.
    +
    +    This is required to add reflog migration support to `git refs migrate`.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      
      	/*
     @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
    + 	struct reftable_log_record *logs = NULL;
      	struct ident_split committer_ident = {0};
      	size_t logs_nr = 0, logs_alloc = 0, i;
    ++	uint64_t max_update_index = ts;
      	const char *committer_info;
    -+	struct strintmap logs_ts;
      	int ret = 0;
      
    - 	committer_info = git_committer_info(0);
    -@@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
    - 
    - 	QSORT(arg->updates, arg->updates_nr, transaction_update_cmp);
    - 
    -+	strintmap_init(&logs_ts, ts);
    -+
    - 	reftable_writer_set_limits(writer, ts, ts);
    - 
    - 	for (i = 0; i < arg->updates_nr; i++) {
    -@@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
    - 
    - 			if (create_reflog) {
    - 				struct ident_split c;
    -+				uint64_t update_index;
    - 
    - 				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
    - 				log = &logs[logs_nr++];
     @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
      				}
      
      				fill_reftable_log_record(log, &c);
     -				log->update_index = ts;
     +
    -+				update_index = strintmap_get(&logs_ts, u->refname);
    -+				log->update_index = update_index;
    -+				strintmap_set(&logs_ts, u->refname, update_index+1);
    ++				/*
    ++				 * Updates are sorted by the writer. So updates for the same
    ++				 * refname need to contain different update indices.
    ++				 */
    ++				log->update_index = ts + u->index;
    ++
    ++				/*
    ++				 * Note the max update_index so the limit can be set later on.
    ++				 */
    ++				if (log->update_index > max_update_index)
    ++					max_update_index = log->update_index;
     +
      				log->refname = xstrdup(u->refname);
      				memcpy(log->value.update.new_hash,
      				       u->new_oid.hash, GIT_MAX_RAWSZ);
     @@ refs/reftable-backend.c: static int write_transaction_table(struct reftable_writer *writer, void *cb_data
    - 
    - done:
    - 	assert(ret != REFTABLE_API_ERROR);
    -+	strintmap_clear(&logs_ts);
    - 	for (i = 0; i < logs_nr; i++)
    - 		reftable_log_record_release(&logs[i]);
    - 	free(logs);
    + 	 * and log blocks.
    + 	 */
    + 	if (logs) {
    ++		reftable_writer_set_limits(writer, ts, max_update_index);
    ++
    + 		ret = reftable_writer_add_logs(writer, logs, logs_nr);
    + 		if (ret < 0)
    + 			goto done;
7:  0df1005b2b ! 8:  06dba479d6 refs: add support for migrating reflogs
    @@ refs.c: int ref_update_check_old_target(const char *referent, struct ref_update
      }
      
      struct migration_data {
    -+	unsigned int index;
    ++	unsigned int reflog_index;
      	struct ref_store *old_refs;
      	struct ref_transaction *transaction;
      	struct strbuf *errbuf;
    @@ refs.c: static int migrate_one_ref(const char *refname, const char *referent UNU
     +	data.old_refs = migration_data->old_refs;
     +	data.transaction = migration_data->transaction;
     +	data.errbuf = migration_data->errbuf;
    -+	data.index = &migration_data->index;
    ++	data.index = &migration_data->reflog_index;
     +
     +	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
     +					migrate_one_reflog_entry, &data);
    @@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
      	 * Worktrees complicate the migration because every worktree has a
      	 * separate ref storage. While it should be feasible to implement, this
     @@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
    - 	 *   1. Set up a new temporary directory and initialize it with the new
    - 	 *      format. This is where all refs will be migrated into.
    - 	 *
    --	 *   2. Enumerate all refs and write them into the new ref storage.
    --	 *      This operation is safe as we do not yet modify the main
    -+	 *   2. Enumerate all refs and reflogs and write them into the new ref
    -+	 *      storage. This operation is safe as we do not yet modify the main
    + 	 *      This operation is safe as we do not yet modify the main
      	 *      repository.
      	 *
    - 	 *   3. If we're in dry-run mode then we are done and can hand over the
    +-	 *   3. If we're in dry-run mode then we are done and can hand over the
    ++	 *   3. Enumerate all reflogs and write them into the new ref storage.
    ++	 *      This operation is safe as we do not yet modify the main
    ++	 *      repository.
    ++	 *
    ++	 *   4. If we're in dry-run mode then we are done and can hand over the
    + 	 *      directory to the caller for inspection. If not, we now start
    + 	 *      with the destructive part.
    + 	 *
    +-	 *   4. Delete the old ref storage from disk. As we have a copy of refs
    ++	 *   5. Delete the old ref storage from disk. As we have a copy of refs
    + 	 *      in the new ref storage it's okay(ish) if we now get interrupted
    + 	 *      as there is an equivalent copy of all refs available.
    + 	 *
    +-	 *   5. Move the new ref storage files into place.
    ++	 *   6. Move the new ref storage files into place.
    + 	 *
    +-	 *   6. Change the repository format to the new ref format.
    ++	 *  7. Change the repository format to the new ref format.
    + 	 */
    + 	strbuf_addf(&new_gitdir, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
    + 	if (!mkdtemp(new_gitdir.buf)) {
     @@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
      	if (ret < 0)
      		goto done;
      
    -+	data.index = 1;
    ++	data.reflog_index = 1;
     +	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
     +	if (ret < 0)
     +		goto done;


--- 

base-commit: 09245f4b75863f4e94dac7feebaafce53a26965f
change-id: 20241111-320-git-refs-migrate-reflogs-a53e3a6cffc9

Thanks
- Karthik

