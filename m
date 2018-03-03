Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1231F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeCCLg5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:36:57 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34985 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeCCLg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:36:56 -0500
Received: by mail-pg0-f67.google.com with SMTP id l131so4864176pga.2
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bmJWGDs6VntjI8ZmIRYxqc1z5mOs4jTqTRwTSjLZINQ=;
        b=DGiBxkJbpfF+lFg3fhQHVs/WYroaQrrPko1XL+SZyer11DIrZj24Pe53f5djufChX5
         OzYAWQxIogFOxJ3OMw9eCHuZ+HIaYVgxK425DNblZHxUNzgmt9Uf0jjpmWp5HkDn7biv
         PjCrPp8h5UPiELW24qtCTvd1zzO+NEmCC3yW/fy39YDwncgEnb/0KYGaf/ksMyfG44FK
         967jb4Gflaa4BPrzBb/1hd+m+0RP2UDuw9phMaaRqagz1t7mXTJKX9Evxz/ED3giP2gt
         Qr17KndkdESWiD3dR+zAJUIBsHHCz26VgcmxNOW/o39R6s/Nm+pQPRMjBWBJcuFLp6jm
         +wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmJWGDs6VntjI8ZmIRYxqc1z5mOs4jTqTRwTSjLZINQ=;
        b=C9ALX9SAvHD4KCDkN5bgG+HUYX86nssukzJ3haxrLHE/p9bnKu9xdKYOnlcSnb8l/Z
         yjq3xSz4dP7GuXKZJV7NvAX7V6Qds2FT8fntAZFugOvU8P4/AQBtcVQ+AVYABZyb2+9h
         MZQpFFu9YiNyJSju0rkwQ2GxeCzv/foE1ASNZ4ZAYF12+BB+EBhITrAiq/BWmf2/gdaO
         bRxLyN+VHDJPpSCYvIqxl5HqQDcFVi5/SFiVGKn9R0MM91cMTYfR5r6+XaL2MHHj88iv
         jzFvMNEk/bF8T4p3Iez8J+0a53ZEYKa7ew2GuDtsjt7qXT7ZF0//Nq6+z+CCYKWc7zRE
         MIpQ==
X-Gm-Message-State: APf1xPCR0ES1VaXWLz0eiKnjnrCSUWTvY/tzqF0L0tPiBElepTMMYDEH
        KyPvvFe8TGRfXTAQe3qhUyFXHg==
X-Google-Smtp-Source: AG47ELtxVh1OFBGQYMWkfaiU5FZHjkI8ouV+JW/B6wE7UBcExV3LZLC5Ln+MezhWCcP+oOhNY7Yr9g==
X-Received: by 10.98.214.10 with SMTP id r10mr8800835pfg.8.1520077015742;
        Sat, 03 Mar 2018 03:36:55 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id w88sm18675403pfa.50.2018.03.03.03.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:36:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:36:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/44] repository.c: move env-related setup code back to environment.c
Date:   Sat,  3 Mar 2018 18:35:55 +0700
Message-Id: <20180303113637.26518-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does not make sense that generic repository code contains handling
of environment variables, which are specific for the main repository
only. Refactor repo_set_gitdir() function to take $GIT_DIR and
optionally _all_ other customizable paths. These optional paths can be
NULL and will be calculated according to the default directory layout.

Note that some dead functions are left behind to reduce diff
noise. They will be deleted in the next patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 cache.h       |  2 +-
 environment.c | 30 +++++++++++++++++++++++---
 repository.c  | 58 +++++++++++++++++++++++++++++++++++----------------
 repository.h  | 11 +++++++++-
 setup.c       |  3 +--
 5 files changed, 79 insertions(+), 25 deletions(-)

diff --git a/cache.h b/cache.h
index 9cac7bb518..41ba67cc16 100644
--- a/cache.h
+++ b/cache.h
@@ -484,7 +484,7 @@ static inline enum object_type object_type(unsigned int mode)
  */
 extern const char * const local_repo_env[];
 
-extern void setup_git_env(void);
+extern void setup_git_env(const char *git_dir);
 
 /*
  * Returns true iff we have a configured git repository (either via
diff --git a/environment.c b/environment.c
index de8431e01e..da3f7daa09 100644
--- a/environment.c
+++ b/environment.c
@@ -13,6 +13,7 @@
 #include "refs.h"
 #include "fmt-merge-msg.h"
 #include "commit.h"
+#include "argv-array.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
@@ -147,10 +148,34 @@ static char *expand_namespace(const char *raw_namespace)
 	return strbuf_detach(&buf, NULL);
 }
 
-void setup_git_env(void)
+/*
+ * Wrapper of getenv() that returns a strdup value. This value is kept
+ * in argv to be freed later.
+ */
+static const char *getenv_safe(struct argv_array *argv, const char *name)
+{
+	const char *value = getenv(name);
+
+	if (!value)
+		return NULL;
+
+	argv_array_push(argv, value);
+	return argv->argv[argv->argc - 1];
+}
+
+void setup_git_env(const char *git_dir)
 {
 	const char *shallow_file;
 	const char *replace_ref_base;
+	struct set_gitdir_args args = { NULL };
+	struct argv_array to_free = ARGV_ARRAY_INIT;
+
+	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
+	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
+	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
+	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
+	repo_set_gitdir(the_repository, git_dir, &args);
+	argv_array_clear(&to_free);
 
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		check_replace_refs = 0;
@@ -300,8 +325,7 @@ int set_git_dir(const char *path)
 {
 	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
 		return error("Could not set GIT_DIR to '%s'", path);
-	repo_set_gitdir(the_repository, path);
-	setup_git_env();
+	setup_git_env(path);
 	return 0;
 }
 
diff --git a/repository.c b/repository.c
index 0eddf28fcd..bb53b54b6d 100644
--- a/repository.c
+++ b/repository.c
@@ -40,34 +40,55 @@ static int find_common_dir(struct strbuf *sb, const char *gitdir, int fromenv)
 	return get_common_dir_noenv(sb, gitdir);
 }
 
