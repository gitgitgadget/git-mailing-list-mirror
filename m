Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7607A14883B
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145100; cv=none; b=sOUpEcJTAC95XcINMKReQHUITJL6jMP05QLuPsFqhughy11HddBfmO2fdIo5ViCl3+uENaDxhQKmRBzEOTgDDcc2TSLUxlqVNinHIFtMrWn9lruLR0OlxMYITgZ6SjB5qUtq63ccLTFCmSitVJ5FgBKAJI7NJpOkhA7CGxhLVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145100; c=relaxed/simple;
	bh=UVArQJvEnJ4fHukVtEKyYIiZvkzF0G3oPUibIdJpKck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ayt1Zmeg/By1kGTVgci+N1Lz7crw6BfOc1uAKOIuDB4VWy5KU17P3vp9rghYqzMwpp2zSnO02lY3VdGxo/76zDrwG530nVgICua/qWo+SuUzE6dCEfT5f7OMMy8GR6kdrcqR6azC09yG6FoEwoH1U03hlLUAXc0paRdSBPteJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcdK9Og8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcdK9Og8"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a58a36008ceso295002966b.0
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145097; x=1714749897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDe92oyAJ2BIIHrFol3XElNT+LWwRwR/FOoM2CPH+dE=;
        b=UcdK9Og8VVXiZdF2KEW9Ia4swdTgdOr3pPFuQrz0D0AxpmXiZRjJEk+FAHJp9Yshyj
         6ToVM9FAB38Jw2dNudidjwrPqUtceX9XhXJaM9iSYQF4uO4MmZZfUWCH+O0JU5JXTkBD
         k8thoxXozdJzB/oGGfMalnOYar+qfjM16rKqQPdkL9gGwBccruYOwm5YogXP+Y3v+goE
         rpz8JQvn68TMzNh1xn/5raNvRltVPWSbzx4O002lNagrA8pbPvzkPA7NuYcFCDesR/+M
         W/qbPs3Vh18Mpqv/x9Nkm7ykWkUyYV9L3RZV6SK2IBaDIuvgBDll6FIuUezhNYTk4q+e
         0+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145097; x=1714749897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDe92oyAJ2BIIHrFol3XElNT+LWwRwR/FOoM2CPH+dE=;
        b=hmkNIFWvjNIYyfWRjUmZJ4r8onK7EFpCrIuh5As4i+K8NMSKgPNG+yplwRiNObrWVE
         jTXbGhhodZajQT4KPBgOeB8QvHxmCsMmpC0VYrxAvplK4te/NmSvzcGMskRfunobmIjm
         rYlzaFwy/rmpVz2Db6pb3/qcZQNTIstCvIj0Y3k5w2SiMehjLbl4h/lXOJa0Or7Tjz89
         u92mXaD0jejKWmULtUqbigJDVlgvQbMWPV9cLJ8gZBg+ogRO/scvC8bAFMy0sYo9KkVR
         sdtLv/ZJmG1XayOub4OY4YD6akf4NianYdIe5ppAA8Tun2CjjeZV/M3PbmpxoKnY35Vm
         G7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVnh8BijzDmMnfVKg4BPmV9UtmR1uyQQkuTPUriL26GK+FrEG02znXYZjJO0mL9ts3SfbZUFkzvcgRBajw6T8a9bDFi
X-Gm-Message-State: AOJu0YzuxdrpRcSgKBzWWQSViJ1M6jwieEo7PseHRbiA4/niJ7HYxXmB
	j9MCnFJvVy4LW4bEzNAxibnSIqeqP1zOo1nzm3Hw83u0cSvrCiki
X-Google-Smtp-Source: AGHT+IEd4kkCF1cCXHoKXGH3Mud7GsGfpkUDtrNTs5ejAmgwb5cUpkHaXZnHeMpCCynZK8k2nnpWAA==
X-Received: by 2002:a17:906:114a:b0:a52:30a3:930c with SMTP id i10-20020a170906114a00b00a5230a3930cmr2411524eja.58.1714145096568;
        Fri, 26 Apr 2024 08:24:56 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm10643868ejm.23.2024.04.26.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:24:55 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 3/7] update-ref: add support for 'symref-verify' command
Date: Fri, 26 Apr 2024 17:24:45 +0200
Message-ID: <20240426152449.228860-4-knayak@gitlab.com>
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

In the previous commits, we added the required base for adding symref
commands to the '--stdin' mode provided by 'git-update-ref(1)'. Using
them, add a new 'symref-verify' command to verify symrefs.

