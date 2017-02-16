Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F121220136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754936AbdBPLtQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:49:16 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35653 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754930AbdBPLtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:49:14 -0500
Received: by mail-pf0-f193.google.com with SMTP id 68so1484369pfx.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHCFtGZSG5sVsu7aVxR3hqPAJR+IuJ8zb4Wj1/MUwvg=;
        b=cdpznIHlju9hbLYWhiKN88fXQT9PmRs6umnGfrvXG91YR9JGEXyfxZv/8DqjuS7RQd
         wOzAq+GTdx6hn6qrKo7NtiaUzY5QoLfOc8QFzGOVc8FLmlNfMDDaBzz8kLyuPdSIdQur
         lpZbhxrTLr76Htjc564L4VWkjfRJ+k9aLVbfz7+29ln9gV9ZbOf9RihV6HvWemqGM/wA
         4W4nLXtibPGWAX4PxPOoLHHgUYYSreiaqFc/6QokqZF0YsRVZTD58zx9UdUXeM/Wfkt8
         lQNj6EWw8gpPAj4BNDn0qwtspOMAnwNbWsK0GPj84XRSoVVE5fTHgC+pdkxEjeBz8XNq
         4PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iHCFtGZSG5sVsu7aVxR3hqPAJR+IuJ8zb4Wj1/MUwvg=;
        b=IBFkyEA7wHUSEf/sxFh5kPIO60Ooz1n7sv0tUmIXsjumfQR/nWTrYlfODhmp2czcQg
         jS0/dUljeXmBGrCUBgP7It5jqHt6KA5LBa2OZmy+2Y7H/LTpzHWq5CwxNXkWnbaVUHav
         /QNenYmkyK2T3sbYCRhNDJSrKCuwvPVUI8Lz3YEI1fAU6rqXEcvIw4KyHkQ0On8LGiHD
         0dJ68HPkIW1MAX0xefhp+dGVnsRbjpDaeaibUSg7T1qODqC5VnDmHehJHBPwrozvPa4j
         DjgJ6OYjo4AuK7vKp+lu1vTqJAHp3E4DtdBmZcv0jxk++v1fF9f82pBK0W9yNwn+pA4d
         UrUQ==
X-Gm-Message-State: AMke39n+LyzhcVQUyWP+YK1DeMMEDncvfDU9t97cfugGTXCHVEQngc5tzCKaABPld29MHA==
X-Received: by 10.99.94.71 with SMTP id s68mr2219311pgb.181.1487245743531;
        Thu, 16 Feb 2017 03:49:03 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id s84sm13238366pfg.128.2017.02.16.03.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:49:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:48:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 02/16] files-backend: convert git_path() to strbuf_git_path()
Date:   Thu, 16 Feb 2017 18:48:04 +0700
Message-Id: <20170216114818.6080-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git_path() and friends are going to be killed in files-backend.c in near
future. And because there's a risk with overwriting buffer in
git_path(), let's convert them all to strbuf_git_path(). We'll have
easier time killing/converting strbuf_git_path() then because we won't
have to worry about memory management again.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 111 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 22 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 75565c3aa..f0c878b92 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2169,6 +2169,8 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	static int timeout_configured = 0;
 	static int timeout_value = 1000;
 	struct packed_ref_cache *packed_ref_cache;
+	struct strbuf sb = STRBUF_INIT;
+	int ret;
 
 	files_assert_main_repository(refs, "lock_packed_refs");
 
@@ -2177,10 +2179,13 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 		timeout_configured = 1;
 	}
 
-	if (hold_lock_file_for_update_timeout(
-			    &packlock, git_path("packed-refs"),
-			    flags, timeout_value) < 0)
+	strbuf_git_path(&sb, "packed-refs");
+	ret = hold_lock_file_for_update_timeout(&packlock, sb.buf,
+						flags, timeout_value);
+	strbuf_release(&sb);
+	if (ret < 0)
 		return -1;
