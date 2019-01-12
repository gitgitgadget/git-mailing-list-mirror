Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A645211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 02:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfALCOv (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 21:14:51 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:40968 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALCOv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 21:14:51 -0500
Received: by mail-pf1-f177.google.com with SMTP id b7so7776225pfi.8
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 18:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EyU4r0D/yCIH/YrCLzxkJmgXc9r/G/nr0JWi4cER1DY=;
        b=RYfNZXMl1Z/aoF9Mf0flBL/3wSRZCC2uztXDSEd72XR7s63i3yjSnYrAnbIpbqn3ZR
         vs6keKjWc8jtDkc9LXMLFI6ONOkjM0ImrWzQ404fmKyLUKvv3SejrR6s3bbPbcF6tLiQ
         QoRmisI1Ya/E7ICrS+8ApJUaQUuL/UZuHQjN3znep+qil73VGI8G3aqQOFOq8bvlJZJW
         BDJbj6t/tPc9fQg+eRpkhTtNtjjjxyikjuGZlOiobh7E59Vs3Kn6JgTOGx/nIJ5IZI98
         TdP4ySsu7mWHB+5EkumqmF52BO7xsfH/Lgd7/+MJ5XQ6BVpNvJFDtcZylzyGYZ47Hq84
         xjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EyU4r0D/yCIH/YrCLzxkJmgXc9r/G/nr0JWi4cER1DY=;
        b=BxOwhW7DpxdEHBA/N50Ans09nni7oJvzPYrYlJMTI76b2GhY/7EgFU8fbAzJ/WNIoH
         XKgQbG5UcVQOBDj194G7cQA3cXC6ASg7R15JCEvhpwmIMg/1swWPmPvZj4b8bGFoSsB5
         P7yCPYl/tYU+bA3ouOt/V9zJ4weyjXRh+5P2JmWH5/30rm2935WjeWP84kfWGahWrURd
         Co4u2wD82JN+DrC88HoDv1shk88VTkTFe3thDaKmfnnXgTO2/t/pbTT1dqaQS4LCrRqR
         33C4INT1RLujXMbcuFKR1lZN3CzdUi9ClxxMrLNEHAkN+n6SaTJBKBxKfwaydZ9wURad
         YYLQ==
X-Gm-Message-State: AJcUukdUtLLRUbR+IgRrlqJAFAelHc1blE1+U3H2qyaEL/2FjZg/gEl6
        w+kMYiv2geMX9eoHLFi9bmYdd8p0
X-Google-Smtp-Source: ALg8bN6lLYlgKKglesbE1juk6ngu6uZp0HTpSH6MhptzHwI2dYNN7AcCFH/gkkHohnqsFAxumlCKew==
X-Received: by 2002:a62:2a4b:: with SMTP id q72mr16611278pfq.61.1547259289741;
        Fri, 11 Jan 2019 18:14:49 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id q5sm135329455pfi.165.2019.01.11.18.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 18:14:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Jan 2019 09:14:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 09/11] merge-recursive.c: remove implicit dependency on the_repository
Date:   Sat, 12 Jan 2019 09:13:30 +0700
Message-Id: <20190112021332.11066-10-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 merge-recursive.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 28f44c73ec..a596d95739 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -146,7 +146,8 @@ static int err(struct merge_options *o, const char *err, ...)
 	return -1;
 }
 
-static struct tree *shift_tree_object(struct tree *one, struct tree *two,
+static struct tree *shift_tree_object(struct repository *repo,
+				      struct tree *one, struct tree *two,
 				      const char *subtree_shift)
 {
 	struct object_id shifted;
@@ -159,12 +160,14 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two,
 	}
 	if (oideq(&two->object.oid, &shifted))
 		return two;
-	return lookup_tree(the_repository, &shifted);
+	return lookup_tree(repo, &shifted);
 }
 
-static struct commit *make_virtual_commit(struct tree *tree, const char *comment)
+static struct commit *make_virtual_commit(struct repository *repo,
+					  struct tree *tree,
+					  const char *comment)
 {
-	struct commit *commit = alloc_commit_node(the_repository);
+	struct commit *commit = alloc_commit_node(repo);
 
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
 	commit->maybe_tree = tree;
@@ -445,7 +448,7 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		return NULL;
 	}
 
