Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5721F4C1
	for <e@80x24.org>; Sun, 27 Oct 2019 16:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfJ0Qap (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 12:30:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43291 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfJ0Qap (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Oct 2019 12:30:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so7373204wrr.10
        for <git@vger.kernel.org>; Sun, 27 Oct 2019 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNyDHyiUbk12+Yptcj1kPY5u09pI7jj6Mg9w+PXyxXo=;
        b=u4s0MSLJoZkdndJEDcUkXYKqdxTxyrI6308qXBKxSUgQtxV9mZSEqiWgyAZr6QDrMZ
         Hv8dAxbbQGQBxq+gvs7KFasgq7e+np98nGSYpciDFmrhrfcJhAlh9y3i7MWkjOXeS03G
         2CrIlCX0164qlllk9wCU28H8wRunvUloCh6jaCar6tG9hCnGecMb5SaA9MTcl8nezM3K
         p3B/Tj70wg27gP+/Z0K/mU7aBrD6pRONOHASo790gM7ea9SpLzhZnUZk/bmnrudoPQiM
         /O0RPvvYlhPI9sMivQQPDT2NtYBQt9U7FAEn2imhx+w+yzDc9elur2of6+YilfVd4Qh9
         Gl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNyDHyiUbk12+Yptcj1kPY5u09pI7jj6Mg9w+PXyxXo=;
        b=YN24zwmMWdQSJigVXPawU1fZc8JiISBdLImt2iPiw98Icxo93POnV0PlFzTzo3NiRj
         R4nUWAaPNRQu7FCb03JaO1uNDH+NG0tufQNNwSOlRMxZy6p8DXmxR7qAms6JfjOkzw26
         13U1ShyVKcfHVVlgQSc07eyLP6647kq100Xm3I2M4pHT/HF76pUwQFL7O9z9NPmddqNi
         JsdUyr+Nl0RSG6HOoRxjrn84pCOdxtnxNNU2BfXQwXrt2ZzBEYgMszXD668MDBWSvRm4
         c+L1PugWRpUo2bV4oQepFsmFt4nZfMB0JerImOWzKhZm5IVmUKj4kzBbCBOCOeGovtFQ
         Dkig==
X-Gm-Message-State: APjAAAUi9I4i9pxozT+MDnksB6WmCFfjStyueaqnIkJdKGMNC1hTPM7G
        2DhajZ3x3FkRiHZ7xVNK86eyeBQT
X-Google-Smtp-Source: APXvYqyQBJF9iRpG9LQlfiKNeOMUzN2HovN/nPKF0iEeReymqgkxAoUeNZqd4rpXEDD0kUeWrunxqQ==
X-Received: by 2002:a5d:55c7:: with SMTP id i7mr8367470wrw.371.1572193842591;
        Sun, 27 Oct 2019 09:30:42 -0700 (PDT)
Received: from localhost.localdomain ([139.47.116.239])
        by smtp.gmail.com with ESMTPSA id b186sm7866496wmb.21.2019.10.27.09.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2019 09:30:42 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [Outreachy] [PATCH] dir: add new function `path_exists()`
Date:   Sun, 27 Oct 2019 17:30:38 +0100
Message-Id: <20191027163038.47409-1-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Added a new function path_exists() that works the same as file_exists()
but with better descriptive name.
New calls should use path_exists() instead of file_exists().

The dir_exists() function in builtin/clone.c is marked as static, so
nobody can use it outside builtin/clone.c and can be replaced by new
function path_exists().

The static function path_exists() in archive.c have been renamed as
archive_path_exists() to avoid name collision.

Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 archive.c       |  6 +++---
 builtin/clone.c | 12 +++---------
 dir.c           |  6 ++++++
 dir.h           |  3 +++
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/archive.c b/archive.c
index a8da0fcc4f..8110a50f17 100644
--- a/archive.c
+++ b/archive.c
@@ -338,7 +338,7 @@ static int reject_entry(const struct object_id *oid, struct strbuf *base,
 	return ret;
 }
 
-static int path_exists(struct archiver_args *args, const char *path)
+static int archive_path_exists(struct archiver_args *args, const char *path)
 {
 	const char *paths[] = { path, NULL };
 	struct path_exists_context ctx;
@@ -358,7 +358,7 @@ static void parse_pathspec_arg(const char **pathspec,
 		struct archiver_args *ar_args)
 {
 	/*
-	 * must be consistent with parse_pathspec in path_exists()
+	 * must be consistent with parse_pathspec in archive_path_exists()
 	 * Also if pathspec patterns are dependent, we're in big
 	 * trouble as we test each one separately
 	 */
@@ -368,7 +368,7 @@ static void parse_pathspec_arg(const char **pathspec,
 	ar_args->pathspec.recursive = 1;
 	if (pathspec) {
 		while (*pathspec) {
-			if (**pathspec && !path_exists(ar_args, *pathspec))
+			if (**pathspec && !archive_path_exists(ar_args, *pathspec))
 				die(_("pathspec '%s' did not match any files"), *pathspec);
 			pathspec++;
 		}
diff --git a/builtin/clone.c b/builtin/clone.c
index c46ee29f0a..20ab535784 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -899,12 +899,6 @@ static void dissociate_from_references(void)
 	free(alternates);
 }
 
-static int dir_exists(const char *path)
-{
-	struct stat sb;
-	return !stat(path, &sb);
-}
-
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -981,7 +975,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		dir = guess_dir_name(repo_name, is_bundle, option_bare);
 	strip_trailing_slashes(dir);
 
-	dest_exists = dir_exists(dir);
+	dest_exists = path_exists(dir);
 	if (dest_exists && !is_empty_dir(dir))
 		die(_("destination path '%s' already exists and is not "
 			"an empty directory."), dir);
@@ -992,7 +986,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		work_tree = NULL;
 	else {
 		work_tree = getenv("GIT_WORK_TREE");
-		if (work_tree && dir_exists(work_tree))
+		if (work_tree && path_exists(work_tree))
 			die(_("working tree '%s' already exists."), work_tree);
 	}
 
@@ -1020,7 +1014,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	if (real_git_dir) {
-		if (dir_exists(real_git_dir))
+		if (path_exists(real_git_dir))
 			junk_git_dir_flags |= REMOVE_DIR_KEEP_TOPLEVEL;
 		junk_git_dir = real_git_dir;
 	} else {
diff --git a/dir.c b/dir.c
index 61f559f980..638a783b65 100644
--- a/dir.c
+++ b/dir.c
@@ -2353,6 +2353,12 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 	return dir->nr;
 }
 
+int path_exists(const char *path)
+{
+    struct stat sb;
+    return !stat(path, &sb);
+}
+
 int file_exists(const char *f)
 {
 	struct stat sb;
diff --git a/dir.h b/dir.h
index 2fbdef014f..376fa93321 100644
--- a/dir.h
+++ b/dir.h
@@ -286,6 +286,9 @@ void clear_pattern_list(struct pattern_list *pl);
 void clear_directory(struct dir_struct *dir);
 
 int repo_file_exists(struct repository *repo, const char *path);
+int path_exists(const char *);
+
+/* New calls should use path_exists(). */
 int file_exists(const char *);
 
 int is_inside_dir(const char *dir);
-- 
2.21.0 (Apple Git-122)

