Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B433B491
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122728; cv=none; b=mSK6ZxkKaDC/+ClgGuYmoCtA9ObYz6aC6uDCYUdc1hiOxuC1qaILldEYKru+HgAShtjtPIi2JkBvoiuucahK+6+Eovx4hZptyBHs+SOhEpT7i0XbwVR8Ap2slAiiwUzx66VuherLyiJITvb0BgD90rQMNzLw7Qk7xmwRF85Bj5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122728; c=relaxed/simple;
	bh=T5QgzSdIp1FkJCoiLzDXvmRd2gwQymChcvkE6nsino8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DuUyVhtReLP1EI6EbgCEQc5EVPP/1dyFh105tv34gl4ko5Sutq9I57Ik/aP2W1xA+vcNIewerDMsJRaf+8A3nJpM1ELxmU8zpFkv1vUBCn1GFaxJpSsyKkn1FwI/U4Jtj47LckY8uuPvQmsybjbgxZNxv4GNJ/VMPG7/iZTa9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2O2OyTW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2O2OyTW"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0473327e70so560683966b.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758122723; x=1758727523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpLj4qrsxw87vz5mpXxKZ4TfMLoFdzTQF2IYvRE9cBA=;
        b=S2O2OyTWFKQ3cHh4SswKN8dcZHgnCUbt5B09pXPtVR0Kz9brdQaESvpzAr5dK6QzTk
         r2D68mF58i7Rdq8OXjcIYBFHFHn9OgM07X2mAzr/mg2ydnozQFtjghln0JXzwJD6MNMz
         1R/VmgM5A7eS7dD1/GUw9ldNcBnrX61xOXwAbzMupXDgYvtCN5dOLXIdBSyRx0dgKU/H
         jstOOYtjE3nkrnnCaUTqCSWBjA68obTMWWaA40NgMZY0JLJl5wQCLSR9+GNzcQ0EdFc9
         gbABMC5lNv+yFxPIln6pRW4Y6trr+4FqIzEWwLpSAxp6/pWPHiTkxRI5KiWiS4v3OqW2
         HVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122723; x=1758727523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpLj4qrsxw87vz5mpXxKZ4TfMLoFdzTQF2IYvRE9cBA=;
        b=mTqQxKhTmJVLpupYikO2MwGXLPvjcRKImnFHcoJKsvAFf8H0Vv5rpYS93phACzDWSJ
         Gl4pp6TxN+allwT/sOZ/BxrV45eQOr1ANu0/Oos/GXPDhpdOkfNqaYuTAtfUU+hNkgRn
         u9049IS553VhPU3GcQdV8lV/9DNJ24UliY325yU8tXlwCRDvd6VrinlqyHoXfbsvjj9+
         Gue2e0iuE1mr6JfqmjIUgF/REDQshc1OKuxTa/i1nTV489rjqh0+5RJftGubjgf8ayhi
         8wEVJEuq2/ElazTLZJyeDmea5suel2smSz82lIVkub1VOjLYNN6Gj359C0rtloFFjSN8
         szKw==
X-Gm-Message-State: AOJu0YwW/HcqSLL9qiNCOVox6yySH3RsP4H5HROazD1o58wdeJoOXpCE
	MSMOEIb9x1QomFCDEB2r410fkEnq+hnWLLWXbcosTCpRsxMLPevRk9vL
X-Gm-Gg: ASbGncsEcL4EJ0wXg3ht8RE2RVnt726EtrnmngV8nORhJ0UQdJ2u2i8dDmrzBDZt5gO
	QT9Rgd1/H4t4wr/maOeStX8BOdNiWbGut/zDyUP5HX7+p3541BSTgmEIDokgOjr3BIxbhyIP36K
	ALUXBk/SNRcCzRbu6vF9rzOnwaSwbez1mr31gc+Wgm9Pxs9Ko5cZwuY5piCU/HYul28nPKU1w0O
	E+Ey8i7Dnd7RMXlMnFyxgj/xhn3+MGhPR+RcjwQoenHQYz/eBlnBg7MAvo3k4/Fj+v3CWJf+hev
	Tsulezm7LEa8jByFDmJmx0ZMDyfsKbQmslO3/faFBnrE2C3RDpJ4q07GRI+cRFvsJRUBw1Ezduu
	YZhfv6Q+vOUh21FONbScrCOmkwXJd
