Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1A143C46
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907709; cv=none; b=XSBRT6qoRoFQWW62ShbX3JerQek7sz5V+GPRP4JcwiI83KAcnC60oqQPLNr3lXT2vSFWX3gWUSXbw5Bvi52sNupp5T7q0lQmSuegd2J/bvNsv6ZtWwGnbsGVB9ZIr3C3gI46YVpOlT8wV53eld0JSQ9dPVoRI6945ecWrOn+UAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907709; c=relaxed/simple;
	bh=d2DZQDk/BxUezkWoW1xrAGylBIcfCR6IYul729P1ppQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6w7R7JLsDvKKlmzJ2DRJdr6yKFJvHz6BmlToR60QXzpuoe00Q7EzIf8dfVvetfdo6Nc0yHwVW0XAl5RtthAMJa4hL+SSWuy875Qk/+nnO8DRO6wFAtJzqhYERThh9r+ikjzzK5NfoWLFKUobO4dKb8cQ06uy2nK6P2IpSiWTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJkpyQBo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJkpyQBo"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5224dfa9adso55361866b.0
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 14:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713907706; x=1714512506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6neRkLWigvqBj+kM2jEZVGy5BYOXBwuihzOpQ18o80=;
        b=AJkpyQBoLNJ9jT/q6hKrsxrPoLyOB4A+tFh3o++VV3McxHe52rv/ImJVwj6bB3QXtx
         WvJNuU3ItH9GY2+AL94nYGrLX+CDzCfHihweCMzQmMgQrPX4K3lF58BlgnIU3Cv8bcU6
         UG2ldoYwcj4FsBYISb69gkLotZ4Y86D31iHRGuEDsyKuwT7FWLfHq+lBqId6G6KuCSt5
         7o5Ez3pQS5AQQe/LiMWipSsbxKnpGOAXB0xuGeai1UdQT42Es6hdmqqzKO6X51wTBPbC
         QhT2fbqTaZEgvHMDNQxLm5bPuzXRgZ14dOYtYKQGwq8zaGZVkrQ5awX6Oz2NMJXjeIWW
         Z3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713907706; x=1714512506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6neRkLWigvqBj+kM2jEZVGy5BYOXBwuihzOpQ18o80=;
        b=uS6wxWSRk8R943lmZWAkxIvMk2NAQygFb8uhN4cu9wJqEV5Ax1KajzFU7K78QX0a7h
         XE5uGNOgqld19HtJ2Dy3RWJa+dMd9V2jH0ftllQD0IpKKEFNUQJhUDf5nC/hJc02thmN
         3YqeOjI+SZE6sEcbgYNtHvt2Ez4N+2dSQxdERitFR4FovuyOkDogT62ppkuLSXhN60Xe
         k1tPpUhzwM0DLoqHJTJEw0OLMxPM6YfoQVFVVnEfud4b7ll8fzVf7GXUBcWGr/Id6j0F
         JDNwng3l29omsyGJLh1TtlRF0HQq4fwnwwgwE4PJnQ7n5lFv79ToNjvkNgYX5h8egQ6b
         lSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEwHLxXax2Y3+AKgSI/7FToSoq1T1nqpEMFYjyautNsqn7MXEglRA59j17ZOD7jPq3eXXJ2Jkk3zKp3irICPKf2eW9
X-Gm-Message-State: AOJu0YwBY98E7bbU5A3Vf7GYS2UzGgZlNP+U2ex0H9tziW2ASVX5oGp8
	PTTAxfarcTcWQZbstl7L3mTUMsJId0dZy3O/spo+/zrVsgnPrn2t
X-Google-Smtp-Source: AGHT+IFIPmHaTgLkKqJfpuHlzVbzI8U5zIE0jkHmYEAgVsKBP27RHHNgao44SXw3Yw9hToxvySJ1Eg==
X-Received: by 2002:a17:907:778c:b0:a55:5958:cb00 with SMTP id ky12-20020a170907778c00b00a555958cb00mr3589707ejc.38.1713907705732;
        Tue, 23 Apr 2024 14:28:25 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:23ba:342:e06:b489])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090660d100b00a587236e646sm1864275ejk.174.2024.04.23.14.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 14:28:25 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 4/8] update-ref: support symrefs in the verify command
Date: Tue, 23 Apr 2024 23:28:14 +0200
Message-ID: <20240423212818.574123-5-knayak@gitlab.com>
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

In the previous commits, we added the required base for adding symref
support to the transaction commands provided by 'git-update-ref(1)'.
Using them, extend the 'verify' command to support symrefs.

The 'verify' command allows users to verify if a provided symbolic
reference `<ref>` contains the provided `<old-oid>` without changing the
`<ref>`. Now we alternatively allow users to provide a
`ref:<old-target>` instead to verify if a symref targets the provided
target. Since we're checking for symbolic refs, this will only work with
the 'no-deref' mode. This is because any dereferenced symbolic ref will
point to an object and not a ref.

Add and use `null_new_value`, a helper function which is used to check
if there is a new_value in a reference update. The new value could
either be a symref target `new_target` or a OID `new_oid`. We also add
tests to test the command in both the regular stdin mode and also with
the '-z' flag.

We also disable the reference-transaction hook for symref-updates which
will be tackled in its own commit.

