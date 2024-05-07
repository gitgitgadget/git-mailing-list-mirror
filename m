Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1873165
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061655; cv=none; b=Rce1SrLLweQ5Xp8VTM4+Du1JDrR2iiVZn71jJd//x8PLMTFlpuEcnwIwkR7leiOAWdhkSm/o10jm4/6juqqaUNRCCO4QFelZkwADe7bo8l7C2d5O8Njg5PisAw0xM48PXKOya3TZSBSc00eh6Mst9ZFEjLO9uqRnNk3lpXvM72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061655; c=relaxed/simple;
	bh=kF+EDh/ryZI6KxNn7WkG5luCKI0VXXDuErCCT0/1lu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLM6tuKKnBKEKx+A8KeOfNWNBC/wSltTUAtwq6V4vp/HCkiTyT3wG50zN9aUwnoKg1UqQU+5bcB3DG0iOR+7qHaEuOA6H1lbfODMh2VKIAB/OH7s5a3RCO6JfApyTQf+V+ENb5gdeDppn4wtHrtmMNbzj53TNIczc7/qKKw7XJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLTSG9ba; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLTSG9ba"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59c04839caso531265466b.2
        for <git@vger.kernel.org>; Mon, 06 May 2024 23:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061652; x=1715666452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVEG99y8fAy6cbpfsABy9hc4SGIvYaKu4M0X0/D2PmY=;
        b=nLTSG9baUB+WrWKdz6gXE0KQ3JnnnU2AT0haz5Nsj28NnLhIYGkePJfEGUsU/tG5we
         Y/QhwIXau44JYQaNJ3z/XmVlABEGD2D+RBeTUOpa6leS8vTFPgsJnrwIavmxkPmQCktl
         FZpZFHMKbyVtuIcQsl9QTt7qJ+e9GYDAjzwn/+iWjSjMNo7d/A2lT6sasWRZHr9Iqa88
         LE/weWZXx9k6q7OB//YLLG+cCJm36AtFCqvV8/SNrIweAP4zk5fQlgblXBlwIpJ2CbIj
         ptyaQ+dVGevPXob4V48JHrdiUlbnzMWPhRAazDNclg0y4qc7LVKmFgIadohcyGuu9BQ4
         jcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061652; x=1715666452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVEG99y8fAy6cbpfsABy9hc4SGIvYaKu4M0X0/D2PmY=;
        b=mIiz0p950QWcWwenlpKEqcnEowyXSh6c5Z9MvPhHMD8DxQyDx5B6gqIt+whV/4pNh9
         9RAVdM5CluS+wu6vUF9n2e+y6+0kp/Nae9j/LWIa25e55hgVD56cBExzS+K4eeAKseTv
         uRfR1yoxo/1x3UO240N6+C1yPp3s5cqzR9rRDlHENA6/yuOlMJE1dV4V0wquPHPesrUh
         F4Im65+HuZzRUDbw2iLF6UykXbsPTU2EohkPr0oern/PczScZIjyqcm16rQhunzJGZAm
         v9OfOWJPSamxQcOeTBGq6A89nbXqV8kpwKWCSPddztbaOUmbR44z1P1vzkEH+6V1x5C1
         l5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1HJEOhN42T6z4eazu0df952+D/BHCvWxua1k0CVQNqEpNipEU4bvLe65HcNJoWltLHfVzhArIAFLV2tBhkgPOT9Oq
X-Gm-Message-State: AOJu0Yw9Sq8qUtLnSSW6USNmtc9H7NfBtSjRxGt+DovhPbhJo6QOy5xi
	xf21LdnEUAiWFXXAByKdB2WhvooprFoHdvzubFuwWI4o6AV1bkno
X-Google-Smtp-Source: AGHT+IGPRwypuVTBAJ4rGvzSrLijpb3Q/SOl8yXyRtJIpmcVBWKpkWoMkXDLiVMyq5DiEPcwjq9eXQ==
X-Received: by 2002:a17:907:7203:b0:a59:c31a:91be with SMTP id dr3-20020a170907720300b00a59c31a91bemr3810033ejc.16.1715061651873;
        Mon, 06 May 2024 23:00:51 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1aa1:adf2:4cd1:ebdc])
        by smtp.gmail.com with ESMTPSA id y27-20020a1709060a9b00b00a59baca79basm3066691ejf.60.2024.05.06.23.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 23:00:51 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v7 8/8] refs: remove `create_symref` and associated dead code
Date: Tue,  7 May 2024 08:00:35 +0200
Message-ID: <20240507060035.28602-9-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507060035.28602-1-knayak@gitlab.com>
References: <20240503124115.252413-1-knayak@gitlab.com>
 <20240507060035.28602-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

In the previous commits, we converted `refs_create_symref()` to utilize
transactions to perform symref updates. Earlier `refs_create_symref()`
used `create_symref()` to do the same.

