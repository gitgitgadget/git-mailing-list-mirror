Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F143519AD46
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767198; cv=none; b=OmICqiXNeHg6BaZxJOGcYPLuz0yU0XWfnDRVdfNWzpGwPBVcp9KxhLwDiaU3wj6KkIlTIUocWDFxdsQ5RM0Eta55bI7uzLhoXB39P/h3g5a8MW79B2n5patt12hUBcit51thNIc6qfFa4XX/03He4XTV9z4M7e5dxY2XXvwn+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767198; c=relaxed/simple;
	bh=ZYte2GA4NtkkNHUAA//rDbe+qAlhvQEYN+TgOrAs+e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXLYaCfWMBPubbwC5tvffd60dICc4ZbAFrZD173BUYQHBVNzn0TNsPrwHX71jAv2bs4FzGViabD1iLMVAgUlpCB1NfJzAqtEXq1OcE9FgCDayLnrIEW/Gs3r/GYrxiN6bRZmgOfCO+JB5HRXnAfwKkXliIGtbCNSLrJX4HVyWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWnlRH7y; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWnlRH7y"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so270319066b.2
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767194; x=1718371994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqia56H/ga97gsbwKVJBW7ZCm3I7W80LHmdo6OOrmoo=;
        b=hWnlRH7yynI3OYlsGdccTTOCucXQVD7yf7Fua6tiM46uf4jnQkBsXOcKa4FCuCOvPg
         6Vlq/52658m9KPXQWEGco2pjvHdrxkcV28uotQ4ofN2hqA5N35EXTyNT4yWYwmmKUANb
         eUQ7V7G3BEiPS7juLMFsoPndyciRplKoYoejZsIfGqqgs8ez1SNtU5v0To5CcaPbiADD
         EktEo2zkyF+oxe72utmRP7Q3paQZOHD7TmAEXA2MtjdojtfXgcsAEkrvSb/oalRg3F9J
         pnmPzlpc4XNjqN3FaFacDFGqlGp8LaB0QxuVUlZqmzBaD/bwrfn8+VW1SUvlN/RRHg6c
         72BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767194; x=1718371994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aqia56H/ga97gsbwKVJBW7ZCm3I7W80LHmdo6OOrmoo=;
        b=bo+BBOMfLA3kCMSmYtRUdinTqbodCXlXbe2a22Y9djbaiCuwEgIdsxEbrj8lSPLtWQ
         IE95ClaXNGEZgg6S+i79E1tpCae81yYThQiaq51Ssb8CS3BcrbJytkkSzuUDdz88MJV6
         F5eKmnqKaAAgqJKUtP1kTHShBsoIPSoTkWkw1VgS/gNGbguRCWxkxvVgvehdC2MbI6A4
         dcSmpXb8Q7thzdX9CR5/c5XtJl0lgT1BEYZOPWGlScvjLT9nBhiAqEQkLtEFkOxpNk8b
         T+7eVGIhREje+gbwlQCaqc0E6F8scPzPfi4o8JFzJBs6YaMmHTQNSlyQuyoIWD8c1Xcr
         iZuw==
X-Gm-Message-State: AOJu0Yx3J13lVgKzvU+FvFs0qX1PQdkMk18ZYcFGr0Lmoumloy2TwHjg
	SUcqkeqdHwroPsHEYM1i00s6uoYyz7vXwSu9Cn9grqeQVtjSUtub
X-Google-Smtp-Source: AGHT+IE6DortFN6eWdQcGVT3RHrS3U33vf//tJZRYhLCag12+eZXbZMJu7E0jCkOZygI0O+W6EnACQ==
X-Received: by 2002:a17:906:3c04:b0:a6a:285d:62d8 with SMTP id a640c23a62f3a-a6cdb9f5c12mr177493566b.74.1717767193417;
        Fri, 07 Jun 2024 06:33:13 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340f6sm2764167a12.90.2024.06.07.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:33:13 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v5 7/7] update-ref: add support for 'symref-update' command
Date: Fri,  7 Jun 2024 15:33:04 +0200
Message-ID: <20240607133304.2333280-8-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240607133304.2333280-1-knayak@gitlab.com>
References: <20240605102958.716432-1-knayak@gitlab.com>
 <20240607133304.2333280-1-knayak@gitlab.com>
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
committish to be provided as an oid. While 'symref-verify' and
'symref-delete' also take in `<old-target>` we do not have this
divergence there as those commands only work with symrefs. Whereas
'symref-update' also works with regular refs and allows users to convert
regular refs to symrefs.

The command allows users to perform symbolic ref updates within a
transaction. This provides atomicity and allows users to perform a set
of operations together.

This command supports deref mode, to ensure that we can update
dereferenced regular refs to symrefs.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |   7 ++
 builtin/update-ref.c             |  92 ++++++++++++++
 t/t1400-update-ref.sh            | 203 +++++++++++++++++++++++++++++++
 t/t1416-ref-transaction-hooks.sh |   4 +
 4 files changed, 306 insertions(+)

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
index 9c40e94626..471fa5c8d1 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -98,6 +98,42 @@ static char *parse_next_refname(const char **next)
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
+
+	strbuf_release(&arg);
+	return NULL;
+}
 
 /*
  * The value being parsed is <old-oid> (as opposed to <new-oid>; the
@@ -237,6 +273,61 @@ static void parse_cmd_update(struct ref_transaction *transaction,
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
+				   new_target,
+				   have_old_oid ? NULL : old_target,
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
@@ -502,6 +593,7 @@ static const struct parse_cmd {
 	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
 	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
 	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-update", parse_cmd_symref_update, 4, UPDATE_REFS_OPEN },
 	{ "symref-create", parse_cmd_symref_create, 2, UPDATE_REFS_OPEN },
 	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
 	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 253263320d..eb1691860d 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1362,6 +1362,7 @@ test_expect_success 'fails with duplicate HEAD update' '
 '
 
 test_expect_success 'fails with duplicate ref update via symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
 	git branch target2 $A &&
 	git symbolic-ref refs/heads/symref2 refs/heads/target2 &&
 	cat >stdin <<-EOF &&
@@ -1864,6 +1865,208 @@ do
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

