Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25A8E20372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbdJFUNB (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:13:01 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:48485 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752757AbdJFUM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:12:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id i124so9565991wmf.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jkwZLv+kLwZQivX/S9C78Xo6qaBRo60bVvZxwL35Gj4=;
        b=J82gSqV/Z0A9WL/1TUkX9KbZjI+q9+cLN1JmSgfpJfpfELCSa8VV7HvH3glRN21x4V
         d8OJZAjCF6cSCSFqq0CWxY7J1KhMycXgzQNE+o+ZdD3MrKV/RnrC5xzCWQ/V59KSAAft
         0YIctWrOMwcG4IzzBkkTurGcUDcDVw3QZ4P6zSKgN/9XYQuwP5tOmdTTzIfXrYP8OSz5
         esRHm+uxNzIZMLfET7Gn4nyjec53pnWyXOQPsd+pNNU5vWUugX8+FjQYG9pFxn1xMLyf
         gulh45T3wUD+W5xHu1srQP1wwiRMzUY/W6MzfNlE9HJ91/mzmwbGTbdWwqCiNoqfLT5n
         DQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jkwZLv+kLwZQivX/S9C78Xo6qaBRo60bVvZxwL35Gj4=;
        b=BpBvQyUvS/x43M5VYN7R9JXEukLOZ7eMlAMThJpd7JmMMJWK0v7k1iXsMJMK/vmR9Q
         0UjKJIZMgFDbgmcUzw437kDbjLaNFF7ZEsUVIap77SZgp/czY4Rmch892qHamcQ1oMfx
         RjUDQhpLz2wlocdREjiHratq1JY75eYAMzO/d/SUVAMpgAjgJUOBEht2WkWUfaxaix1F
         4EVT/EMzoromeXxWg+iIs5nVVqClCdmLOXIk9INMf2E5ZjWgI2UBpLlwq0QCeuAWo92w
         blV7GlHvu+PBd8xKJQZjmCkuHJgwk87+puAFlbVhPQw00AWrOokuJHHuE/deExqnKFMb
         dk+Q==
X-Gm-Message-State: AMCzsaVb1RSj6CWXwmwo+buvGLSj2bYGTCLVcFyMHbWEhXOFwLs1vceI
        zuK8idrCwlwM4RNGRtQHwtORymQWAxQ=
X-Google-Smtp-Source: AOwi7QDnG1NOGTMQOBHVsmdz9Ve2/GhxvrrfEWLp10QSQc906YR19QXZ+9v95TQH9Qii1yGmfL6X5w==
X-Received: by 10.28.19.10 with SMTP id 10mr2658848wmt.87.1507320775352;
        Fri, 06 Oct 2017 13:12:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/12] read-cache: drop explicit `CLOSE_LOCK`-flag
Date:   Fri,  6 Oct 2017 22:12:12 +0200
Message-Id: <db718624ece17a7bed4c956d581dab83b579db0b.1507320376.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0
In-Reply-To: <cover.1507320376.git.martin.agren@gmail.com>
References: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com> <cover.1507320376.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`write_locked_index()` takes two flags: `COMMIT_LOCK` and `CLOSE_LOCK`.
At most one is allowed. But it is also possible to use no flag, i.e.,
`0`. But when `write_locked_index()` calls `do_write_index()`, the
temporary file, a.k.a. the lockfile, will be closed. So passing `0` is
effectively the same as `CLOSE_LOCK`, which seems like a bug.

We might feel tempted to restructure the code in order to close the file
later, or conditionally. It also feels a bit unfortunate that we simply
"happen" to close the lock by way of an implementation detail of
lockfiles. But note that we need to close the temporary file before
`stat`-ing it, at least on Windows. See 9f41c7a6b (read-cache: close
index.lock in do_write_index, 2017-04-26).

Drop `CLOSE_LOCK` and make it explicit that `write_locked_index()`
always closes the lock. Whether it is also committed is governed by the
remaining flag, `COMMIT_LOCK`.

This means we neither have nor suggest that we have a mode to write the
index and leave the file open. Whatever extra contents we might
eventually want to write, we should probably write it from within
`write_locked_index()` itself anyway.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v3: Dropped the comment in `do_write_locked_index()` and documented how
`do_write_index()` handles the temporary file instead.

 builtin/commit.c | 10 +++++-----
 cache.h          |  5 ++---
 read-cache.c     | 14 ++++++++------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0f8ddb686..32dc2101f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -355,7 +355,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 
 		refresh_cache_or_die(refresh_flags);
 
-		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
+		if (write_locked_index(&the_index, &index_lock, 0))
 			die(_("unable to create temporary index"));
 
 		old_index_env = getenv(INDEX_ENVIRONMENT);
@@ -374,7 +374,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
-			if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
+			if (write_locked_index(&the_index, &index_lock, 0))
 				die(_("unable to update temporary index"));
 		} else
 			warning(_("Failed to update main cache tree"));
@@ -401,7 +401,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
-		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
+		if (write_locked_index(&the_index, &index_lock, 0))
 			die(_("unable to write new_index file"));
 		commit_style = COMMIT_NORMAL;
 		ret = get_lock_file_path(&index_lock);
@@ -474,7 +474,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 	update_main_cache_tree(WRITE_TREE_SILENT);
-	if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
+	if (write_locked_index(&the_index, &index_lock, 0))
 		die(_("unable to write new_index file"));
 
 	hold_lock_file_for_update(&false_lock,
@@ -486,7 +486,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 
-	if (write_locked_index(&the_index, &false_lock, CLOSE_LOCK))
+	if (write_locked_index(&the_index, &false_lock, 0))
 		die(_("unable to write temporary index file"));
 
 	discard_cache();
diff --git a/cache.h b/cache.h
index e9d9556e3..21a6856c5 100644
--- a/cache.h
+++ b/cache.h
@@ -604,11 +604,10 @@ extern int read_index_unmerged(struct index_state *);
 
 /* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
-#define CLOSE_LOCK		(1 << 1)
 
 /*
- * Write the index while holding an already-taken lock. The flags may
- * contain at most one of `COMMIT_LOCK` and `CLOSE_LOCK`.
+ * Write the index while holding an already-taken lock. Close the lock,
+ * and if `COMMIT_LOCK` is given, commit it.
  *
  * Unless a split index is in use, write the index into the lockfile.
  *
diff --git a/read-cache.c b/read-cache.c
index 65f4fe837..c7aa3632a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2187,6 +2187,13 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
 		rollback_lock_file(lockfile);
 }
 
+/*
+ * On success, `tempfile` is closed. If it is the temporary file
+ * of a `struct lock_file`, we will therefore effectively perform
+ * a 'close_lock_file_gently()`. Since that is an implementation
+ * detail of lockfiles, callers of `do_write_index()` should not
+ * rely on it.
+ */
 static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 			  int strip_extensions)
 {
@@ -2343,14 +2350,9 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 	int ret = do_write_index(istate, lock->tempfile, 0);
 	if (ret)
 		return ret;
-	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=
-	       (COMMIT_LOCK | CLOSE_LOCK));
 	if (flags & COMMIT_LOCK)
 		return commit_locked_index(lock);
-	else if (flags & CLOSE_LOCK)
-		return close_lock_file_gently(lock);
-	else
-		return ret;
+	return close_lock_file_gently(lock);
 }
 
 static int write_split_index(struct index_state *istate,
-- 
2.15.0.rc0