Add required tests for symref support in 'verify' while also adding
reflog checks for the pre-existing 'verify' tests.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt | 13 ++++--
 builtin/update-ref.c             | 14 ++++--
 refs.c                           | 30 ++++++++++--
 refs.h                           |  1 +
 refs/files-backend.c             | 43 +++++++++++++++++
 refs/refs-internal.h             |  7 +++
 refs/reftable-backend.c          | 21 ++++++++-
 t/t1400-update-ref.sh            | 79 +++++++++++++++++++++++++++++++-
 8 files changed, 194 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 374a2ebd2b..9f8c059944 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -64,7 +64,7 @@ performs all modifications together.  Specify commands of the form:
 	update SP <ref> SP <new-oid> [SP <old-oid>] LF
 	create SP <ref> SP <new-oid> LF
 	delete SP <ref> [SP <old-oid>] LF
-	verify SP <ref> [SP <old-oid>] LF
+	verify SP <ref> [SP (<old-oid> | ref:<old-target>)] LF
 	option SP <opt> LF
 	start LF
 	prepare LF
@@ -85,7 +85,7 @@ quoting:
 	update SP <ref> NUL <new-oid> NUL [<old-oid>] NUL
 	create SP <ref> NUL <new-oid> NUL
 	delete SP <ref> NUL [<old-oid>] NUL
-	verify SP <ref> NUL [<old-oid>] NUL
+	verify SP <ref> NUL [(<old-oid> | ref:<old-target>)] NUL
 	option SP <opt> NUL
 	start NUL
 	prepare NUL
@@ -95,6 +95,12 @@ quoting:
 In this format, use 40 "0" to specify a zero value, and use the empty
 string to specify a missing value.
 
+For commands which support it, substituting the <old-oid> value with
+ref:<old-target> will ensure that the <ref> targets the specified
+old-target before the update.  Similarly, substituting the <new-oid>
+with ref:<new-target> will ensure that the <ref> is a symbolic ref
+targeting the new-target after the update.
+
 In either format, values can be specified in any form that Git
 recognizes as an object name.  Commands in any other format or a
 repeated <ref> produce an error.  Command meanings are:
@@ -115,7 +121,8 @@ delete::
 
 verify::
 	Verify <ref> against <old-oid> but do not change it.  If
-	<old-oid> is zero or missing, the ref must not exist.
+	<old-oid> is zero or missing, the ref must not exist. For
+	verifying symbolic refs, provide ref:<old-target>.
 
 option::
 	Modify the behavior of the next command naming a <ref>.
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 98ec356394..246167e835 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -308,6 +308,7 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
 	struct strbuf err = STRBUF_INIT;
+	struct strbuf old_target = STRBUF_INIT;
 	char *refname;
 	struct object_id old_oid;
 
@@ -315,20 +316,27 @@ static void parse_cmd_verify(struct ref_transaction *transaction,
 	if (!refname)
 		die("verify: missing <ref>");
 
-	if (parse_next_arg(&next, end, &old_oid, NULL,
-			   "verify", refname, PARSE_SHA1_OLD))
+	if (parse_next_arg(&next, end, &old_oid, &old_target,
+			   "verify", refname,
+			   PARSE_SHA1_OLD | PARSE_REFNAME_TARGETS))
 		oidclr(&old_oid);
 
+	if (old_target.len && !(update_flags & REF_NO_DEREF))
+		die("verify %s: cannot operate on symrefs in deref mode", refname);
+
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	if (ref_transaction_verify(transaction, refname, &old_oid,
+	if (ref_transaction_verify(transaction, refname,
+				   old_target.len ? NULL : &old_oid,
+				   old_target.len ? old_target.buf : NULL,
 				   update_flags, &err))
 		die("%s", err.buf);
 
 	update_flags = default_flags;
 	free(refname);
 	strbuf_release(&err);
+	strbuf_release(&old_target);
 }
 
 static void report_ok(const char *command)
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
index ec3443cc87..1f2b63755a 100755
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
@@ -1641,4 +1647,73 @@ test_expect_success PIPE 'transaction flushes status updates' '
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
+	test_expect_success "stdin ${type} verify symref fails without --no-deref" '
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "verify refs/heads/symref" "ref:$a" &&
+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+		grep "fatal: verify refs/heads/symref: cannot operate on symrefs in deref mode" err
+	'
+
+	test_expect_success "stdin ${type} verify symref fails with too many arguments" '
+		create_stdin_buf ${type} "verify refs/heads/symref" "ref:$a" "ref:$a" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err  &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: ref:$a" err
+		else
+			grep "fatal: verify refs/heads/symref: extra input:  ref:$a" err
+		fi
+	'
+
+	test_expect_success "stdin ${type} verify symref succeeds for correct value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
+		create_stdin_buf ${type} "verify refs/heads/symref" "ref:$a" &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
+		test_cmp before after
+	'
+
+	test_expect_success "stdin ${type} verify symref succeeds for missing reference" '
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >before &&
+		create_stdin_buf ${type} "verify refs/heads/missing" "$Z" &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		test_must_fail git rev-parse --verify -q refs/heads/missing &&
+		test-tool ref-store main for-each-reflog-ent refs/heads/symref >after &&
+		test_cmp before after
+	'
+
+	test_expect_success "stdin ${type} verify symref fails for wrong value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		create_stdin_buf ${type} "verify refs/heads/symref" "$b" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin &&
+		git symbolic-ref refs/heads/symref >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "stdin ${type} verify symref fails for mistaken null value" '
+		git symbolic-ref refs/heads/symref >expect &&
+		create_stdin_buf ${type} "verify refs/heads/symref" "$Z" &&
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

