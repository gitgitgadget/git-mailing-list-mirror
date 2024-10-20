Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57585193425
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431824; cv=none; b=kgaJ/SlI0/RL+3BPrIKzaVckV+aGSraEUhHuNL+HgkWTO9Q2qMXLmKYuelxEZJ/QI6nrTWnoyUDSWfU+fEq1A1YoZBaKun53s1/WAZA/DHRBZPLM/Cqahp4a12ssIOljehgeUt+Ud9VG4ayr80gd59upM1Ew4MX98ffFQDMNw4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431824; c=relaxed/simple;
	bh=2TGFiYtSK8HMIyaeTOuSKRp7mrxIpYUI6kNIC0slwik=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XOL6AC5f4LeLjpM1WmDewFyMXL84xavRagrG1ghiQ+ElFwoplLSQOvE9Ejpz+VtGZDzyOpN7OdqW1RivNkaEbpOP0iWP+Lx+HIKHRfgvvqvYUVsbKx98x/d+v5zz/MmXJgasLmw41wNxx8BmpF0+ZtHtC0JO8XR8QA3hWxqRhtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWqcM3vg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWqcM3vg"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso564583766b.1
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431820; x=1730036620; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErhD4OZv4Hk6HVtHqwAGvW2Wpwsef5/Cu//ACnqDeKs=;
        b=dWqcM3vgGkDhWIwJia7oCwyuAKZEaOpLzX5jFqk5PL00D4Z+3VI/WgZgifxIfr0X1B
         Bppzfivb2uLyuu3gmgxlkrWfiR+GAWWIERqfF21eDRUtrPgoT3gud+Ub4rYP5bxzA5vJ
         oJg10q4qhmHhHggcYyl4dDGKSneu5IAgHZoXGeQF8bpSCW17wocv1Cynydbfdkganr06
         7s8l9aN5JpHuUBjnDJwZdUqCfHI9IoqEMl/hCzY+VFBuUSJ8nrH5+yQVppL2ZfPlOMCJ
         wqRWOWg8L3FGAXcPLguWKd00Jya1K8N9EualwFr6dTYeLPgVqovCCKHhwInCBQduU7Rn
         CAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431820; x=1730036620;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErhD4OZv4Hk6HVtHqwAGvW2Wpwsef5/Cu//ACnqDeKs=;
        b=VvGsQshQFNQziX5RP+z5r/0HSSrueV2ZvFgNyy6rteAbcIk2MlV6+PZrm7TTw/0CtW
         Nk78QEBUtf62j+JoqvNQ19eL1jnETsh6PfwmFPIgAKO8YPXBxAxiYCuIj7zB5K/KW4wC
         Bo/EPG3O8q4OvbEAa8srpRmUXqaslldq7kK4TrkrD7ioRezI8OiDwvQC8ywPgnmBr6Ed
         bdmw0UIj06uRtlT7fnEO2arjrw/Iboca8Z53YGlIunIwE8+rBf4+PKW7YbK3y3MPGQMZ
         tKG1c6dp14P//FI5Zry4pY647wbWK1SuUtqZNWcQPR7jcqluOc0/3gV+9RWznfv2DUFd
         Ez9w==
X-Gm-Message-State: AOJu0Yx7Qg8lHP5j8rhw+JZPX4G1nVhxXPgP2PATWVyDkmi+ciqeApMj
	ETyH7ng8rGKbvP7m5oA9CxyZlii8HF0p1Dik4RQZf2fc1QWxW7aGj0zsbw==
X-Google-Smtp-Source: AGHT+IFydtJ/WSzrSYuA66iUNyKCcBzQUPV7NGsSh4wHE3fK2d7UZ9uOdklyy+1NkMORy3wpVn9JBQ==
X-Received: by 2002:a17:907:6d03:b0:a9a:5cf8:9e40 with SMTP id a640c23a62f3a-a9a69a79c26mr616640766b.24.1729431820031;
        Sun, 20 Oct 2024 06:43:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a915a46fbsm91056766b.215.2024.10.20.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:39 -0700 (PDT)
