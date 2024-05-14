Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380D6E611
	for <git@vger.kernel.org>; Tue, 14 May 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690661; cv=none; b=C5mdBT06xEgd5KdYy2nVUuchzayIwgM9e/uDnzX1fd+FHoTun5xuUVDqeQ6aai/Kb0ru6Xi7U7k8nYoOHfi78qy1QwOFDqTed4qPET8WAybSFpBrHnHPj7ICecNKw7zyImrP8+Df3ewSybepsN/tcl0B/vhSp5pUG085hcXeKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690661; c=relaxed/simple;
	bh=A7OzkcCKrWBgrajZNkkttCV3XO+yijWJaT9ExmIiRKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5leoUofOPXJnmL3u78Wd9GF3a4rgHj3DMLaw1IWsUgRoPyU8JzTPTFEApKzp/w231h5gLfsf3PqvFjdY4QtzE3FrHgvSyCZsvlbbDrZaqJ5UGS4i7F/AjUpjWZmbmuBU1gPX8qlwWQyVhvOIP1vgajzJu6O2DRUtVkCbioRvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXyMZ1FX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXyMZ1FX"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5708d8beec6so44166a12.0
        for <git@vger.kernel.org>; Tue, 14 May 2024 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715690657; x=1716295457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5bEPS5kPyrdTs0gnkuC1q3hx6VqBVyVRPKQltXymZ8=;
        b=QXyMZ1FXmXEQeffsi32CgxR8D59OaGgC8VuF1433vWP4WuYnurixMOr1MfbkJrvJsO
         a7jsamolPmu9K9orI6o0qDHhEG6k+Npnu/NeoMwJr0vek2NrgNdeHckE6vGff5+Cw3/G
         osZQAogOAY26PhmT2eoy4hlsuNwy7L5YcgCbj3TKibhrP7IW5UtMnOJBM46uboytndx0
         AOmKs4bGiVX/38UZD1FFk6QJCyo8JDadHtHxH0DVOWIXlRyBjf7cAd8BTgh3XYv+YLx8
         T+JoJDCQOPCP/cBw2wr76XIVm2DzDTcR3qePoF6D9Q/9G2pEJ42ZIUDogAlDHhtJyyam
         Yh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715690657; x=1716295457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5bEPS5kPyrdTs0gnkuC1q3hx6VqBVyVRPKQltXymZ8=;
        b=GUpg5OY2Gf0RnqI0F7VzRF001BZorYmYhrDUyH5g2R31CnJLwvU8lRGdhpGNvmJyt+
         XF8G2LriRZ9v3rIBFEG1ywoXc8VE8ekpBLtAwy2L3idxoaqX2dyrDZG7XLUTxsxNJ56Y
         xHrQehrlM8eQ+vJhDqoT8kgTnPg+jhsQIMN4IDwJpvINkPF7l4gZESCvo4TLm9DBqEOy
         1VEcl1XHxfGdt0m943lwNQ2SFfvfrZNwaZrbOYveELkKtvbDI2Jax1ZSKtal07PQelXs
         KG6ubOeYpeKX207IL0qpRjlZsuVcAFn6Vw5B9bB81HRDEVGU6CP0alHHR1zvD8R5kN4k
         ZElw==
X-Gm-Message-State: AOJu0YzKZKxhPk3vjsMbnIbqQ5R3n4kVUTSgNKbzeXGx1yCqYyowQkWt
	e7uIH3LVynwAqhUDZIBGdKATvwDj4D++lRC8Y0wjB4eqhJ2dL3U254nhkA==
X-Google-Smtp-Source: AGHT+IHXwcp0vb47/8jT6HYH216Ncz0sql6/Hub/OS7cr4fgtuVWfGD8nPKlo3AE8YSrZ3BAuNYI/w==
X-Received: by 2002:a17:906:4f83:b0:a59:ea34:fe0d with SMTP id a640c23a62f3a-a5a2d65ed4bmr1289116366b.47.1715690657351;
        Tue, 14 May 2024 05:44:17 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b019edsm730530566b.174.2024.05.14.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:44:16 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH 3/6] update-ref: add support for 'symref-delete' command
