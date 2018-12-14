Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2AA20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbeLNVWY (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:22:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40365 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbeLNVWX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:22:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so3403622pfo.7
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 13:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K5EnuxTbaCE+DcxcIotmd3VrL5kQ7fi6/F2tU/ROO10=;
        b=oVk7y8V1ni0RaECsAW2nf927/CfjRC+2VzJgf18OvDOa8eKj+yzdLQfVDY3EHxvvPH
         vBQshndVumRzz2lP5UAQxgTQOQMb+n3OiaIYe1q3z60fuwVVLgX2tHgUapTLtF67WPsb
         +0c9DJ6AzTXUtIYSylx8B7mC91qhoSLUOZWPX4bXXLU57SX5ZPAbgbnqjAUmullVfLgB
         HwdTPESHuyVoG1rYHzlglShy2C/LaBZES89j7WAwycu8h5k2YsAOvUGViJP7UwSw6hoR
         CCMU1s/PejZGW/hbPpdkl5EOTVN0pdZgyexPjk6bvcZlh9IHqFUFER+ZATZDgyucBURG
         XqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K5EnuxTbaCE+DcxcIotmd3VrL5kQ7fi6/F2tU/ROO10=;
        b=doEOOWIidDwYjfis1i9DPhwSpMMLXb5favP3xjQjAgtFpl9vYPY9hMPwO4fbvZqWAm
         3fzgYyqai4wFsVXu0RAh2yDFaCTrtcCChT5m+6OMXbKhPNxl2nQIOb3bbvWfo49i1ACa
         40vOAXXOzl9/cr+EolIr1pzsB6Y6JsNkMQnSSO4k8nrCL5UXsq9hAgktTCOFU6Ta8zrh
         xOLMFfwyoJcK8RGw5G7nz/dDkJ2hTsGWpMWtpTCOCIxwIFmIny1Nkvkcrza7IbMnc93q
         UGlIlAR9oxtJfbIrF1wji5htlq0FLPXne2E1aIB2DJjhPgtgsIILlwfayytF4IMylY8W
         KyNQ==
X-Gm-Message-State: AA+aEWa4LFZLlnrLvcelOUs0Cju8TGRvUE8/yVycXU6Vc6XIkcEKpfYT
        PiqFxia4VjlWQOfKJNSYiQFjJUXe
X-Google-Smtp-Source: AFSGD/WSm+eE9Z2VW7tllIvXrp421zLkvz0oAK2Awavuvxt+MGDBGxHAyQhGhr4HDuHD6iDjoa7UFA==
X-Received: by 2002:aa7:868f:: with SMTP id d15mr4238025pfo.225.1544822541665;
        Fri, 14 Dec 2018 13:22:21 -0800 (PST)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id k14sm9011356pgs.52.2018.12.14.13.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 13:22:21 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:22:21 -0800 (PST)
X-Google-Original-Date: Fri, 14 Dec 2018 21:22:10 GMT
Message-Id: <c44172c35ece7aafec02c7f3c8438ccca4f69023.1544822533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v4.git.gitgitgadget@gmail.com>
References: <pull.89.v3.git.gitgitgadget@gmail.com>
        <pull.89.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 4/6] revision: implement sparse algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When enumerating objects to place in a pack-file during 'git
pack-objects --revs', we discover the "frontier" of commits
that we care about and the boundary with commit we find
uninteresting. From that point, we walk trees to discover which
trees and blobs are uninteresting. Finally, we walk trees from the
interesting commits to find the interesting objects that are
placed in the pack.

This commit introduces a new, "sparse" way to discover the
uninteresting trees. We use the perspective of a single user trying
to push their topic to a large repository. That user likely changed
a very small fraction of the paths in their working directory, but
we spend a lot of time walking all reachable trees.

The way to switch the logic to work in this sparse way is to start
caring about which paths introduce new trees. While it is not
possible to generate a diff between the frontier boundary and all
of the interesting commits, we can simulate that behavior by
inspecting all of the root trees as a whole, then recursing down
to the set of trees at each path.

We already had taken the first step by passing an oidset to
mark_trees_uninteresting_sparse(). We now create a dictionary
whose keys are paths and values are oidsets. We consider the set
of trees that appear at each path. While we inspect a tree, we
add its subtrees to the oidsets corresponding to the tree entry's
path. We also mark trees as UNINTERESTING if the tree we are
parsing is UNINTERESTING.

To actually improve the peformance, we need to terminate our
recursion. If the oidset contains only UNINTERESTING trees, then
we do not continue the recursion. This avoids walking trees that
are likely to not be reachable from interesting trees. If the
oidset contains only interesting trees, then we will walk these
trees in the final stage that collects the intersting objects to
place in the pack. Thus, we only recurse if the oidset contains
both interesting and UNINITERESTING trees.

