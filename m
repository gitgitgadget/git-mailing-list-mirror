Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B783880023
	for <git@vger.kernel.org>; Wed, 22 May 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368621; cv=none; b=Ydq2qDxnlqi9RCF9aC5OCc/fNwO+U9wWpfK4PoTJju/CGIOgsTvBSCaa4+sEB1NkhmmVBylGMaWoPP26GxjHLAF0ikOvUuhESc9S/fwYqcxkH67ZZxMzwzIytgoSvXtZB24DrrBko9G6Qip3HzzPLwLRfBPXtIV/GsWJadrw8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368621; c=relaxed/simple;
	bh=K3Hndgwh8Vl7hrFUu0NKEaDMh/M3P+zQnqI1X1a0eOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suMQjaokR756xNlCnfbY3gK86vZvPaPrctr6jZPndphQXuoKmY5k8FjMh0jlFVvTPWZ01Lo0U5jilWzwQ6gYjuQwjbfRwYba20mq+xqbDq0U8drgGfkyonIXFiCxGQiB9HDXoUUp3wZ8nkJfUTY1owUsB6GFYGQAx6aG3Mab4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7aJ6esZ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7aJ6esZ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so7714561e87.2
        for <git@vger.kernel.org>; Wed, 22 May 2024 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716368617; x=1716973417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOvmsrx6o0Frx0r09R1Ep2FegdZNetuk7DZ7zeBuMi8=;
        b=G7aJ6esZhHY7AHAoU5p8iVorTU/iU9a3k2a9Kti8ESGucvV9OfW2/M5oYL2ZTcpeF9
         2sCcMIOHgxEn6sO3hUBUitPdlS8Fi4WpBGcnaJevlfMXGT4CBQR3QWZ462rBIv1gdKrO
         scnh5Ca8UfzQEYPVItK/m3tWR4/Z8h/Hso9QFqeAgNFWCwuJW7zL8Rs8+Gc5B+cUkobv
         3OmuOLnu44BqglAj20XpWTxkdNkOi3bbg5xAAXJQ4qy56FxVfAL7cFG+NbsCrMVFd7pq
         j1htv+4MY4kj2qhWRYWBds+FRRlVbu2hAHIGnXa2tRdy9Jzgnun6zIWugQRb6qMXm739
         ZEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368617; x=1716973417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOvmsrx6o0Frx0r09R1Ep2FegdZNetuk7DZ7zeBuMi8=;
        b=Fp6/ASelNzEUqMcPYdbbW69I/NMooaptW0iPLCQCxZoYCnvmL/mWn+JRGCtPojoAHC
         OHx92z7Kar9BO5E0tI5XZqBt+3PBGfOo0ZSpN4tBiL39EPyZBWErKxHfPfQfGGr40q+e
         YiM61tra0jjGKl0ULqWW5CO8xQ3J0KSn/uEz7LuJvwXWXBiBZVNEOTuxj5f80WJXG4w+
         hNJesjfT/mAiH157D573VkckyG4QBwuoSwtBq2pNTp2j+WsKb3jSFRxt/kdvO6qahmi7
         DvNpUa55A3EGt1gE/xLJ2UgccogrFgCCqjtJmRf3XtzltM94GZIB8jN5nizhBfi70npt
         3FpA==
X-Gm-Message-State: AOJu0YwoZtyu8QiZZWwx3i6tuTfaxvEzElQM+YJdyI7kr/6lDidEz0Bg
	XSOII074XJxlDqwTWwD72QitFcpojbJX45SHlih3Z5AplROaE39X
X-Google-Smtp-Source: AGHT+IFWWQJy6lajaI//1M8tpZp73n68Kwj3h07zI9eYdTIVJA0BAQXCRrqoPmBSViQSOgXPNHoHwg==
X-Received: by 2002:a05:6512:442:b0:51b:f78d:c189 with SMTP id 2adb3069b0e04-526bd694edbmr786648e87.14.1716368616367;
        Wed, 22 May 2024 02:03:36 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:414d:df4b:1d67:e754])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57509d459desm8281354a12.61.2024.05.22.02.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:03:35 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 6/6] update-ref: add support for 'symref-update' command
Date: Wed, 22 May 2024 11:03:26 +0200
Message-ID: <20240522090326.1268326-7-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522090326.1268326-1-knayak@gitlab.com>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240522090326.1268326-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

Add 'symref-update' command to the '--stdin' mode of 'git-update-ref' to
allow updates of symbolic refs. The 'symref-update' command takes in a
<new-target>, which the <ref> will be updated to. If the <ref> doesn't
exist it will be created.

