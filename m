Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7F381DF
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838798; cv=none; b=O67p/oiENe5d8yBZf/u910n9Kogwd7DvXc2yBSsfyHHq/dWw4GTuFNMRcIDlgQL7hNOC6Nu/uYq0htW4Scj3w93IUPUbBfR+SfSC3mcSq/VP0sFMXIOyDEfonx1L+wChw9TiGkI20JyXnINI/8p70uvhphaTSlRg6qNn/CidDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838798; c=relaxed/simple;
	bh=ZHtKWNvTzyz+uBNJTBK8fx8Iz7WdsutD6e381kTMRrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXuN3olfr8iRZp15rnYAg/XeIzzZJlug617h/L/GyYzXWxod4949aQJBRk19QztybYkbR3ZTYcn2FCFRiS5Wnoh3HUdIQGureCXmc8IZ9C8FYatv+qqv8+HiWTYQJgr1imaGZQGbY44L6B6C13gnegRv/bVm9Ff3xIL6HyF2WXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWrbTMMn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWrbTMMn"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46ba938de0so396168566b.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711838794; x=1712443594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlaWPzTeMegfBmCCEyFm1Ddhz/DJL8YRXMernyZs1pI=;
        b=QWrbTMMnZbgEa8vpgH2gbMGCMN9W78jApGpzsMOtftXVUmljVKMy6f3zXvWolQ1EQs
         ZQptcF5qbbruIiuXeVOrH+o33bIyfmFwnoPIj4qRHQKMRwhgDv0yHhaCU0R13De1gRf+
         MpiuZZOh8dyfKnb+Rcdt3x3vTlG84osNeRl39dRerXR6FQo7tsfXoaICr7NTuqEpbG78
         a138yfvkJLpJqvHYitUrNXRcEozn/kEV5KYkHAERlqWWTy5vVhiFR4umTr959TBDGTS/
         xcqyvd1W8cx9cO+pWpDRNo//HkaE7OHvb4D/HfNNrnRxXdwMXQ5AyTCD4S/nQyg1hgWQ
         cKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711838794; x=1712443594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlaWPzTeMegfBmCCEyFm1Ddhz/DJL8YRXMernyZs1pI=;
        b=mLRIne8pKkuCNerJ92QL6B5xLe3hwOM4DpghE+tybVjkr8uMAfwYCH09DJq4RJ5+9y
         Av621YmD3XezY2Zs7c4PRsV3jxnGDAF86rYmmlOgRNPqDC9GwHkRISR+KcmeTItA+EG5
         8mbkAxdXfoMQYPNt4QcMIuE2ZBDOuSDFep8MSeOoqrrQytNabq0QBhWWkRHRJJboc5A4
         GhgafjCivl7PtGREXrcDJ2OlFitr6Q5R4i0JctcnS27WWDaw9sjasXiMeUuO/TwAPZad
         TYxNnROXUcVCA7kH7BpW6t7bMaGe3Qtqdkn4E6Bqj7RAZqUZRLoqWT/rS4fuLnFZaAa/
         bnWQ==
X-Gm-Message-State: AOJu0YxQvViFmrVi0JvVQj7T0ARN9njsSyDgWn1QCBulCQ+QwLdS2HZV
	26AafJU7X7zhQKQWBK7NpDlTprXRrwVaCL5rhA0tsbYpi3nXHGFzQAae14rYyKc=
X-Google-Smtp-Source: AGHT+IEzmFyqcF8GptS4+GXeaWnkQjxtswA44lzQDkXas2OFseVyhZQgwXix7qm/IfI+4aVsh4PQxw==
X-Received: by 2002:a17:906:3152:b0:a46:8e02:19c4 with SMTP id e18-20020a170906315200b00a468e0219c4mr2929853eje.77.1711838793873;
        Sat, 30 Mar 2024 15:46:33 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:9f01:e67d:4cf3:c3bc])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b00a46cc48ab07sm3533580ejc.221.2024.03.30.15.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 15:46:33 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
