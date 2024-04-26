Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D5148FF5
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145101; cv=none; b=RZXhaQSlV6I0+9YJ7TR808tT2YIFJcq22fQ2aSVzAVlQDwEbOAqJEuCXwotKbB9FFJtreeICqXax//ziYRSLlSGcEaZ7+pc+Vm0T6PicevAQvULHGS5yKWVYoVvSIkfWr0YSNvhgq9Ro1IRFdL9VlKvPSkVfIh7OoS1a3zBzXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145101; c=relaxed/simple;
	bh=ojZCFCCg/p2r5tzHg/951PaPwVV551q3LIc1mco4WVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=in9zXwg+MpcDC3uZIqqrlwJyhctrLlaI0gvusU5GQjj3dp+YkY9thnxF8guWIghTjsD7TK2Kq15MiU1r8ezQiad5doyXcTVZvRbJXBq2s3/024pmE+/mgPtTtK7J28nrop/jtlAnHfjqORk05/hc6b1iEbhtoSeA4/mSy6MUI8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/rc2rV2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/rc2rV2"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5723edf0ae5so2498742a12.0
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145097; x=1714749897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qc1s/0+vVCSXI+Df4NlIfI3ORvyO6XaoSEzjPE8qS4=;
        b=P/rc2rV2/JqWbKTiJfgKXXtzF2MTJHt21n47mzX4YLpsn2Cv3RxbObycH//EXpZU98
         +Y42uoFe+hoR4or0SPDO4fpdL3UlCKtkQftEHl6r5jm79cxtpG7FnpsVpTzQPLUYbv7T
         L9ugzjwHtaH+PvCvLghbsG/XFspTBmKNIHIhucqeNJVVJhdiHF8TXI/36sS2UakND+zM
         1pmovdUvq6Gnv9lyTvusfTyWJPF2KrHofnhZLQuYMr9P0ulfkAdYBbridVzLBmSxa/HW
         pJoZSSVGbDVy7bx5YnkvyaLXfiIjLwlcc/UCmMLOefeG8QWquCOSxY9ov7eVjQF9D2bb
         T1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145097; x=1714749897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qc1s/0+vVCSXI+Df4NlIfI3ORvyO6XaoSEzjPE8qS4=;
        b=ifhoRsxAUJqfYDzWhq4s1QuQGaXxrWhOLese4nCwbXPMdngWYVpru6Euq1pcL8PET6
         SqR4m94EFVyBMw3l6ZC/Kka19n0moo447FO+hdACIxYqu92iv0p87RcPluWcyayjc482
         ic5K1rTcEvcu02KYsj6ouLhKvW8WotpF5+JAeWm5cNeWU7CQFIQN7YGudvRE9hWTRWpI
         r11sHYJoVmw04hI1lj4EerOhJYuBLZMq2yGKrZZTOg+1AvQK7D+D3/Rw1ifKMgBF5V4O
         de5ip7uz55GzHU7/vYMjvmXio/52XR93/vBqqPbl7hjS9kyvlxTWxWf546dtVXIEiJHu
         6Lmw==
X-Forwarded-Encrypted: i=1; AJvYcCV2B8jzP1TTSr9U/t86mIg01uGPszEchpMUQkmaVV1KmX/c+C1jN1/uRRfm7222snO7FNB8qnD6AedX7B1vpomHeob3
X-Gm-Message-State: AOJu0YwPG9a9TU7v8JMVx+5Sr8st2jhOyGlfuYcHPMC79D/CvzWhmQwf
	z2R0/FU9Bha+n7s2nDbVJBcGLc4arSYPCGX0hqX7OOFdWQ0nJddRPorrVg==
X-Google-Smtp-Source: AGHT+IH/4nEeusEfi08Poq9z0cnmoKiyUunR2LoQblysKmMCXt28lE3n2cC39P8+cg/B+vy0egYz2Q==
X-Received: by 2002:a17:906:13d3:b0:a55:61cc:7337 with SMTP id g19-20020a17090613d300b00a5561cc7337mr2294163ejc.43.1714145097314;
        Fri, 26 Apr 2024 08:24:57 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm10643868ejm.23.2024.04.26.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:24:56 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 4/7] update-ref: add support for 'symref-delete' command