-static void repo_setup_env(struct repository *repo)
+static void expand_base_dir(char **out, const char *in,
+			    const char *base_dir, const char *def_in)
+{
+	free(*out);
+	if (in)
+		*out = xstrdup(in);
+	else
+		*out = xstrfmt("%s/%s", base_dir, def_in);
+}
+
+static void repo_set_commondir(struct repository *repo,
+			       const char *commondir)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	repo->different_commondir = find_common_dir(&sb, repo->gitdir,
-						    !repo->ignore_env);
 	free(repo->commondir);
+
+	if (commondir) {
+		repo->different_commondir = 1;
+		repo->commondir = xstrdup(commondir);
+		return;
+	}
+
+	repo->different_commondir = get_common_dir_noenv(&sb, repo->gitdir);
 	repo->commondir = strbuf_detach(&sb, NULL);
-	free(repo->objectdir);
-	repo->objectdir = git_path_from_env(DB_ENVIRONMENT, repo->commondir,
-					    "objects", !repo->ignore_env);
-	free(repo->graft_file);
-	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
-					     "info/grafts", !repo->ignore_env);
-	free(repo->index_file);
-	repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
-					     "index", !repo->ignore_env);
 }
 
-void repo_set_gitdir(struct repository *repo, const char *path)
+void repo_set_gitdir(struct repository *repo,
+		     const char *root,
+		     const struct set_gitdir_args *o)
 {
-	const char *gitfile = read_gitfile(path);
+	const char *gitfile = read_gitfile(root);
+	/*
+	 * repo->gitdir is saved because the caller could pass "root"
+	 * that also points to repo->gitdir. We want to keep it alive
+	 * until after xstrdup(root). Then we can free it.
+	 */
 	char *old_gitdir = repo->gitdir;
 
-	repo->gitdir = xstrdup(gitfile ? gitfile : path);
-	repo_setup_env(repo);
-
+	repo->gitdir = xstrdup(gitfile ? gitfile : root);
 	free(old_gitdir);
+
+	repo_set_commondir(repo, o->commondir);
+	expand_base_dir(&repo->objectdir, o->object_dir,
+			repo->commondir, "objects");
+	expand_base_dir(&repo->graft_file, o->graft_file,
+			repo->commondir, "info/grafts");
+	expand_base_dir(&repo->index_file, o->index_file,
+			repo->gitdir, "index");
 }
 
 void repo_set_hash_algo(struct repository *repo, int hash_algo)
@@ -85,6 +106,7 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 	int error = 0;
 	char *abspath = NULL;
 	const char *resolved_gitdir;
+	struct set_gitdir_args args = { NULL };
 
 	abspath = real_pathdup(gitdir, 0);
 	if (!abspath) {
@@ -99,7 +121,7 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 		goto out;
 	}
 
-	repo_set_gitdir(repo, resolved_gitdir);
+	repo_set_gitdir(repo, resolved_gitdir, &args);
 
 out:
 	free(abspath);
diff --git a/repository.h b/repository.h
index 40c1c81bdc..84aeac2825 100644
--- a/repository.h
+++ b/repository.h
@@ -88,7 +88,16 @@ struct repository {
 
 extern struct repository *the_repository;
 
-extern void repo_set_gitdir(struct repository *repo, const char *path);
+struct set_gitdir_args {
+	const char *commondir;
+	const char *object_dir;
+	const char *graft_file;
+	const char *index_file;
+};
+
+extern void repo_set_gitdir(struct repository *repo,
+			    const char *root,
+			    const struct set_gitdir_args *optional);
 extern void repo_set_worktree(struct repository *repo, const char *path);
 extern void repo_set_hash_algo(struct repository *repo, int algo);
 extern void initialize_the_repository(void);
diff --git a/setup.c b/setup.c
index c5d55dcee4..6fac1bb58a 100644
--- a/setup.c
+++ b/setup.c
@@ -1116,8 +1116,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
-			repo_set_gitdir(the_repository, gitdir);
-			setup_git_env();
+			setup_git_env(gitdir);
 		}
 		if (startup_info->have_repository)
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
-- 
2.16.1.435.g8f24da2e1a

