Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEA14388A
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907711; cv=none; b=UQLwzLPOLeq6rQR0C8t4HKE8WOahY0jP3xlHzmvhe731kf8HKAesfhZkPZB4PZ93lRADbJT6PtHdUwHLl15BssWWhy/Z7ydA8Cm0Q4VTsfNHYsX+CwuKLm0102wtywTvumGL+erJsNhOrOYQYJFKzaXATtHdSqTE3mhKV1eLpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907711; c=relaxed/simple;
	bh=VRbHz0Pk8vng7mWVl5m9H/enNsPzTaBvJATBgsbOkOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDA0K8fadbFcEv0HR+fXw7fiBjJk7Aya+Pb/PeSWR/fdjmTksGdAQPpxNl5WuToolT3hkEDeivTEeZFM8Zbwsm+3SvKH0yHh2ZC0tQZVTRdfr7euNevFRvVeIUDu9a23QqV3YOwIlk/x+IGHNh9iQX5r1kUnU95qy3cOmmqhegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixcNr7vD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixcNr7vD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a442c9dcbso22233735e9.2
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713907708; x=1714512508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFfcFyYCArqf76DF05vZMUVj7hzWciHBal1mxu6DOaA=;
        b=ixcNr7vDU/k2cT2bSdttyzHvCmo5sDoWS3UTWEpDC65RAV/94A/V9DMWJjZYnASSjM
         lU+RaunWsDe9CEWxa+HNxcfGLuWDCD8dYTmn7g6N/e9VoTucLBTHw4NtxT4X2JEATmZf
         y8pJHYRpQVp9hZ7pStUEipa8pijLGQ/fM2jIrO5zm94KBSWFJD3lLuqGQMmSi9+fXcfN
         XWhOFOPpjki3WFD1E5ALvxIt4+OVOuo8wqSffuGCGB8BqDvarrh7zM/VTOcW8sO3ryK3
         sn4XsG6UTc48pJthuW3qG98xi5B08ujIeKjA44c4ZaQJYJMbZFUVWNLImAOYyDUYGMr6
         SA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713907708; x=1714512508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFfcFyYCArqf76DF05vZMUVj7hzWciHBal1mxu6DOaA=;
        b=oN7NcNkakhkr0AyJDbYgzQZk42qMq0iVqY0RhCEtQ1aMq5HZX6bw2WimwsoV4Esrjw
         fGd4kjJQNAWlUoAhy/AGNDqqrrSxJ1GYNBljNicfU207bNs/79MCNfzl1QKDtcRSnUQK
         bcJARiTOK0/CRBzSw3xO7LMWHOjVG+Rv0eRZdVVd8ZXh2tYMhzBI5/+umKmBTDNZzWg9
         3rGffrhuUNWH06HNr+KQYDxLSY089gkg4Z7xjwOvEJh9OelLxID3avyqBB8csNZTMO38
         lEX1EHNENXwaxgO3yydfWDDAvjt7ZXO4ecKfUT1FCugngbOS8wVvp+yPkkBVO/jeDVK9
         ju/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUV37JGL7xuSFbHr+JtPkg528/JGdLJpBGf8J5Y8E0ElYt8527OMEY0dmUqNkdd9x8v0smiSNbDEv2HLX41u1L+OPgK
X-Gm-Message-State: AOJu0YxnV4CTAL/jJUHEKPSzcB0Br1niT5rM508zKld80Rw9KJGYO89Z
	ZYlmtrjhji6UcrMVBDtfDYcesS6vw/6kanBmrGPmVXxCSJR2snyCW7VBzQ==
X-Google-Smtp-Source: AGHT+IEYXvXf6Odd/GK76yPBW4Zlm4toS3QvfuulTOQDzFpK1lB9YbSSwpFOOLsqPim2GO08u0T4jw==
X-Received: by 2002:a05:6000:156f:b0:343:71c2:287e with SMTP id 15-20020a056000156f00b0034371c2287emr293949wrz.59.1713907707898;
        Tue, 23 Apr 2024 14:28:27 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:23ba:342:e06:b489])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090660d100b00a587236e646sm1864275ejk.174.2024.04.23.14.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 14:28:27 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 6/8] update-ref: support symrefs in the create command
Date: Tue, 23 Apr 2024 23:28:16 +0200
Message-ID: <20240423212818.574123-7-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423212818.574123-1-knayak@gitlab.com>
References: <20240412095908.1134387-1-knayak@gitlab.com>
 <20240423212818.574123-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'create' commands in 'git-update-ref' allows users to create `<ref>`
with `<new-oid>` after verifying it does not exist. Extend this command
to alternatively take in `ref:<new-target>` which is used to create a
symref with `<new-target>` as its target.