Message-Id: <238d7d95715d3e161489a5ef8d788c0cac4f7a03.1729431810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:19 +0000
Subject: [PATCH v2 06/17] path-walk: add prune_all_uninteresting option
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This option causes the path-walk API to act like the sparse tree-walk
algorithm implemented by mark_trees_uninteresting_sparse() in
list-objects.c.

Starting from the commits marked as UNINTERESTING, their root trees and
all objects reachable from those trees are UNINTERSTING, at least as we
walk path-by-path. When we reach a path where all objects associated
with that path are marked UNINTERESTING, then do no continue walking the
children of that path.

We need to be careful to pass the UNINTERESTING flag in a deep way on
the UNINTERESTING objects before we start the path-walk, or else the
depth-first search for the path-walk API may accidentally report some
objects as interesting.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |  8 +++
 path-walk.c                               | 64 ++++++++++++++++++++++-
 path-walk.h                               |  8 +++
 t/helper/test-path-walk.c                 | 10 +++-
 t/t6601-path-walk.sh                      | 40 +++++++++++---
 5 files changed, 118 insertions(+), 12 deletions(-)

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index 5fea1d1db17..c51f92cd649 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -57,6 +57,14 @@ commits are emitted.
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
index 55758f50abd..910dfc6fdc9 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -22,6 +22,7 @@ struct type_and_oid_list
 {
 	enum object_type type;
 	struct oid_array oids;
+	int maybe_interesting;
 };
 
 #define TYPE_AND_OID_LIST_INIT { \
@@ -124,6 +125,8 @@ static int add_children(struct path_walk_context *ctx,
 			strmap_put(&ctx->paths_to_lists, path.buf, list);
 			string_list_append(&ctx->path_stack, path.buf);
 		}
+		if (!(o->flags & UNINTERESTING))
+			list->maybe_interesting = 1;
 		oid_array_append(&list->oids, &entry.oid);
 	}
 
@@ -145,6 +148,40 @@ static int walk_path(struct path_walk_context *ctx,
 
 	list = strmap_get(&ctx->paths_to_lists, path);
 
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
+			} else {
+				struct blob *b = lookup_blob(ctx->repo,
+							     &list->oids.oid[i]);
+				if (b && !(b->object.flags & UNINTERESTING))
+					list->maybe_interesting = 1;
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
 	    (list->type == OBJ_BLOB && ctx->info->blobs))
@@ -187,7 +224,7 @@ static void clear_strmap(struct strmap *map)
 int walk_objects_by_path(struct path_walk_info *info)
 {
 	const char *root_path = "";
-	int ret = 0;
+	int ret = 0, has_uninteresting = 0;
 	size_t commits_nr = 0, paths_nr = 0;
 	struct commit *c;
 	struct type_and_oid_list *root_tree_list;
@@ -199,6 +236,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 		.path_stack = STRING_LIST_INIT_DUP,
 		.paths_to_lists = STRMAP_INIT
 	};
+	struct oidset root_tree_set = OIDSET_INIT;
 
 	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
 
@@ -211,6 +249,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
+	root_tree_list->maybe_interesting = 1;
 	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
 
 	/*
@@ -306,10 +345,16 @@ int walk_objects_by_path(struct path_walk_info *info)
 		t = lookup_tree(info->revs->repo, oid);
 
 		if (t) {
+			if ((c->object.flags & UNINTERESTING)) {
+				t->object.flags |= UNINTERESTING;
+				has_uninteresting = 1;
+			}
+
 			if (t->object.flags & SEEN)
 				continue;
 			t->object.flags |= SEEN;
-			oid_array_append(&root_tree_list->oids, oid);
+			if (!oidset_insert(&root_tree_set, oid))
+				oid_array_append(&root_tree_list->oids, oid);
 		} else {
 			warning("could not find tree %s", oid_to_hex(oid));
 		}
@@ -325,6 +370,21 @@ int walk_objects_by_path(struct path_walk_info *info)
 	oid_array_clear(&commit_list->oids);
 	free(commit_list);
 
+	/*
+	 * Before performing a DFS of our paths and emitting them as interesting,
+	 * do a full walk of the trees to distribute the UNINTERESTING bit. Use
+	 * the sparse algorithm if prune_all_uninteresting was set.
+	 */
+	if (has_uninteresting) {
+		trace2_region_enter("path-walk", "uninteresting-walk", info->revs->repo);
+		if (info->prune_all_uninteresting)
+			mark_trees_uninteresting_sparse(ctx.repo, &root_tree_set);
+		else
+			mark_trees_uninteresting_dense(ctx.repo, &root_tree_set);
+		trace2_region_leave("path-walk", "uninteresting-walk", info->revs->repo);
+	}
+	oidset_clear(&root_tree_set);
+
 	string_list_append(&ctx.path_stack, root_path);
 
 	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