It also optionally takes either an `ref <old-target>` or `oid
<old-oid>`. If the <old-target> is provided, it checks to see if the
<ref> targets the <old-target> before the update. If <old-oid> is provided
it checks <ref> to ensure that it is a regular ref and <old-oid> is the
OID before the update. This by extension also means that this when a
zero <old-oid> is provided, it ensures that the ref didn't exist before.

The divergence in syntax from the regular `update` command is because if
we don't use a `(ref | oid)` prefix for the old_value, then there is
ambiguity around if the value provided should be treated as an oid or a
reference. This is more so the reason, because we allow anything
committish to be provided as an oid.

The command allows users to perform symbolic ref updates within a
transaction. This provides atomicity and allows users to perform a set
of operations together.

This command supports deref mode, to ensure that we can update
dereferenced regular refs to symrefs.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |   7 ++
 builtin/update-ref.c             |  90 ++++++++++++++
 t/t1400-update-ref.sh            | 203 +++++++++++++++++++++++++++++++
 t/t1416-ref-transaction-hooks.sh |   4 +
 4 files changed, 304 insertions(+)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 364ef78af1..afcf33cf60 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-update SP <ref> SP <new-target> [SP (ref SP <old-target> | oid SP <old-oid>)] LF
 	symref-create SP <ref> SP <new-target> LF
 	symref-delete SP <ref> [SP <old-target>] LF
 	symref-verify SP <ref> [SP <old-target>] LF
@@ -89,6 +90,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-update SP <ref> NUL <new-target> [NUL (ref NUL <old-target> | oid NUL <old-oid>)] NUL
 	symref-create SP <ref> NUL <new-target> NUL
 	symref-delete SP <ref> [NUL <old-target>] NUL
 	symref-verify SP <ref> [NUL <old-target>] NUL
@@ -119,6 +121,11 @@ delete::
 	Delete <ref> after verifying it exists with <old-oid>, if
 	given.  If given, <old-oid> may not be zero.
 
+symref-update::
+	Set <ref> to <new-target> after verifying <old-target> or <old-oid>,
+	if given. Specify a zero <old-oid> to ensure that the ref does not
+	exist before the update.
+
 verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 16d184603b..bda37c161d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -98,6 +98,40 @@ static char *parse_next_refname(const char **next)
 	return parse_refname(next);
 }
 
