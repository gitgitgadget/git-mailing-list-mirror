Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDBB53E3C
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915971; cv=none; b=X71e5fngof9JPxqXGhzhUcj0Q62PGQoFFPLsF4m143Q2NwPUJd6fJ/Ks6CFAaxALA1rFUcSpf/sKY6JKLC2oZBfprTDBnhynpFW4GUmOf1zQI8vc47kSLEJMtcylupc37RP08zwCYHopu49tyy0WfNurPLRxrR5qfTiY54ZGQF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915971; c=relaxed/simple;
	bh=ukcACA36yrCHLE1TJdSQkhMveVrDSSCCPHHt/hVvuao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxjoQ5HXBCyKHzmeQ1XguQUQWnWjP4XwCj0GCXJOM5hhENRhasGKBqyLOkF3+gEAv3z1oLFLKQscZch1T0rV/pUSGDUvDrFjnr09vGDrembxR2qIqdmEuJw/NS/HSu9+0NqH8Sm9hHTQaIzKz2F9Cj0jSPp5NLEe21NVfpWN0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXbGZtr5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXbGZtr5"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so748380a12.1
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712915968; x=1713520768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whiY43yokn8tn/taznfy3t/i2EWRn9tzBrP/AIh7a1Q=;
        b=eXbGZtr5zZeJYIuzLj/VpRHlwEYPM9qrETlvle1jqC7TL1oqpjeunU8GztCXssS9IT
         aYz/b2RZ0II0sFy+he4Gl7PPJUPMxe/6dIY82zjvJYyUxXxo6vSKeeQs3RDNc4UmY55I
         4KZSWSVpswHLeHlQyafYSbztzMMnAx2O6LXV9SX9ShDgR6G8D5gVlt7eAe0g3UNDOa9s
         pvlysco1tBtG+3ICKbKoOK6yos8ta8qo8NRzYugs8+uvg4b1c2slOLXDhkog7wSZveqF
         0AeXD3ywSo0S5d6Mg//AOptcJfRSX5X+jf1x5EwnLAdwUTK8Z5obVpvvHKjIMmneh58v
         HBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915968; x=1713520768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whiY43yokn8tn/taznfy3t/i2EWRn9tzBrP/AIh7a1Q=;
        b=t7E3wKSU9CS/Q+yuJEjUUp6tXxcxAab8745m66w83/Rdp296A4GynyqdIYowx3Tkdc
         bxfYw6d4OzuwFPqO2US3Zk6qWBctUwrKoRK7eYZA+2Y9ntL64AUDRsm7DRNXvzouzSux
         TjICnlzFvh9pQsKmDT8/pt25PZD/WESE6NOnkzbjqwkbj6hQS5Lvs+IoIH0qMgl2sfXq
         vjr0/02osDOyS29VT+FFtxfJr8+35GAcGbboKK+Kic9/UJ+EIuoUCgGgzLIQRix7cJq+
         PLuKzhgaHgWUN1WVEr5jE8eAG7mQV8k1SOb0xOSuySWKzLFDKUtenZD15O366DIMB4xK
         NjEw==
X-Forwarded-Encrypted: i=1; AJvYcCVAKvCICAe5EXwcfYHx1vcMUJTkyyMzyisJOi5BtNvcvxcq9i9wVHLEn3r40lwGsdGf+X1F2mnz5OYM8yg/gefKPYYJ
X-Gm-Message-State: AOJu0Yx4E9ljdZKa/wQy0Gii5E/R7Z3r0npyWO84Y34jQ6hPw5TH0lrB
	rFpID8FM38q6hLtj6ck/NYlVLQpdjRcxMMrcJ0QwjKx/9sNBiEcgndIvdg==
X-Google-Smtp-Source: AGHT+IGase6dBo8NorO3n2YyY473oVMQT7SXCvawQWMVbNfZIfLadOsuiqgduDNO/NNsHPR2+9mRkA==
X-Received: by 2002:a50:d75e:0:b0:56e:3505:14e5 with SMTP id i30-20020a50d75e000000b0056e350514e5mr1861746edj.21.1712915966954;
        Fri, 12 Apr 2024 02:59:26 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:355c:c013:66aa:c838])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b0056e67f9f4c3sm1498552edb.72.2024.04.12.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:59:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 6/7] update-ref: add support for symref-update
Date: Fri, 12 Apr 2024 11:59:07 +0200
Message-ID: <20240412095908.1134387-7-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412095908.1134387-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