X-Google-Smtp-Source: AGHT+IFEhPvK8DXnjWGmbWtRxMPqxT9CFD/xfiXbBaN+enN76c3tipSStknji62OgpyAOA02PEriOg==
X-Received: by 2002:a17:907:2d25:b0:b04:274a:fc87 with SMTP id a640c23a62f3a-b1bb17cad60mr335231266b.4.1758122722851;
        Wed, 17 Sep 2025 08:25:22 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:bc15:cb75:326d:fed1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f21a2sm1410380566b.83.2025.09.17.08.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:25:22 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 17 Sep 2025 17:25:11 +0200
Subject: [PATCH v4 1/4] refs/files: catch conflicts on case-insensitive
 file-systems
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-1-da3c74a08ed0@gmail.com>
References: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
In-Reply-To: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com, toon@iotcl.com, 
 jltobler@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12747;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=T5QgzSdIp1FkJCoiLzDXvmRd2gwQymChcvkE6nsino8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjK0t8ugX8zCEQ5TV/De1zN3i415Su/QQDmw
 XI910t3twZJHokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoytLfAAoJED7VnySO
 Rox/m/8L/iUjNw2vu3FrxlGqqADMMuv5A5nRKFrA0GHb7a4FHN+MfhkPUO5TkXyDt8UozTgFWZx
 HW0+jc1brt5hl599AhLE8PuaAhacp0DbABPljnSvpEwo3k9Y6QNZ6U6I2dq8agcI/wFwZl59xb5
 fgysyGQ3BNqTmggPCEi1UE5a3LhMMb+0WT6HOMIrK2qEMvjj2IywJ8BQ7o/WLtWC9PHpyeCbi29
 txLssZEID6Tgg57h3azBvuZ73SpgCwrs+mOsD5NA/VQjrq7rq0sSOCbMOFHPWvjQcOF4UlPyLY3
 wt63p+gF5J7jiPKRvPeDISrcXzC8cT/BwHLs+qT2UeYJc1MhHns/5CbWIhLnDNgOWf6b92khUwN
 Ubbznm25oIRo0rEP2sh4J+Gm0pyX7ZNSad3sMR34234VQYXIUKUnlQFlC5G1xK+mn7/A80kVUsj
 KdY4KDje37PEn1DbRtckox+6r/odNpgTq5pWjInEQyCQtPWY4S2XxPEoRBJYMRdr8eL3wuGPZ/5
 4A=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

During the 'prepare' phase of a reference transaction in the files
backend, we create the lock files for references to be created. When
using batched updates on case-insensitive filesystems, the entire
batched updates would be aborted if there are conflicting names such as:

  refs/heads/Foo
  refs/heads/foo

This affects all commands which were migrated to use batched updates in
Git 2.51, including 'git-fetch(1)' and 'git-receive-pack(1)'. Before
that, reference updates would be applied serially with one transaction
used per update. When users fetched multiple references on
case-insensitive systems, subsequent references would simply overwrite
any earlier references. So when fetching:

  refs/heads/foo: 5f34ec0bfeac225b1c854340257a65b106f70ea6
  refs/heads/Foo: ec3053b0977e83d9b67fc32c4527a117953994f3
  refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56

The user would simply end up with:

  refs/heads/foo: ec3053b0977e83d9b67fc32c4527a117953994f3
  refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56

This is buggy behavior since the user is never informed about the
overrides performed and missing references. Nevertheless, the user is
left with a working repository with a subset of the references. Since
Git 2.51, in such situations fetches would simply fail without updating
any references. Which is also buggy behavior and worse off since the
user is left without any references.

The error is triggered in `lock_raw_ref()` where the files backend
attempts to create a lock file. When a lock file already exists the
function returns a 'REF_TRANSACTION_ERROR_GENERIC'. When this happens,
the entire batched updates, not individual operation, is aborted as if
it were in a transaction.

Change this to return 'REF_TRANSACTION_ERROR_CASE_CONFLICT' instead to
aid the batched update mechanism to simply reject such errors. The
change only affects batched updates since batched updates will reject
individual updates with non-generic errors. So specifically this would
only affect:

    1. git fetch
    2. git receive-pack
    3. git update-ref --batch-updates

