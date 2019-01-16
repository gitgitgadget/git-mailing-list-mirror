Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B16111F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404161AbfAPKcy (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:32:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34332 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbfAPKcy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:32:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so2896286pfg.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gl3EMyC9TJQppvk98H59R/WIcNobqPlCuYMv+cf0QyM=;
        b=IFP8fQ9S01JkipzzuMnh8jOVqpIKIrYX7/KWMq/5WZKe60LbLK4xxFs/omNZOl3mpy
         pL/LwLmCqMu2v9GohzGn4jNIGJBdQZzZRN2zcVByT+y96y5mcVwROoDZtFucsiVZTvf4
         15dWOuT/ftboe7p6/qgLE/smnA+H2iajJzYnJ6SXYYh3aHB1WmySNJgk6+CHiXdkPVUG
         jaSfUhhNE4J2Kk5AjI+MHtPjPS17QD6ONkT176HRE3ElKaZrQ8IEPe8MwNjOcssstYb/
         de6PUq1VOGpvhD4CKDkj3I3OmwdGHnPxtEq3SvW7BPShX/dX/hsIJ8rEiOvQo+VziSe5
         MX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gl3EMyC9TJQppvk98H59R/WIcNobqPlCuYMv+cf0QyM=;
        b=GgOhJ4lOZGsHQLWwjyRGLDzrOsilWsNI/VHQZrpd8rvQT0S8wCDWjXZxC6PgjN0kn1
         d6ujQ4KZHGqg9YR9y8BNAbQbouQIlQkLF4S18LUmTY9c4nm3+Y0KfD10Ag9wvHzQlW+X
         nKe9mdsTkhC8VU5CUj6UWLfsqdLHn1YAuVtiFjwda8iqyDy0RE4cuiZ+s4Ql5FmnxEDs
         XuqSvFzXhiQ6NJYStEYHLr2oOR3LIUTiX8mYRbhlrcHLxY42NZuXesxZURgrqoz77cOJ
         NkYwtFlANkJmb6kXOEX+oSNjJpK57MHT0rdUY7i7+Qp8s3oNk+HzxlZyGL3RTen++XZo
         Ca7A==
X-Gm-Message-State: AJcUukc3RYfnCi8DaaJhA0uv3x/spY1k392Is4oJcWzbde8LtTCDpILp
        kjRzUikYMYbGcNx+qHmaP8RNTVWs
X-Google-Smtp-Source: ALg8bN6HvFgP/a/8YJm84/+te/azPY1ZgQEi84glU9ixLH2Fvd5v6+PGTy6Qhhz2hzOoLBG5ITZ8jw==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr8293767pgf.240.1547634772868;
        Wed, 16 Jan 2019 02:32:52 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l5sm5752168pgp.82.2019.01.16.02.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:32:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Jan 2019 17:32:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, tsniatowski@vewd.com,
        Jonathan Nieder <jrnieder@gmail.com>, marcnarc@xiplink.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/10] submodule clone: use repo_config_set()
Date:   Wed, 16 Jan 2019 17:31:57 +0700
Message-Id: <20190116103159.9305-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190116103159.9305-1-pclouds@gmail.com>
References: <20190116103159.9305-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid direct access to $SUBMODULE/config and do it through
repo_config_set() instead. Note that repo_submodule_init() cannot be
used because this early in the submodule initialization process, we
may fail to get and parse .gitmodules with submodule_from_path().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/submodule--helper.c | 24 +++++++-----------------
 config.c                    | 10 ++++++++++
 config.h                    |  1 +
 repository.c                | 21 ++++++++++++++-------
 repository.h                |  4 ++++
 5 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 8943127ae7..b5d74cd415 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1366,11 +1366,11 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	const char *name = NULL, *url = NULL, *depth = NULL;
 	int quiet = 0;
 	int progress = 0;
-	char *p, *path = NULL, *sm_gitdir;
+	char *path = NULL, *sm_gitdir;
 	struct strbuf sb = STRBUF_INIT;
 	struct string_list reference = STRING_LIST_INIT_NODUP;
 	int dissociate = 0;
-	char *sm_alternate = NULL, *error_strategy = NULL;
+	struct repository subrepo;
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -1443,27 +1443,17 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
 