The 'symref-verify' command allows users to verify if a provided <ref>
contains the provided <old-target> without changing the <ref>. If
<old-target> is not provided, the command will verify that the <ref>
doesn't exist. Since we're checking for symbolic refs, this command will
only work with the 'no-deref' mode. This is because any dereferenced
symbolic ref will point to an object and not a ref and the regular
'verify' command can be used in such situations.

Add and use `ref_update_is_null_new_value`, a helper function which is
used to check if there is a new_value in a reference update. The new
value could either be a symref target `new_target` or a OID `new_oid`.
We also add tests to test the command in both the regular stdin mode and
also with the '-z' flag.

We also disable the reference-transaction hook for symref-updates which
will be tackled in its own commit.

Add required tests for symref support in 'verify' while also adding
reflog checks for the pre-existing 'verify' tests.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt |  7 +++
 builtin/update-ref.c             | 80 +++++++++++++++++++++++----
 refs.c                           | 30 +++++++++--
 refs.h                           |  1 +
 refs/files-backend.c             | 43 +++++++++++++++
 refs/refs-internal.h             |  7 +++
 refs/reftable-backend.c          | 21 +++++++-
 t/t1400-update-ref.sh            | 93 +++++++++++++++++++++++++++++++-
 8 files changed, 264 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 374a2ebd2b..9fe78b3501 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
 	verify SP <ref> [SP <old-oid>] LF
+	symref-verify SP <ref> [SP <old-target>] LF
 	option SP <opt> LF
 	start LF
 	prepare LF
@@ -86,6 +87,7 @@ quoting:
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
 	verify SP <ref> NUL [<old-oid>] NUL
+	symref-verify SP <ref> [NUL <old-target>] NUL
 	option SP <opt> NUL
 	start NUL
 	prepare NUL
@@ -117,6 +119,11 @@ verify::
 	Verify <ref> against <old-oid> but do not change it.  If
 	<old-oid> is zero or missing, the ref must not exist.
 
+symref-verify::
+	Verify symbolic <ref> against <old-target> but do not change it.
+	If <old-target> is missing, the ref must not exist.  Can only be
+	used in `no-deref` mode.
+
 option::
 	Modify the behavior of the next command naming a <ref>.
 	The only valid option is `no-deref` to avoid dereferencing
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 21fdbf6ac8..419b28169b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -76,6 +76,29 @@ static char *parse_refname(const char **next)
 	return strbuf_detach(&ref, NULL);
 }
 
+/*
+ * Wrapper around parse_refname which skips the next delimiter.
+ */
+static char *parse_next_refname(const char **next)
+{
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
+	return parse_refname(next);
+}
+
+
 /*
  * The value being parsed is <old-oid> (as opposed to <new-oid>; the
  * difference affects which error messages are generated):
@@ -297,11 +320,47 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
 		die("verify %s: extra input: %s", refname, next);
 
 	if (ref_transaction_verify(transaction, refname, &old_oid,
-				   update_flags, &err))
+				   NULL, update_flags, &err))
+		die("%s", err.buf);
+
+	update_flags = default_flags;
+	free(refname);
+	strbuf_release(&err);
+}
+
+static void parse_cmd_symref_verify(struct ref_transaction *transaction,
+				    const char *next, const char *end)
+{
+	struct strbuf err = STRBUF_INIT;
+	struct object_id old_oid;
+	char *refname, *old_target;
+
+	if (!(update_flags & REF_NO_DEREF))
+		die("symref-verify: cannot operate with deref mode");
+
+	refname = parse_refname(&next);
+	if (!refname)
+		die("symref-verify: missing <ref>");
+
+	/*
+	 * old_ref is optional, but we want to differentiate between
+	 * a NULL and zero value.
+	 */
+	old_target = parse_next_refname(&next);
+	if (!old_target)
+		old_oid = *null_oid();
+
+	if (*next != line_termination)
+		die("symref-verify %s: extra input: %s", refname, next);
+
+	if (ref_transaction_verify(transaction, refname,
+				   old_target ? NULL : &old_oid,
+				   old_target, update_flags, &err))
 		die("%s", err.buf);
 
 	update_flags = default_flags;
 	free(refname);
+	free(old_target);
 	strbuf_release(&err);
 }
 
@@ -380,15 +439,16 @@ static const struct parse_cmd {
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
+	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
+	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
+	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
+	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
+	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
+	{ "start",         parse_cmd_start,         0, UPDATE_REFS_STARTED },
+	{ "prepare",       parse_cmd_prepare,       0, UPDATE_REFS_PREPARED },
+	{ "abort",         parse_cmd_abort,         0, UPDATE_REFS_CLOSED },
+	{ "commit",        parse_cmd_commit,        0, UPDATE_REFS_CLOSED },
 };
 
 static void update_refs_stdin(void)
