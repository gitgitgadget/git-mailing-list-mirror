Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6FF211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 02:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfALCOM (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 21:14:12 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:39966 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALCOL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 21:14:11 -0500
Received: by mail-pl1-f177.google.com with SMTP id u18so7562942plq.7
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 18:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BwYxy+GlnXK18dzhPFNNCSCr3y5mQbXN4uXCRuEWy6Y=;
        b=cM0bDq43f3bNDiPJD2V20L1lBo9Jvl9DSYy1+ZlSx7fse8tEZEuXl2Tjo9+mDSuYv3
         r/r5HbvzbPWdx9I++nhC0pJnVhmvjyJXQ0huaZy0X9HV1+xv4BUqm2kAy6EWp8lTrzxn
         6WePHir96wI6cMfUBrXDm7tQGOcfX3Sg/E2P0Bf/JenDmhOcsbCG6oUtR2WtJEjIa1ah
         +j+EmVHPjd5u8yxXD6dZ8RbU48T6HePsPsy6XCHXo4EP5GsOjg3xp/GwELLebCCEUHdT
         wgE8mz+QpaI0Haa8WefJe2pt765ga4d59gDaqMvC6djiMLnyvGAFAWPupW0A7VWgvFY4
         vqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BwYxy+GlnXK18dzhPFNNCSCr3y5mQbXN4uXCRuEWy6Y=;
        b=kDtuF9xC+nGSW8jNsCMF7Xjg2NvPeYjPpnWK91dp2hArHLdc1MDvGVjNzrm20XXd7b
         pC0f9f69hKNV9lt2xvcY291GcyJVLBQMJCJO3LvBxmuISCYgsb1zI9+E4XouoYXNnoiO
         HuliAJXYADOG2jcpDrhs61LVttveE2U+PNdLuSOIut8XuhVIP+Var19npnUnNyqCmk69
         g+X+bJkK4UKBxXIIF4GTXNn72QZuFk5GH7VPxOcBsHDnOx7X5wDOy9vmZ9xs2wI0eL/d
         hOHG2ivSPn4hBZgUpJ9AqNHSkKHDwGmN3j7YfCf5RYiSE5ADBhFbZzE2sbvCg7S7iTQw
         I1SQ==
X-Gm-Message-State: AJcUukc0VhbvkLoLojZ9WuMUtAUqQgQ4J5EMsJuhaqqpM7NzsdkO9l3h
        vOjSRAoOrUL/gMUKhe04hkZJxkBn
X-Google-Smtp-Source: ALg8bN7BmKhjY7h0UODcBuHa0rNvs6XKTMIi6XDGwb7HejLYPDzgL6HOT5tL8/uTX/KsL4/N4AZO4w==
X-Received: by 2002:a17:902:3124:: with SMTP id w33mr17100968plb.241.1547259250403;
        Fri, 11 Jan 2019 18:14:10 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id g6sm27232068pgq.18.2019.01.11.18.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 18:14:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Jan 2019 09:14:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 01/11] grep: use grep_opt->repo instead of explict repo argument
Date:   Sat, 12 Jan 2019 09:13:22 +0700
Message-Id: <20190112021332.11066-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190112021332.11066-1-pclouds@gmail.com>
References: <20190105055153.3256-1-pclouds@gmail.com>
 <20190112021332.11066-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command is probably the first one that operates on a repository
other than the_repository, in f9ee2fcdfa (grep: recurse in-process
using 'struct repository' - 2017-08-02). An explicit 'struct
repository *' was added in that commit to pass around the repository
that we're supposed to grep from.

Since 38bbc2ea39 (grep.c: remove implicit dependency on the_index -
2018-09-21). 'struct grep_opt *' carries in itself a repository
parameter for grepping. We should now be able to reuse grep_opt to
hold the submodule repo instead of a separate argument, which is just
room for mistakes.

While at there, use the right reference instead of the_repository and
the_index in this code. I was a bit careless in my attempt to kick
the_repository / the_index out of library code. It's normally safe to
just stick the_repository / the_index in bultin/ code, but it's not
the case for grep.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index bad9c0a3d5..0cc671f7d6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -393,18 +393,20 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 		exit(status);
 }
 
-static int grep_cache(struct grep_opt *opt, struct repository *repo,
+static int grep_cache(struct grep_opt *opt,
 		      const struct pathspec *pathspec, int cached);
 static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
-		     int check_attr, struct repository *repo);
+		     int check_attr);
 
