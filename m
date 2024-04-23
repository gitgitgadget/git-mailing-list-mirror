Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043D143C6C
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907710; cv=none; b=YIYZzgH2NfNh4MeJS+q5VHX1HDt72Y2Z9t36gJtc63Fcxd6cGkVeA/p5CipO+3AirHnHaxVeEXmYm0KPFtifty6vWzeyKigg6StYuNGMd9FtaEgfa5kh/UMkt2U0fRMoOSylktBcjoBXgoP6CVNokZvMKjMIDfypeS/BoJb6JWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907710; c=relaxed/simple;
	bh=7fgNZLIdgqcPVq2dFfmQnatCOPsQQS40BlWbJcqdQ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4ffuCuno0Kc0yqUD6bsIEqWFG9ZDJ6C1hBOlZ5Lvio+E1lUHVNiEZb7425us5c4fOiALSgqJQnnCTGme0UDpCVv/8mwGgYCFGY7Us5BC0Dg/sy2fqKHTrRD+E77znj9uQtKufR9r4y03krMpCVnwEElUQn0YL/dCbJPOBNd2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q40lmkos; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q40lmkos"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5196fe87775so6949034e87.3
        for <git@vger.kernel.org>; Tue, 23 Apr 2024 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713907707; x=1714512507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFTZnhsnqX9pdSNR7VPaXflincA9/kJsG+wpqJGeIBM=;
        b=Q40lmkos2X/BP+4MIq/ZGHCG/m7ZOLWQaDokZZRgigbcG4tv8fU6qCeLHYwn15SbIG
         nMetCINcvbS8vfmKLDJNpvO4i8fa2b+lo4eqsFfaS+MhRypDeYikgvrUM1BQTzRZtbSo
         5nb8mCTzoHmwYlaldTCtBMg3qMiE4oR5gnohs4Ns5bja0RO51g+GqRJzVVcJLRfdGArH
         FEKnVMxntPxz5yohF95rXVZ6RmJpb0xB+ReCWenEHEcmVXshpRyCwlrYXu+psXpLwTtM
         rFutlnIEAPXh5fpM1DfB4bwBN0acbEt/ePbk8t63gufEbh708m41t4+qbxoGrpxAYghA
         4AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713907707; x=1714512507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFTZnhsnqX9pdSNR7VPaXflincA9/kJsG+wpqJGeIBM=;
        b=G/z81R7V2n62f0BgltvL2q55xiB+1DFKtjkgT6eOho6EZ9/WRJPvHXYQV5PLzEVZQY
         rFx0l0yynDqLQbA3tEi4Yu/EGr26E87l0keAD4ffKM5KQ/nDmKBocgASZKdF1vUWwjQ/
         G4hRz9CdlZDzEhZq/srH5KsUc9tn15VNG39HZLzC/Y9ImyFTzSrSNAPQmee2kU+5YOdl
         mZCxxL8hxL7AZ4wHYTq3geOFV+krSdJycabohOSdOIaklVJMTI5leB/douIAgYuqnVXw
         O0BNkgYFmSXYqshhAQ9kDo5exRbpVgmRzlyt/BiQmVw5abLBGG9+hKNwlSFN1rXFIYyx
         bLIg==
X-Forwarded-Encrypted: i=1; AJvYcCWfFSssglQVB0qcS/Z/A7fbjSfkQEIKsknEQoy6cxuvK8sqyPsBa49NCAWJZWL7qe2IJbTAeEF5Gf8+DRMd7Y9g7noG
X-Gm-Message-State: AOJu0YyP5IoRVZ/rJ0tKX53rVVHRMSMcK59EzxobIfxG5dzEJg2EdE0G
	4dVv2fF4uKDK7vOd/xxuJdKi9rV2ZD4LZfVWeJ6QaA0eXYZKrE3l
X-Google-Smtp-Source: AGHT+IEFIxra6paoucAfFg8l9J7gA7FvfkOX+yL8WHmnq2DFKCsuvrOjU0m0nZryOnzm24+egMIgwg==
X-Received: by 2002:ac2:44a8:0:b0:51b:a710:d6c7 with SMTP id c8-20020ac244a8000000b0051ba710d6c7mr537528lfm.14.1713907706913;
        Tue, 23 Apr 2024 14:28:26 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:23ba:342:e06:b489])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090660d100b00a587236e646sm1864275ejk.174.2024.04.23.14.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 14:28:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v3 5/8] update-ref: support symrefs in the delete command
Date: Tue, 23 Apr 2024 23:28:15 +0200
Message-ID: <20240423212818.574123-6-knayak@gitlab.com>
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

