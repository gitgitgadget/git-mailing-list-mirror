Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005C1465A5
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734279957; cv=none; b=PQa5lOuoDIHEOEwokXzlU3dU+L7UA5cttpu99DBJMV2YcEvchw1w+IjBTIV1ElvNZC1mnoNiVOJo5vgM/OLGxQ5bGNGhHx3HwQNMS9YPGHKs38IEVYOkS4KMmSsxoQBwWTOkyevzvHeddznd89rIxAThNturmaIBQtW6zZP3N/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734279957; c=relaxed/simple;
	bh=CWEVI3SfICsljbcXmBRBpf7HRM6AMjudHPMJvnzitlY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=FzneMvqbljf2jaU6HABaqPBmHc1Uqmecd+OAwGQXnpMp3BCz8+v4wtDybInvZFrvslVniHoS011Xxg+XkWT81LsfZzViFGOlOz6BW5nD+aKXV/Ww+IHLRNu91oypQiXAOZS3zE59VZm7x52AuaBjiWSXBzVtEU9tffK4EgklQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ns2EdjPh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns2EdjPh"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa543c4db92so674371966b.0
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 08:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734279953; x=1734884753; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UguxWZaA7vjIISEOs9KAw3Hr9ABpaJuoVZyPmEBZig=;
        b=Ns2EdjPhCa72t0tPfvJlnm5JQ+IiykaLNNVa31NNyzfqb1TLFlDb5LwyfQ/GtWWxgD
         1rWdhbHSX8GznY7n47b1fPILTOS4b25jFmgL3DcxsjeKgPLf0Ma9jmJIaRBiyLa1/3qG
         ugZtcU5pY1jT4VeX4Oaa8w7+JyfP0KJ3D4EUUqXBzalx4kWnlOmGboqNf46C0ldUccJr
         YMX/IOIZKEtKQoHR1xxZu4GPqrTHp++O8QwTEc/rP0BN55r2Uh5PVqQc34xJHecuZRq1
         I4A4xMDi2BMzBLz61FkqykqPO3nNNdKl/Ywx/qeXal2lB2PqV7RXibZG+baEt8g29P+q
         X4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734279953; x=1734884753;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8UguxWZaA7vjIISEOs9KAw3Hr9ABpaJuoVZyPmEBZig=;
        b=BRXl/EHfZr8pfoLpsA7tyzv36tz5UAQeRCG66rW0C7C7jqS+SSuOWkuexnOtH4l23/
         GAqnXxI/wcsZ5Tu/dRmuGU+wpJj5eQ95vMIyXLTwhSJSMup9DxiC22CyGrxgJ0vQzRny
         4Sp+tQsl/yxPgpO0zHql/JAluVZbfOWeFsVE4a7p8h6FEzhjuURP4j/spv8SCgdeXNve
         B6dmPS4EQgbNVieOQu8kY9U9UFyAyY5bAGRm5fS32m/7IxxJVJusH7p5hD3AJ0Ssn4V3
         2JKVaw3Jrv8Pu57ZdxkIwsf2OrSyrbDU7vIUrD54fzfrtp+KcKi8EoPRpHtatDANY5gg
         g6Qw==
X-Gm-Message-State: AOJu0Yw9RL27YmWxeVffvgoy9y/pQG6RvNI2syIC69vYbSb7O430j32D
	FmIXCTMQucYgrPkSQKvKLP1+vYkDFrSB8/6nTdfhIKu2/hA00g1p
X-Gm-Gg: ASbGncsLgZ7WJb8mW9KdvMH0icG8UkvRJ30/tF0p0JWH8mGr8cIdSSdb8kLJIcgVM7F
	X5N4SZCw8XiO8fK/9Mg5P223i9mOwOOa+Rl2IZsgii59WBrzwIuy4DvQIMYSKmdh9IClzbLNSI4
	gXxa6zgG21IZl852njRlNOG6/2zT2s1+3hQSGFViBESS9xCUuBxYB/rIQv+L2puMNXeM5/8Z6YC
	bNmCBVkWXkoAc7JUcbTakIsBHwG6fTbxDOLCQRxl9Mrdbe2ke2oW5nHn+i72XdOh8CbSw==