diff --git a/refs.c b/refs.c
index 060a31616d..0e1013b5ab 100644
--- a/refs.c
+++ b/refs.c
@@ -1217,6 +1217,8 @@ void ref_transaction_free(struct ref_transaction *transaction)
 
 	for (i = 0; i < transaction->nr; i++) {
 		free(transaction->updates[i]->msg);
+		free((void *)transaction->updates[i]->old_target);
+		free((void *)transaction->updates[i]->new_target);
 		free(transaction->updates[i]);
 	}
 	free(transaction->updates);
@@ -1247,9 +1249,13 @@ struct ref_update *ref_transaction_add_update(
 
 	update->flags = flags;
 
-	if (flags & REF_HAVE_NEW)
+	if (new_target)
+		update->new_target = xstrdup(new_target);
+	if (old_target)
+		update->old_target = xstrdup(old_target);
+	if (new_oid && flags & REF_HAVE_NEW)
 		oidcpy(&update->new_oid, new_oid);
-	if (flags & REF_HAVE_OLD)
+	if (old_oid && flags & REF_HAVE_OLD)
 		oidcpy(&update->old_oid, old_oid);
 	update->msg = normalize_reflog_message(msg);
 	return update;
@@ -1286,6 +1292,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
 
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
+	flags |= (new_target ? REF_HAVE_NEW : 0) | (old_target ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
 				   new_oid, old_oid, new_target,
@@ -1325,14 +1332,17 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
+			   const char *old_target,
 			   unsigned int flags,
 			   struct strbuf *err)
 {
-	if (!old_oid)
-		BUG("verify called with old_oid set to NULL");
+	if (!old_target && !old_oid)
+		BUG("verify called with old_oid and old_target set to NULL");
+	if (old_target && !(flags & REF_NO_DEREF))
+		BUG("verify cannot operate on symrefs with deref mode");
 	return ref_transaction_update(transaction, refname,
 				      NULL, old_oid,
-				      NULL, NULL,
+				      NULL, old_target,
 				      flags, NULL, err);
 }
 
@@ -2349,6 +2359,12 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
+		/*
+		 * Skip reference transaction for symbolic refs.
+		 */
+		if (update->new_target || update->old_target)
+			continue;
+
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s %s %s\n",
 			    oid_to_hex(&update->old_oid),
@@ -2802,3 +2818,7 @@ int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg
 {
 	return refs_copy_existing_ref(get_main_ref_store(the_repository), oldref, newref, logmsg);
 }
+
+int ref_update_is_null_new_value(struct ref_update *update) {
+	return !update->new_target && is_null_oid(&update->new_oid);
+}
diff --git a/refs.h b/refs.h
index c792e13a64..27b9aeaf54 100644
--- a/refs.h
+++ b/refs.h
@@ -780,6 +780,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
+			   const char *old_target,
 			   unsigned int flags,
 			   struct strbuf *err);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2420dac2aa..53197fa3af 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2425,6 +2425,37 @@ static const char *original_update_refname(struct ref_update *update)
 	return update->refname;
 }
 