-static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
+static int grep_submodule(struct grep_opt *opt,
 			  const struct pathspec *pathspec,
 			  const struct object_id *oid,
 			  const char *filename, const char *path)
 {
+	struct repository *superproject = opt->repo;
 	struct repository submodule;
+	struct grep_opt subopt;
 	int hit;
 
 	/*
@@ -440,6 +442,9 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 	add_to_alternates_memory(submodule.objects->odb->path);
 	grep_read_unlock();
 
+	memcpy(&subopt, opt, sizeof(subopt));
+	subopt.repo = &submodule;
+
 	if (oid) {
 		struct object *object;
 		struct tree_desc tree;
@@ -461,21 +466,22 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
 		strbuf_addch(&base, '/');
 
 		init_tree_desc(&tree, data, size);
-		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
-				object->type == OBJ_COMMIT, &submodule);
+		hit = grep_tree(&subopt, pathspec, &tree, &base, base.len,
+				object->type == OBJ_COMMIT);
 		strbuf_release(&base);
 		free(data);
 	} else {
-		hit = grep_cache(opt, &submodule, pathspec, 1);
+		hit = grep_cache(&subopt, pathspec, 1);
 	}
 
 	repo_clear(&submodule);
 	return hit;
 }
 
-static int grep_cache(struct grep_opt *opt, struct repository *repo,
+static int grep_cache(struct grep_opt *opt,
 		      const struct pathspec *pathspec, int cached)
 {
+	struct repository *repo = opt->repo;
 	int hit = 0;
 	int nr;
 	struct strbuf name = STRBUF_INIT;
@@ -513,7 +519,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 			}
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
 			   submodule_path_match(repo->index, pathspec, name.buf, NULL)) {
-			hit |= grep_submodule(opt, repo, pathspec, NULL, ce->name, ce->name);
+			hit |= grep_submodule(opt, pathspec, NULL, ce->name, ce->name);
 		} else {
 			continue;
 		}
@@ -535,8 +541,9 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 
 static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 		     struct tree_desc *tree, struct strbuf *base, int tn_len,
-		     int check_attr, struct repository *repo)
+		     int check_attr)
 {
+	struct repository *repo = opt->repo;
 	int hit = 0;
 	enum interesting match = entry_not_interesting;
 	struct name_entry entry;
@@ -582,10 +589,10 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			strbuf_addch(base, '/');
 			init_tree_desc(&sub, data, size);
 			hit |= grep_tree(opt, pathspec, &sub, base, tn_len,
-					 check_attr, repo);
+					 check_attr);
 			free(data);
 		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
-			hit |= grep_submodule(opt, repo, pathspec, entry.oid,
+			hit |= grep_submodule(opt, pathspec, entry.oid,
 					      base->buf, base->buf + tn_len);
 		}
 
@@ -627,7 +634,7 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		}
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
-				obj->type == OBJ_COMMIT, the_repository);
+				obj->type == OBJ_COMMIT);
 		strbuf_release(&base);
 		free(data);
 		return hit;
@@ -644,12 +651,12 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
-		real_obj = deref_tag(the_repository, list->objects[i].item,
+		real_obj = deref_tag(opt->repo, list->objects[i].item,
 				     NULL, 0);
 
 		/* load the gitmodules file for this rev */
 		if (recurse_submodules) {
-			submodule_free(the_repository);
+			submodule_free(opt->repo);
 			gitmodules_config_oid(&real_obj->oid);
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,
@@ -674,9 +681,9 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 	if (exc_std)
 		setup_standard_excludes(&dir);
 
-	fill_directory(&dir, &the_index, pathspec);
+	fill_directory(&dir, opt->repo->index, pathspec);
 	for (i = 0; i < dir.nr; i++) {
-		if (!dir_path_match(&the_index, dir.entries[i], pathspec, 0, NULL))
+		if (!dir_path_match(opt->repo->index, dir.entries[i], pathspec, 0, NULL))
 			continue;
 		hit |= grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
@@ -1117,7 +1124,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (!cached)
 			setup_work_tree();
 
-		hit = grep_cache(&opt, the_repository, &pathspec, cached);
+		hit = grep_cache(&opt, &pathspec, cached);
 	} else {
 		if (cached)
 			die(_("both --cached and trees are given"));
-- 
2.20.0.482.g66447595a7