diff --git a/path-walk.h b/path-walk.h
index 3f3b63180ef..3e44c4b8a58 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -38,6 +38,14 @@ struct path_walk_info {
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
index c6c60d68749..06b103d8760 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -55,8 +55,12 @@ static int emit_block(const char *path, struct oid_array *oids,
 		BUG("we do not understand this type");
 	}
 
-	for (size_t i = 0; i < oids->nr; i++)
-		printf("%s:%s:%s\n", typestr, path, oid_to_hex(&oids->oid[i]));
+	for (size_t i = 0; i < oids->nr; i++) {
+		struct object *o = lookup_unknown_object(the_repository,
+							 &oids->oid[i]);
+		printf("%s:%s:%s%s\n", typestr, path, oid_to_hex(&oids->oid[i]),
+		       o->flags & UNINTERESTING ? ":UNINTERESTING" : "");
+	}
 
 	return 0;
 }
@@ -76,6 +80,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of tag objects")),
 		OPT_BOOL(0, "trees", &info.trees,
 			 N_("toggle inclusion of tree objects")),
+		OPT_BOOL(0, "prune", &info.prune_all_uninteresting,
+			 N_("toggle pruning of uninteresting paths")),
 		OPT_END(),
 	};
 
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 7758e2529ee..943adc6c8f1 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -229,19 +229,19 @@ test_expect_success 'topic, not base, boundary' '
 
 	cat >expect <<-EOF &&
 	COMMIT::$(git rev-parse topic)
-	COMMIT::$(git rev-parse base~1)
+	COMMIT::$(git rev-parse base~1):UNINTERESTING
 	commits:2
 	TREE::$(git rev-parse topic^{tree})
-	TREE::$(git rev-parse base~1^{tree})
-	TREE:left/:$(git rev-parse base~1:left)
+	TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
+	TREE:left/:$(git rev-parse base~1:left):UNINTERESTING
 	TREE:right/:$(git rev-parse topic:right)
-	TREE:right/:$(git rev-parse base~1:right)
+	TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
 	trees:5
-	BLOB:a:$(git rev-parse base~1:a)
-	BLOB:left/b:$(git rev-parse base~1:left/b)
-	BLOB:right/c:$(git rev-parse base~1:right/c)
+	BLOB:a:$(git rev-parse base~1:a):UNINTERESTING
+	BLOB:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
+	BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
 	BLOB:right/c:$(git rev-parse topic:right/c)
-	BLOB:right/d:$(git rev-parse base~1:right/d)
+	BLOB:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
 	blobs:5
 	tags:0
 	EOF
@@ -252,6 +252,30 @@ test_expect_success 'topic, not base, boundary' '
 	test_cmp expect.sorted out.sorted
 '
 
+test_expect_success 'topic, not base, boundary with pruning' '
+	test-tool path-walk --prune -- --boundary topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	COMMIT::$(git rev-parse topic)
+	COMMIT::$(git rev-parse base~1):UNINTERESTING
+	commits:2
+	TREE::$(git rev-parse topic^{tree})
+	TREE::$(git rev-parse base~1^{tree}):UNINTERESTING
+	TREE:right/:$(git rev-parse topic:right)
+	TREE:right/:$(git rev-parse base~1:right):UNINTERESTING
+	trees:4
+	BLOB:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
+	BLOB:right/c:$(git rev-parse topic:right/c)
+	blobs:2
+	tags:0
+	EOF
+
+	sort expect >expect.sorted &&
+	sort out >out.sorted &&
+
+	test_cmp expect.sorted out.sorted
+'
+
 test_expect_success 'trees are reported exactly once' '
 	test_when_finished "rm -rf unique-trees" &&
 	test_create_repo unique-trees &&
-- 
gitgitgadget