X-Google-Smtp-Source: AGHT+IGcmxRGWZv1dgphbuD+RpPepT3aDgKjZh8zq3tXIdGnwBi3EFBEJTx6nWLvWQSmpFdaVM86+A==
X-Received: by 2002:a17:907:9491:b0:aa6:84c3:70e2 with SMTP id a640c23a62f3a-aab77909e8fmr1164572866b.20.1734279952856;
        Sun, 15 Dec 2024 08:25:52 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ad1asm224887866b.139.2024.12.15.08.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:25:52 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/8] refs: add reflog support to `git refs migrate`
Date: Sun, 15 Dec 2024 17:25:37 +0100
Message-Id: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAIDX2cC/4XNzQ6CMAzA8VchO1uzD0T05HsYD2N0owkws5FFQ
 3h3B144aW//Nvl1ZhEDYWTXYmYBE0XyYw51KJjp9OgQqM3NJJelyANKcnA0QUAbYSAX9IRr9N5
 F0CeFSlfGWnNhmXjmA702/v7I3VGcfHhv35JYt19Y8stvOAng0JaNUWfEuuL25gZN/dH4ga1wk
 jtMqD+YzJiVtRLStE1l+B5bluUDLP7JWhUBAAA=
X-Change-ID: 20241111-320-git-refs-migrate-reflogs-a53e3a6cffc9
In-Reply-To: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14186;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=CWEVI3SfICsljbcXmBRBpf7HRM6AMjudHPMJvnzitlY=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnXwMGDm4CIRCBO4tOYy3TeGa7XTD0oZrMTcmLV
 +qA2PnjXYaJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ18DBgAKCRA+1Z8kjkaM
 fyjdC/45fzTOJSFibNkYKvVUy+pxaa+KpBunGaRJpcFYIAkWLVMkcFsxuMslg5nNVYiyNFIvzCg
 8y4FN9DucC+JTu0DdisB/KMsrorakck6r3iqVyk7oIIIq8svfgn5YOPLFFIEeN0QQBQRgm2psW1
 PaIurOG4yJon7NQkRykO4b6pmNJY7mZ3aD+8qq2VbqE6Ovg5xbjTDHpDDQLKND9f2Tuj3OEUdfz
 a987LyR/9U01vZ+qHvTaHaucCSWJ8U7iuiIP3porYR7bVydN2sA3U0H5wGX5Z6U2K698qXuEfGN
 c/0Hg9cuEPh8x69ewONltBOJvlbBuVY8OpZf9dyjligcvFdOTS1Vid88Ar6fSwCY/bYmLkaan94
 k5gAN6fZPk25408HuYt8OF+PxM7HsqdwrBqBA/2GnqrPcLNeR7RV+9sRJZEU36k6Na4yINeMARB
 WTmxR+kF3rCLwpewaxU8rreWXjcruABytCEu+jh/DJ6OdkGWlzyhrXj8QPqNU5rf8ijoI=
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
Changes in v3:
- patch 5: Use `xstrdup_or_null` unconditionally. 
- patch 6: In `transaction_refname_valid()` use the transaction flags
  to identify reflogs. Update the documentation to also mention the
  purpose of the `index` field.
- patch 8: Instead of allocating an strbuf for each reflog entry, we 
  store and re-use one in the migration callback data.
- patch 8: Don't use a global index increment for all reflogs entries,
  instead create and use one per reflog.
- patch 8: Avoid setting the first reflog index to `1`. This would default
  to `0` as the first index, which is okay, since the index is incremented
  for consequtive reflog entries.
- Small typo fixes. 
- Thanks to Christian and Patrick for the review!  
- Link to v2: https://lore.kernel.org/all/20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com/

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
 refs.c                     | 165 +++++++++++++++++++++++++++++++++------------
 refs.h                     |  14 ++++
 refs/files-backend.c       | 131 ++++++++++++++++++++++-------------
 refs/refs-internal.h       |   9 +++
 refs/reftable-backend.c    |  53 ++++++++++++---
 t/t1460-refs-migrate.sh    |  73 ++++++++++++++------
 7 files changed, 327 insertions(+), 120 deletions(-)
---

Range-diff versus v2:

