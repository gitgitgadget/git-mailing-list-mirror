Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E080632
	for <git@vger.kernel.org>; Wed, 22 May 2024 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716368616; cv=none; b=ch8erI3vaw6KW+E63amAgZdy/YDnvJgmnjKAb6bp0sfZovWMGxOkbd3+lNHfWkcCCqB2MdszSJQKipT48nEeSq6JgoDH9er8RDERVrdzRny6tIo19rXzyFjtmnl4iDHGEFcdbVAYvcff9tcs6K1hCmTFqQC9JTxvae6mzxggBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716368616; c=relaxed/simple;
	bh=HZQeBlGGeL/gxQU58fHe4ME63q+oE5R76esqen9PpXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS70MA7SHTEPPMCkGra1UOPEL633fkEW6kMvLbsUDeMP+Ag9KoHC9cmehPhp3ybHVnWYe9WS7vK7KC59QN3ZnZHVnt6P034++YIXle9JVcFuxwcb/Pf2+2A9gzsmPsc9N/myzWQGHaY3neZ0hMr0s1R63et+MUNZXTMZG43m6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmRlmBCE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmRlmBCE"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so11096907a12.1
        for <git@vger.kernel.org>; Wed, 22 May 2024 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716368613; x=1716973413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGVphmbiPVn7ximhQRvx4E885yMC909YJDzBXXFur4I=;
        b=EmRlmBCEp9vd99aalgLV121MtWfT0KdZBf/n210nI0YcEu/et6y6+vld7mxrOgEy0a
         xBpES2snXGHwZaF2aCjiz4oPbr8qR7XCRp3nUZLHdbUFp8PNezjOCs+bdT8MGcgAgbBa
         VtTRVrs40+gMtF8kLg57Rr5IklCUtWmbnhvXyPQpK/aecvVzhbCcxrgTOOMwXtNOE7UW
         G9HItbhKHr17sxseIurfXQZ8CtQHuYzJKQC25IqjdxpujhIfkKSEwar87TZKxSEU34VT
         t/+vAGLcdF/bpnSpTGlEjI6IUZ/M4SVAgmLv8/0A4iAzKB7vR4lEKvEnKvHMx0wgcpfw
         +jyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368613; x=1716973413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGVphmbiPVn7ximhQRvx4E885yMC909YJDzBXXFur4I=;
        b=wj6Poq8qA9eHCq1u3DLHE3hIZ2X1YQZMcSAeob7RjNS/d0854Idkz9l+9TKZ1VdCD+
         WF1ri8VIM0XTitzkoXoZctF0Afz0mx1BXuD4YKFeS7mXQhQo9y0PAEr/DBf1oeOK+LDm
         e39tiBsXCywzg4oCW0JULX7HcX8MYgsmNVCJmSBrJu1I9wulppDw3vsPwBMIXI4q9dBQ
         qc9nuBrKdgM5n1KSk/+pOPiOo6dgpogeZ1CA7ix0zCwfs7TvdCJZUISOpZXS/+I0Dd6A
         KuW6wO+0ZwFd6sLHUO9Ae3/4RDTzAbip+UJqN1Uh+VmO0vxSejYve5O1Bx64DIM49RTh
         xs7w==
X-Gm-Message-State: AOJu0Yzra873kk0Ak3bs8dWQ34x/++EVfqowlj+ircxNnRli5YpOVqVX
	2okYM9FRePfKUyqa/LR9hYibK95ckFaLyGBZwAS5afW4CQHYV0dwl/ZBolUA
X-Google-Smtp-Source: AGHT+IF0YSAMozp6sSPZAKci4lNc151GXj495txCumD6w9VFTCqjeGEpU1Q0FtSDp99W7nl7oB6+sw==
X-Received: by 2002:a50:950e:0:b0:572:8aab:4415 with SMTP id 4fb4d7f45d1cf-57832c12431mr824956a12.40.1716368613030;
        Wed, 22 May 2024 02:03:33 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:414d:df4b:1d67:e754])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57509d459desm8281354a12.61.2024.05.22.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:03:32 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v2 3/6] update-ref: add support for 'symref-delete' command
Date: Wed, 22 May 2024 11:03:23 +0200
Message-ID: <20240522090326.1268326-4-knayak@gitlab.com>
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
 refs.c                           | 14 ++++++---
 refs.h                           |  4 ++-
 t/t1400-update-ref.sh            | 54 ++++++++++++++++++++++++++++++++
 t/t1416-ref-transaction-hooks.sh | 19 ++++++++++-
 8 files changed, 125 insertions(+), 9 deletions(-)

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
index 865264d487..3afebfcb63 100644
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
@@ -1317,14 +1317,20 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
+	if (old_oid && old_target)
+		BUG("delete called with both old_oid and old_target set");
+	if (old_target && !(flags & REF_NO_DEREF))
+		BUG("delete cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname,
 				      null_oid(), old_oid,
-				      NULL, NULL, flags,
+				      NULL, old_target, flags,
 				      msg, err);
 }
 
@@ -2767,7 +2773,7 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 
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
index 07e111b063..22d560f0bf 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1729,6 +1729,60 @@ do
 		test_cmp expect actual
 	'
 
+	test_expect_success "stdin $type symref-delete fails without --no-deref" '
+		git symbolic-ref refs/heads/symref $a &&
+		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
+		test_must_fail git update-ref --stdin $type <stdin 2>err &&
+		grep "fatal: symref-delete: cannot operate with deref mode" err
+	'
+
+	test_expect_success "stdin $type symref-delete fails with no ref" '
+		format_command $type "symref-delete " >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		grep "fatal: symref-delete: missing <ref>" err
+	'
+
+	test_expect_success "stdin $type symref-delete fails with too many arguments" '
+		format_command $type "symref-delete refs/heads/symref" "$a" "$a" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: $a" err
+		else
+			grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
+		fi
+	'
+
+	test_expect_success "stdin $type symref-delete fails with wrong old value" '
+		format_command $type "symref-delete refs/heads/symref" "$m" >stdin &&
+		test_must_fail git update-ref --stdin $type --no-deref <stdin 2>err &&
+		grep "fatal: verifying symref target: ${SQ}refs/heads/symref${SQ}: is at $a but expected refs/heads/main" err &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin $type symref-delete works with right old value" '
+		format_command $type "symref-delete refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		test_must_fail git rev-parse --verify -q refs/heads/symref
+	'
+
+	test_expect_success "stdin $type symref-delete works with empty old value" '
+		git symbolic-ref refs/heads/symref $a >stdin &&
+		format_command $type "symref-delete refs/heads/symref" "" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
+		test_must_fail git rev-parse --verify -q $b
+	'
+
+	test_expect_success "stdin $type symref-delete succeeds for dangling reference" '
+		test_must_fail git symbolic-ref refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
+		format_command $type "symref-delete refs/heads/symref2" "refs/heads/nonexistent" >stdin &&
+		git update-ref --stdin $type --no-deref <stdin &&
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