We can now remove `create_symref()` and any code associated with it
which is no longer used. We remove `create_symref()` code from all the
reference backends and also remove it entirely from the `ref_storage_be`
struct.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/debug.c            |  13 -----
 refs/files-backend.c    |  67 -------------------------
 refs/packed-backend.c   |   1 -
 refs/refs-internal.h    |   5 --
 refs/reftable-backend.c | 105 ----------------------------------------
 5 files changed, 191 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index c7531b17f0..8be316bb67 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -131,18 +131,6 @@ static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *o
 	return res;
 }
 
-static int debug_create_symref(struct ref_store *ref_store,
-			       const char *ref_name, const char *target,
-			       const char *logmsg)
-{
-	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
-	int res = drefs->refs->be->create_symref(drefs->refs, ref_name, target,
-						 logmsg);
-	trace_printf_key(&trace_refs, "create_symref: %s -> %s \"%s\": %d\n", ref_name,
-		target, logmsg, res);
-	return res;
-}
-
 static int debug_rename_ref(struct ref_store *ref_store, const char *oldref,
 			    const char *newref, const char *logmsg)
 {
@@ -441,7 +429,6 @@ struct ref_storage_be refs_be_debug = {
 	.initial_transaction_commit = debug_initial_transaction_commit,
 
 	.pack_refs = debug_pack_refs,
-	.create_symref = debug_create_symref,
 	.rename_ref = debug_rename_ref,
 	.copy_ref = debug_copy_ref,
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1d4650b7cb..dc0490f0db 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1902,23 +1902,6 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
 	return ret;
 }
 
-static void update_symref_reflog(struct files_ref_store *refs,
-				 struct ref_lock *lock, const char *refname,
-				 const char *target, const char *logmsg)
-{
-	struct strbuf err = STRBUF_INIT;
-	struct object_id new_oid;
-
-	if (logmsg &&
-	    refs_resolve_ref_unsafe(&refs->base, target,
-				    RESOLVE_REF_READING, &new_oid, NULL) &&
-	    files_log_ref_write(refs, refname, &lock->old_oid,
-				&new_oid, logmsg, 0, &err)) {
-		error("%s", err.buf);
-		strbuf_release(&err);
-	}
-}
-
 static int create_symref_lock(struct files_ref_store *refs,
 			      struct ref_lock *lock, const char *refname,
 			      const char *target, struct strbuf *err)
@@ -1938,55 +1921,6 @@ static int create_symref_lock(struct files_ref_store *refs,
 	return 0;
 }
 
-static int create_and_commit_symref(struct files_ref_store *refs,
-				    struct ref_lock *lock, const char *refname,
-				    const char *target, const char *logmsg)
-{
-	struct strbuf err = STRBUF_INIT;
-	int ret;
-
-	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
-		update_symref_reflog(refs, lock, refname, target, logmsg);
-		return 0;
-	}
-
-	ret = create_symref_lock(refs, lock, refname, target, &err);
-	if (!ret) {
-		update_symref_reflog(refs, lock, refname, target, logmsg);
-
-		if (commit_ref(lock) < 0)
-			return error("unable to write symref for %s: %s", refname,
-				     strerror(errno));
-	} else {
-		return error("%s", err.buf);
-	}
-
-	return ret;
-}
-
-static int files_create_symref(struct ref_store *ref_store,
-			       const char *refname, const char *target,
-			       const char *logmsg)
-{
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_WRITE, "create_symref");
-	struct strbuf err = STRBUF_INIT;
-	struct ref_lock *lock;
-	int ret;
-
-	lock = lock_ref_oid_basic(refs, refname, &err);
-	if (!lock) {
-		error("%s", err.buf);
-		strbuf_release(&err);
-		return -1;
-	}
-
-	ret = create_and_commit_symref(refs, lock, refname, target, logmsg);
-
-	unlock_ref(lock);
-	return ret;
-}
-
 static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