This bubbles the error type up to `files_transaction_prepare()` which
tries to lock each reference update. So if the locking fails, we check
if the rejection type can be ignored, which is done by calling
`ref_transaction_maybe_set_rejected()`.

As the error type is now 'REF_TRANSACTION_ERROR_CASE_CONFLICT',
the specific reference update would simply be rejected, while other
updates in the transaction would continue to be applied. This allows
partial application of references in case-insensitive filesystems when
fetching colliding references.

While the earlier implementation allowed the last reference to be
applied overriding the initial references, this change would allow the
first reference to be applied while rejecting consequent collisions.
This should be an okay compromise since with the files backend, there is
no scenario possible where we would retain all colliding references.

Let's also be more proactive and notify users on case-insensitive
filesystems about such problems by providing a brief about the issue
while also recommending using the reftable backend, which doesn't have
the same issue.

Reported-by: Joe Drew <joe.drew@indexexchange.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c       | 21 +++++++++++++++++---
 refs.c                |  2 ++
 refs.h                |  2 ++
 refs/files-backend.c  | 33 +++++++++++++++++++++++++++-----
 t/t1400-update-ref.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t5510-fetch.sh      | 22 ++++++++++++++++++++-
 6 files changed, 124 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 24645c4653..c7ff3480fb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1643,7 +1643,8 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 
 struct ref_rejection_data {
 	int *retcode;
-	int conflict_msg_shown;
+	bool conflict_msg_shown;
+	bool case_sensitive_msg_shown;
 	const char *remote_name;
 };
 
@@ -1657,11 +1658,25 @@ static void ref_transaction_rejection_handler(const char *refname,
 {
 	struct ref_rejection_data *data = cb_data;
 
-	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
+	if (err == REF_TRANSACTION_ERROR_CASE_CONFLICT && ignore_case &&
+	    !data->case_sensitive_msg_shown) {
+		error(_("You're on a case-insensitive filesystem, and the remote you are\n"
+			"trying to fetch from has references that only differ in casing. It\n"
+			"is impossible to store such references with the 'files' backend. You\n"
+			"can either accept this as-is, in which case you won't be able to\n"
+			"store all remote references on disk. Or you can alternatively\n"
+			"migrate your repository to use the 'reftable' backend with the\n"
+			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
+			"Please keep in mind that not all implementations of Git support this\n"
+			"new format yet. So if you use tools other than Git to access this\n"
+			"repository it may not be an option to migrate to reftables.\n"));
+		data->case_sensitive_msg_shown = true;
+	} else if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT &&
+		   !data->conflict_msg_shown) {
 		error(_("some local refs could not be updated; try running\n"
 			" 'git remote prune %s' to remove any old, conflicting "
 			"branches"), data->remote_name);
-		data->conflict_msg_shown = 1;
+		data->conflict_msg_shown = true;
 	} else {
 		const char *reason = ref_transaction_error_msg(err);
 
diff --git a/refs.c b/refs.c
index bfdbe718b7..4c1c339ed9 100644
--- a/refs.c
+++ b/refs.c
@@ -3321,6 +3321,8 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
 		return "invalid new value provided";
 	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
 		return "expected symref but found regular ref";
+	case REF_TRANSACTION_ERROR_CASE_CONFLICT:
+		return "reference conflict due to case-insensitive filesystem";
 	default:
 		return "unknown failure";
 	}
diff --git a/refs.h b/refs.h
index eedbb599c5..41915086b3 100644
--- a/refs.h
+++ b/refs.h
@@ -31,6 +31,8 @@ enum ref_transaction_error {
 	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
 	/* Expected ref to be symref, but is a regular ref */
 	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
+	/* Cannot create ref due to case-insensitive filesystem */
+	REF_TRANSACTION_ERROR_CASE_CONFLICT = -8,
 };
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 088b52c740..01df32904b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -647,6 +647,26 @@ static void unlock_ref(struct ref_lock *lock)
 	}
 }
 
