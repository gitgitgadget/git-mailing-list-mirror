Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D87149C72
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145102; cv=none; b=dc9OOGsGmL6uAlfWzTvF1hP1ujBWTErA7KnThgxMtpCIdJ7+MEO+IPvm6dD1WqvZHGr7g74o+426Fj7U2iD2r7REvgLaj/0EjBObAJYjTAf6+oES59F9CxQ55Oybe45wjQswR2JzfN42L9UnEzL85TxNyuqVC6i+1Yk52JEjT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145102; c=relaxed/simple;
	bh=dK/cwbzERywXwb6jmo2f6GlObeiI2M9bOX6d5J+NWq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZ7VKO06w3GndEtSwNBRhLQsp/mbBL+uAp7BAGlAFpNzWCiNhoLuqHkG1i2xz7S7SYbh2Lmq2skNlRGnVdwfdr8skWMYrXzPTpY7nUG7s0RlqW8+GtVjgbU0gJ4DjqCWfjxOElbg569fIJ1kL+ZlGJ3wOFRpVcKmRG7+N2OEVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVpjteXn; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVpjteXn"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so2770238e87.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145098; x=1714749898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LY7oDpRu4UrAgKcse5WCaaw5NZyqQScLMwqQxTFFsk=;
        b=cVpjteXnLwBt+7M0vZbH0PEaVWlGL95DbGkGfNkgfyZ/JDDnjLUQCI+EBhrbDHTOmW
         uYcDfjW75N2EaH4E09Kx/VkPggfCl6X3qtolKthruLL/seOyZFWEqDEDEcvrjopJfn0+
         bmEdrmP/nVaamgjXrr+O2FB3bUGRqm1qBSt4ItUd8BHd4vG2Fs7jY17KotrD0PSvUjXq
         DvN+1eVoEIWcZRR915mEg7c2xgYs1ALosSIbyUIzB0+nN431t4ibLXbQbuemWbffDDK5
         XWA/6eUJE8BZwrJYAXRiSL3qPSHIViflHMQoVXwcRvsklJrhU2nIHevDZncdlhR+HRMA
         QIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145098; x=1714749898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LY7oDpRu4UrAgKcse5WCaaw5NZyqQScLMwqQxTFFsk=;
        b=A86ST1CWeI1iwsXXJEzr2QVFDCI5Tk2tp9OyF4JfbZ+YPXc85qg8AcY+UyUmBm6WBu
         HpIEKTY8YKlDuCOFsLlf85jCdr0YOn7cjP6ra2iYZP2Ic7tY4/G4elIzkKY4s78NcM8f
         7iZYPYCOcPz1fodMuKFeuUyJkCdK71xRNOMr6lQN3Inlgbzb3/+f6J1qB0q79hFfMF7K
         1dKC3/AY2F+yz/I9eX9MW9bPUmFREPjb8Iumtyn7MggYVW9oc7ejSKq8ZsIiM63kAofK
         BdBrHpD31KJT1/Ck5bSHc2NKQmOD+0OZGsBULf6Sn7PhkmwJoL66DcoGgCEJ2x9DbbXq
         WXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHgFQezEecYiuYTbptZRtTVw4D0InZSQUUT41iG5srMckkgkCeqiPCkDWWtdR8Rhmdx334aTuieIzEf+0PztiX+tok
X-Gm-Message-State: AOJu0YxaLQTyJNv7wiKzOnw7KIWCTHNZbHTeY0L/cvguzlsCD9veIt8/
	ZCkt4OTLdRfZQ3ZcZZPXLGBEQT77m/ZatPmYQ/tYvybWA5eBJ62m
X-Google-Smtp-Source: AGHT+IHT4ZDa8eFi6SVej5dKYumWsKpF9uK81u7oCdWB11l+PUVK72fT5Cp0DRJ0ld1SCbUisHrHug==
X-Received: by 2002:ac2:4884:0:b0:517:8ad8:c64 with SMTP id x4-20020ac24884000000b005178ad80c64mr1860937lfc.21.1714145098422;
        Fri, 26 Apr 2024 08:24:58 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm10643868ejm.23.2024.04.26.08.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:24:57 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 5/7] update-ref: add support for 'symref-create' command
Date: Fri, 26 Apr 2024 17:24:47 +0200
Message-ID: <20240426152449.228860-6-knayak@gitlab.com>
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

Add 'symref-create' command to the '--stdin' mode 'git-update-ref' to
allow creation of symbolic refs in a transaction. The 'symref-create'
command takes in a <new-target>, which the created <ref> will point to.