Add 'symref-update' to allow updates of symbolic refs in a transaction
via the 'git-update-ref' command. The 'symref-update' command takes in a
<new-ref>, which the <ref> will be updated to. If the <ref> doesn't
exist it will be created.

It also optionally takes either an <old-ref> or <old-oid>. If the
<old-ref> is provided, it checks to see if the <ref> ponints to the
<old-ref> before the update. If <old-oid> is provided it checks <ref> to
ensure that it is a regular ref and <old-oid> is the OID before the
update. This by extension also means that this when a zero <old-oid> is
provided, it ensures that the ref didn't exist before.

This command will also support deref mode, to ensure that we can update
dereferenced regular refs to symrefs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |   6 ++
 builtin/update-ref.c             |  49 +++++++++++
 refs.c                           |  24 ++----
 refs/files-backend.c             |  15 ++--
 refs/reftable-backend.c          |   7 +-
 t/t1400-update-ref.sh            | 143 +++++++++++++++++++++++++++++++
 6 files changed, 220 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index a5b1f42728..9710c9bc78 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-update SP <ref> SP <new-ref> [SP (<old-ref> | <old-oid>)] LF
 	symref-create SP <ref> SP <new-ref> LF
 	symref-delete SP <ref> [SP <old-ref>] LF
 	symref-verify SP <ref> [SP <old-ref>] LF
@@ -89,6 +90,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-update SP <ref> NUL <new-ref> [NUL (<old-ref> | <old-oid>)] NUL
 	symref-create SP <ref> NUL <new-ref> NUL
 	symref-delete SP <ref> [NUL <old-ref>] NUL
 	symref-verify SP <ref> [NUL <old-ref>] NUL
@@ -123,6 +125,10 @@ verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
 