There are a few ways that this is not a universally better option.

First, we can pack extra objects. If someone copies a subtree
from one tree to another, the first tree will appear UNINTERESTING
and we will not recurse to see that the subtree should also be
UNINTERESTING. We will walk the new tree and see the subtree as
a "new" object and add it to the pack. We add a test case that
demonstrates this as a way to prove that the --sparse option is
actually working.

Second, we can have extra memory pressure. If instead of being a
single user pushing a small topic we are a server sending new
objects from across the entire working directory, then we will
gain very little (the recursion will rarely terminate early) but
will spend extra time maintaining the path-oidset dictionaries.

Despite these potential drawbacks, the benefits of the algorithm
are clear. By adding a counter to 'add_children_by_path' and
'mark_tree_contents_uninteresting', I measured the number of
parsed trees for the two algorithms in a variety of repos.

For git.git, I used the following input:

	v2.19.0
	^v2.19.0~10

 Objects to pack: 550
Walked (old alg): 282
Walked (new alg): 130

For the Linux repo, I used the following input:

	v4.18
	^v4.18~10

 Objects to pack:   518
Walked (old alg): 4,836
Walked (new alg):   188

The two repos above are rather "wide and flat" compared to
other repos that I have used in the past. As a comparison,
I tested an old topic branch in the Azure DevOps repo, which
has a much deeper folder structure than the Linux repo.

 Objects to pack:    220
Walked (old alg): 22,804
Walked (new alg):    129

I used the number of walked trees the main metric above because
it is consistent across multiple runs. When I ran my tests, the
performance of the pack-objects command with the same options
could change the end-to-end time by 10x depending on the file
system being warm. However, by repeating the same test on repeat
I could get more consistent timing results. The git.git and
Linux tests were too fast overall (less than 0.5s) to measure
an end-to-end difference. The Azure DevOps case was slow enough
to see the time improve from 15s to 1s in the warm case. The
cold case was 90s to 9s in my testing.

These improvements will have even larger benefits in the super-
large Windows repository. In our experiments, we see the
"Enumerate objects" phase of pack-objects taking 60-80% of the
end-to-end time of non-trivial pushes, taking longer than the
network time to send the pack and the server time to verify the
pack.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c                     | 139 ++++++++++++++++++++++++++++++---
 t/t5322-pack-objects-sparse.sh |  21 +++--
 2 files changed, 144 insertions(+), 16 deletions(-)

diff --git a/revision.c b/revision.c
index f9eb6400f1..63bf6230dc 100644
--- a/revision.c
+++ b/revision.c
@@ -27,6 +27,7 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "prio-queue.h"
+#include "hashmap.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -99,29 +100,147 @@ void mark_tree_uninteresting(struct repository *r, struct tree *tree)
 	mark_tree_contents_uninteresting(r, tree);
 }
 