-	result = lookup_tree(the_repository, &istate->cache_tree->oid);
+	result = lookup_tree(o->repo, &istate->cache_tree->oid);
 
 	return result;
 }
@@ -1208,9 +1211,9 @@ static int merge_submodule(struct merge_options *o,
 		return 0;
 	}
 
-	if (!(commit_base = lookup_commit_reference(the_repository, base)) ||
-	    !(commit_a = lookup_commit_reference(the_repository, a)) ||
-	    !(commit_b = lookup_commit_reference(the_repository, b))) {
+	if (!(commit_base = lookup_commit_reference(o->repo, base)) ||
+	    !(commit_a = lookup_commit_reference(o->repo, a)) ||
+	    !(commit_b = lookup_commit_reference(o->repo, b))) {
 		output(o, 1, _("Failed to merge submodule %s (commits not present)"), path);
 		return 0;
 	}
@@ -3416,8 +3419,8 @@ int merge_trees(struct merge_options *o,
 	}
 
 	if (o->subtree_shift) {
-		merge = shift_tree_object(head, merge, o->subtree_shift);
-		common = shift_tree_object(head, common, o->subtree_shift);
+		merge = shift_tree_object(o->repo, head, merge, o->subtree_shift);
+		common = shift_tree_object(o->repo, head, common, o->subtree_shift);
 	}
 
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
@@ -3553,8 +3556,8 @@ int merge_recursive(struct merge_options *o,
 		/* if there is no common ancestor, use an empty tree */
 		struct tree *tree;
 
-		tree = lookup_tree(the_repository, the_repository->hash_algo->empty_tree);
-		merged_common_ancestors = make_virtual_commit(tree, "ancestor");
+		tree = lookup_tree(o->repo, o->repo->hash_algo->empty_tree);
+		merged_common_ancestors = make_virtual_commit(o->repo, tree, "ancestor");
 	}
 
 	for (iter = ca; iter; iter = iter->next) {
@@ -3598,7 +3601,7 @@ int merge_recursive(struct merge_options *o,
 	}
 
 	if (o->call_depth) {
-		*result = make_virtual_commit(mrtree, "merged tree");
+		*result = make_virtual_commit(o->repo, mrtree, "merged tree");
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
@@ -3611,17 +3614,17 @@ int merge_recursive(struct merge_options *o,
 	return clean;
 }
 
-static struct commit *get_ref(const struct object_id *oid, const char *name)
+static struct commit *get_ref(struct repository *repo, const struct object_id *oid,
+			      const char *name)
 {
 	struct object *object;
 
-	object = deref_tag(the_repository, parse_object(the_repository, oid),
-			   name,
-			   strlen(name));
+	object = deref_tag(repo, parse_object(repo, oid),
+			   name, strlen(name));
 	if (!object)
 		return NULL;
 	if (object->type == OBJ_TREE)
-		return make_virtual_commit((struct tree*)object, name);
+		return make_virtual_commit(repo, (struct tree*)object, name);
 	if (object->type != OBJ_COMMIT)
 		return NULL;
 	if (parse_commit((struct commit *)object))
@@ -3638,15 +3641,15 @@ int merge_recursive_generic(struct merge_options *o,
 {
 	int clean;
 	struct lock_file lock = LOCK_INIT;
-	struct commit *head_commit = get_ref(head, o->branch1);
-	struct commit *next_commit = get_ref(merge, o->branch2);
+	struct commit *head_commit = get_ref(o->repo, head, o->branch1);
+	struct commit *next_commit = get_ref(o->repo, merge, o->branch2);
 	struct commit_list *ca = NULL;
 
 	if (base_list) {
 		int i;
 		for (i = 0; i < num_base_list; ++i) {
 			struct commit *base;
-			if (!(base = get_ref(base_list[i], oid_to_hex(base_list[i]))))
+			if (!(base = get_ref(o->repo, base_list[i], oid_to_hex(base_list[i]))))
 				return err(o, _("Could not parse object '%s'"),
 					   oid_to_hex(base_list[i]));
 			commit_list_insert(base, &ca);
-- 
2.20.0.482.g66447595a7

