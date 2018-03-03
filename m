Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 444E21F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeCCLhR (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:37:17 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36299 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeCCLhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:37:16 -0500
Received: by mail-pl0-f67.google.com with SMTP id 61-v6so7195802plf.3
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yrXpEWSKPrVBu7aufC610sfzrcLoyr0qOuPkPiLTIs=;
        b=mGoU9K7RevIbauUq8hiVe3oVGIzZ0caPr+RtZJoSjea3DBlGfWxHZyJOjfue0qqFFo
         gOlR3wnapG7qCosR7tKs/nUCPfZUdXtw6aXwGn9BjM4NRNnoyM102zfBx1h96+lDZdDw
         Z0YVk26OkZT6LMz750FuaEBQgj3ocecennRnSKqyeJv2n2ax3OpofmUOwIWN1JtH8wmB
         4LuyCj/Ydax/fg9zQCv7Zf9pjNpBA8zwYJe0ftPZsuoaX4AHqmFsP/ImtMUHvPEuNJ9v
         qm0JR6jvvgIR6ROpXv5syGauCR3KZ3Qa2AXcTTX2cgFnlrTjxM46bJuZ7PMIOA9uTMYS
         MuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yrXpEWSKPrVBu7aufC610sfzrcLoyr0qOuPkPiLTIs=;
        b=MEMj2/736uQ5594ApsBcN2W2DIQ6LJaiRqK+/R2a2KWkAs045B8R9xFGv0d0IWWo/N
         WnZq2E8YgfRdOy+CV+Emr8+WIFB1eIlPrcqIG2fuzjn+rdyGTynxPaIPsUDdD4uPs2nO
         fOe4ISg2jQR/r5W/5rSn8/gHDo0Dv9gCtiiWcXwyOQdDe140uqwZHqnB8BSDw5DJn8R0
         HwX+zfmhtreidGQwqfHps7EmC4Lmp60Ga5GK2I+p1EfUfr4yI4lfRyWRbfoMR/qwkmho
         /o6K25MppbJw+5r6sAYAURJSF3+XdUDNfYPpM29b7ETp4rnLIZ4K1mM2grv68HqynjQ0
         1TfQ==
X-Gm-Message-State: APf1xPC1E6q16EHr1zaS1gBqCBZE5nOJccxs7t05HeQ2sDH8GNT6OPJz
        PxoLHwlF7ckbgTAW4GSWMwfcRg==
X-Google-Smtp-Source: AG47ELuZugjHx8xGU15PJqYtrzWavNsYaHhQRi9HATlkeawgS+bEyKE0JwaGb6JYMn1xM3SEbnzkIA==
X-Received: by 2002:a17:902:59d3:: with SMTP id d19-v6mr7907063plj.356.1520077035466;
        Sat, 03 Mar 2018 03:37:15 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id p128sm13211644pga.45.2018.03.03.03.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:37:14 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:37:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/44] repository: introduce raw object store field
Date:   Sat,  3 Mar 2018 18:35:59 +0700
Message-Id: <20180303113637.26518-7-pclouds@gmail.com>
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

From: Stefan Beller <sbeller@google.com>

The raw object store field will contain any objects needed for
access to objects in a given repository.

This patch introduces the raw object store and populates it with the
`objectdir`, which used to be part of the repository struct.

As the struct gains members, we'll also populate the function to clear
the memory for these members.

In a later we'll introduce a struct object_parser, that will complement
the object parsing in a repository struct: The raw object parser is the
layer that will provide access to raw object content, while the higher
level object parser code will parse raw objects and keeps track of
parenthood and other object relationships using 'struct object'.
For now only add the lower level to the repository struct.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c |  2 +-
 environment.c  |  5 +++--
 object-store.h | 18 ++++++++++++++++++
 object.c       | 10 ++++++++++
 path.c         |  2 +-
 repository.c   | 14 +++++++++-----
 repository.h   | 10 ++++------
 sha1_file.c    |  3 ++-
 8 files changed, 48 insertions(+), 16 deletions(-)
 create mode 100644 object-store.h

diff --git a/builtin/grep.c b/builtin/grep.c
index 3ca4ac80d8..0f0c195705 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -432,7 +432,7 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	 * object.
 	 */
 	grep_read_lock();
-	add_to_alternates_memory(submodule.objectdir);
+	add_to_alternates_memory(submodule.objects.objectdir);
 	grep_read_unlock();
 
 	if (oid) {
diff --git a/environment.c b/environment.c
index a5eaa97fb1..c05705e384 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@
 #include "fmt-merge-msg.h"
 #include "commit.h"
 #include "argv-array.h"
+#include "object-store.h"
 
 int trust_executable_bit = 1;
 int trust_ctime = 1;
@@ -270,9 +271,9 @@ const char *get_git_work_tree(void)
 
 char *get_object_directory(void)
 {
-	if (!the_repository->objectdir)
+	if (!the_repository->objects.objectdir)
 		BUG("git environment hasn't been setup");
-	return the_repository->objectdir;
+	return the_repository->objects.objectdir;
 }
 
 int odb_mkstemp(struct strbuf *template, const char *pattern)
diff --git a/object-store.h b/object-store.h
new file mode 100644
index 0000000000..69bb5ac065
--- /dev/null
+++ b/object-store.h
@@ -0,0 +1,18 @@
+#ifndef OBJECT_STORE_H
+#define OBJECT_STORE_H
+
+struct raw_object_store {
+	/*
+	 * Path to the repository's object store.
+	 * Cannot be NULL after initialization.
+	 */
+	char *objectdir;
+
+	/* Path to extra alternate object database if not NULL */
+	char *alternate_db;
+};
+
+void raw_object_store_init(struct raw_object_store *o);
+void raw_object_store_clear(struct raw_object_store *o);
+
+#endif /* OBJECT_STORE_H */
diff --git a/object.c b/object.c
index 9e6f9ff20b..e91711dd56 100644
--- a/object.c
+++ b/object.c
@@ -445,3 +445,13 @@ void clear_commit_marks_all(unsigned int flags)
 			obj->flags &= ~flags;
 	}
 }