Date: Fri, 26 Apr 2024 17:24:46 +0200
Message-ID: <20240426152449.228860-5-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426152449.228860-1-knayak@gitlab.com>
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

Add a new command 'symref-delete' to allow deletions of symbolic refs in
a transaction via the '--stdin' mode of the 'git-update-ref' command.
The 'symref-delete' command can, when given an <old-target>, delete the
provided <ref> only when it points to <old-target>. This will only work
when used with the 'no-deref' mode as it doesn't make sense to deref a
symref during deletion.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt | 11 ++++--
 builtin/fetch.c                  |  2 +-
 builtin/receive-pack.c           |  3 +-
 builtin/update-ref.c             | 33 ++++++++++++++++-
 refs.c                           | 12 ++++---
 refs.h                           |  4 ++-
 refs/files-backend.c             |  2 +-
 refs/reftable-backend.c          |  2 +-
 t/t1400-update-ref.sh            | 61 +++++++++++++++++++++++++++++++-
 9 files changed, 117 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 9fe78b3501..2924b9437e 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-delete SP <ref> [SP <old-target>] LF
 	symref-verify SP <ref> [SP <old-target>] LF
 	option SP <opt> LF
 	start LF
@@ -87,6 +88,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-delete SP <ref> [NUL <old-target>] NUL
 	symref-verify SP <ref> [NUL <old-target>] NUL
 	option SP <opt> NUL
 	start NUL
@@ -112,13 +114,18 @@ create::
 	exist.  The given <new-oid> may not be zero.
 
 delete::
-	Delete <ref> after verifying it exists with <old-oid>, if
-	given.  If given, <old-oid> may not be zero.
+	Delete <ref> after verifying it exists with <old-oid>, if given.
+	If given, <old-oid> may not be zero.  If instead, ref:<old-target>
+	is provided, verify that the symbolic ref <ref> targets
+	<old-target> before deleting it.
 
 verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
 
