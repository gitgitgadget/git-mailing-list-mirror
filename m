Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01006126BF7
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367479; cv=none; b=PKBTLC7leUbTVI/XBdr8l5wagKVpXqpQdzD1VaXQyWm85+KcXV1JT399GfTn1ytnchTZw158q/Gy5WAa4UNFO++vknnYN8x7EQOl16cOWImaT+VQmaqptOM0F5Q6mR/oC54tyOIdQReD+k+VtcHbPCn39ZbhJLf1NlNwu26dYkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367479; c=relaxed/simple;
	bh=4/wYvDsfzR8kNRM/wyEljG309hhP1nB4l3b/vy3qooE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=f80ZZ/JJC2sxu2dad7hA4B6cRVbUahiR6SsDhinDxeGVzWb5GtbMSu+Z0DF2pZYIUqeI/F24MvN/l1jADDKj0O/Z9gjhoqtFLTFbP5HVXEpZc+fIHbEnmzlikQ1hlSfbHfy/TTQ8yQtg8VfGM3PeSLkzF7AFO2YpmM9VyUHTIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYyc4mzm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYyc4mzm"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa69107179cso808729266b.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367475; x=1734972275; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAb4hypnHBuNzElAZ7NQeX7i3XlUWbA9nN+sMtGojMs=;
        b=YYyc4mzmEQk5Ay1KcaiSVPUaZALt+92j+oSYSUAjjiNsXQxPu7MG4x2Mn+FaQFUYJb
         o+gha7ED4PgLWtD+emADXK8cnYqRqHrAa5gfydDgy/0Bf6rM3nv+QQ9WGFSP3qGZ/hdM
         mjEZ25qykynYv8S4sa1ThNbPBtyL/J8Mj0yTQ8qUuS7tdFiRLaobqJq9YABbC0tZWx5U
         MiEHKL5JA6Croslt6wrWkCpDWpbY68BaAIW233Y1u4mizLU63Oa0LYMn3B3sctWT/Iyj
         ExDlv7aIATLtLhC2JWrnZuG5r7PcL8rD2iMk+IDHVGBs+/71br4+CkK1n+1umDln8jnW
         LiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367475; x=1734972275;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aAb4hypnHBuNzElAZ7NQeX7i3XlUWbA9nN+sMtGojMs=;
        b=BbyNo799iJUXM0IQCiIHjBXBAdpEpqJBrhKCfktFkxSY1MSpaCfx4ih8g9TjZQ94yk
         5QvJhZMewbQV9UR1ZJ/RQ72VwDeE1oeQ+iBVW3F55lU89hXvm4tv+/ZxJhSqmRR4QMyw
         dyCSZbkiAe3iZFvxEepiNwWYiIqm9RLcvnFjII7WNeYUKbix9m7Ke3m4unkI9I9OsKAD
         KCHzumotvVbKY0xKnmNGNcLOtmOvpiRO431z4MMRsRJ8z/TlvQTWg1jPICCmjOdhttcf
         xcjs1wvFPOea6SMeWTujkzkCgd/WkAbomINV61SJzeaXRDLyQh5n8VdVhXUCd+eWazGX
         L3Tw==
X-Gm-Message-State: AOJu0YzaDok2czLvQ1AMQFDOt4HebMVcIa/cx/iIdlfDgH8Pjgg/esis
	ol86XFhzLqG1AYNRSZtK7IB0+5/uXYKUzF0Iz0m3D1MObPjiPvzryfgJPlGL
X-Gm-Gg: ASbGncsKZ7YXuJOgCAk7arBXLqOddpclCGYyQ9gJHPqx78vcB9HJIkOUx7LeuPLT41F
	4aUMwlAt/cVd+jGhgaszfftyS+hZoDZFJGICjPRJr7xgUn8cqzibq6Hk/iFV2k2B3Nq91vf0P0e
	NjON+7A+kvR8ildddbtOXLZi5HxIvbVRDuGo1EHoXniXK6Z+FDejY2tqpmsWE3Fo+wN/SoxRR1l
	rQQFn2L+43WhycUUW8kKcmkfBr4+r36ZYDC+0TZPR7H/330NOY3uRFHFL4=