Date: Tue, 14 May 2024 14:44:08 +0200
Message-ID: <20240514124411.1037019-4-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240514124411.1037019-1-knayak@gitlab.com>
References: <20240514124411.1037019-1-knayak@gitlab.com>
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
provided <ref> only when it points to <old-target>.

This command is only compatible with the 'no-deref' mode because we
optionally want to check the 'old_target' of the ref being deleted.
De-referencing a symbolic ref would provide a regular ref and we already
have the 'delete' command for regular refs.

While users can also use 'git symbolic-ref -d' to delete symbolic refs,
the 'symref-delete' command in 'git-update-ref' allows users to do so
within a transaction, which promises atomicity of the operation and can
be batched with other commands.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  5 +++
 builtin/fetch.c                  |  2 +-
 builtin/receive-pack.c           |  3 +-
 builtin/update-ref.c             | 33 ++++++++++++++++++-
 refs.c                           | 12 ++++---
 refs.h                           |  4 ++-
 t/t1400-update-ref.sh            | 56 +++++++++++++++++++++++++++++++-
 t/t1416-ref-transaction-hooks.sh | 19 ++++++++++-
 8 files changed, 124 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 9fe78b3501..16e02f6979 100644
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
@@ -119,6 +121,9 @@ verify::
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
index 6dce1cd663..0ef9c38d8d 100644
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
index ee4c6ed99c..c2c9889466 100644
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
@@ -1317,14 +1317,18 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
 
@@ -2765,7 +2769,7 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 
 	for_each_string_list_item(item, refnames) {
 		ret = ref_transaction_delete(transaction, item->string,
-					     NULL, flags, msg, &err);
+					     NULL, flags, NULL, msg, &err);
 		if (ret) {
 			warning(_("could not delete reference %s: %s"),
 				item->string, err.buf);
diff --git a/refs.h b/refs.h
index 48cec1ba72..053c382f0b 100644
--- a/refs.h
+++ b/refs.h
@@ -767,7 +767,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
-			   unsigned int flags, const char *msg,
+			   unsigned int flags,
+			   const char *old_target,
+			   const char *msg,
 			   struct strbuf *err);
 
 /*
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 8784c59a53..fbc6b234cb 100755
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
@@ -1729,6 +1729,60 @@ do
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
+		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected refs/heads/main" err &&
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
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index fd58b902f4..ccde1b944b 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -162,6 +162,7 @@ test_expect_success 'hook gets all queued symref updates' '
 
 	git update-ref refs/heads/branch $POST_OID &&
 	git symbolic-ref refs/heads/symref refs/heads/main &&
+	git symbolic-ref refs/heads/symrefd refs/heads/main &&
 
 	test_hook reference-transaction <<-\EOF &&
 	echo "$*" >>actual
@@ -171,16 +172,32 @@ test_expect_success 'hook gets all queued symref updates' '
 	done >>actual
 	EOF
 
-	cat >expect <<-EOF &&
+	# In the files backend, "delete" also triggers an additional transaction
+	# update on the packed-refs backend, which constitutes additional reflog
+	# entries.
+	if test_have_prereq REFFILES
+	then
+		cat >expect <<-EOF
+		aborted
+		$ZERO_OID $ZERO_OID refs/heads/symrefd
+		EOF
+	else
+		>expect
+	fi &&
+
+	cat >>expect <<-EOF &&
 	prepared
 	ref:refs/heads/main $ZERO_OID refs/heads/symref
+	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
 	committed
 	ref:refs/heads/main $ZERO_OID refs/heads/symref
+	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
 	EOF
 
 	git update-ref --no-deref --stdin <<-EOF &&
 	start
 	symref-verify refs/heads/symref refs/heads/main
+	symref-delete refs/heads/symrefd refs/heads/main
 	prepare
 	commit
 	EOF
-- 
2.43.GIT

