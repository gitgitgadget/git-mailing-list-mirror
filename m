Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE721A452
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711690; cv=none; b=PYTW3IJsAeG6vhmLuql54IT554tvYN6EJYjQBHjNL4bH/XG9ROT4ag2JspIlwj0YAoMbrMHbsZYxYFschCKHoI98xq7xEG6si3zMR8uS5ZpZbTmZWpQx1Sva8kX3EeOzf4WTnArB6+/7BXNXB47arhA9lPGGuBQR98qcehAj9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711690; c=relaxed/simple;
	bh=GjsMXug+vIKde5hYP3Aia2ahlM3KoOml5oSaOXSnZPU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FUF64FG3SHT8pRyJmlitg82oSSk6fFvN24ksjyoEHtafUNYcRH99FAlEGVQunRk1QsRa5PQJ97YgQVrNwdX8q5ETalZvwM1qE/7nAEaD19HOvmOW+uMbgBZT/Dem4SkvKpVJ3DdbxvvnHynqOo3xbUfE6UgswtfghUoelkaFy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8u53kqB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8u53kqB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43626213fffso20188705e9.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734711686; x=1735316486; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTBSN1N3JtKb/Zgwqcq+umgISBS8Bt5EJwykvrKBjQM=;
        b=k8u53kqBSLPmIpoFEFSOGPQzGGfwrZpGbPc1XN9CRQ9oL54wha3vvLhJDTF7HajH5V
         MU/1CioC9xq1fpYnsfQB5jMQNca9Pp6NQmqvH4aahY2GHy8yXhYxIoF+rwVns7aBuxgS
         SJWf2v5kvylVNX799/mvchSNNGxVFLClg05kSUsIMB2WYiv+2TmEcTH4e6fodCWWgSf9
         FSjeU2mg4nhpLxr7XOahdNFHhphZhba8MSPPAJ7az45YFRdEWITCNcOUd0xalwmquQix
         /zJi+0USZTentMlWcLyL/q29QD6x1OMzNIVXEJtq2acybVRqmacoVzUA4ezXfvF7+WUF
         Qpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734711686; x=1735316486;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTBSN1N3JtKb/Zgwqcq+umgISBS8Bt5EJwykvrKBjQM=;
        b=bdH+DVNJHZfiU8oS8j2fgr6DuSCLvwcUO1JkKoLXi6iuugL/ROBTCauNCa9S63eikK
         nVmlyrM4XHJgXyftNgjVQP/YY/rI+/N9H+tz8yWR1NuvgIVvF7xxAP0o/Jj2oIfn8uOe
         l50Q6QDbF//RTwtzkKzRgZV7wPBEO6GMpD2MepYJ3gyWhecyTRn0S0uMwTQWWCOFfGpr
         Rzkbe7hQk1aaPj8t43dhr1USLXoK8TXhzhmW2p2HjlcI+VnhpG2l/d9Yc4/kBPl63DRU
         Turu8viQpy3kcJJiayTif9GA07bq2vLvSgMGFgRsGdh3PtK5B07Jewz0G+FxBONDWNy1
         l57A==
X-Gm-Message-State: AOJu0YxfxioWNwsI/xnA1B02LCiprakx80+s2Xzjo4SLG6ivOf8T5uui
	Tb9rkX2kF+7z4aQ83hXvXex130No2yenj9WTeE+o+dg2j9vYj+GyIrR2yQ==
X-Gm-Gg: ASbGncve+96U1nCgPdMdeYnzx1bq6AzjXWqnZPgS3KHgWpqSBfyAonlY68n5klL02uT
	my3ySTu13msxZHDqNjN2FCTE42rk9GVND7bavdZcYu14L8nJVN8SaQwv8kbJsdtrf+PrRxk3EcO
	dWtFJDJQ3XujUo2DdzITSiOh1FkfJWsGQAVeAvIzWZeSr2dqIaECeeS7VTIBcpp1m3DZqhvTTgr
	tlZhbvZLRhlYE66DVGRhEodwmXJl322RQ8Qfx5mvfwwGP6alkfMlJoocw==
X-Google-Smtp-Source: AGHT+IGbLLli8O9WhKB2+cZGt2SZBC+UtPHoiur2tY/iZKu1QAIT3QM+1qxnEV7AiG4PmwGfvWM+xw==
X-Received: by 2002:a5d:64cc:0:b0:386:42b1:d7e4 with SMTP id ffacd0b85a97d-38a1a264ae2mr7494202f8f.19.1734711685653;
        Fri, 20 Dec 2024 08:21:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a2432e587sm1485637f8f.95.2024.12.20.08.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:21:25 -0800 (PST)
Message-Id: <f2ffc32a3033549420fb9e3a902cce1cc739440e.1734711676.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>
References: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
	<pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 16:21:14 +0000