+/*
+ * Check if the transaction has another update with a case-insensitive refname
+ * match.
+ *
+ * If the update is part of the transaction, we only check up to that index.
+ * Further updates are expected to call this function to match previous indices.
+ */
+static bool transaction_has_case_conflicting_update(struct ref_transaction *transaction,
+						    struct ref_update *update)
+{
+	for (size_t i = 0; i < transaction->nr; i++) {
+		if (transaction->updates[i] == update)
+			break;
+
+		if (!strcasecmp(transaction->updates[i]->refname, update->refname))
+			return true;
+	}
+	return false;
+}
+
 /*
  * Lock refname, without following symrefs, and set *lock_p to point
  * at a newly-allocated lock object. Fill in lock->old_oid, referent,
@@ -677,16 +697,17 @@ static void unlock_ref(struct ref_lock *lock)
  * - Generate informative error messages in the case of failure
  */
 static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
-					       struct ref_update *update,
+					       struct ref_transaction *transaction,
 					       size_t update_idx,
 					       int mustexist,
 					       struct string_list *refnames_to_check,
-					       const struct string_list *extras,
 					       struct ref_lock **lock_p,
 					       struct strbuf *referent,
 					       struct strbuf *err)
 {
 	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
+	struct ref_update *update = transaction->updates[update_idx];
+	const struct string_list *extras = &transaction->refnames;
 	const char *refname = update->refname;
 	unsigned int *type = &update->type;
 	struct ref_lock *lock;
@@ -776,6 +797,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 			goto retry;
 		} else {
 			unable_to_lock_message(ref_file.buf, myerr, err);
+			if (myerr == EEXIST && ignore_case &&
+			    transaction_has_case_conflicting_update(transaction, update))
+				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
 			goto error_return;
 		}
 	}
@@ -2583,9 +2607,8 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 	if (lock) {
 		lock->count++;
 	} else {
-		ret = lock_raw_ref(refs, update, update_idx, mustexist,
-				   refnames_to_check, &transaction->refnames,
-				   &lock, &referent, err);
+		ret = lock_raw_ref(refs, transaction, update_idx, mustexist,
+				   refnames_to_check, &lock, &referent, err);
 		if (ret) {
 			char *reason;
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 96648a6e5d..08d5df2af7 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2294,6 +2294,59 @@ do
 		)
 	'
 
+	test_expect_success CASE_INSENSITIVE_FS,REFFILES "stdin $type batch-updates existing reference" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+
+			{
+				format_command $type "create refs/heads/foo" "$head" &&
+				format_command $type "create refs/heads/ref" "$old_head" &&
+				format_command $type "create refs/heads/Foo" "$old_head"
+			} >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+
+			echo $head >expect &&
+			git rev-parse refs/heads/foo >actual &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref >actual &&
+			test_cmp expect actual &&
+			test_grep -q "reference conflict due to case-insensitive filesystem" stdout
+		)
+	'
+
+	test_expect_success CASE_INSENSITIVE_FS "stdin $type batch-updates existing reference" '
+		git init --ref-format=reftable repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+
+			{
+				format_command $type "create refs/heads/foo" "$head" &&
+				format_command $type "create refs/heads/ref" "$old_head" &&
+				format_command $type "create refs/heads/Foo" "$old_head"
+			} >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+
+			echo $head >expect &&
+			git rev-parse refs/heads/foo >actual &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref >actual &&
+			test_cmp expect actual &&
+			git rev-parse refs/heads/Foo >actual &&
+			test_cmp expect actual
+		)
+	'
+
 	test_expect_success "stdin $type batch-updates delete incorrect symbolic ref" '
 		git init repo &&
 		test_when_finished "rm -fr repo" &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ebc696546b..57f60da81b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -47,7 +47,13 @@ test_expect_success "clone and setup child repos" '
 		git config set branch.main.merge refs/heads/one
 	) &&
 	git clone . bundle &&
-	git clone . seven
+	git clone . seven &&
+	git clone --ref-format=reftable . case_sensitive &&
+	(
+		cd case_sensitive &&
+		git branch branch1 &&
+		git branch bRanch1
+	)
 '
 
 test_expect_success "fetch test" '
@@ -1526,6 +1532,20 @@ test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
 	test_path_is_missing whoops
 '
 
+test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case insensitive filesystem' '
+	test_when_finished rm -rf case_insensitive &&
+	(
+		git init --bare case_insensitive &&
+		cd case_insensitive &&
+		git remote add origin -- ../case_sensitive &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "You${SQ}re on a case-insensitive filesystem" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/branch1 >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.51.0