+
+void raw_object_store_init(struct raw_object_store *o)
+{
+	memset(o, 0, sizeof(*o));
+}
+void raw_object_store_clear(struct raw_object_store *o)
+{
+	FREE_AND_NULL(o->objectdir);
+	FREE_AND_NULL(o->alternate_db);
+}
diff --git a/path.c b/path.c
index da8b655730..81a42d9115 100644
--- a/path.c
+++ b/path.c
@@ -382,7 +382,7 @@ static void adjust_git_path(const struct repository *repo,
 		strbuf_splice(buf, 0, buf->len,
 			      repo->index_file, strlen(repo->index_file));
 	else if (dir_prefix(base, "objects"))
-		replace_dir(buf, git_dir_len + 7, repo->objectdir);
+		replace_dir(buf, git_dir_len + 7, repo->objects.objectdir);
 	else if (git_hooks_path && dir_prefix(base, "hooks"))
 		replace_dir(buf, git_dir_len + 5, git_hooks_path);
 	else if (repo->different_commondir)
diff --git a/repository.c b/repository.c
index 62f52f47fc..34c0a7f180 100644
--- a/repository.c
+++ b/repository.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "repository.h"
+#include "object-store.h"
 #include "config.h"
 #include "submodule-config.h"
 
@@ -12,6 +13,7 @@ void initialize_the_repository(void)
 	the_repository = &the_repo;
 
 	the_repo.index = &the_index;
+	raw_object_store_init(&the_repo.objects);
 	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
 
@@ -58,10 +60,10 @@ void repo_set_gitdir(struct repository *repo,
 	free(old_gitdir);
 
 	repo_set_commondir(repo, o->commondir);
-	expand_base_dir(&repo->objectdir, o->object_dir,
+	expand_base_dir(&repo->objects.objectdir, o->object_dir,
 			repo->commondir, "objects");
-	free(repo->alternate_db);
-	repo->alternate_db = xstrdup_or_null(o->alternate_db);
+	free(repo->objects.alternate_db);
+	repo->objects.alternate_db = xstrdup_or_null(o->alternate_db);
 	expand_base_dir(&repo->graft_file, o->graft_file,
 			repo->commondir, "info/grafts");
 	expand_base_dir(&repo->index_file, o->index_file,
@@ -140,6 +142,8 @@ static int repo_init(struct repository *repo,
 	struct repository_format format;
 	memset(repo, 0, sizeof(*repo));
 
+	raw_object_store_init(&repo->objects);
+
 	if (repo_init_gitdir(repo, gitdir))
 		goto error;
 
@@ -214,13 +218,13 @@ void repo_clear(struct repository *repo)
 {
 	FREE_AND_NULL(repo->gitdir);
 	FREE_AND_NULL(repo->commondir);
-	FREE_AND_NULL(repo->objectdir);
-	FREE_AND_NULL(repo->alternate_db);
 	FREE_AND_NULL(repo->graft_file);
 	FREE_AND_NULL(repo->index_file);
 	FREE_AND_NULL(repo->worktree);
 	FREE_AND_NULL(repo->submodule_prefix);
 
+	raw_object_store_clear(&repo->objects);
+
 	if (repo->config) {
 		git_configset_clear(repo->config);
 		FREE_AND_NULL(repo->config);
diff --git a/repository.h b/repository.h
index e7127baffb..6c383c05c6 100644
--- a/repository.h
+++ b/repository.h
@@ -1,6 +1,8 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
 
+#include "object-store.h"
+
 struct config_set;
 struct index_state;
 struct submodule_cache;
@@ -21,13 +23,9 @@ struct repository {
 	char *commondir;
 
 	/*
-	 * Path to the repository's object store.
-	 * Cannot be NULL after initialization.
+	 * Holds any information related to accessing the raw object content.
 	 */
-	char *objectdir;
-
-	/* Path to extra alternate object database if not NULL */
-	char *alternate_db;
+	struct raw_object_store objects;
 
 	/*
 	 * Path to the repository's graft file.
diff --git a/sha1_file.c b/sha1_file.c
index 4af422e3cf..792bb21c15 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -671,7 +671,8 @@ void prepare_alt_odb(void)
 		return;
 
 	alt_odb_tail = &alt_odb_list;
-	link_alt_odb_entries(the_repository->alternate_db, PATH_SEP, NULL, 0);
+	link_alt_odb_entries(the_repository->objects.alternate_db,
+			     PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
 }
-- 
2.16.1.435.g8f24da2e1a