+/*
+ * Check whether the REF_HAVE_OLD and old_target values stored in
+ * update are consistent with ref, which is the symbolic reference's
+ * current value. If everything is OK, return 0; otherwise, write an
+ * error message to err and return -1.
+ */
+static int check_old_target(struct ref_update *update, char *ref,
+			    struct strbuf *err)
+{
+	if (!(update->flags & REF_HAVE_OLD) ||
+	    !strcmp(update->old_target, ref))
+		return 0;
+
+	if (!strcmp(update->old_target, ""))
+		strbuf_addf(err, "cannot lock ref '%s': "
+			    "reference already exists",
+			    original_update_refname(update));
+	else if (!strcmp(ref, ""))
+		strbuf_addf(err, "cannot lock ref '%s': "
+			    "reference is missing but expected %s",
+			    original_update_refname(update),
+			    update->old_target);
+	else
+		strbuf_addf(err, "cannot lock ref '%s': "
+			    "is at %s but expected %s",
+			    original_update_refname(update),
+			    ref, update->old_target);
+
+	return -1;
+}
+
 /*
  * Check whether the REF_HAVE_OLD and old_oid values stored in update
  * are consistent with oid, which is the reference's current value. If
@@ -2528,6 +2559,18 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto out;
 				}
+			}
+
+			/*
+			 * For symref verification, we need to check the reference value
+			 * rather than the oid. If we're dealing with regular refs or we're
+			 * verifying a dereferenced symref, we then check the oid.
+			 */
+			if (update->old_target) {
+				if (check_old_target(update, referent.buf, err)) {
+					ret = TRANSACTION_GENERIC_ERROR;
+					goto out;
+				}
 			} else if (check_old_oid(update, &lock->old_oid, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto out;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3040d4797c..23e65f65e8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -748,4 +748,11 @@ void base_ref_store_init(struct ref_store *refs, struct repository *repo,
  */
 struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_store *store);
 
+/*
+ * Helper function to check if the new value is null, this
+ * takes into consideration that the update could be a regular
+ * ref or a symbolic ref.
+ */
+int ref_update_is_null_new_value(struct ref_update *update);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6104471199..a2474245aa 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -938,7 +938,26 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		 * individual refs. But the error messages match what the files
 		 * backend returns, which keeps our tests happy.
 		 */
-		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
+		if ((u->flags & REF_HAVE_OLD) && u->old_target) {
+			if (strcmp(referent.buf, u->old_target)) {
+				if (!strcmp(u->old_target, ""))
+					strbuf_addf(err, "verifying symref target: '%s': "
+						    "provided target is empty",
+						    original_update_refname(u));
+				else if (!strcmp(referent.buf, ""))
+					strbuf_addf(err, "verifying symref target: '%s': "
+						    "reference is missing but expected %s",
+						    original_update_refname(u),
+						    u->old_target);
+				else
+					strbuf_addf(err, "verifying symref target: '%s': "
+						    "is at %s but expected %s",
+						    original_update_refname(u),
+						    referent.buf, u->old_target);
+				ret = -1;
+				goto done;
+			}
+		} else if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
 			if (is_null_oid(&u->old_oid))
 				strbuf_addf(err, _("cannot lock ref '%s': "
 					    "reference already exists"),
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index ec3443cc87..34b29eeac8 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -890,17 +890,23 @@ test_expect_success 'stdin update/create/verify combination works' '
 '
 
 test_expect_success 'stdin verify succeeds for correct value' '
+	test-tool ref-store main for-each-reflog-ent $m >before &&
 	git rev-parse $m >expect &&
 	echo "verify $m $m" >stdin &&
 	git update-ref --stdin <stdin &&
 	git rev-parse $m >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test-tool ref-store main for-each-reflog-ent $m >after &&
+	test_cmp before after
 '
 
 test_expect_success 'stdin verify succeeds for missing reference' '
+	test-tool ref-store main for-each-reflog-ent $m >before &&
 	echo "verify refs/heads/missing $Z" >stdin &&
 	git update-ref --stdin <stdin &&
-	test_must_fail git rev-parse --verify -q refs/heads/missing
+	test_must_fail git rev-parse --verify -q refs/heads/missing &&
+	test-tool ref-store main for-each-reflog-ent $m >after &&
+	test_cmp before after
 '
 
 test_expect_success 'stdin verify treats no value as missing' '
@@ -1641,4 +1647,87 @@ test_expect_success PIPE 'transaction flushes status updates' '
 	test_cmp expected actual
 '
 
+create_stdin_buf () {
+	if test "$1" = "-z"
+	then
+		shift
+		printf "$F" "$@" >stdin
+	else
+		echo "$@" >stdin
+	fi
+}
+
+for type in "" "-z"
+do
+
+	test_expect_success "stdin ${type} symref-verify fails without --no-deref" '
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+		grep "fatal: symref-verify: cannot operate with deref mode" err
+	'
+
+	test_expect_success "stdin ${type} symref-verify fails with too many arguments" '
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" "$a" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err  &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: $a" err
+		else
+			grep "fatal: symref-verify refs/heads/symref: extra input:  $a" err
+		fi
+	'
+
+	test_expect_success "stdin ${type} symref-verify succeeds for correct value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$a" &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
+		test_cmp before after
+	'
+
+	test_expect_success "stdin ${type} symref-verify no value is treated as zero value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin
+	'
+
+	test_expect_success "stdin ${type} symref-verify succeeds for dangling reference" '
+		test_when_finished "git symbolic-ref -d refs/heads/symref2" &&
+		test_must_fail git symbolic-ref refs/heads/nonexistent &&
+		git symbolic-ref refs/heads/symref2 refs/heads/nonexistent &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref2" "refs/heads/nonexistent" &&
+		git update-ref --stdin ${type} --no-deref <stdin
+	'
+
+	test_expect_success "stdin ${type} symref-verify succeeds for missing reference" '
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
+		create_stdin_buf ${type} "symref-verify refs/heads/missing" "$Z" &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		test_must_fail git rev-parse --verify -q refs/heads/missing &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
+		test_cmp before after
+	'
+
+	test_expect_success "stdin ${type} symref-verify fails for wrong value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$b" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} symref-verify fails for mistaken null value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		create_stdin_buf ${type} "symref-verify refs/heads/symref" "$Z" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+done
+
 test_done
-- 
2.43.GIT