Date: Sat, 30 Mar 2024 23:46:22 +0100
Message-ID: <20240330224623.579457-8-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330224623.579457-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'git-update-ref(1)' command allows transactional reference updates.
But currently only supports regular reference updates. Meaning, if one
wants to update HEAD (symbolic ref) in a transaction, there is no tool
to do so.

One option to obtain transactional updates for the HEAD ref is to
manually create the HEAD.lock file and commit. This is intrusive, where
the user needs to mimic internal git behavior. Also, this only works
when using the files backend.

To allow users to update the HEAD ref in a transaction, we introduce
'update-symref' command for 'git-update-ref(1)'. This command allows the
user to create symref in a transaction similar to the 'update' command
of 'git-update-ref(1)'. This command also works well with the existing
'no-deref' option.

The option can also be used to create new symrefs too. This means we
don't need a dedicated `create-symref` option. This is also because we
don't verify the old symref value when updating a symref. So in this
case update and create hold the same meaning.

The regular `delete` option can also be used to delete symrefs. So we
don't add a dedicated `delete-symref` option.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  11 ++-
 builtin/update-ref.c             |  61 ++++++++++++---
 refs.c                           |  10 +++
 t/t0600-reffiles-backend.sh      |  30 ++++++++
 t/t1400-update-ref.sh            | 127 +++++++++++++++++++++++++++++++
 5 files changed, 229 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 0561808cca..2ea8bc8167 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <newvalue> LF
 	delete SP <ref> [SP <oldvalue>] LF
 	verify SP <ref> [SP <oldvalue>] LF
+	update-symref SP <ref> SP <newvalue> LF
 	option SP <opt> LF
 	start LF
 	prepare LF
@@ -86,6 +87,7 @@ quoting:
 	create SP <ref> NUL <newvalue> NUL
 	delete SP <ref> NUL [<oldvalue>] NUL
 	verify SP <ref> NUL [<oldvalue>] NUL
+	update-symref NUL <ref> NUL <newvalue> NUL
 	option SP <opt> NUL
 	start NUL
 	prepare NUL
@@ -111,12 +113,19 @@ create::
 
 delete::
 	Delete <ref> after verifying it exists with <oldvalue>, if
-	given.  If given, <oldvalue> may not be zero.
+	given.  If given, <oldvalue> may not be zero. Can also delete
+	symrefs.
 
 verify::
 	Verify <ref> against <oldvalue> but do not change it.  If
 	<oldvalue> is zero or missing, the ref must not exist.
 
