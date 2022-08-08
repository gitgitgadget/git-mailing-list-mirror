Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28BCC25B0C
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiHHN2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbiHHN15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:27:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888D2A449
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 06:27:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z17so10902097wrq.4
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 06:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=j0PQ1fijek74RD1U23MrGDGCUhUVjKLyhgHg2JC7YOU=;
        b=e9qqS9prU7wi2cL84upqIrB/LxwQVwHkJR54JxFbWPrT1fhszlL7aVZqA0VILSomIY
         NrlzRMcOOtUWCFcXazS2OxTE4WWbqNiGGGIHE1tXPHFkh+vBerU4mUR9qLRA0bPguEXb
         lUvJZXlmBBF+j/duwSdNfWVvgd1+Isjwq3jF9PTeAd05qt5OpP+yTz1WB2XxEbSpQNZw
         aCHtNqcIE/VND1kDfHEiwm27IKcGQCA0aPHrwcYxJWt0vbgfn1fJUZ8UELBSbgpOpME6
         SsE0vYS3qKW9kWt4U/tS78/9HAiW4Zc6oKeX/oRYyQ73k5zMSzwXaKyE3gJSPzCmqdrR
         S5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=j0PQ1fijek74RD1U23MrGDGCUhUVjKLyhgHg2JC7YOU=;
        b=0IENmhR8VgFx0PGJ1AfOZCK2Z0mqvyGx3u3CAKLIWXjarndR3dYUeGxx0SB7K18H97
         DLpF8FthRm4m29HRiw3YPNf26yrzgLWYe6uI9J3Vbs7TTqHQQaxPoAcjuYIaVOPQ5pnS
         +zvIepNjJTxHjGgz1KwsboqpEkFH45ODmYDSqj5iG9ec2R6PkrBpelrMcJuVYdk3qpYc
         eAa053FZGihUt+mEoBF/PnwMTWm+AYntOcQAgzftAyPEInJdFlVXBnuyw8fn7L4Si8up
         vWquJSHss7i0idEPW/lUPQDJOJ/5NekWzg4aVdIBkzVWjUp+diAeW4YTKu4Ti30w5yrS
         98GA==
X-Gm-Message-State: ACgBeo3zXYrBpQqqallBQ+VJT0SV13NniCW7TFucNvGSmuK8Tw3aK/e1
        uLdz2C3cxPejiXT+vMGeg+zXYw5xB3E=
X-Google-Smtp-Source: AA6agR4NUmB9IpU5es8wOT7Z+VLG5uwOB9jmfYzT+DAM6taJBlEjVwoQNi05UFCEFuPHHPpPFJYs7A==
X-Received: by 2002:a5d:684e:0:b0:220:63df:3760 with SMTP id o14-20020a5d684e000000b0022063df3760mr10846056wrw.508.1659965273752;
        Mon, 08 Aug 2022 06:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6-20020adfde06000000b0022069ccb6a1sm12115573wrm.94.2022.08.08.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 06:27:53 -0700 (PDT)
Message-Id: <8cc45e4922a6a445e9f643e709c3efaf48553a09.1659965270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
References: <pull.1286.git.1657700238.gitgitgadget@gmail.com>
        <pull.1286.v2.git.1659965270.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 13:27:47 +0000
Subject: [PATCH v2 2/5] Prepare for more detailed "dubious ownership" messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When verifying the ownership of the Git directory, we sometimes would
like to say a bit more about it, e.g. when using a platform-dependent
code path (think: Windows and the permission model that is so different
from Unix'), but only when it is a appropriate to actually say
something.

To allow for that, collect that information and hand it back to the
caller (whose responsibility it is to show it or not).

Note: We do not actually fill in any platform-dependent information yet,
this commit just adds the infrastructure to be able to do so.

Based-on-an-idea-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c    |  2 +-
 compat/mingw.h    |  2 +-
 git-compat-util.h |  5 ++++-
 setup.c           | 25 +++++++++++++++----------
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 2607de93af5..f12b7df16d9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2673,7 +2673,7 @@ static PSID get_current_user_sid(void)
 	return result;
 }
 
