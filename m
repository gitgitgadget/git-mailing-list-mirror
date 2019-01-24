Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621DA1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfAXI33 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:29:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36729 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfAXI31 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:29:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so2357892pgm.3
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NdEd9S/HV0Xwe4Lbkro60RhBSGmJNOcnyaB0/5ohaHk=;
        b=NmbCU9ve9xVN9yl9m3A/x/hCvSlFjHKdGP5PnoR+Qi7oPqEbtVqpIUhSJ1fdcTYy4f
         Zfmrm7ATVnMfog4FkYdon/1KGQvBpZGZEBPpgQ4+a9X9NG7jxkI+kVpXVSCRsdnmTczm
         uxP488ZGXpszc3m8zqoaJ6c7abJmEzgLik+C9SSSWE7dvlHZmONicTng6XP6BksnoLjp
         wNwe3ANhyiZqPxjUco7Rw2vGwY81ZEyBubSf9hV/b9pg2l0SjVYru7wVP1/cojZ83i3Y
         slTNrJn2zrK0eGY2ppHHyJwuh6akRgBSFe4EXTHlx0hClgOL0QijrxkwHbfujhK4EnMe
         G4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NdEd9S/HV0Xwe4Lbkro60RhBSGmJNOcnyaB0/5ohaHk=;
        b=jtcsXEvjLfa0OZvMyInqAdqdsZK6FP1schfvAvx7HSo+jWAUDZ97Huck2zRfryowef
         SdImggpJIFHxR/hHyTYcod/+Czkfuzm0znNIX3hs78bdDOaFng9VSAE14khDUVpcctgZ
         OHSUYbLtIJh7ML8nqy8K9ku/8rcWBO3EZoae0UIf4zErPoXr2LokrAfZ18jhuTTTALAr
         WMoM9Owyo30zqPYT1gQ3E6pBv9acev16UR6OCNImDaQPZIBFKwIB8g5+yiDbzrfyK3Fi
         a8fpNf83Nx3lGFmzcPGwc0WLCCJfCr/Ig5OmEXOhCRKPdTvI5uqtewm5906z2pHkEVBk
         QgCg==
X-Gm-Message-State: AJcUukdVpJS8+vHZwg8uNFtL7a3sQZU8RY3VnNUouvK5QolZm61sFGHh
        ZBmM/1Ue9z5BuUlVty5asW9BqPiIXqo=
X-Google-Smtp-Source: ALg8bN5Y9vKO/PAwNBGTnd+6gJtVqKeQvSl6hgnNLc3atDMb2nB0ekBjmKpKizmVHDIp1CB0H6vjJQ==
X-Received: by 2002:a62:5e41:: with SMTP id s62mr5494245pfb.232.1548318566513;
        Thu, 24 Jan 2019 00:29:26 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id g28sm33610082pfd.100.2019.01.24.00.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:29:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 24 Jan 2019 15:29:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/11] grep: use grep_opt->repo instead of explict repo argument
Date:   Thu, 24 Jan 2019 15:29:02 +0700
Message-Id: <20190124082912.24401-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190124082912.24401-1-pclouds@gmail.com>
References: <20190124082912.24401-1-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.20.1.560.g70ca8b83ee