Subject: [PATCH v4 6/7] path-walk: mark trees and blobs as UNINTERESTING
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When the input rev_info has UNINTERESTING starting points, we want to be
sure that the UNINTERESTING flag is passed appropriately through the
objects. To match how this is done in places such as 'git pack-objects', we
use the mark_edges_uninteresting() method.

This method has an option for using the "sparse" walk, which is similar in
spirit to the path-walk API's walk. To be sure to keep it independent, add a
new 'prune_all_uninteresting' option to the path_walk_info struct.

To check how the UNINTERSTING flag is spread through our objects, extend the
'test-tool path-walk' command to output whether or not an object has that
flag. This changes our tests significantly, including the removal of some
objects that were previously visited due to the incomplete implementation.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |  8 +++
 path-walk.c                               | 74 +++++++++++++++++++++
 path-walk.h                               |  8 +++
 t/helper/test-path-walk.c                 | 12 +++-
 t/t6601-path-walk.sh                      | 79 +++++++++++++++++------
 5 files changed, 159 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index 6022c381b7c..7075d0d5ab5 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -48,6 +48,14 @@ commits.
 While it is possible to walk only commits in this way, consumers would be
 better off using the revision walk API instead.
 
+`prune_all_uninteresting`::
+	By default, all reachable paths are emitted by the path-walk API.
+	This option allows consumers to declare that they are not
+	interested in paths where all included objects are marked with the
+	`UNINTERESTING` flag. This requires using the `boundary` option in
+	the revision walk so that the walk emits commits marked with the
+	`UNINTERESTING` flag.
+
 Examples
 --------
 
diff --git a/path-walk.c b/path-walk.c
index f34dbf61de0..4013569e9e4 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -8,6 +8,7 @@
 #include "dir.h"
 #include "hashmap.h"
 #include "hex.h"
+#include "list-objects.h"
 #include "object.h"
 #include "oid-array.h"
 #include "revision.h"
@@ -23,6 +24,7 @@ static const char *root_path = "";
 struct type_and_oid_list {
 	enum object_type type;
 	struct oid_array oids;
+	int maybe_interesting;
 };
 
 #define TYPE_AND_OID_LIST_INIT { \
@@ -142,6 +144,10 @@ static int add_tree_entries(struct path_walk_context *ctx,
 			strmap_put(&ctx->paths_to_lists, path.buf, list);
 		}
 		push_to_stack(ctx, path.buf);
+
+		if (!(o->flags & UNINTERESTING))
+			list->maybe_interesting = 1;
+
 		oid_array_append(&list->oids, &entry.oid);
 	}
 