Also, support the 'core.prefersymlinkrefs' config, wherein if the config
is set and the filesystem supports symlinks, we create the symbolic ref
as a symlink. We fallback to creating a regular symref if creating the
symlink is unsuccessful.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  8 +++--
 builtin/clone.c                  |  2 +-
 builtin/update-ref.c             | 14 ++++++--
 refs.c                           |  9 ++++--
 refs.h                           |  1 +
 refs/files-backend.c             | 42 ++++++++++++++++++++++++
 refs/reftable-backend.c          | 23 +++++++++++--
 t/t0600-reffiles-backend.sh      | 32 +++++++++++++++++++
 t/t1400-update-ref.sh            | 55 ++++++++++++++++++++++++++++++++
 9 files changed, 173 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index f28b026cd7..1202769178 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -62,7 +62,7 @@ With `--stdin`, update-ref reads instructions from standard input and
 performs all modifications together.  Specify commands of the form:
 
 	update SP <ref> SP <new-oid> [SP <old-oid>] LF
-	create SP <ref> SP <new-oid> LF
+	create SP <ref> SP (<new-oid> | ref:<new-target>) LF
 	delete SP <ref> [SP (<old-oid> | ref:<old-target>)] LF
 	verify SP <ref> [SP (<old-oid> | ref:<old-target>)] LF
 	option SP <opt> LF
@@ -83,7 +83,7 @@ Alternatively, use `-z` to specify in NUL-terminated format, without
 quoting:
 
 	update SP <ref> NUL <new-oid> NUL [<old-oid>] NUL
-	create SP <ref> NUL <new-oid> NUL
+	create SP <ref> NUL (<new-oid> | ref:<new-target>) NUL
 	delete SP <ref> NUL [(<old-oid> | ref:<old-target>)] NUL
 	verify SP <ref> NUL [(<old-oid> | ref:<old-target>)] NUL
 	option SP <opt> NUL
@@ -113,7 +113,9 @@ update::
 
 create::
 	Create <ref> with <new-oid> after verifying it does not
-	exist.  The given <new-oid> may not be zero.
+	exist.  The given <new-oid> may not be zero.  If instead
+	ref:<new-target> is provided, a symbolic ref is created
+	which targets <new-target>.
 
 delete::
 	Delete <ref> after verifying it exists with <old-oid>, if given.
diff --git a/builtin/clone.c b/builtin/clone.c
index 74ec14542e..c0eed8e795 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -547,7 +547,7 @@ static void write_remote_refs(const struct ref *local_refs)
 		if (!r->peer_ref)
 			continue;
 		if (ref_transaction_create(t, r->peer_ref->name, &r->old_oid,
-					   0, NULL, &err))
+					   NULL, 0, NULL, &err))
 			die("%s", err.buf);
 	}
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index cee7a5ebc0..afab706cd7 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -244,6 +244,7 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
 	struct strbuf err = STRBUF_INIT;
+	struct strbuf new_target = STRBUF_INIT;
 	char *refname;
 	struct object_id new_oid;
 
@@ -251,16 +252,22 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	if (!refname)
 		die("create: missing <ref>");
 
-	if (parse_next_arg(&next, end, &new_oid, NULL, "create", refname, 0))
+	if (parse_next_arg(&next, end, &new_oid, &new_target,
+			   "create", refname, PARSE_REFNAME_TARGETS))
 		die("create %s: missing <new-oid>", refname);
 
-	if (is_null_oid(&new_oid))
+	if (!new_target.len && is_null_oid(&new_oid))
 		die("create %s: zero <new-oid>", refname);
 