X-Google-Smtp-Source: AGHT+IHS3qfezf8ulhvyv6o7d1ks9UZ+rkREFgT0N35s4jqFlHETQqDxykstSvSc2EWt8ct2vTS7ug==
X-Received: by 2002:a17:907:3da7:b0:aa6:2704:4840 with SMTP id a640c23a62f3a-aab77ed2b9emr1281184166b.51.1734367474707;
        Mon, 16 Dec 2024 08:44:34 -0800 (PST)
Received: from [10.82.4.202] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635957fsm354834366b.109.2024.12.16.08.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:44:34 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/8] refs: add reflog support to `git refs migrate`
Date: Mon, 16 Dec 2024 17:44:25 +0100
Message-Id: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOpYYGcC/4XNSw6CMBCA4auQrq3pg6cr72FclDItk4CYlhAN4
 e4OuCEupLt/ZvJ1ZhECQmSXZGYBJow4PCjSU8Jsax4eODbUTAmVSnpcK8E9jjyAi7xHH8wIa3S
 Dj9xkGrTJrXO2YkQ8aYGvjb/dqVuM4xDe22+TXKdfWInqPzxJLniT1lYXAGUu3NX3BruzHXq2w
 pPaYVIfYIowp0otlW3q3IpfTO+x7ADThNFd4aAQRV2Ve2xZlg9noka7YgEAAA==
X-Change-ID: 20241111-320-git-refs-migrate-reflogs-a53e3a6cffc9
In-Reply-To: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8689; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=4/wYvDsfzR8kNRM/wyEljG309hhP1nB4l3b/vy3qooE=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnYFjtlUZtekcKrSsqKqG7IsmPBt1DonstS69Ch
 lJHEJNH/+GJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ2BY7QAKCRA+1Z8kjkaM
 f7ZTC/9apKQvfyLr8zIjm4+hTqj5Lxoi8SfDJCpvyB3kzZwede+SHp5HGHr1/L/DVJ8KxJE8Fpk
 +zQPcFU7zlH93lB9kMm3AUyVTVicTK0i1RYQTVBaMBbDj7HN9v/Dbz3wa8DQA2fJYpT6ZxSmnxY
 0dYmAulLgI2B9IaKEWc+jbGsur2fwnvR6HL+jwtf3RTKa+SiuaB2/i6VVtq6ccR4CxuVzizi3HE
 uQkNC4/LsRqiBPJAnZ4tqlk/aWPJv5pzN5v2HFv15Wq6bPp9XNLrJf3jsLOLSjp3j4Vfv+hQKem
 7L8Y/vWEybw7in04Qs71u1ID+ednQWmnmU04GuT7PX+XgqHwLgIOuRngU9NhaP18HQVTEqLGp6I
 9puTmZWIKc+8TRRw/LfO+VLtyftywEcdQ9f8uTiMmnRm+llY6VYAlRCn4R6iwZFKz2N+XH9E4+h
 IeaK2cOsqIK2wAK7MkNxxn5MGHYt6DDdGvPIZ7lJFlVn32ZWdKTp5yeB7vtuZaFr/6CaE=
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
Changes in v4:
- Fix broken tests, due to two reasons in patch 8/8:
  - The `index` field in `reflog_migration_data` wasn't initialized to
    0. This specifically doesn't break the test, but causes undefined
    behavior. Fix this by using designated initializers.
  - The strbuf within `migration_data` wasn't initialized when the flow
    exited early, causing memory leaks. Fix this too by using designated
    initializers.
- Thanks to Junio for reporting and Patrick for helping shed some light
  on these broken tests.