@@ -169,6 +175,43 @@ static int walk_path(struct path_walk_context *ctx,
 	if (!list->oids.nr)
 		return 0;
 
+	if (ctx->info->prune_all_uninteresting) {
+		/*
+		 * This is true if all objects were UNINTERESTING
+		 * when added to the list.
+		 */
+		if (!list->maybe_interesting)
+			return 0;
+
+		/*
+		 * But it's still possible that the objects were set
+		 * as UNINTERESTING after being added. Do a quick check.
+		 */
+		list->maybe_interesting = 0;
+		for (size_t i = 0;
+		     !list->maybe_interesting && i < list->oids.nr;
+		     i++) {
+			if (list->type == OBJ_TREE) {
+				struct tree *t = lookup_tree(ctx->repo,
+							     &list->oids.oid[i]);
+				if (t && !(t->object.flags & UNINTERESTING))
+					list->maybe_interesting = 1;
+			} else if (list->type == OBJ_BLOB) {
+				struct blob *b = lookup_blob(ctx->repo,
+							     &list->oids.oid[i]);
+				if (b && !(b->object.flags & UNINTERESTING))
+					list->maybe_interesting = 1;
+			} else {
+				/* Tags are always interesting if visited. */
+				list->maybe_interesting = 1;
+			}
+		}
+
+		/* We have confirmed that all objects are UNINTERESTING. */
+		if (!list->maybe_interesting)
+			return 0;
+	}
+
 	/* Evaluate function pointer on this data, if requested. */
 	if ((list->type == OBJ_TREE && ctx->info->trees) ||
 	    (list->type == OBJ_BLOB && ctx->info->blobs) ||
@@ -203,6 +246,26 @@ static void clear_paths_to_lists(struct strmap *map)
 	strmap_init(map);
 }
 
+static struct repository *edge_repo;
+static struct type_and_oid_list *edge_tree_list;
+
+static void show_edge(struct commit *commit)
+{
+	struct tree *t = repo_get_commit_tree(edge_repo, commit);
+
+	if (!t)
+		return;
+
+	if (commit->object.flags & UNINTERESTING)
+		t->object.flags |= UNINTERESTING;
+
+	if (t->object.flags & SEEN)
+		return;
+	t->object.flags |= SEEN;
+
+	oid_array_append(&edge_tree_list->oids, &t->object.oid);
+}
+
 static int setup_pending_objects(struct path_walk_info *info,
 				 struct path_walk_context *ctx)
 {
@@ -314,6 +377,7 @@ static int setup_pending_objects(struct path_walk_info *info,
 		if (tagged_blobs->oids.nr) {
 			const char *tagged_blob_path = "/tagged-blobs";
 			tagged_blobs->type = OBJ_BLOB;
+			tagged_blobs->maybe_interesting = 1;
 			push_to_stack(ctx, tagged_blob_path);
 			strmap_put(&ctx->paths_to_lists, tagged_blob_path, tagged_blobs);
 		} else {
@@ -325,6 +389,7 @@ static int setup_pending_objects(struct path_walk_info *info,
 		if (tags->oids.nr) {
 			const char *tag_path = "/tags";
 			tags->type = OBJ_TAG;
+			tags->maybe_interesting = 1;
 			push_to_stack(ctx, tag_path);
 			strmap_put(&ctx->paths_to_lists, tag_path, tags);
 		} else {
@@ -369,6 +434,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
+	root_tree_list->maybe_interesting = 1;
 	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
 	push_to_stack(&ctx, root_path);
 
@@ -382,6 +448,14 @@ int walk_objects_by_path(struct path_walk_info *info)
 	if (prepare_revision_walk(info->revs))
 		die(_("failed to setup revision walk"));
 
+	/* Walk trees to mark them as UNINTERESTING. */
+	edge_repo = info->revs->repo;
+	edge_tree_list = root_tree_list;
+	mark_edges_uninteresting(info->revs, show_edge,
+				 info->prune_all_uninteresting);
+	edge_repo = NULL;
+	edge_tree_list = NULL;
+
 	info->revs->blob_objects = info->revs->tree_objects = 0;
 
 	trace2_region_enter("path-walk", "pending-walk", info->revs->repo);
diff --git a/path-walk.h b/path-walk.h
index 3679fa7a859..414d6db23c2 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -40,6 +40,14 @@ struct path_walk_info {
 	int trees;
 	int blobs;
 	int tags;
+
+	/**
+	 * When 'prune_all_uninteresting' is set and a path has all objects
+	 * marked as UNINTERESTING, then the path-walk will not visit those
+	 * objects. It will not call path_fn on those objects and will not
+	 * walk the children of such trees.
+	 */
+	int prune_all_uninteresting;
 };
 
 #define PATH_WALK_INFO_INIT {   \
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index 56289859e69..7f2d409c5bc 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -50,10 +50,14 @@ static int emit_block(const char *path, struct oid_array *oids,
 		printf("%"PRIuMAX":%s:%s:EMPTY\n",
 		       tdata->batch_nr, typestr, path);
 
-	for (size_t i = 0; i < oids->nr; i++)
-		printf("%"PRIuMAX":%s:%s:%s\n",
+	for (size_t i = 0; i < oids->nr; i++) {
+		struct object *o = lookup_unknown_object(the_repository,
+							 &oids->oid[i]);
+		printf("%"PRIuMAX":%s:%s:%s%s\n",
 		       tdata->batch_nr, typestr, path,
-		       oid_to_hex(&oids->oid[i]));
+		       oid_to_hex(&oids->oid[i]),
+		       o->flags & UNINTERESTING ? ":UNINTERESTING" : "");
+	}
 
 	tdata->batch_nr++;
 	return 0;
@@ -74,6 +78,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of tag objects")),
 		OPT_BOOL(0, "trees", &info.trees,
 			 N_("toggle inclusion of tree objects")),
+		OPT_BOOL(0, "prune", &info.prune_all_uninteresting,
+			 N_("toggle pruning of uninteresting paths")),
 		OPT_END(),
 	};
 
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 1f3d2e0cb76..a317cdf289e 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -211,11 +211,11 @@ test_expect_success 'topic, not base' '
 	0:commit::$(git rev-parse topic)
 	1:tree::$(git rev-parse topic^{tree})
 	2:tree:right/:$(git rev-parse topic:right)
-	3:blob:right/d:$(git rev-parse topic:right/d)
+	3:blob:right/d:$(git rev-parse topic:right/d):UNINTERESTING
 	4:blob:right/c:$(git rev-parse topic:right/c)
-	5:tree:left/:$(git rev-parse topic:left)
-	6:blob:left/b:$(git rev-parse topic:left/b)
-	7:blob:a:$(git rev-parse topic:a)
+	5:tree:left/:$(git rev-parse topic:left):UNINTERESTING
+	6:blob:left/b:$(git rev-parse topic:left/b):UNINTERESTING
+	7:blob:a:$(git rev-parse topic:a):UNINTERESTING
 	blobs:4
 	commits:1
 	tags:0
@@ -225,15 +225,38 @@ test_expect_success 'topic, not base' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'fourth, blob-tag2, not base' '
+	test-tool path-walk -- fourth blob-tag2 --not base >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	1:tag:/tags:$(git rev-parse fourth)
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:tree::$(git rev-parse topic^{tree})
+	4:tree:right/:$(git rev-parse topic:right)
+	5:blob:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
+	6:blob:right/c:$(git rev-parse topic:right/c)
+	7:tree:left/:$(git rev-parse base~1:left):UNINTERESTING
+	8:blob:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
+	9:blob:a:$(git rev-parse base~1:a):UNINTERESTING
+	blobs:5
+	commits:1
+	tags:1
+	trees:3
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'topic, not base, only blobs' '
 	test-tool path-walk --no-trees --no-commits \
 		-- topic --not base >out &&
 
 	cat >expect <<-EOF &&
-	0:blob:right/d:$(git rev-parse topic:right/d)
+	0:blob:right/d:$(git rev-parse topic:right/d):UNINTERESTING
 	1:blob:right/c:$(git rev-parse topic:right/c)
-	2:blob:left/b:$(git rev-parse topic:left/b)
-	3:blob:a:$(git rev-parse topic:a)
+	2:blob:left/b:$(git rev-parse topic:left/b):UNINTERESTING
+	3:blob:a:$(git rev-parse topic:a):UNINTERESTING
 	blobs:4
 	commits:0
 	tags:0
@@ -267,7 +290,7 @@ test_expect_success 'topic, not base, only trees' '
 	cat >expect <<-EOF &&
 	0:tree::$(git rev-parse topic^{tree})
 	1:tree:right/:$(git rev-parse topic:right)
-	2:tree:left/:$(git rev-parse topic:left)
+	2:tree:left/:$(git rev-parse topic:left):UNINTERESTING
 	commits:0
 	blobs:0
 	tags:0
@@ -282,17 +305,17 @@ test_expect_success 'topic, not base, boundary' '
 
 	cat >expect <<-EOF &&
 	0:commit::$(git rev-parse topic)
-	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~1):UNINTERESTING
 	1:tree::$(git rev-parse topic^{tree})
-	1:tree::$(git rev-parse base~1^{tree})
+	1:tree::$(git rev-parse base~1^{tree}):UNINTERESTING
 	2:tree:right/:$(git rev-parse topic:right)
-	2:tree:right/:$(git rev-parse base~1:right)
-	3:blob:right/d:$(git rev-parse base~1:right/d)
-	4:blob:right/c:$(git rev-parse base~1:right/c)
+	2:tree:right/:$(git rev-parse base~1:right):UNINTERESTING
+	3:blob:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
+	4:blob:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
 	4:blob:right/c:$(git rev-parse topic:right/c)
-	5:tree:left/:$(git rev-parse base~1:left)
-	6:blob:left/b:$(git rev-parse base~1:left/b)
-	7:blob:a:$(git rev-parse base~1:a)
+	5:tree:left/:$(git rev-parse base~1:left):UNINTERESTING
+	6:blob:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
+	7:blob:a:$(git rev-parse base~1:a):UNINTERESTING
 	blobs:5
 	commits:2
 	tags:0
@@ -302,6 +325,27 @@ test_expect_success 'topic, not base, boundary' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'topic, not base, boundary with pruning' '
+	test-tool path-walk --prune -- --boundary topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base~1):UNINTERESTING
+	1:tree::$(git rev-parse topic^{tree})
+	1:tree::$(git rev-parse base~1^{tree}):UNINTERESTING
+	2:tree:right/:$(git rev-parse topic:right)
+	2:tree:right/:$(git rev-parse base~1:right):UNINTERESTING
+	3:blob:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
+	3:blob:right/c:$(git rev-parse topic:right/c)
+	blobs:2
+	commits:2
+	tags:0
+	trees:4
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'trees are reported exactly once' '
 	test_when_finished "rm -rf unique-trees" &&
 	test_create_repo unique-trees &&
@@ -309,15 +353,12 @@ test_expect_success 'trees are reported exactly once' '
 		cd unique-trees &&
 		mkdir initial &&
 		test_commit initial/file &&
-
 		git switch -c move-to-top &&
 		git mv initial/file.t ./ &&
 		test_tick &&
 		git commit -m moved &&
-
 		git update-ref refs/heads/other HEAD
 	) &&
-
 	test-tool -C unique-trees path-walk -- --all >out &&
 	tree=$(git -C unique-trees rev-parse HEAD:) &&
 	grep "$tree" out >out-filtered &&
-- 
gitgitgadget