+struct path_and_oids_entry {
+	struct hashmap_entry ent;
+	char *path;
+	struct oidset set;
+};
+
+static int path_and_oids_cmp(const void *hashmap_cmp_fn_data,
+			     const struct path_and_oids_entry *e1,
+			     const struct path_and_oids_entry *e2,
+			     const void *keydata)
+{
+	return strcmp(e1->path, e2->path);
+}
+
+int map_flags = 0;
+static void paths_and_oids_init(struct hashmap *map)
+{
+	hashmap_init(map, (hashmap_cmp_fn) path_and_oids_cmp, &map_flags, 0);
+}
+
+static void paths_and_oids_clear(struct hashmap *map)
+{
+	struct hashmap_iter iter;
+	struct path_and_oids_entry *entry;
+	hashmap_iter_init(map, &iter);
+
+	while ((entry = (struct path_and_oids_entry *)hashmap_iter_next(&iter))) {
+		oidset_clear(&entry->set);
+		free(entry->path);
+	}
+
+	hashmap_free(map, 1);
+}
+
+static void paths_and_oids_insert(struct hashmap *map,
+				  const char *path,
+				  const struct object_id *oid)
+{
+	int hash = strhash(path);
+	struct path_and_oids_entry key;
+	struct path_and_oids_entry *entry;
+
+	hashmap_entry_init(&key, hash);
+	key.path = xstrdup(path);
+	oidset_init(&key.set, 0);
+
+	if (!(entry = (struct path_and_oids_entry *)hashmap_get(map, &key, NULL))) {
+		entry = xcalloc(1, sizeof(struct path_and_oids_entry));
+		hashmap_entry_init(entry, hash);
+		entry->path = key.path;
+		oidset_init(&entry->set, 16);
+		hashmap_put(map, entry);
+	} else {
+		free(key.path);
+	}
+
+	oidset_insert(&entry->set, oid);
+}
+
+static void add_children_by_path(struct repository *r,
+				 struct tree *tree,
+				 struct hashmap *map)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+
+	if (!tree)
+		return;
+
+	if (parse_tree_gently(tree, 1) < 0)
+		return;
+
+	init_tree_desc(&desc, tree->buffer, tree->size);
+	while (tree_entry(&desc, &entry)) {
+		switch (object_type(entry.mode)) {
+		case OBJ_TREE:
+			paths_and_oids_insert(map, entry.path, entry.oid);
+
+			if (tree->object.flags & UNINTERESTING) {
+				struct tree *child = lookup_tree(r, entry.oid);
+				if (child)
+					child->object.flags |= UNINTERESTING;
+			}
+			break;
+		case OBJ_BLOB:
+			if (tree->object.flags & UNINTERESTING) {
+				struct blob *child = lookup_blob(r, entry.oid);
+				if (child)
+					child->object.flags |= UNINTERESTING;
+			}
+			break;
+		default:
+			/* Subproject commit - not in this repository */
+			break;
+		}
+	}
+
+	free_tree_buffer(tree);
+}
+
 void mark_trees_uninteresting_sparse(struct repository *r,
 				     struct oidset *set)
 {
+	unsigned has_interesting = 0, has_uninteresting = 0;
+	struct hashmap map;
+	struct hashmap_iter map_iter;
+	struct path_and_oids_entry *entry;
 	struct object_id *oid;
 	struct oidset_iter iter;
 
 	oidset_iter_init(set, &iter);
-	while ((oid = oidset_iter_next(&iter))) {
+	while ((!has_interesting || !has_uninteresting) &&
+	       (oid = oidset_iter_next(&iter))) {
 		struct tree *tree = lookup_tree(r, oid);
 
 		if (!tree)
 			continue;
 
-		if (tree->object.flags & UNINTERESTING) {
-			/*
-			 * Remove the flag so the next call
-			 * is not a no-op. The flag is added
-			 * in mark_tree_unintersting().
-			 */
-			tree->object.flags ^= UNINTERESTING;
-			mark_tree_uninteresting(r, tree);
-		}
+		if (tree->object.flags & UNINTERESTING)
+			has_uninteresting = 1;
+		else
+			has_interesting = 1;
+	}
+
+	/* Do not walk unless we have both types of trees. */
+	if (!has_uninteresting || !has_interesting)
+		return;
+
+	paths_and_oids_init(&map);
+
+	oidset_iter_init(set, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct tree *tree = lookup_tree(r, oid);
+		add_children_by_path(r, tree, &map);
 	}
+
+	hashmap_iter_init(&map, &map_iter);
+	while ((entry = hashmap_iter_next(&map_iter)))
+		mark_trees_uninteresting_sparse(r, &entry->set);
+
+	paths_and_oids_clear(&map);
 }
 
 struct commit_stack {
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 81f6805bc3..45dba6e014 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -83,22 +83,25 @@ test_expect_success 'sparse pack-objects' '
 	test_cmp expect_objects.txt sparse_objects.txt
 '
 
+# Demonstrate that the algorithms differ when we copy a tree wholesale
+# from one folder to another.
+
 test_expect_success 'duplicate a folder from f1 into f3' '
 	mkdir f3/f4 &&
 	cp -r f1/f1/* f3/f4 &&
 	git add f3/f4 &&
 	git commit -m "Copied f1/f1 to f3/f4" &&
-	cat >packinput.txt <<-EOF &&
+	cat >packinput.txt <<-EOF
 	topic1
 	^topic1~1
 	EOF
-	git rev-parse		\
-		topic1		\
-		topic1^{tree}	\
-		topic1:f3 | sort >expect_objects.txt
 '
 
 test_expect_success 'non-sparse pack-objects' '
+	git rev-parse			\
+		topic1			\
+		topic1^{tree}		\
+		topic1:f3 | sort >expect_objects.txt &&
 	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
 	git index-pack -o nonsparse.idx nonsparse.pack &&
 	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
@@ -106,10 +109,16 @@ test_expect_success 'non-sparse pack-objects' '
 '
 
 test_expect_success 'sparse pack-objects' '
+	git rev-parse			\
+		topic1			\
+		topic1^{tree}		\
+		topic1:f3		\
+		topic1:f3/f4		\
+		topic1:f3/f4/data.txt | sort >expect_sparse_objects.txt &&
 	git pack-objects --stdout --revs --sparse <packinput.txt >sparse.pack &&
 	git index-pack -o sparse.idx sparse.pack &&
 	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
-	test_cmp expect_objects.txt sparse_objects.txt
+	test_cmp expect_sparse_objects.txt sparse_objects.txt
 '
 
 test_done
-- 
gitgitgadget