+update-symref::
+	Update <ref> as a symbolic reference to point to the given
+	reference <newvalue>. By default, <ref> will be recursively
+	de-referenced, unless the `no-deref` option is used. Can also
+	be used to create new symrefs.
+
 option::
 	Modify the behavior of the next command naming a <ref>.
 	The only valid option is `no-deref` to avoid dereferencing
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 3807cf4106..357daf31b8 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -213,6 +213,48 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
+static void parse_cmd_update_symref(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	char *refname, *symref;
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("update-symref: missing <ref>");
+
+	if (line_termination) {
+		/* Without -z, consume SP and use next argument */
+		if (!*next || *next == line_termination)
+			die("update-symref %s: missing <newvalue>", refname);
+		if (*next != ' ')
+			die("update-symref %s: expected SP but got: %s",
+			    refname, next);
+	} else {
+		/* With -z, read the next NUL-terminated line */
+		if (*next)
+			die("update-symref %s: missing <newvalue>", refname);
+	}
+	next++;
+
+	symref = parse_refname(&next);
+	if (!symref)
+		die("update-symref %s: missing <newvalue>", refname);
+
+	if (*next != line_termination)
+		die("update-symref %s: extra input: %s", refname, next);
+
+	if (ref_transaction_update(transaction, refname, NULL, NULL,
+				   update_flags | create_reflog_flag | REF_UPDATE_SYMREF,
+				   msg, symref, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(symref);
+	free(refname);
+	strbuf_release(&err);
+}
+
 static void parse_cmd_create(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -379,15 +421,16 @@ static const struct parse_cmd {
 	unsigned args;
 	enum update_refs_state state;
 } command[] = {
-	{ "update",  parse_cmd_update,  3, UPDATE_REFS_OPEN },
-	{ "create",  parse_cmd_create,  2, UPDATE_REFS_OPEN },
-	{ "delete",  parse_cmd_delete,  2, UPDATE_REFS_OPEN },
-	{ "verify",  parse_cmd_verify,  2, UPDATE_REFS_OPEN },
-	{ "option",  parse_cmd_option,  1, UPDATE_REFS_OPEN },
-	{ "start",   parse_cmd_start,   0, UPDATE_REFS_STARTED },
-	{ "prepare", parse_cmd_prepare, 0, UPDATE_REFS_PREPARED },
-	{ "abort",   parse_cmd_abort,   0, UPDATE_REFS_CLOSED },
-	{ "commit",  parse_cmd_commit,  0, UPDATE_REFS_CLOSED },
+	{ "update",        parse_cmd_update,        3, UPDATE_REFS_OPEN },
+	{ "update-symref", parse_cmd_update_symref, 2, UPDATE_REFS_OPEN },
+	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
+	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
+	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
+	{ "start",         parse_cmd_start,         0, UPDATE_REFS_STARTED },
+	{ "prepare",       parse_cmd_prepare,       0, UPDATE_REFS_PREPARED },
+	{ "abort",         parse_cmd_abort,         0, UPDATE_REFS_CLOSED },
+	{ "commit",        parse_cmd_commit,        0, UPDATE_REFS_CLOSED },
 };
 
 static void update_refs_stdin(void)
diff --git a/refs.c b/refs.c
index 69b89a1aa2..706dcd6deb 100644
--- a/refs.c
+++ b/refs.c
@@ -1216,6 +1216,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	}
 
 	for (i = 0; i < transaction->nr; i++) {
+		free(transaction->updates[i]->symref_target);
 		free(transaction->updates[i]->msg);
 		free(transaction->updates[i]);
 	}
@@ -1235,6 +1236,9 @@ struct ref_update *ref_transaction_add_update(
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		BUG("update called for transaction that is not open");
 
+	if ((flags & (REF_HAVE_NEW | REF_UPDATE_SYMREF)) == (REF_HAVE_NEW | REF_UPDATE_SYMREF))
+		BUG("cannot create regular ref and symref at once");
+
 	FLEX_ALLOC_STR(update, refname, refname);
 	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
 	transaction->updates[transaction->nr++] = update;
@@ -1245,6 +1249,8 @@ struct ref_update *ref_transaction_add_update(
 		oidcpy(&update->new_oid, new_oid);
 	if (flags & REF_HAVE_OLD)
 		oidcpy(&update->old_oid, old_oid);
+	if (flags & REF_UPDATE_SYMREF)
+		update->symref_target = xstrdup(symref);
 	update->msg = normalize_reflog_message(msg);
 	return update;
 }
@@ -2337,6 +2343,10 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
+		// Reference transaction does not support symbolic updates.
+		if (update->flags & REF_UPDATE_SYMREF)
+			continue;
+
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s %s %s\n",
 			    oid_to_hex(&update->old_oid),
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 64214340e7..6d334cb477 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -472,4 +472,34 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	esac
 '
 
+test_expect_success SYMLINKS 'symref transaction supports symlinks' '
+	git update-ref refs/heads/new @ &&
+	test_config core.prefersymlinkrefs true &&
+	cat >stdin <<-EOF &&
+	start
+	update-symref TESTSYMREFONE refs/heads/new
+	prepare
+	commit
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	test_path_is_symlink .git/TESTSYMREFONE &&
+	test "$(test_readlink .git/TESTSYMREFONE)" = refs/heads/new
+'
+
+test_expect_success 'symref transaction supports false symlink config' '
+	git update-ref refs/heads/new @ &&
+	test_config core.prefersymlinkrefs false &&
+	cat >stdin <<-EOF &&
+	start
+	update-symref TESTSYMREFONE refs/heads/new
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
index 6ebc3ef945..2a6036471b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -868,6 +868,105 @@ test_expect_success 'stdin delete symref works flag --no-deref' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stdin update-symref creates symref with --no-deref' '
+	# ensure that the symref does not already exist 
+	test_must_fail git symbolic-ref --no-recurse refs/heads/symref &&
+	cat >stdin <<-EOF &&
+	update-symref refs/heads/symref $b
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	echo $b >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+	grep "$Z $(git rev-parse $b)" actual
+'
+
+test_expect_success 'stdin update-symref updates symref with --no-deref' '
+	# ensure that the symref already exists
+	git symbolic-ref --no-recurse refs/heads/symref &&
+	cat >stdin <<-EOF &&
+	update-symref refs/heads/symref $a
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+	grep "$(git rev-parse $b) $(git rev-parse $a)" actual
+'
+
+test_expect_success 'stdin update-symref noop update with --no-deref' '
+	git symbolic-ref --no-recurse refs/heads/symref >actual &&
+	echo $a >expect &&
+	test_cmp expect actual &&
+	cat >stdin <<-EOF &&
+	update-symref refs/heads/symref $a
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	git symbolic-ref --no-recurse refs/heads/symref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+	grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+'
+
+test_expect_success 'stdin update-symref regular ref with --no-deref' '
+	git update-ref refs/heads/regularref $a &&
+	cat >stdin <<-EOF &&
+	update-symref refs/heads/regularref $a
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/regularref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
+	grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+'
+
+test_expect_success 'stdin update-symref creates symref' '
+	# delete the ref since it already exists from previous tests
+	git update-ref --no-deref -d refs/heads/symref &&
+	cat >stdin <<-EOF &&
+	update-symref refs/heads/symref $b
+	EOF
+	git update-ref --stdin <stdin &&
+	echo $b >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+	grep "$Z $(git rev-parse $b)" actual
+'
+
+test_expect_success 'stdin update-symref updates symref' '
+	git update-ref refs/heads/symref2 $b &&
+	git symbolic-ref --no-recurse refs/heads/symref refs/heads/symref2 &&
+	cat >stdin <<-EOF &&
+	update-symref refs/heads/symref $a
+	EOF
+	git update-ref --stdin <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref2 >actual &&
+	test_cmp expect actual &&
+	echo refs/heads/symref2 >expect &&
+	git symbolic-ref --no-recurse refs/heads/symref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+	grep "$(git rev-parse $b) $(git rev-parse $b)" actual
+'
+
+test_expect_success 'stdin update-symref regular ref' '
+	git update-ref --no-deref refs/heads/regularref $a &&
+	cat >stdin <<-EOF &&
+	update-symref refs/heads/regularref $a
+	EOF
+	git update-ref --stdin <stdin &&
+	echo $a >expect &&
+	git symbolic-ref --no-recurse refs/heads/regularref >actual &&
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
+	grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+'
+
 test_expect_success 'stdin delete ref works with right old value' '
 	echo "delete $b $m~1" >stdin &&
 	git update-ref --stdin <stdin &&
@@ -1641,4 +1740,32 @@ test_expect_success PIPE 'transaction flushes status updates' '
 	test_cmp expected actual
 '
 
+test_expect_success 'transaction can commit symref update' '
+	git symbolic-ref TESTSYMREFONE $a &&
+	cat >stdin <<-EOF &&
+	start
+	update-symref TESTSYMREFONE refs/heads/branch
+	prepare
+	commit
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	echo refs/heads/branch >expect &&
+	git symbolic-ref TESTSYMREFONE >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'transaction can abort symref update' '
+	git symbolic-ref TESTSYMREFONE $a &&
+	cat >stdin <<-EOF &&
+	start
+	update-symref TESTSYMREFONE refs/heads/branch
+	prepare
+	abort
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	echo $a >expect &&
+	git symbolic-ref TESTSYMREFONE >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.GIT