@@ -3373,7 +3307,6 @@ struct ref_storage_be refs_be_files = {
 	.initial_transaction_commit = files_initial_transaction_commit,
 
 	.pack_refs = files_pack_refs,
-	.create_symref = files_create_symref,
 	.rename_ref = files_rename_ref,
 	.copy_ref = files_copy_ref,
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4e826c05ff..a937e7dbfc 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1714,7 +1714,6 @@ struct ref_storage_be refs_be_packed = {
 	.initial_transaction_commit = packed_initial_transaction_commit,
 
 	.pack_refs = packed_pack_refs,
-	.create_symref = NULL,
 	.rename_ref = NULL,
 	.copy_ref = NULL,
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 819157256e..53a6c5d842 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -566,10 +566,6 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 
 typedef int pack_refs_fn(struct ref_store *ref_store,
 			 struct pack_refs_opts *opts);
-typedef int create_symref_fn(struct ref_store *ref_store,
-			     const char *ref_target,
-			     const char *refs_heads_master,
-			     const char *logmsg);
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
@@ -690,7 +686,6 @@ struct ref_storage_be {
 	ref_transaction_commit_fn *initial_transaction_commit;
 
 	pack_refs_fn *pack_refs;
-	create_symref_fn *create_symref;
 	rename_ref_fn *rename_ref;
 	copy_ref_fn *copy_ref;
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4817dc2f0b..d8e06767a4 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1307,110 +1307,6 @@ struct write_create_symref_arg {
 	const char *logmsg;
 };
 
-static int write_create_symref_table(struct reftable_writer *writer, void *cb_data)
-{
-	struct write_create_symref_arg *create = cb_data;
-	uint64_t ts = reftable_stack_next_update_index(create->stack);
-	struct reftable_ref_record ref = {
-		.refname = (char *)create->refname,
-		.value_type = REFTABLE_REF_SYMREF,
-		.value.symref = (char *)create->target,
-		.update_index = ts,
-	};
-	struct ident_split committer_ident = {0};
-	struct reftable_log_record log = {0};
-	struct object_id new_oid;
-	struct object_id old_oid;
-	const char *committer_info;
-	int ret;
-
-	reftable_writer_set_limits(writer, ts, ts);
-
-	ret = refs_verify_refname_available(&create->refs->base, create->refname,
-					    NULL, NULL, create->err);
-	if (ret < 0)
-		return ret;
-
-	ret = reftable_writer_add_ref(writer, &ref);
-	if (ret)
-		return ret;
-
-	/*
-	 * Note that it is important to try and resolve the reference before we
-	 * write the log entry. This is because `should_write_log()` will munge
-	 * `core.logAllRefUpdates`, which is undesirable when we create a new
-	 * repository because it would be written into the config. As HEAD will
-	 * not resolve for new repositories this ordering will ensure that this
-	 * never happens.
-	 */
-	if (!create->logmsg ||
-	    !refs_resolve_ref_unsafe(&create->refs->base, create->target,
-				     RESOLVE_REF_READING, &new_oid, NULL) ||
-	    !should_write_log(&create->refs->base, create->refname))
-		return 0;
-
-	committer_info = git_committer_info(0);
-	if (split_ident_line(&committer_ident, committer_info, strlen(committer_info)))
-		BUG("failed splitting committer info");
-
-	fill_reftable_log_record(&log, &committer_ident);
-	log.refname = xstrdup(create->refname);
-	log.update_index = ts;
-	log.value.update.message = xstrndup(create->logmsg,
-					    create->refs->write_options.block_size / 2);
-	memcpy(log.value.update.new_hash, new_oid.hash, GIT_MAX_RAWSZ);
-	if (refs_resolve_ref_unsafe(&create->refs->base, create->refname,
-				    RESOLVE_REF_READING, &old_oid, NULL))
-		memcpy(log.value.update.old_hash, old_oid.hash, GIT_MAX_RAWSZ);
-
-	ret = reftable_writer_add_log(writer, &log);
-	reftable_log_record_release(&log);
-	return ret;
-}
-
-static int reftable_be_create_symref(struct ref_store *ref_store,
-				     const char *refname,
-				     const char *target,
-				     const char *logmsg)
-{
-	struct reftable_ref_store *refs =
-		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create_symref");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
-	struct strbuf err = STRBUF_INIT;
-	struct write_create_symref_arg arg = {
-		.refs = refs,
-		.stack = stack,
-		.refname = refname,
-		.target = target,
-		.logmsg = logmsg,
-		.err = &err,
-	};
-	int ret;
-
-	ret = refs->err;
-	if (ret < 0)
-		goto done;
-
-	ret = reftable_stack_reload(stack);
-	if (ret)
-		goto done;
-
-	ret = reftable_stack_add(stack, &write_create_symref_table, &arg);
-
-done:
-	assert(ret != REFTABLE_API_ERROR);
-	if (ret) {
-		if (err.len)
-			error("%s", err.buf);
-		else
-			error("unable to write symref for %s: %s", refname,
-			      reftable_error_str(ret));
-	}
-
-	strbuf_release(&err);
-	return ret;
-}
-
 struct write_copy_arg {
 	struct reftable_ref_store *refs;
 	struct reftable_stack *stack;
@@ -2325,7 +2221,6 @@ struct ref_storage_be refs_be_reftable = {
 	.initial_transaction_commit = reftable_be_initial_transaction_commit,
 
 	.pack_refs = reftable_be_pack_refs,
-	.create_symref = reftable_be_create_symref,
 	.rename_ref = reftable_be_rename_ref,
 	.copy_ref = reftable_be_copy_ref,
 
-- 
2.43.GIT