The 'delete' command in 'git-update-ref' allows users to delete `<ref>`
after verifying it exists with `<old-oid>`, if given. Extend this command
to alternatively take in `ref:<old-target>` which is used to verify if
the symbolic ref targets the provided `<old-target>` before deletion.
This will only work when used with the 'no-deref' mode as it doesn't
make sense to deref a symref during deletion.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-update-ref.txt | 10 +++++---
 builtin/fetch.c                  |  2 +-
 builtin/receive-pack.c           |  3 ++-
 builtin/update-ref.c             | 18 +++++++++----
 refs.c                           | 12 ++++++---
 refs.h                           |  4 ++-
 refs/files-backend.c             |  2 +-
 refs/reftable-backend.c          |  2 +-
 t/t1400-update-ref.sh            | 44 ++++++++++++++++++++++++++++++++
 9 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 9f8c059944..f28b026cd7 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -63,7 +63,7 @@ performs all modifications together.  Specify commands of the form:
 
 	update SP <ref> SP <new-oid> [SP <old-oid>] LF
 	create SP <ref> SP <new-oid> LF
-	delete SP <ref> [SP <old-oid>] LF
+	delete SP <ref> [SP (<old-oid> | ref:<old-target>)] LF
 	verify SP <ref> [SP (<old-oid> | ref:<old-target>)] LF
 	option SP <opt> LF
 	start LF
@@ -84,7 +84,7 @@ quoting:
 
 	update SP <ref> NUL <new-oid> NUL [<old-oid>] NUL
 	create SP <ref> NUL <new-oid> NUL
-	delete SP <ref> NUL [<old-oid>] NUL
+	delete SP <ref> NUL [(<old-oid> | ref:<old-target>)] NUL
 	verify SP <ref> NUL [(<old-oid> | ref:<old-target>)] NUL
 	option SP <opt> NUL
 	start NUL
@@ -116,8 +116,10 @@ create::
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
index 246167e835..cee7a5ebc0 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -274,6 +274,7 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
 	struct strbuf err = STRBUF_INIT;
+	struct strbuf old_target = STRBUF_INIT;
 	char *refname;
 	struct object_id old_oid;
 	int have_old;
@@ -282,26 +283,33 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
 	if (!refname)
 		die("delete: missing <ref>");
 
-	if (parse_next_arg(&next, end, &old_oid, NULL,
-			   "delete", refname, PARSE_SHA1_OLD)) {
+	if (parse_next_arg(&next, end, &old_oid, &old_target,
+			   "delete", refname, PARSE_SHA1_OLD |
+			   PARSE_REFNAME_TARGETS)) {
 		have_old = 0;
 	} else {
-		if (is_null_oid(&old_oid))
+		if (!old_target.len && is_null_oid(&old_oid))
 			die("delete %s: zero <old-oid>", refname);
-		have_old = 1;
+		have_old = 1 && !old_target.len;
 	}
 
+	if (old_target.len && !(update_flags & REF_NO_DEREF))
+		die("delete %s: cannot operate on symrefs in deref mode", refname);
+
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
 	if (ref_transaction_delete(transaction, refname,
 				   have_old ? &old_oid : NULL,
-				   update_flags, msg, &err))
+				   update_flags,
+				   old_target.len ? old_target.buf : NULL,
+				   msg, &err))
 		die("%s", err.buf);
 
 	update_flags = default_flags;
 	free(refname);
 	strbuf_release(&err);
+	strbuf_release(&old_target);
 }
 
 static void parse_cmd_verify(struct ref_transaction *transaction,
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
index 1f2b63755a..cd1ad0d2ec 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1714,6 +1714,50 @@ do
 		test_cmp expect actual
 	'
 
+	test_expect_success "stdin ${type} delete symref fails without --no-deref" '
+		git symbolic-ref refs/heads/symref $a &&
+		create_stdin_buf ${type} "delete refs/heads/symref" "ref:$a" &&
+		test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
+		grep "fatal: delete refs/heads/symref: cannot operate on symrefs in deref mode" err
+	'
+
+	test_expect_success "stdin ${type} delete symref fails with no ref" '
+		create_stdin_buf ${type} "delete " &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		grep "fatal: delete: missing <ref>" err
+	'
+
+	test_expect_success "stdin ${type} delete symref fails with too many arguments" '
+		create_stdin_buf ${type} "delete refs/heads/symref" "ref:$a" "ref:$a" &&
+		test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
+		if test "$type" = "-z"
+		then
+			grep "fatal: unknown command: ref:$a" err
+		else
+			grep "fatal: delete refs/heads/symref: extra input:  ref:$a" err
+		fi
+	'
+
+	test_expect_success "stdin ${type} delete symref fails with wrong old value" '
+		create_stdin_buf ${type} "delete refs/heads/symref" "ref:$m" &&
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
+	test_expect_success "stdin ${type} delete symref works with right old value" '
+		create_stdin_buf ${type} "delete refs/heads/symref" "ref:$a" &&
+		git update-ref --stdin ${type} --no-deref <stdin &&
+		test_must_fail git rev-parse --verify -q $b
+	'
+
 done
 
 test_done
-- 
2.43.GIT