+symref-update::
+	Set <ref> to <new-ref> after verifying <old-ref> or <old-oid>,
+	if given. Can be used to delete or create symrefs too.
+
 symref-create::
 	Create symbolic ref <ref> with <new-ref> after verifying
 	it does not exist.  Can only be used in `no-deref` mode.
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 24556a28a8..809c1c7a76 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -238,6 +238,54 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
+static void parse_cmd_symref_update(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	char *refname, *new_ref, *old_ref;
+	struct object_id old_oid;
+	int have_old = 0;
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-update: missing <ref>");
+
+	new_ref = parse_next_refname(&next);
+	if (!new_ref)
+		die("symref-update %s: missing <new-ref>", refname);
+	if (read_ref(new_ref, NULL))
+		die("symref-update %s: invalid <new-ref>", refname);
+
+	old_ref = parse_next_refname(&next);
+	/*
+	 * Since the user can also send in an old-oid, we try to parse
+	 * it as such too.
+	 */
+	if (old_ref && read_ref(old_ref, NULL)) {
+		if (!repo_get_oid(the_repository, old_ref, &old_oid)) {
+			old_ref = NULL;
+			have_old = 1;
+		} else
+			die("symref-update %s: invalid <old-ref> or <old-oid>", refname);
+	}
+
+	if (*next != line_termination)
+		die("symref-update %s: extra input: %s", refname, next);
+
+	update_flags |= create_reflog_flag | REF_SYMREF_UPDATE;
+	if (ref_transaction_update(transaction, refname, NULL,
+				   have_old ? &old_oid : NULL,
+				   new_ref, old_ref, update_flags,
+				   msg, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	free(old_ref);
+	free(new_ref);
+	strbuf_release(&err);
+}
+
 static void parse_cmd_create(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -509,6 +557,7 @@ static const struct parse_cmd {
 	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
 	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
 	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-update", parse_cmd_symref_update, 3, UPDATE_REFS_OPEN },
 	{ "symref-create", parse_cmd_symref_create, 2, UPDATE_REFS_OPEN },
 	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
 	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
diff --git a/refs.c b/refs.c
index e62c0f4aca..31c09c3317 100644
--- a/refs.c
+++ b/refs.c
@@ -1246,21 +1246,15 @@ struct ref_update *ref_transaction_add_update(
 
 	update->flags = flags;
 
-	/*
-	 * The ref values are to be considered over the oid values when we're
-	 * doing symref operations.
-	 */
-	if (update->flags & REF_SYMREF_UPDATE) {
-		if (old_ref)
-			update->old_ref = xstrdup(old_ref);
-		if (new_ref)
-			update->new_ref = xstrdup(new_ref);
-	} else {
-		if (flags & REF_HAVE_NEW)
-			oidcpy(&update->new_oid, new_oid);
-		if (flags & REF_HAVE_OLD)
-			oidcpy(&update->old_oid, old_oid);
-	}
+	if (old_ref)
+		update->old_ref = xstrdup(old_ref);
+	if (new_ref)
+		update->new_ref = xstrdup(new_ref);
+	if (new_oid && flags & REF_HAVE_NEW)
+		oidcpy(&update->new_oid, new_oid);
+	if (old_oid && flags & REF_HAVE_OLD)
+		oidcpy(&update->old_oid, old_oid);
+
 	update->msg = normalize_reflog_message(msg);
 	return update;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 59d438878a..fb9886484c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2386,7 +2386,7 @@ static int split_symref_update(struct ref_update *update,
 	new_update = ref_transaction_add_update(
 			transaction, referent, new_flags,
 			&update->new_oid, &update->old_oid,
-			NULL, NULL, update->msg);
+			update->new_ref, update->old_ref, update->msg);
 
 	new_update->parent_update = update;
 
@@ -2609,7 +2609,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		}
 	}
 
-	if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {
+	if (update->flags & REF_SYMREF_UPDATE &&
+	    !(update->flags & REF_LOG_ONLY) &&
+	    update->new_ref) {
 		if (create_symref_lock(refs, lock, update->refname, update->new_ref)) {
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
@@ -2627,12 +2629,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 		 * phase of the transaction only needs to commit the lock.
 		 */
 		update->flags |= REF_NEEDS_COMMIT;
-	}
-
-
-	if ((update->flags & REF_HAVE_NEW) &&
-	    !(update->flags & REF_DELETING) &&
-	    !(update->flags & REF_LOG_ONLY)) {
+	} else if ((update->flags & REF_HAVE_NEW) &&
+		   !(update->flags & REF_DELETING) &&
+		   !(update->flags & REF_LOG_ONLY)) {
 		if (!(update->type & REF_ISSYMREF) &&
 		    oideq(&lock->old_oid, &update->new_oid)) {
 			/*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6d42838e15..4bc6a369c7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -908,7 +908,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				new_update = ref_transaction_add_update(
 						transaction, referent.buf, new_flags,
-						&u->new_oid, &u->old_oid, NULL, NULL, u->msg);
+						&u->new_oid, &u->old_oid, u->new_ref, u->old_ref, u->msg);
 				new_update->parent_update = u;
 
 				/*
@@ -1106,6 +1106,11 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			    should_write_log(&arg->refs->base, u->refname))) {
 			struct reftable_log_record *log;
 
+			if (u->flags & REF_SYMREF_UPDATE && u->new_ref)
+				if (!refs_resolve_ref_unsafe(&arg->refs->base, u->new_ref,
+				     RESOLVE_REF_READING, &u->new_oid, NULL))
+					goto done;
+
 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 			log = &logs[logs_nr++];
 			memset(log, 0, sizeof(*log));
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index f4e63fae6e..eeb3ee7952 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1360,6 +1360,7 @@ test_expect_success 'fails with duplicate HEAD update' '
 '
 
 test_expect_success 'fails with duplicate ref update via symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
 	git branch target2 $A &&
 	git symbolic-ref refs/heads/symref2 refs/heads/target2 &&
 	cat >stdin <<-EOF &&
@@ -1812,6 +1813,148 @@ test_expect_success "stdin ${type} symref-create reflogs with --create-reflog" '
 	git reflog exists refs/heads/symref
 '
 
+test_expect_success "stdin ${type} fails symref-update with no ref" '
+	create_stdin_buf ${type} "symref-update " >stdin &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+	grep "fatal: symref-update: missing <ref>" err
+'
+
+test_expect_success "stdin ${type} fails symref-update with no new value" '
+	create_stdin_buf ${type} "symref-update refs/heads/symref" >stdin &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+	grep "fatal: symref-update refs/heads/symref: missing <new-ref>" err
+'
+
+test_expect_success "stdin ${type} fails symref-update with too many arguments" '
+	create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "$a" "$a" >stdin &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+	if test "$type" = "-z"
+	then
+		grep "fatal: unknown command: $a" err
+	else
+		grep "fatal: symref-update refs/heads/symref: extra input:  $a" err
+	fi
+'
+
+test_expect_success "stdin ${type} symref-update ref creates with zero old value" '
+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+	create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "$Z" >stdin &&
+	git update-ref --stdin ${type} --no-deref <stdin &&
+	echo $a >expect &&
+	git symbolic-ref refs/heads/symref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "stdin ${type} symref-update ref creates with empty old value" '
+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+	create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" >stdin &&
+	git update-ref --stdin ${type} --no-deref <stdin &&
+	echo $a >expect &&
+	git symbolic-ref refs/heads/symref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "stdin ${type} symref-update ref fails with wrong old value" '
+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+	git symbolic-ref refs/heads/symref $a &&
+	create_stdin_buf ${type} "symref-update refs/heads/symref" "$m" "$b" >stdin &&
+	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+	grep "fatal: symref-update refs/heads/symref: invalid <old-ref> or <old-oid>" err &&
+	test_must_fail git rev-parse --verify -q $c
+'
+
+test_expect_success "stdin ${type} symref-update ref works with right old value" '
+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+	git symbolic-ref refs/heads/symref $a &&
+	create_stdin_buf ${type} "symref-update refs/heads/symref" "$m" "$a" >stdin &&
+	git update-ref --stdin ${type} --no-deref <stdin &&
+	echo $m >expect &&
+	git symbolic-ref refs/heads/symref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "stdin ${type} symref-update creates symref (with deref)" '
+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+	create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" >stdin &&
+	git update-ref --stdin ${type} <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+	grep "$Z $(git rev-parse $a)" actual
+'
+
+test_expect_success "stdin ${type} symref-update updates symref (with deref)" '
+	test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+	test_when_finished "git update-ref -d --no-deref refs/heads/symref2" &&
+	git update-ref refs/heads/symref2 $a &&
+	git symbolic-ref --no-recurse refs/heads/symref refs/heads/symref2 &&
+	create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" >stdin &&
+	git update-ref --stdin ${type} <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref2 >actual &&
+	test_cmp expect actual &&
+	echo refs/heads/symref2 >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+	grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+'
+
+test_expect_success "stdin ${type} symref-update regular ref" '
+	test_when_finished "git symbolic-ref -d --no-recurse refs/heads/regularref" &&
+	git update-ref --no-deref refs/heads/regularref $a &&
+	create_stdin_buf ${type} "symref-update refs/heads/regularref" "$a" >stdin &&
+	git update-ref --stdin ${type} <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/regularref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
+	grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+'
+
+test_expect_success "stdin ${type} symref-update regular ref with correct old-oid" '
+	test_when_finished "git symbolic-ref -d --no-recurse refs/heads/regularref" &&
+	git update-ref --no-deref refs/heads/regularref $a &&
+	create_stdin_buf ${type} "symref-update refs/heads/regularref" "$a" "$(git rev-parse $a)" >stdin &&
+	git update-ref --stdin ${type} <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/regularref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
+	grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+'
+
+test_expect_success "stdin ${type} symref-update regular ref fails with wrong old-oid" '
+	test_when_finished "git update-ref -d refs/heads/regularref" &&
+	git update-ref --no-deref refs/heads/regularref $a &&
+	create_stdin_buf ${type} "symref-update refs/heads/regularref" "$a" "$(git rev-parse refs/heads/target2)" >stdin &&
+	test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+	echo $(git rev-parse $a) >expect &&
+	git rev-parse refs/heads/regularref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "stdin ${type} symref-update with zero old-oid" '
+	test_when_finished "git symbolic-ref -d --no-recurse refs/heads/symref" &&
+	create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "$Z" >stdin &&
+	git update-ref --stdin ${type} <stdin 2>err &&
+	echo $a >expect &&
+	git symbolic-ref refs/heads/symref >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "stdin ${type} symref-update ref with zero old-oid" '
+	test_when_finished "git symbolic-ref -d --no-recurse refs/heads/symref" &&
+	git symbolic-ref refs/heads/symref refs/heads/target2 &&
+	create_stdin_buf ${type} "symref-update refs/heads/symref" "$a" "$Z" >stdin &&
+	test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+	grep "fatal: cannot lock ref '"'"'refs/heads/symref'"'"': reference already exists" err &&
+	echo refs/heads/target2 >expect &&
+	git symbolic-ref refs/heads/symref >actual &&
+	test_cmp expect actual
+'
+
 done
 
 test_done
-- 
2.43.GIT