+symref-delete::
+	Delete <ref> after verifying it exists with <old-target>, if given.
+
 symref-verify::
 	Verify symbolic <ref> against <old-target> but do not change it.
 	If <old-target> is missing, the ref must not exist.  Can only be
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 66840b7c5b..d02592efca 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1383,7 +1383,7 @@ static int prune_refs(struct display_state *display_state,
 		if (transaction) {
 			for (ref = stale_refs; ref; ref = ref->next) {
 				result = ref_transaction_delete(transaction, ref->name, NULL, 0,
-								"fetch: prune", &err);
+								NULL, "fetch: prune", &err);
 				if (result)
 					goto cleanup;
 			}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b150ef39a8..9a4667d57d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1576,7 +1576,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		if (ref_transaction_delete(transaction,
 					   namespaced_name,
 					   old_oid,
-					   0, "push", &err)) {
+					   0, NULL,
+					   "push", &err)) {
 			rp_error("%s", err.buf);
 			ret = "failed to delete";
 		} else {
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 419b28169b..8fef3aed0a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -293,7 +293,7 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 
 	if (ref_transaction_delete(transaction, refname,
 				   have_old ? &old_oid : NULL,
-				   update_flags, msg, &err))
+				   update_flags, NULL, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = default_flags;
@@ -301,6 +301,36 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
+
+static void parse_cmd_symref_delete(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	char *refname, *old_target;
+
+	if (!(update_flags & REF_NO_DEREF))
+		die("symref-delete: cannot operate with deref mode");
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-delete: missing <ref>");
+
+	old_target = parse_next_refname(&next);
+
+	if (*next != line_termination)
+		die("symref-delete %s: extra input: %s", refname, next);
+
+	if (ref_transaction_delete(transaction, refname, NULL,
+				   update_flags, old_target, msg, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	free(old_target);
+	strbuf_release(&err);
+}
+
+
 static void parse_cmd_verify(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -443,6 +473,7 @@ static const struct parse_cmd {
 	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
 	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
 	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
 	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
 	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
 	{ "start",         parse_cmd_start,         0, UPDATE_REFS_STARTED },
diff --git a/refs.c b/refs.c
index 0e1013b5ab..6b7c46bfd8 100644
--- a/refs.c
+++ b/refs.c
@@ -979,7 +979,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_oid,
-				   flags, msg, &err) ||
+				   flags, NULL, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ref_transaction_free(transaction);
@@ -1318,14 +1318,18 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
-			   unsigned int flags, const char *msg,
+			   unsigned int flags,
+			   const char *old_target,
+			   const char *msg,
 			   struct strbuf *err)
 {
 	if (old_oid && is_null_oid(old_oid))
 		BUG("delete called with old_oid set to zeros");
+	if (old_target && !(flags & REF_NO_DEREF))
+		BUG("delete cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname,
 				      null_oid(), old_oid,
-				      NULL, NULL, flags,
+				      NULL, old_target, flags,
 				      msg, err);
 }
 
@@ -2752,7 +2756,7 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 
 	for_each_string_list_item(item, refnames) {
 		ret = ref_transaction_delete(transaction, item->string,
-					     NULL, flags, msg, &err);
+					     NULL, flags, NULL, msg, &err);
 		if (ret) {
 			warning(_("could not delete reference %s: %s"),
 				item->string, err.buf);
diff --git a/refs.h b/refs.h
index 27b9aeaf54..4be4930f04 100644
--- a/refs.h
+++ b/refs.h
@@ -766,7 +766,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
-			   unsigned int flags, const char *msg,
+			   unsigned int flags,
+			   const char *old_target,
+			   const char *msg,
 			   struct strbuf *err);
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 53197fa3af..fc5037fe5a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2516,7 +2516,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	files_assert_main_repository(refs, "lock_ref_for_update");
 
-	if ((update->flags & REF_HAVE_NEW) && is_null_oid(&update->new_oid))
+	if ((update->flags & REF_HAVE_NEW) && ref_update_is_null_new_value(update))
 		update->flags |= REF_DELETING;
 
 	if (head_ref) {
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index a2474245aa..2b2cbca8c0 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1120,7 +1120,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 		if (u->flags & REF_LOG_ONLY)
 			continue;
 
-		if (u->flags & REF_HAVE_NEW && is_null_oid(&u->new_oid)) {
+		if (u->flags & REF_HAVE_NEW && ref_update_is_null_new_value(u)) {
 			struct reftable_ref_record ref = {
 				.refname = (char *)u->refname,
 				.update_index = ts,
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 34b29eeac8..8efddac013 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1689,7 +1689,7 @@ do
 		test_cmp before after
 	'
 
-	test_expect_success "stdin ${type} symref-verify no value is treated as zero value" '
+	test_expect_success "stdin ${type} symref-verify fails with no value" '
 		git symbolic-ref refs/heads/symref >expect &&
 		create_stdin_buf ${type} "symref-verify refs/heads/symref" "" &&
 		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
@@ -1728,6 +1728,65 @@ do
 		test_cmp expect actual
 	'
 
+	test_expect_success "stdin ${type} symref-delete fails without --no-deref" '
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+		grep "fatal: symref-delete: cannot operate with deref mode" err
+	'
+
+	test_expect_success "stdin ${type} symref-delete fails with no ref" '
+		create_stdin_buf ${type} "symref-delete " &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		grep "fatal: symref-delete: missing <ref>" err
+	'
+
+	test_expect_success "stdin ${type} symref-delete fails with too many arguments" '
+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" "$a" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: $a" err
+		else
+			grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
+		fi
+	'
+
+	test_expect_success "stdin ${type} symref-delete fails with wrong old value" '
+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$m" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		if test_have_prereq REFTABLE
+		then
+			grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected refs/heads/main" err
+		else
+			grep "fatal: cannot lock ref ${SQ}refs/heads/symref${SQ}" err
+		fi &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-delete works with right old value" '
+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		test_must_fail git rev-parse --verify -q refs/heads/symref
+	'
+
+	test_expect_success "stdin ${type} symref-delete works with empty old value" '
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "symref-delete refs/heads/symref" "" &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		test_must_fail git rev-parse --verify -q $b
+	'
+
+	test_expect_success "stdin ${type} symref-delete succeeds for dangling reference" '
+		test_must_fail git symbolic-ref refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
+		create_stdin_buf ${type} "symref-delete refs/heads/symref2" "refs/heads/nonexistent" &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		test_must_fail git symbolic-ref -d refs/heads/symref2
+	'
+
 done
 
 test_done
-- 
2.43.GIT