+
 	/*
 	 * Get the current packed-refs while holding the lock.  If the
 	 * packed-refs file has been modified since we last read it,
@@ -2335,6 +2340,9 @@ static void try_remove_empty_parents(char *name)
 	for (q = p; *q; q++)
 		;
 	while (1) {
+		struct strbuf sb = STRBUF_INIT;
+		int ret;
+
 		while (q > p && *q != '/')
 			q--;
 		while (q > p && *(q-1) == '/')
@@ -2342,7 +2350,10 @@ static void try_remove_empty_parents(char *name)
 		if (q == p)
 			break;
 		*q = '\0';
-		if (rmdir(git_path("%s", name)))
+		strbuf_git_path(&sb, "%s", name);
+		ret = rmdir(sb.buf);
+		strbuf_release(&sb);
+		if (ret)
 			break;
 	}
 }
@@ -2431,7 +2442,11 @@ static int repack_without_refs(struct files_ref_store *refs,
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(refs, 0)) {
-		unable_to_lock_message(git_path("packed-refs"), errno, err);
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_git_path(&sb, "packed-refs");
+		unable_to_lock_message(sb.buf, errno, err);
+		strbuf_release(&sb);
 		return -1;
 	}
 	packed = get_packed_refs(refs);
@@ -2529,8 +2544,10 @@ static int rename_tmp_log(const char *newrefname)
 {
 	int attempts_remaining = 4;
 	struct strbuf path = STRBUF_INIT;
+	struct strbuf tmp_renamed_log = STRBUF_INIT;
 	int ret = -1;
 
+	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
  retry:
 	strbuf_reset(&path);
 	strbuf_git_path(&path, "logs/%s", newrefname);
@@ -2546,7 +2563,7 @@ static int rename_tmp_log(const char *newrefname)
 		goto out;
 	}
 
-	if (rename(git_path(TMP_RENAMED_LOG), path.buf)) {
+	if (rename(tmp_renamed_log.buf, path.buf)) {
 		if ((errno==EISDIR || errno==ENOTDIR) && --attempts_remaining > 0) {
 			/*
 			 * rename(a, b) when b is an existing
@@ -2574,6 +2591,7 @@ static int rename_tmp_log(const char *newrefname)
 	ret = 0;
 out:
 	strbuf_release(&path);
+	strbuf_release(&tmp_renamed_log);
 	return ret;
 }
 
@@ -2614,9 +2632,15 @@ static int files_rename_ref(struct ref_store *ref_store,
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
-	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
+	struct strbuf sb_oldref = STRBUF_INIT;
+	struct strbuf sb_newref = STRBUF_INIT;
+	struct strbuf tmp_renamed_log = STRBUF_INIT;
+	int log, ret;
 	struct strbuf err = STRBUF_INIT;
 
+	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	log = !lstat(sb_oldref.buf, &loginfo);
+	strbuf_release(&sb_oldref);
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
@@ -2630,7 +2654,12 @@ static int files_rename_ref(struct ref_store *ref_store,
 	if (!rename_ref_available(oldrefname, newrefname))
 		return 1;
 
-	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
+	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
+	ret = log && rename(sb_oldref.buf, tmp_renamed_log.buf);
+	strbuf_release(&sb_oldref);
+	strbuf_release(&tmp_renamed_log);
+	if (ret)
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
@@ -2709,13 +2738,19 @@ static int files_rename_ref(struct ref_store *ref_store,
 	log_all_ref_updates = flag;
 
  rollbacklog:
-	if (logmoved && rename(git_path("logs/%s", newrefname), git_path("logs/%s", oldrefname)))
+	strbuf_git_path(&sb_newref, "logs/%s", newrefname);
+	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from %s: %s",
 			oldrefname, newrefname, strerror(errno));
+	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
 	if (!logmoved && log &&
-	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldrefname)))
+	    rename(tmp_renamed_log.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
+	strbuf_release(&sb_newref);
+	strbuf_release(&sb_oldref);
+	strbuf_release(&tmp_renamed_log);
 
 	return 1;
 }
@@ -3111,22 +3146,32 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
+	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
+	int ret;
 
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "reflog_exists");
 
-	return !lstat(git_path("logs/%s", refname), &st) &&
-		S_ISREG(st.st_mode);
+	strbuf_git_path(&sb, "logs/%s", refname);
+	ret = !lstat(sb.buf, &st) && S_ISREG(st.st_mode);
+	strbuf_release(&sb);
+	return ret;
 }
 
 static int files_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
+	struct strbuf sb = STRBUF_INIT;
+	int ret;
+
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "delete_reflog");
 
-	return remove_path(git_path("logs/%s", refname));
+	strbuf_git_path(&sb, "logs/%s", refname);
+	ret = remove_path(sb.buf);
+	strbuf_release(&sb);
+	return ret;
 }
 
 static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
@@ -3181,7 +3226,9 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
 
-	logfp = fopen(git_path("logs/%s", refname), "r");
+	strbuf_git_path(&sb, "logs/%s", refname);
+	logfp = fopen(sb.buf, "r");
+	strbuf_release(&sb);
 	if (!logfp)
 		return -1;
 
@@ -3287,7 +3334,9 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "for_each_reflog_ent");
 
-	logfp = fopen(git_path("logs/%s", refname), "r");
+	strbuf_git_path(&sb, "logs/%s", refname);
+	logfp = fopen(sb.buf, "r");
+	strbuf_release(&sb);
 	if (!logfp)
 		return -1;
 
@@ -3369,12 +3418,15 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 {
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
+	struct strbuf sb = STRBUF_INIT;
 
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "reflog_iterator_begin");
 
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	iter->dir_iterator = dir_iterator_begin(git_path("logs"));
+	strbuf_git_path(&sb, "logs");
+	iter->dir_iterator = dir_iterator_begin(sb.buf);
+	strbuf_release(&sb);
 	return ref_iterator;
 }
 
@@ -3843,8 +3895,13 @@ static int files_transaction_commit(struct ref_store *ref_store,
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
-	for_each_string_list_item(ref_to_delete, &refs_to_delete)
-		unlink_or_warn(git_path("logs/%s", ref_to_delete->string));
+	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
+		struct strbuf sb = STRBUF_INIT;
+
+		strbuf_git_path(&sb, "logs/%s", ref_to_delete->string);
+		unlink_or_warn(sb.buf);
+		strbuf_release(&sb);
+	}
 	clear_loose_ref_cache(refs);
 
 cleanup:
@@ -4098,18 +4155,28 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
+	struct strbuf sb = STRBUF_INIT;
+
 	/* Check validity (but we don't need the result): */
 	files_downcast(ref_store, 0, "init_db");
 
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	safe_create_dir(git_path("refs/heads"), 1);
-	safe_create_dir(git_path("refs/tags"), 1);
+	strbuf_git_path(&sb, "refs/heads");
+	safe_create_dir(sb.buf, 1);
+	strbuf_reset(&sb);
+	strbuf_git_path(&sb, "refs/tags");
+	safe_create_dir(sb.buf, 1);
+	strbuf_reset(&sb);
 	if (get_shared_repository()) {
-		adjust_shared_perm(git_path("refs/heads"));
-		adjust_shared_perm(git_path("refs/tags"));
+		strbuf_git_path(&sb, "refs/heads");
+		adjust_shared_perm(sb.buf);
+		strbuf_reset(&sb);
+		strbuf_git_path(&sb, "refs/tags");
+		adjust_shared_perm(sb.buf);
 	}
+	strbuf_release(&sb);
 	return 0;
 }
 
-- 
2.11.0.157.gd943d85