Also, support the 'core.prefersymlinkrefs' config, wherein if the config
is set and the filesystem supports symlinks, we create the symbolic ref
as a symlink. We fallback to creating a regular symref if creating the
symlink is unsuccessful.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt | 10 ++++-
 builtin/clone.c                  |  2 +-
 builtin/update-ref.c             | 35 ++++++++++++++++-
 refs.c                           |  9 +++--
 refs.h                           |  1 +
 refs/files-backend.c             | 42 +++++++++++++++++++++
 refs/reftable-backend.c          | 23 +++++++++--
 t/t0600-reffiles-backend.sh      | 32 ++++++++++++++++
 t/t1400-update-ref.sh            | 65 ++++++++++++++++++++++++++++++++
 9 files changed, 210 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 2924b9437e..7a33f70767 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-create SP <ref> SP <new-target> LF
 	symref-delete SP <ref> [SP <old-target>] LF
 	symref-verify SP <ref> [SP <old-target>] LF
 	option SP <opt> LF
@@ -88,6 +89,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-create SP <ref> NUL <new-target> NUL
 	symref-delete SP <ref> [NUL <old-target>] NUL
 	symref-verify SP <ref> [NUL <old-target>] NUL
 	option SP <opt> NUL
@@ -111,7 +113,9 @@ update::
 
 create::
 	Create <ref> with <new-oid> after verifying it does not
-	exist.  The given <new-oid> may not be zero.
+	exist.  The given <new-oid> may not be zero.  If instead
+	ref:<new-target> is provided, a symbolic ref is created
+	which targets <new-target>.
 
 delete::
 	Delete <ref> after verifying it exists with <old-oid>, if given.
@@ -123,6 +127,10 @@ verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
 
+symref-create::
+	Create symbolic ref <ref> with <new-target> after verifying
+	it does not exist.  Can only be used in `no-deref` mode.
+
 symref-delete::
 	Delete <ref> after verifying it exists with <old-target>, if given.
 
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
index 8fef3aed0a..ae68ffde5e 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -257,7 +257,7 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	if (ref_transaction_create(transaction, refname, &new_oid,
+	if (ref_transaction_create(transaction, refname, &new_oid, NULL,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);
@@ -267,6 +267,38 @@ static void parse_cmd_create(struct ref_transaction *transaction,
 	strbuf_release(&err);
 }
 
+
+static void parse_cmd_symref_create(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	char *refname, *new_target;
+
+	if (!(update_flags & REF_NO_DEREF))
+		die("symref-create: cannot operate with deref mode");
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-create: missing <ref>");
+
+	new_target = parse_next_refname(&next);
+	if (!new_target)
+		die("symref-create %s: missing <new-target>", refname);
+
+	if (*next != line_termination)
+		die("symref-create %s: extra input: %s", refname, next);
+
+	if (ref_transaction_create(transaction, refname, NULL, new_target,
+				   update_flags | create_reflog_flag,
+				   msg, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	free(new_target);
+	strbuf_release(&err);
+}
+
 static void parse_cmd_delete(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -473,6 +505,7 @@ static const struct parse_cmd {
 	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
 	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
 	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-create", parse_cmd_symref_create, 2, UPDATE_REFS_OPEN },
 	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
 	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
 	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
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
index 64214340e7..c5061c26cf 100755
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
+	symref-create TESTSYMREFONE refs/heads/new
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
+	symref-create TESTSYMREFONE refs/heads/new
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
index 8efddac013..452fc1da50 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1787,6 +1787,71 @@ do
 		test_must_fail git symbolic-ref -d refs/heads/symref2
 	'
 
+	test_expect_success "stdin ${type} symref-create fails without --no-deref" '
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" &&
+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+		grep "fatal: symref-create: cannot operate with deref mode" err
+	'
+
+	test_expect_success "stdin ${type} symref-create fails with too many arguments" '
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" "$a" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: $a" err
+		else
+			grep "fatal: symref-create refs/heads/symref: extra input:  $a" err
+		fi
+	'
+
+	test_expect_success "stdin ${type} symref-create fails with no target" '
+		create_stdin_buf ${type} "symref-create refs/heads/symref" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
+	'
+
+	test_expect_success "stdin ${type} symref-create fails with empty target" '
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "" >stdin &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
+	'
+
+	test_expect_success "stdin ${type} symref-create works" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} create dangling symref ref works" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "refs/heads/unkown" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >expect &&
+		echo refs/heads/unkown >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-create does not create reflogs by default" '
+		test_when_finished "git symbolic-ref -d refs/symref" &&
+		create_stdin_buf ${type} "symref-create refs/symref" "$a" >stdin &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/symref >expect &&
+		echo $a >actual &&
+		test_cmp expect actual &&
+		test_must_fail git reflog exists refs/symref
+	'
+
+	test_expect_success "stdin ${type} symref-create reflogs with --create-reflog" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref" &&
+		create_stdin_buf ${type} "symref-create refs/heads/symref" "$a" >stdin &&
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