-int is_path_owned_by_current_sid(const char *path)
+int is_path_owned_by_current_sid(const char *path, struct strbuf *report)
 {
 	WCHAR wpath[MAX_PATH];
 	PSID sid = NULL;
diff --git a/compat/mingw.h b/compat/mingw.h
index a74da68f313..209cf7cebad 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -463,7 +463,7 @@ char *mingw_query_user_email(void);
  * Verifies that the specified path is owned by the user running the
  * current process.
  */
-int is_path_owned_by_current_sid(const char *path);
+int is_path_owned_by_current_sid(const char *path, struct strbuf *report);
 #define is_path_owned_by_current_user is_path_owned_by_current_sid
 
 /**
diff --git a/git-compat-util.h b/git-compat-util.h
index 58d7708296b..36a25ae252f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -23,6 +23,9 @@
 #include <crtdbg.h>
 #endif
 
+struct strbuf;
+
+
 #define _FILE_OFFSET_BITS 64
 
 
@@ -487,7 +490,7 @@ static inline void extract_id_from_env(const char *env, uid_t *id)
 	}
 }
 
-static inline int is_path_owned_by_current_uid(const char *path)
+static inline int is_path_owned_by_current_uid(const char *path, struct strbuf *report)
 {
 	struct stat st;
 	uid_t euid;
diff --git a/setup.c b/setup.c
index 2f7b3e598f8..cefd5f63c46 100644
--- a/setup.c
+++ b/setup.c
@@ -1142,16 +1142,17 @@ static int safe_directory_cb(const char *key, const char *value, void *d)
  * added, for bare ones their git directory.
  */
 static int ensure_valid_ownership(const char *gitfile,
-				  const char *worktree, const char *gitdir)
+				  const char *worktree, const char *gitdir,
+				  struct strbuf *report)
 {
 	struct safe_directory_data data = {
 		.path = worktree ? worktree : gitdir
 	};
 
 	if (!git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0) &&
-	   (!gitfile || is_path_owned_by_current_user(gitfile)) &&
-	   (!worktree || is_path_owned_by_current_user(worktree)) &&
-	   (!gitdir || is_path_owned_by_current_user(gitdir)))
+	    (!gitfile || is_path_owned_by_current_user(gitfile, report)) &&
+	    (!worktree || is_path_owned_by_current_user(worktree, report)) &&
+	    (!gitdir || is_path_owned_by_current_user(gitdir, report)))
 		return 1;
 
 	/*
@@ -1232,6 +1233,7 @@ enum discovery_result {
  */
 static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 							  struct strbuf *gitdir,
+							  struct strbuf *report,
 							  int die_on_error)
 {
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
@@ -1320,7 +1322,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 				gitdir_path ? gitdir_path : gitdirenv;
 
 			if (ensure_valid_ownership(gitfile, dir->buf,
-						   gitdir_candidate)) {
+						   gitdir_candidate, report)) {
 				strbuf_addstr(gitdir, gitdirenv);
 				ret = GIT_DIR_DISCOVERED;
 			} else
@@ -1345,7 +1347,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		if (is_git_directory(dir->buf)) {
 			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT)
 				return GIT_DIR_DISALLOWED_BARE;
-			if (!ensure_valid_ownership(NULL, NULL, dir->buf))
+			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, ".");
 			return GIT_DIR_BARE;
@@ -1378,7 +1380,7 @@ int discover_git_directory(struct strbuf *commondir,
 		return -1;
 
 	cwd_len = dir.len;
-	if (setup_git_directory_gently_1(&dir, gitdir, 0) <= 0) {
+	if (setup_git_directory_gently_1(&dir, gitdir, NULL, 0) <= 0) {
 		strbuf_release(&dir);
 		return -1;
 	}
@@ -1425,7 +1427,7 @@ int discover_git_directory(struct strbuf *commondir,
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static struct strbuf cwd = STRBUF_INIT;
-	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT;
+	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	const char *prefix = NULL;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
@@ -1450,7 +1452,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		die_errno(_("Unable to read current working directory"));
 	strbuf_addbuf(&dir, &cwd);
 
-	switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
+	switch (setup_git_directory_gently_1(&dir, &gitdir, &report, 1)) {
 	case GIT_DIR_EXPLICIT:
 		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, &repo_fmt, nongit_ok);
 		break;
@@ -1482,12 +1484,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		if (!nongit_ok) {
 			struct strbuf quoted = STRBUF_INIT;
 
+			strbuf_complete(&report, '\n');
 			sq_quote_buf_pretty(&quoted, dir.buf);
 			die(_("detected dubious ownership in repository at '%s'\n"
+			      "%s"
 			      "To add an exception for this directory, call:\n"
 			      "\n"
 			      "\tgit config --global --add safe.directory %s"),
-			    dir.buf, quoted.buf);
+			    dir.buf, report.buf, quoted.buf);
 		}
 		*nongit_ok = 1;
 		break;
@@ -1574,6 +1578,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
+	strbuf_release(&report);
 	clear_repository_format(&repo_fmt);
 
 	return prefix;
-- 
gitgitgadget