+	if (new_target.len && !(update_flags & REF_NO_DEREF))
+		die("create %s: cannot create symrefs in deref mode", refname);
+
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	if (ref_transaction_create(transaction, refname, &new_oid,
+	if (ref_transaction_create(transaction, refname,
+				   new_target.len ? NULL : &new_oid ,
+				   new_target.len ? new_target.buf : NULL,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);
@@ -268,6 +275,7 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	update_flags = default_flags;
 	free(refname);
 	strbuf_release(&err);
+	strbuf_release(&new_target);
 }
 
 static void parse_cmd_delete(struct ref_transaction *transaction,
diff --git a/refs.c b/refs.c
index 6b7c46bfd8..42cb4126a7 100644
--- a/refs.c
+++ b/refs.c
@@ -1303,15 +1303,18 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
+			   const char *new_target,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err)
 {
-	if (!new_oid || is_null_oid(new_oid)) {
-		strbuf_addf(err, "'%s' has a null OID", refname);
+	if ((!new_oid || is_null_oid(new_oid)) && !new_target) {
+		strbuf_addf(err, "'%s' has a null OID or no new target", refname);
 		return 1;
 	}
+	if (new_target && !(flags & REF_NO_DEREF))
+		BUG("create cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(), NULL, NULL, flags,
+				      null_oid(), new_target, NULL, flags,
 				      msg, err);
 }
 
diff --git a/refs.h b/refs.h
index 4be4930f04..bde8606213 100644
--- a/refs.h
+++ b/refs.h
@@ -752,6 +752,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
+			   const char *new_target,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index fc5037fe5a..f5e271a442 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2610,6 +2610,27 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		}
 	}
 
+	if (update->new_target) {
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
+	}
+
+
 	if ((update->flags & REF_HAVE_NEW) &&
 	    !(update->flags & REF_DELETING) &&
 	    !(update->flags & REF_LOG_ONLY)) {
@@ -2905,6 +2926,18 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
+			if (update->new_target) {
+				/*
+				 * We want to get the resolved OID for the target, to ensure
+				 * that the correct value is added to the reflog.
+				 */
+				if (!refs_resolve_ref_unsafe(&refs->base, update->new_target,
+							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
+					/* for dangling symrefs we gracefully set the oid to zero */
+					update->new_oid = *null_oid();
+				}
+			}
+
 			if (files_log_ref_write(refs,
 						lock->ref_name,
 						&lock->old_oid,
@@ -2922,6 +2955,15 @@ static int files_transaction_finish(struct ref_store *ref_store,
 				goto cleanup;
 			}
 		}
+
+		/*
+		 * We try creating a symlink, if that succeeds we continue to the
+		 * next updated. If not, we try and create a regular symref.
+		 */
+		if (update->new_target && prefer_symlink_refs)
+			if (!create_ref_symlink(lock, update->new_target))
+				continue;
+
 		if (update->flags & REF_NEEDS_COMMIT) {
 			clear_loose_ref_cache(refs);
 			if (commit_ref(lock)) {
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 2b2cbca8c0..e203c697f2 100644
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
@@ -1062,7 +1062,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		 * - `core.logAllRefUpdates` tells us to create the reflog for
 		 *   the given ref.
 		 */
-		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && is_null_oid(&u->new_oid)) {
+		if (u->flags & REF_HAVE_NEW && !(u->type & REF_ISSYMREF) && ref_update_is_null_new_value(u)) {
 			struct reftable_log_record log = {0};
 			struct reftable_iterator it = {0};
 
@@ -1104,6 +1104,12 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			    should_write_log(&arg->refs->base, u->refname))) {
 			struct reftable_log_record *log;
 
+			if (u->new_target)
+				if (!refs_resolve_ref_unsafe(&arg->refs->base, u->new_target,
+							     RESOLVE_REF_READING, &u->new_oid, NULL))
+					/* for dangling symrefs we gracefully set the oid to zero */
+					u->new_oid = *null_oid();
+
 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 			log = &logs[logs_nr++];
 			memset(log, 0, sizeof(*log));
@@ -1120,7 +1126,18 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		if (u->flags & REF_LOG_ONLY)
 			continue;
 
-		if (u->flags & REF_HAVE_NEW && ref_update_is_null_new_value(u)) {
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
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 64214340e7..1291242940 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -472,4 +472,36 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	esac
 '
 
+test_expect_success SYMLINKS 'symref transaction supports symlinks' '
+	test_when_finished "git symbolic-ref -d TESTSYMREFONE" &&
+	git update-ref refs/heads/new @ &&
+	test_config core.prefersymlinkrefs true &&
+	cat >stdin <<-EOF &&
+	start
+	create TESTSYMREFONE ref:refs/heads/new
+	prepare
+	commit
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	test_path_is_symlink .git/TESTSYMREFONE &&
+	test "$(test_readlink .git/TESTSYMREFONE)" = refs/heads/new
+'
+
+test_expect_success 'symref transaction supports false symlink config' '
+	test_when_finished "git symbolic-ref -d TESTSYMREFONE" &&
+	git update-ref refs/heads/new @ &&
+	test_config core.prefersymlinkrefs false &&
+	cat >stdin <<-EOF &&
+	start
+	create TESTSYMREFONE ref:refs/heads/new
+	prepare
+	commit
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	test_path_is_file .git/TESTSYMREFONE &&
+	git symbolic-ref TESTSYMREFONE >actual &&
+	echo refs/heads/new >expect &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index cd1ad0d2ec..e85d08ce5c 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1758,6 +1758,61 @@ do
 		test_must_fail git rev-parse --verify -q $b
 	'
 
+	test_expect_success "stdin ${type} create symref fails without --no-deref" '
+		create_stdin_buf ${type} "create refs/heads/symref" "ref:$a" &&
+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+		grep "fatal: create refs/heads/symref: cannot create symrefs in deref mode" err
+	'
+
+	test_expect_success "stdin ${type} create symref fails with too many arguments" '
+		create_stdin_buf ${type} "create refs/heads/symref" "ref:$a" "ref:$a" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: ref:$a" err
+		else
+			grep "fatal: create refs/heads/symref: extra input:  ref:$a" err
+		fi
+	'
+
+	test_expect_success "stdin ${type} create symref ref works" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "create refs/heads/symref" "ref:$a" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} create dangling symref ref works" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "create refs/heads/symref" "ref:refs/heads/unkown" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo refs/heads/unkown >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} create symref does not create reflogs by default" '
+		test_when_finished "git symbolic-ref -d refs/symref" &&
+		create_stdin_buf ${type} "create refs/symref" "ref:$a" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual &&
+		test_must_fail git reflog exists refs/symref
+	'
+
+	test_expect_success "stdin ${type} create symref reflogs with --create-reflog" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "create refs/heads/symref" "ref:$a" >stdin &&
+		git update-ref --create-reflog --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual &&
+		git reflog exists refs/heads/symref
+	'
+
 done
 
 test_done
-- 
2.43.GIT