- Link to v3: https://lore.kernel.org/r/20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com

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
 refs.c                     | 168 +++++++++++++++++++++++++++++++++------------
 refs.h                     |  14 ++++
 refs/files-backend.c       | 131 +++++++++++++++++++++++------------
 refs/refs-internal.h       |   9 +++
 refs/reftable-backend.c    |  53 +++++++++++---
 t/t1460-refs-migrate.sh    |  73 ++++++++++++++------
 7 files changed, 329 insertions(+), 121 deletions(-)
---

Range-diff versus v3:

1:  7989ca0679 = 1:  34fb6a475e refs: include committer info in `ref_update` struct
2:  12acd7b4bb = 2:  4badd2b8ec refs: add `index` field to `struct ref_udpate`
3:  0d13c0d09b = 3:  0d8673c2fe refs/files: add count field to ref_lock
4:  d4073cd9dc = 4:  dec4b3c6f6 refs: extract out refname verification in transactions
5:  5a3d242955 = 5:  b1cc1bb242 refs: add `committer_info` to `ref_transaction_add_update()`
6:  fedd93f113 = 6:  f669e87498 refs: introduce the `ref_transaction_update_reflog` function
7:  b4465ee0c5 = 7:  53c0d2b62b refs: allow multiple reflog entries for the same refname
8:  8760610904 ! 8:  1cf30a5c3a refs: add support for migrating reflogs
    @@ Commit message
         the reflogs from the old reference backend. This is to ensure that the
         order is maintained in the new backend.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/git-refs.txt ##
    @@ refs.c: static int migrate_one_ref(const char *refname, const char *referent UNU
     +static int migrate_one_reflog(const char *refname, void *cb_data)
     +{
     +	struct migration_data *migration_data = cb_data;
    -+	struct reflog_migration_data data;
    -+
    -+	data.refname = refname;
    -+	data.old_refs = migration_data->old_refs;
    -+	data.transaction = migration_data->transaction;
    -+	data.errbuf = migration_data->errbuf;
    -+	data.sb = &migration_data->sb;
    ++	struct reflog_migration_data data = {
    ++		.refname = refname,
    ++		.old_refs = migration_data->old_refs,
    ++		.transaction = migration_data->transaction,
    ++		.errbuf = migration_data->errbuf,
    ++		.sb = &migration_data->sb,
    ++	};
     +
     +	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
     +					migrate_one_reflog_entry, &data);
    @@ refs.c: static int move_files(const char *from_path, const char *to_path, struct
      {
      	struct worktree **worktrees = get_worktrees();
     @@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
    + 	struct ref_store *old_refs = NULL, *new_refs = NULL;
      	struct ref_transaction *transaction = NULL;
      	struct strbuf new_gitdir = STRBUF_INIT;
    - 	struct migration_data data;
    +-	struct migration_data data;
     -	size_t reflog_count = 0;
    ++	struct migration_data data = {
    ++		.sb = STRBUF_INIT,
    ++	};
      	int did_migrate_refs = 0;
      	int ret;
      
    @@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
      	 */
      	strbuf_addf(&new_gitdir, "%s/%s", old_refs->gitdir, "ref_migration.XXXXXX");
      	if (!mkdtemp(new_gitdir.buf)) {
    -@@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
    - 	data.old_refs = old_refs;
    - 	data.transaction = transaction;
    - 	data.errbuf = errbuf;
    -+	strbuf_init(&data.sb, 0);
    - 
    - 	/*
    - 	 * We need to use the internal `do_for_each_ref()` here so that we can
     @@ refs.c: int repo_migrate_ref_storage_format(struct repository *repo,
      	if (ret < 0)
      		goto done;


--- 

base-commit: 09245f4b75863f4e94dac7feebaafce53a26965f
change-id: 20241111-320-git-refs-migrate-reflogs-a53e3a6cffc9

Thanks
- Karthik