1:  d9bd20468c = 1:  d1c06e34bf refs: include committer info in `ref_update` struct
2:  8478eeac95 = 2:  33e65a965a refs: add `index` field to `struct ref_udpate`
3:  913fd320f0 = 3:  34c5beccb6 refs/files: add count field to ref_lock
4:  66b86b5807 = 4:  4fceb64954 refs: extract out refname verification in transactions
5:  33ad1774d4 ! 5:  3c5abd0047 refs: add `committer_info` to `ref_transaction_add_update()`
    @@ refs.c: struct ref_update *ref_transaction_add_update(
      		oidcpy(&update->old_oid, old_oid);
     -	if (!(flags & REF_SKIP_CREATE_REFLOG))
     +	if (!(flags & REF_SKIP_CREATE_REFLOG)) {
    -+		if (committer_info)
    -+			update->committer_info = xstrdup(committer_info);
    -+
    ++		update->committer_info = xstrdup_or_null(committer_info);
      		update->msg = normalize_reflog_message(msg);
     +	}
      
6:  cdbb15b11a ! 6:  9e12f16b96 refs: introduce the `ref_transaction_update_reflog` function
    @@ Commit message
           means clients can add reflog entries with custom committer
           information.
     
    +    The `transaction_refname_valid()` function also modifies the error
    +    message selectively based on the type of the update. This change also
    +    affects reflog updates which go through `ref_transaction_update()`.
    +
         A follow up commit will utilize this function to add reflog support to
         `git refs migrate`.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## refs.c ##
    -@@ refs.c: struct ref_update *ref_transaction_add_update(
    - 
    - static int transaction_refname_valid(const char *refname,
    - 				     const struct object_id *new_oid,
    --				     unsigned int flags, struct strbuf *err)
    -+				     unsigned int flags, unsigned int reflog,
    -+				     struct strbuf *err)
    - {
    - 	if (flags & REF_SKIP_REFNAME_VERIFICATION)
    +@@ refs.c: static int transaction_refname_valid(const char *refname,
      		return 1;
      
      	if (is_pseudo_ref(refname)) {
     -		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
     -			    refname);
    -+		const char *what = reflog ? "reflog for pseudoref" : "pseudoref";
    ++		const char *what = flags & REF_LOG_ONLY ? "reflog for pseudoref" : "pseudoref";
     +		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
      		return 0;
      	} else if ((new_oid && !is_null_oid(new_oid)) ?
    @@ refs.c: struct ref_update *ref_transaction_add_update(
      		 !refname_is_safe(refname)) {
     -		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
     -			    refname);
    -+		const char *what = reflog ? "reflog with bad name" : "ref with bad name";
    ++		const char *what = flags & REF_LOG_ONLY ? "reflog with bad name" : "ref with bad name";
     +		strbuf_addf(err, _("refusing to update %s '%s'"), what, refname);
      		return 0;
      	}
      
    -@@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
    - 		return -1;
    - 	}
    - 
    --	if (!transaction_refname_valid(refname, new_oid, flags, err))
    -+	if (!transaction_refname_valid(refname, new_oid, flags, 0, err))
    - 		return -1;
    - 
    - 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
     @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
      	ref_transaction_add_update(transaction, refname, flags,
      				   new_oid, old_oid, new_target,
    @@ refs.c: int ref_transaction_update(struct ref_transaction *transaction,
     +
     +	assert(err);
     +
    -+	if (!transaction_refname_valid(refname, new_oid, flags, 1, err))
    -+		return -1;
    -+
     +	flags |= REF_LOG_ONLY | REF_NO_DEREF;
     +
    ++	if (!transaction_refname_valid(refname, new_oid, flags, err))
    ++		return -1;
    ++
     +	update = ref_transaction_add_update(transaction, refname, flags,
     +					    new_oid, old_oid, NULL, NULL,
     +					    committer_info, msg);
    @@ refs.h: int ref_transaction_update(struct ref_transaction *transaction,
      
     +/*
     + * Similar to`ref_transaction_update`, but this function is only for adding
    -+ * a reflog update. Supports providing custom committer information.
    ++ * a reflog update. Supports providing custom committer information. The index
    ++ * field can be utiltized to order updates as desired. When not used, the
    ++ * updates default to being ordered by refname.
     + */
     +int ref_transaction_update_reflog(struct ref_transaction *transaction,
     +				  const char *refname,
7:  dffc14e1a3 ! 7:  4d76cf4773 refs: allow multiple reflog entries for the same refname
    @@ Commit message
         update_index before writing to the block. When there are multiple
         reflogs for a given refname, it is essential that the order of the
         reflogs is maintained. So add the `index` value to the `update_index`.
    -    The `index` field is only be set when multiple reflog entries for a
    -    given refname are added and as such in most scenarios the old behavior
    +    The `index` field is only set when multiple reflog entries for a given
    +    refname are added and as such in most scenarios the old behavior
         remains.
     
         This is required to add reflog migration support to `git refs migrate`.
8:  481d185e6e ! 8:  31cc392d8d refs: add support for migrating reflogs
    @@ refs.c
      
      /*
       * List of all available backends
    -@@ refs.c: int ref_update_check_old_target(const char *referent, struct ref_update *update,
    - }
    - 
    - struct migration_data {
    -+	unsigned int reflog_index;
    +@@ refs.c: struct migration_data {
      	struct ref_store *old_refs;
      	struct ref_transaction *transaction;
      	struct strbuf *errbuf;
    ++	struct strbuf sb;
    + };
    + 
    + static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
     @@ refs.c: static int migrate_one_ref(const char *refname, const char *referent UNUSED, con
      	return ret;
      }
      
     +struct reflog_migration_data {
    -+	unsigned int *index;
    ++	unsigned int index;
     +	const char *refname;
     +	struct ref_store *old_refs;
     +	struct ref_transaction *transaction;
     +	struct strbuf *errbuf;
    ++	struct strbuf *sb;
     +};
     +
     +static int migrate_one_reflog_entry(struct object_id *old_oid,
    @@ refs.c: static int migrate_one_ref(const char *refname, const char *referent UNU
     +				    const char *msg, void *cb_data)
     +{
     +	struct reflog_migration_data *data = cb_data;
    -+	struct strbuf sb = STRBUF_INIT;
     +	const char *date;
     +	int ret;
     +
     +	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
    ++	strbuf_reset(data->sb);
     +	/* committer contains name and email */
    -+	strbuf_addstr(&sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
    ++	strbuf_addstr(data->sb, fmt_ident("", committer, WANT_BLANK_IDENT, date, 0));
     +
     +	ret = ref_transaction_update_reflog(data->transaction, data->refname,
    -+					    new_oid, old_oid, sb.buf,
    ++					    new_oid, old_oid, data->sb->buf,
     +					    REF_HAVE_NEW | REF_HAVE_OLD, msg,
    -+					    (*data->index)++, data->errbuf);
    -+	strbuf_release(&sb);
    -+
    ++					    data->index++, data->errbuf);
     +	return ret;
     +}
     +
    @@ refs.c: static int migrate_one_ref(const char *refname, const char *referent UNU
     +	data.old_refs = migration_data->old_refs;
     +	data.transaction = migration_data->transaction;
     +	data.errbuf = migration_data->errbuf;
    -+	data.index = &migration_data->reflog_index;
    ++	data.sb = &migration_data->sb;
     +
     +	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
     +					migrate_one_reflog_entry, &data);
    @@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
      	 */
      	strbuf_addf(&new_gitdir, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
      	if (!mkdtemp(new_gitdir.buf)) {
    +@@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
    + 	data.old_refs = old_refs;
    + 	data.transaction = transaction;
    + 	data.errbuf = errbuf;
    ++	strbuf_init(&data.sb, 0);
    + 
    + 	/*
    + 	 * We need to use the internal `do_for_each_ref()` here so that we can
     @@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
      	if (ret < 0)
      		goto done;
      
    -+	data.reflog_index = 1;
     +	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
     +	if (ret < 0)
     +		goto done;
    @@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
      	ret = ref_transaction_commit(transaction, errbuf);
      	if (ret < 0)
      		goto done;
    +@@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
    + 	}
    + 	ref_transaction_free(transaction);
    + 	strbuf_release(&new_gitdir);
    ++	strbuf_release(&data.sb);
    + 	return ret;
    + }
    + 
     
      ## t/t1460-refs-migrate.sh ##
     @@ t/t1460-refs-migrate.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME


--- 

base-commit: 09245f4b75863f4e94dac7feebaafce53a26965f
change-id: 20241111-320-git-refs-migrate-reflogs-a53e3a6cffc9

Thanks
- Karthik