-	p = git_pathdup_submodule(path, "config");
-	if (!p)
-		die(_("could not get submodule directory for '%s'"), path);
+	if (repo_submodule_init_by_name(&subrepo, the_repository, path, name))
+		die(_("could not get a repository handle for submodule '%s'"), path);
 
 	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
-	git_config_get_string("submodule.alternateLocation", &sm_alternate);
-	if (sm_alternate)
-		git_config_set_in_file(p, "submodule.alternateLocation",
-					   sm_alternate);
-	git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
-	if (error_strategy)
-		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
-					   error_strategy);
-
-	free(sm_alternate);
-	free(error_strategy);
+	repo_config_copy(&subrepo, the_repository, "submodule.alternateLocation");
+	repo_config_copy(&subrepo, the_repository, "submodule.alternateErrorStrategy");
 
+	repo_clear(&subrepo);
 	strbuf_release(&sb);
 	free(sm_gitdir);
 	free(path);
-	free(p);
 	return 0;
 }
 
diff --git a/config.c b/config.c
index 151d28664e..007436b382 100644
--- a/config.c
+++ b/config.c
@@ -2157,6 +2157,16 @@ void repo_config_set(struct repository *r, const char *key, const char *value)
 		die(_("could not unset '%s'"), key);
 }
 
+void repo_config_copy(struct repository *dst, struct repository *src, const char *key)
+{
+	char *value = NULL;
+
+	repo_config_get_string(src, key, &value);
+	if (value)
+		repo_config_set(dst, key, value);
+	free(value);
+}
+
 int repo_config_set_worktree_gently(struct repository *r,
 				    const char *key, const char *value)
 {
diff --git a/config.h b/config.h
index 62204dc252..22edd96716 100644
--- a/config.h
+++ b/config.h
@@ -105,6 +105,7 @@ extern void git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set_gently(const char *, const char *);
 extern int repo_config_set_gently(struct repository *, const char *, const char *);
 extern void repo_config_set(struct repository *, const char *, const char *);
+extern void repo_config_copy(struct repository *dst, struct repository *src, const char *key);
 extern int repo_config_set_worktree_gently(struct repository *, const char *, const char *);
 extern void git_config_set(const char *, const char *);
 extern int git_config_parse_key(const char *, char **, int *);
diff --git a/repository.c b/repository.c
index 5dd1486718..f997bd1629 100644
--- a/repository.c
+++ b/repository.c
@@ -176,16 +176,23 @@ int repo_submodule_init(struct repository *submodule,
 			const char *path)
 {
 	const struct submodule *sub;
+
+	sub = submodule_from_path(superproject, &null_oid, path);
+	if (!sub)
+		return -1;
+	return repo_submodule_init_by_name(submodule, superproject,
+					   path, sub->name);
+}
+
+int repo_submodule_init_by_name(struct repository *submodule,
+				struct repository *superproject,
+				const char *path,
+				const char *name)
+{
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf worktree = STRBUF_INIT;
 	int ret = 0;
 
-	sub = submodule_from_path(superproject, &null_oid, path);
-	if (!sub) {
-		ret = -1;
-		goto out;
-	}
-
 	strbuf_repo_worktree_path(&gitdir, superproject, "%s/.git", path);
 	strbuf_repo_worktree_path(&worktree, superproject, "%s", path);
 
@@ -199,7 +206,7 @@ int repo_submodule_init(struct repository *submodule,
 		 */
 		strbuf_reset(&gitdir);
 		strbuf_repo_git_path(&gitdir, superproject,
-				     "modules/%s", sub->name);
+				     "modules/%s", name);
 
 		if (repo_init(submodule, gitdir.buf, NULL)) {
 			ret = -1;
diff --git a/repository.h b/repository.h
index 9f16c42c1e..d3f0592471 100644
--- a/repository.h
+++ b/repository.h
@@ -119,6 +119,10 @@ int repo_init(struct repository *r, const char *gitdir, const char *worktree);
 int repo_submodule_init(struct repository *submodule,
 			struct repository *superproject,
 			const char *path);
+int repo_submodule_init_by_name(struct repository *submodule,
+				struct repository *superproject,
+				const char *path,
+				const char *name);
 void repo_clear(struct repository *repo);
 
 /*
-- 
2.20.0.482.g66447595a7