+/*
+ * Wrapper around parse_arg which skips the next delimiter.
+ */
+static char *parse_next_arg(const char **next)
+{
+	struct strbuf arg = STRBUF_INIT;
+
+	if (line_termination) {
+		/* Without -z, consume SP and use next argument */
+		if (!**next || **next == line_termination)
+			return NULL;
+		if (**next != ' ')
+			die("expected SP but got: %s", *next);
+	} else {
+		/* With -z, read the next NUL-terminated line */
+		if (**next)
+			return NULL;
+	}
+	/* Skip the delimiter */
+	(*next)++;
+
+	if (line_termination) {
+		/* Without -z, use the next argument */
+		*next = parse_arg(*next, &arg);
+	} else {
+		/* With -z, use everything up to the next NUL */
+		strbuf_addstr(&arg, *next);
+		*next += arg.len;
+	}
+
+	if (arg.len)
+		return strbuf_detach(&arg, NULL);
+	return NULL;
+}
 
 /*
  * The value being parsed is <old-oid> (as opposed to <new-oid>; the
@@ -237,6 +271,61 @@ static void parse_cmd_update(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
+static void parse_cmd_symref_update(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	char *refname, *new_target, *old_arg;
+	char *old_target = NULL;
+	struct strbuf err = STRBUF_INIT;
+	struct object_id old_oid;
+	int have_old_oid = 0;
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-update: missing <ref>");
+
+	new_target = parse_next_refname(&next);
+	if (!new_target)
+		die("symref-update %s: missing <new-target>", refname);
+
+	old_arg = parse_next_arg(&next);
+	if (old_arg) {
+		old_target = parse_next_arg(&next);
+		if (!old_target)
+			die("symref-update %s: expected old value", refname);
+
+		if (!strcmp(old_arg, "oid")) {
+			if (repo_get_oid(the_repository, old_target, &old_oid))
+				die("symref-update %s: invalid oid: %s", refname, old_target);
+
+			old_target = NULL;
+			have_old_oid = 1;
+		} else if (!strcmp(old_arg, "ref")) {
+			if (check_refname_format(old_target, REFNAME_ALLOW_ONELEVEL))
+				die("symref-update %s: invalid ref: %s", refname, old_target);
+		} else {
+			die("symref-update %s: invalid arg '%s' for old value", refname, old_arg);
+		}
+	}
+
+	if (*next != line_termination)
+		die("symref-update %s: extra input: %s", refname, next);
+
+	if (ref_transaction_update(transaction, refname, NULL,
+				   have_old_oid ? &old_oid : NULL,
+				   new_target, old_target,
+				   update_flags | create_reflog_flag,
+				   msg, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	free(old_arg);
+	free(old_target);
+	free(new_target);
+	strbuf_release(&err);
+}
+
 static void parse_cmd_create(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -502,6 +591,7 @@ static const struct parse_cmd {
 	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
 	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
 	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-update", parse_cmd_symref_update, 4, UPDATE_REFS_OPEN },
 	{ "symref-create", parse_cmd_symref_create, 2, UPDATE_REFS_OPEN },
 	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
 	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 78001f879a..68afe7c228 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1360,6 +1360,7 @@ test_expect_success 'fails with duplicate HEAD update' '
 '
 
 test_expect_success 'fails with duplicate ref update via symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
 	git branch target2 $A &&
 	git symbolic-ref refs/heads/symref2 refs/heads/target2 &&
 	cat >stdin <<-EOF &&
@@ -1848,6 +1849,208 @@ do
 		git reflog exists refs/heads/symref
 	'
 
+	test_expect_success "stdin $type symref-update fails with too many arguments" '
+		format_command $type "symref-update refs/heads/symref" "$a" "ref" "$a" "$a" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: $a" err
+		else
+			grep "fatal: symref-update refs/heads/symref: extra input:  $a" err
+		fi
+	'
+
+	test_expect_success "stdin $type symref-update fails with wrong old value argument" '
+		format_command $type "symref-update refs/heads/symref" "$a" "foo" "$a" "$a" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		grep "fatal: symref-update refs/heads/symref: invalid arg ${SQ}foo${SQ} for old value" err
+	'
+
+	test_expect_success "stdin $type symref-update creates with zero old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		format_command $type "symref-update refs/heads/symref" "$a" "oid" "$Z" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update creates with no old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		format_command $type "symref-update refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update creates dangling" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		test_must_fail git rev-parse refs/heads/nonexistent &&
+		format_command $type "symref-update refs/heads/symref" "refs/heads/nonexistent" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		echo refs/heads/nonexistent >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update fails with wrong old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref $a &&
+		format_command $type "symref-update refs/heads/symref" "$m" "ref" "$b" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected $b" err &&
+		test_must_fail git rev-parse --verify -q $c
+	'
+
+	test_expect_success "stdin $type symref-update updates dangling ref" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		test_must_fail git rev-parse refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
+		format_command $type "symref-update refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update updates dangling ref with old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		test_must_fail git rev-parse refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
+		format_command $type "symref-update refs/heads/symref" "$a" "ref" "refs/heads/nonexistent" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update fails update dangling ref with wrong old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		test_must_fail git rev-parse refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref refs/heads/nonexistent &&
+		format_command $type "symref-update refs/heads/symref" "$a" "ref" "refs/heads/wrongref" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin &&
+		echo refs/heads/nonexistent >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update works with right old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref $a &&
+		format_command $type "symref-update refs/heads/symref" "$m" "ref" "$a" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		echo $m >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update works with no old value" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref $a &&
+		format_command $type "symref-update refs/heads/symref" "$m" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		echo $m >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update fails with empty old ref-target" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref $a &&
+		format_command $type "symref-update refs/heads/symref" "$m" "ref" "" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin &&
+		echo $a >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update creates (with deref)" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		format_command $type "symref-update refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin $type <stdin &&
+		echo $a >expect &&
+		git symbolic-ref --no-recurse refs/heads/symref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+		grep "$Z $(git rev-parse $a)" actual
+	'
+
+	test_expect_success "stdin $type symref-update regular ref to symref with correct old-oid" '
+		test_when_finished "git symbolic-ref -d --no-recurse refs/heads/regularref" &&
+		git update-ref --no-deref refs/heads/regularref $a &&
+		format_command $type "symref-update refs/heads/regularref" "$a" "oid" "$(git rev-parse $a)" >stdin &&
+		git update-ref --stdin $type <stdin &&
+		echo $a >expect &&
+		git symbolic-ref --no-recurse refs/heads/regularref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
+		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+	'
+
+	test_expect_success "stdin $type symref-update regular ref to symref fails with wrong old-oid" '
+		test_when_finished "git update-ref -d refs/heads/regularref" &&
+		git update-ref --no-deref refs/heads/regularref $a &&
+		format_command $type "symref-update refs/heads/regularref" "$a" "oid" "$(git rev-parse refs/heads/target2)" >stdin &&
+		test_must_fail git update-ref --stdin $type <stdin 2>err &&
+		grep "fatal: cannot lock ref ${SQ}refs/heads/regularref${SQ}: is at $(git rev-parse $a) but expected $(git rev-parse refs/heads/target2)" err &&
+		echo $(git rev-parse $a) >expect &&
+		git rev-parse refs/heads/regularref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update regular ref to symref fails with invalid old-oid" '
+		test_when_finished "git update-ref -d refs/heads/regularref" &&
+		git update-ref --no-deref refs/heads/regularref $a &&
+		format_command $type "symref-update refs/heads/regularref" "$a" "oid" "not-a-ref-oid" >stdin &&
+		test_must_fail git update-ref --stdin $type <stdin 2>err &&
+		grep "fatal: symref-update refs/heads/regularref: invalid oid: not-a-ref-oid" err &&
+		echo $(git rev-parse $a) >expect &&
+		git rev-parse refs/heads/regularref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update existing symref with zero old-oid" '
+		test_when_finished "git symbolic-ref -d --no-recurse refs/heads/symref" &&
+		git symbolic-ref refs/heads/symref refs/heads/target2 &&
+		format_command $type "symref-update refs/heads/symref" "$a" "oid" "$Z" >stdin &&
+		test_must_fail git update-ref --stdin $type <stdin 2>err &&
+		grep "fatal: cannot lock ref ${SQ}refs/heads/symref${SQ}: reference already exists" err &&
+		echo refs/heads/target2 >expect &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-update regular ref to symref (with deref)" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		test_when_finished "git update-ref -d --no-deref refs/heads/symref2" &&
+		git update-ref refs/heads/symref2 $a &&
+		git symbolic-ref --no-recurse refs/heads/symref refs/heads/symref2 &&
+		format_command $type "symref-update refs/heads/symref" "$a" >stdin &&
+		git update-ref $type --stdin <stdin &&
+		echo $a >expect &&
+		git symbolic-ref --no-recurse refs/heads/symref2 >actual &&
+		test_cmp expect actual &&
+		echo refs/heads/symref2 >expect &&
+		git symbolic-ref --no-recurse refs/heads/symref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >actual &&
+		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+	'
+
+	test_expect_success "stdin $type symref-update regular ref to symref" '
+		test_when_finished "git symbolic-ref -d --no-recurse refs/heads/regularref" &&
+		git update-ref --no-deref refs/heads/regularref $a &&
+		format_command $type "symref-update refs/heads/regularref" "$a" >stdin &&
+		git update-ref $type --stdin <stdin &&
+		echo $a >expect &&
+		git symbolic-ref --no-recurse refs/heads/regularref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/regularref >actual &&
+		grep "$(git rev-parse $a) $(git rev-parse $a)" actual
+	'
+
 done
 
 test_done
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index ff77dcca6b..5a812ca3c0 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -163,6 +163,7 @@ test_expect_success 'hook gets all queued symref updates' '
 	git update-ref refs/heads/branch $POST_OID &&
 	git symbolic-ref refs/heads/symref refs/heads/main &&
 	git symbolic-ref refs/heads/symrefd refs/heads/main &&
+	git symbolic-ref refs/heads/symrefu refs/heads/main &&
 
 	test_hook reference-transaction <<-\EOF &&
 	echo "$*" >>actual
@@ -190,10 +191,12 @@ test_expect_success 'hook gets all queued symref updates' '
 	ref:refs/heads/main $ZERO_OID refs/heads/symref
 	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
 	$ZERO_OID ref:refs/heads/main refs/heads/symrefc
+	ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
 	committed
 	ref:refs/heads/main $ZERO_OID refs/heads/symref
 	ref:refs/heads/main $ZERO_OID refs/heads/symrefd
 	$ZERO_OID ref:refs/heads/main refs/heads/symrefc
+	ref:refs/heads/main ref:refs/heads/branch refs/heads/symrefu
 	EOF
 
 	git update-ref --no-deref --stdin <<-EOF &&
@@ -201,6 +204,7 @@ test_expect_success 'hook gets all queued symref updates' '
 	symref-verify refs/heads/symref refs/heads/main
 	symref-delete refs/heads/symrefd refs/heads/main
 	symref-create refs/heads/symrefc refs/heads/main
+	symref-update refs/heads/symrefu refs/heads/branch ref refs/heads/main
 	prepare
 	commit
 	EOF
-- 
2.43.GIT

