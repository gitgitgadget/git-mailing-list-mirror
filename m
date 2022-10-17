Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B75DC433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 02:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJQCXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiJQCX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 22:23:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A813ED5D
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk15so16377261wrb.13
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNgLLqtbOnMTt48SDCS+y+l4hNAduY13uCwvFG6xpqg=;
        b=qDSc6UTIfxtoaowCfJ+Ho9a0MP52XjbOuL4c4AKa6eF0mDXlBMHo+KuLYxfR6z0r5b
         PTbblFSicpHOcDk5lluQ/eOOVP6zX8emeEftBzPwABUZyz94RbxO3i3Ic8zduCaToWGg
         9ihJX9UgsD1PHkul6n1hjk5/4TKMLTod4fzWD7qsL6NSEAj6kC8bFcCJR+UVjltbeH+6
         W162QwNge7lVyy1ElQDifM6+eUCtK0NMHKsO45otLXTZBvvvqCr/WEj5h3q1rcwJlBGm
         t5NbiFULiQgKdocNah1LbFO2TKlZOQgUwLdT8HPfadDaRYg4FbucF2dj8C1WHpgQVSQx
         HwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNgLLqtbOnMTt48SDCS+y+l4hNAduY13uCwvFG6xpqg=;
        b=eQNJZUym8PCCGDtAM0hfUL69UgzMAogyDer3mQwcDmqvru42kJO4mNvCi5nQfaQeAr
         QqCeORRBkcA4LcMlnFy7mq08kxv9FBaDR/qRSMKw5S2pSQie35P9fMXyDuGgqUaFTP7d
         8VZ4r1EY5WNR2fgzoFSNIajhnOWQ01fnYGpeIr7AD5BzkLLa5Qh0Cd6QX3W9ga8C2+bq
         EHDFbydi758vhKfbX8G8g15Lt3dzbmgheMDSdzcyyILQU15ebCSbUYOptOdnrQZXvcVx
         4ymjP4Ke1doYDKRhGcrAyEZbHiL9oZLwCrQnlnXBLVVigVeLGBG/Fjl0SvnAashZ0mAM
         rjPA==
X-Gm-Message-State: ACrzQf3HNU94wEA9YBMF0KyfBICyD17svz7i/AuFyqnsyxC3Bl9Q6iSd
        GeTZXZAntNq8XX8zOaEont81yO/gUls=
X-Google-Smtp-Source: AMsMyM4l7Xx38sy9crUALmHg26DUZs7C7PAkzEROsHFKr0J79Zl7CxypDD5o8vGHTis030ZUJy/IHQ==
X-Received: by 2002:a5d:64c2:0:b0:22e:41b0:42ca with SMTP id f2-20020a5d64c2000000b0022e41b042camr4861007wri.411.1665973403839;
        Sun, 16 Oct 2022 19:23:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w16-20020adf8bd0000000b0022f40a2d06esm7387143wra.35.2022.10.16.19.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:23:23 -0700 (PDT)
Message-Id: <79959a54eb4c1a0812b1f4643530069a63e549f4.1665973401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
From:   "Alphadelta14 via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 02:23:13 +0000
Subject: [PATCH v3 1/9] tree: do not use the_repository for tree traversal
 methods.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>,
        Alphadelta14 <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alphadelta14 <alpha@alphaservcomputing.solutions>

Expect that tree walking may switch repository contexts for cases
such as submodules.
Added compatibility macros for existing cases.

Annotate an existing issue where repo is wrong when traversing.

Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
---
 tree.c | 15 +++++++++------
 tree.h | 14 ++++++++++----
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/tree.c b/tree.c
index 410e3b477e5..13f9173d45e 100644
--- a/tree.c
+++ b/tree.c
@@ -22,7 +22,7 @@ int read_tree_at(struct repository *r,
 	int len, oldlen = base->len;
 	enum interesting retval = entry_not_interesting;
 
-	if (parse_tree(tree))
+	if (repo_parse_tree(r, tree))
 		return -1;
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
@@ -58,7 +58,11 @@ int read_tree_at(struct repository *r,
 				    oid_to_hex(&entry.oid),
 				    base->buf, entry.path);
 
-			if (parse_commit(commit))
+			// FIXME: This is the wrong repo instance (it refers to the superproject)
+			// it will always fail as is (will fix in later patch)
+			// This current codepath isn't executed by any existing callbacks
+			// so it wouldn't show up as an issue at this time.
+			if (repo_parse_commit(r, commit))
 				die("Invalid commit %s in submodule path %s%s",
 				    oid_to_hex(&entry.oid),
 				    base->buf, entry.path);
@@ -121,7 +125,7 @@ int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 	return 0;
 }
 
-int parse_tree_gently(struct tree *item, int quiet_on_missing)
+int repo_parse_tree_gently(struct repository *r, struct tree *item, int quiet_on_missing)
 {
 	 enum object_type type;
 	 void *buffer;
@@ -129,7 +133,7 @@ int parse_tree_gently(struct tree *item, int quiet_on_missing)
 
 	if (item->object.parsed)
 		return 0;
-	buffer = read_object_file(&item->object.oid, &type, &size);
+	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
 	if (!buffer)
 		return quiet_on_missing ? -1 :
 			error("Could not read %s",
@@ -149,9 +153,8 @@ void free_tree_buffer(struct tree *tree)
 	tree->object.parsed = 0;
 }
 
-struct tree *parse_tree_indirect(const struct object_id *oid)
+struct tree *repo_parse_tree_indirect(struct repository *r, const struct object_id *oid)
 {
-	struct repository *r = the_repository;
 	struct object *obj = parse_object(r, oid);
 	return (struct tree *)repo_peel_to_type(r, NULL, 0, obj, OBJ_TREE);
 }
diff --git a/tree.h b/tree.h
index 6efff003e21..cc6402e4738 100644
--- a/tree.h
+++ b/tree.h
@@ -18,15 +18,21 @@ struct tree *lookup_tree(struct repository *r, const struct object_id *oid);
 
 int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
 
-int parse_tree_gently(struct tree *tree, int quiet_on_missing);
-static inline int parse_tree(struct tree *tree)
+int repo_parse_tree_gently(struct repository *r, struct tree *tree, int quiet_on_missing);
+static inline int repo_parse_tree(struct repository *r, struct tree *tree)
 {
-	return parse_tree_gently(tree, 0);
+	return repo_parse_tree_gently(r, tree, 0);
 }
+
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define parse_tree(tree) repo_parse_tree(the_repository, tree)
+#define parse_tree_gently(tree, quiet_on_missing) repo_parse_tree_gently(the_repository, tree, quiet_on_missing)
+#define parse_tree_indirect(oid) repo_parse_tree_indirect(the_repository, oid)
+#endif
 void free_tree_buffer(struct tree *tree);
 
 /* Parses and returns the tree in the given ent, chasing tags and commits. */
-struct tree *parse_tree_indirect(const struct object_id *oid);
+struct tree *repo_parse_tree_indirect(struct repository *r, const struct object_id *oid);
 
 int cmp_cache_name_compare(const void *a_, const void *b_);
 
-- 
gitgitgadget

