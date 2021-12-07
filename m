Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5854FC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 13:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbhLGNmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhLGNl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 08:41:57 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18292C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 05:38:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o13so29470538wrs.12
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 05:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gEp4bKfQL+NnYSScrqq4hmnwCYjF/KAyBwcYmIy9Rs0=;
        b=Bsj1BfHaoELvbh7ArPHIpBkrC1oUNN9rM23/5T2tPo0kOCwgs8XLQF/PNrObT7KhlU
         E/jGNiV5933bCnzEPHRzEkfPEwPNUeymBjbTOi0XSgJlllTCkZ9tOByF4dtSX7rAipkl
         OlGjtQ5la8x0Pix4CeznSGGIV2FDR0YjeOZe++4iL8kZVDIzvb9lDT7rwSNtCCmBB+C5
         0OVsmboAwi31fNQdr8fI6oOcxeZkYSSrJk7rJ6B4RW8Xtdnu2ehu2D+m+2F/SuCExNEV
         rMh3joOUk11NjSdzBtzCFgc+A9ipcykbN2+/JWPsjrr8fOG+9KF12OZk4gL5yOdCIPpT
         FTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gEp4bKfQL+NnYSScrqq4hmnwCYjF/KAyBwcYmIy9Rs0=;
        b=FUkSti9WFvGL41UbnIQVwi4FF6PqT7iCqeD3KtBt0InYsfI6LuXrRZZPQPtxo0ok9e
         Fx+w7jyCDvwR/xHwLt6ApmzNK+HW2SOLlguu/K2HUKW8GAX6d9z6zqzIIYRwBhU7w9BB
         gHNLnOeZbSsIQtFEea1OttgGY3bzG61XMJNq8bEgWK+HITV8D269tR6n9TSXegqz5xz6
         pDRy7OLTD/U4gBJQIzOmRmI8ThYC5OAyZwSmsxGp3h3NpLuLDGjUxNhML1NpZW+snnRV
         Wut6KEy7svwqW0aZ0DQuMI11S8e2PK2vyN1dNmopkXaep+QyToN2Ne3jB4gj3ewDJfj0
         StCw==
X-Gm-Message-State: AOAM532sEwSXycF+lDPXK4V7v4jX1bwB9sEjN8tqErRDQJ0CTb0eXFYQ
        k6VdNO+6SZIvaSexZVHxjN8cMiSaGhE=
X-Google-Smtp-Source: ABdhPJz/MQE6DEXxHychRk+WhqgqXSKe6g0s2CqXPocI3X/SXPJ342vtcsEo/G8F6PHvmH4gSs1hOQ==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr49047677wrn.349.1638884305474;
        Tue, 07 Dec 2021 05:38:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm2823480wmb.24.2021.12.07.05.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:38:25 -0800 (PST)
Message-Id: <a8713dd59ee10aaceaeb271b3de4302121e699a9.1638884300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
        <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 13:38:17 +0000
Subject: [PATCH v4 5/8] refs: introduce REF_SKIP_OID_VERIFICATION flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This lets the ref-store test helper write non-existent or unparsable objects
into the ref storage.

Use this to make t1006 and t3800 independent of the files storage backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.h                    |  8 ++++++-
 refs/files-backend.c      | 50 +++++++++++++++++++++++----------------
 t/helper/test-ref-store.c |  1 +
 t/t1006-cat-file.sh       |  5 ++--
 t/t3800-mktag.sh          |  6 +++--
 5 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/refs.h b/refs.h
index 45c34e99e3a..76efc589cca 100644
--- a/refs.h
+++ b/refs.h
@@ -615,12 +615,18 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 #define REF_FORCE_CREATE_REFLOG (1 << 1)
 
+/*
+ * Blindly write an object_id. This is useful for testing data corruption
+ * scenarios.
+ */
+#define REF_SKIP_OID_VERIFICATION (1 << 10)
+
 /*
  * Bitmask of all of the flags that are allowed to be passed in to
  * ref_transaction_update() and friends:
  */
 #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS \
-	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG)
+	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION)
 
 /*
  * Add a reference update to transaction. `new_oid` is the value that
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 37329b98cca..d0019fcd8b7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1353,7 +1353,8 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 }
 
 static int write_ref_to_lockfile(struct ref_lock *lock,
-				 const struct object_id *oid, struct strbuf *err);
+				 const struct object_id *oid,
+				 int skip_oid_verification, struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
 			     const struct object_id *oid, const char *logmsg,
@@ -1500,7 +1501,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
@@ -1520,7 +1521,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	flag = log_all_ref_updates;
 	log_all_ref_updates = LOG_REFS_NONE;
-	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1756,26 +1757,31 @@ static int files_log_ref_write(struct files_ref_store *refs,
  * errors, rollback the lockfile, fill in *err and return -1.
  */
 static int write_ref_to_lockfile(struct ref_lock *lock,
-				 const struct object_id *oid, struct strbuf *err)
+				 const struct object_id *oid,
+				 int skip_oid_verification, struct strbuf *err)
 {
 	static char term = '\n';
 	struct object *o;
 	int fd;
 
-	o = parse_object(the_repository, oid);
-	if (!o) {
-		strbuf_addf(err,
-			    "trying to write ref '%s' with nonexistent object %s",
-			    lock->ref_name, oid_to_hex(oid));
-		unlock_ref(lock);
-		return -1;
-	}
-	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
-		strbuf_addf(err,
-			    "trying to write non-commit object %s to branch '%s'",
-			    oid_to_hex(oid), lock->ref_name);
-		unlock_ref(lock);
-		return -1;
+	if (!skip_oid_verification) {
+		o = parse_object(the_repository, oid);
+		if (!o) {
+			strbuf_addf(
+				err,
+				"trying to write ref '%s' with nonexistent object %s",
+				lock->ref_name, oid_to_hex(oid));
+			unlock_ref(lock);
+			return -1;
+		}
+		if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
+			strbuf_addf(
+				err,
+				"trying to write non-commit object %s to branch '%s'",
+				oid_to_hex(oid), lock->ref_name);
+			unlock_ref(lock);
+			return -1;
+		}
 	}
 	fd = get_lock_file_fd(&lock->lk);
 	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
@@ -2189,7 +2195,7 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
+				      struct object_id *peeled)
 {
 	BUG("ref_iterator_peel() called for reflog_iterator");
 }
@@ -2575,8 +2581,10 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * The reference already has the desired
 			 * value, so we don't need to write it.
 			 */
-		} else if (write_ref_to_lockfile(lock, &update->new_oid,
-						 err)) {
+		} else if (write_ref_to_lockfile(
+				   lock, &update->new_oid,
+				   update->flags & REF_SKIP_OID_VERIFICATION,
+				   err)) {
 			char *write_err = strbuf_detach(err, NULL);
 
 			/*
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 8fee3cfce1a..0f3aa84c9f0 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -130,6 +130,7 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 static struct flag_definition transaction_flags[] = {
 	FLAG_DEF(REF_NO_DEREF),
 	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
+	FLAG_DEF(REF_SKIP_OID_VERIFICATION),
 	{ NULL, 0 }
 };
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 658628375c8..0d4c55f74ec 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -452,9 +452,8 @@ test_expect_success 'the --allow-unknown-type option does not consider replaceme
 	# Create it manually, as "git replace" will die on bogus
 	# types.
 	head=$(git rev-parse --verify HEAD) &&
-	test_when_finished "rm -rf .git/refs/replace" &&
-	mkdir -p .git/refs/replace &&
-	echo $head >.git/refs/replace/$bogus_short_sha1 &&
+	test_when_finished "test-tool ref-store main delete-refs 0 msg refs/replace/$bogus_short_sha1" &&
+	test-tool ref-store main update-ref msg "refs/replace/$bogus_short_sha1" $head $ZERO_OID REF_SKIP_OID_VERIFICATION &&
 
 	cat >expect <<-EOF &&
 	commit
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 0544d58a6ea..e3cf0ffbe59 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -72,7 +72,8 @@ check_verify_failure () {
 
 		# Manually create the broken, we cannot do it with
 		# update-ref
-		echo "$bad_tag" >"bad-tag/$tag_ref" &&
+		test-tool -C bad-tag ref-store main delete-refs 0 msg "$tag_ref" &&
+		test-tool -C bad-tag ref-store main update-ref msg "$tag_ref" $bad_tag $ZERO_OID REF_SKIP_OID_VERIFICATION &&
 
 		# Unlike fsck-ing unreachable content above, this
 		# will always fail.
@@ -83,7 +84,8 @@ check_verify_failure () {
 		# Make sure the earlier test created it for us
 		git rev-parse "$bad_tag" &&
 
-		echo "$bad_tag" >"bad-tag/$tag_ref" &&
+		test-tool -C bad-tag ref-store main delete-refs 0 msg "$tag_ref" &&
+		test-tool -C bad-tag ref-store main update-ref msg "$tag_ref" $bad_tag $ZERO_OID REF_SKIP_OID_VERIFICATION &&
 
 		printf "%s tag\t%s\n" "$bad_tag" "$tag_ref" >expected &&
 		git -C bad-tag for-each-ref "$tag_ref" >actual &&
-- 
gitgitgadget

