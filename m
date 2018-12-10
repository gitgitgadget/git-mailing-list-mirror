Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D07520A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 16:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeLJQms (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 11:42:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46053 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeLJQmr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 11:42:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so5194851pgc.12
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 08:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HLU2sMPjr+h9ck0+QsfZ4PYzXtuVrsJ6tRe5Lt0qbFk=;
        b=V80G8e3bFB1zqUk9vm80Bt8pM5Yr7kS5reJnLnNPwIV4MUVl24HLVCr/6OM4NI9UPG
         N9MWICMI5hz8OCGkBtIwysXdC8EcGM/k2DAZmPPat7lnzOI/wzA1XCWXz1+XzvivY/po
         +AGpJjEjK9GPFwLI7LzUlXK4Xmzj25I2CLeVOQMClj6FHCqHBJUErtO+i2wXOjVHSnuG
         Jf58JVOxtF9lkX62vWmss1bd7p0LjlLQJB7TEGH0b2whvEWI8XeD/uZ0rwml7y497Qif
         9xqgYQyxo8zuZrEa5GfnRxJk4+uTca3RjINPVauG2A1wgwSgElr210YPJ4JhKimJG1Of
         QTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HLU2sMPjr+h9ck0+QsfZ4PYzXtuVrsJ6tRe5Lt0qbFk=;
        b=kBe4Z1VjKsYTbk2eijEBqn9LuWp0ZC56ddpCAD15qcS2/9hPYDda5mff5zduGRx6ZC
         tt+zs6gxE0A3nDuS/aa/uhmqDC7kZ2UtXPPTgYUSi6BVIGW8fSQe0ZRy/bOQjGhtR866
         x3iuWFELhNqf8xi3SglWUmpYeaMlnKu5xQpgDVFQbDexAINaAx+agmFgpZZ+ZF0yZoep
         k39QOmsjakss75STNx9C9/A4Gl9UqqZqerAHOxSHbhG16E4g/WN+RZcH/TI3CdP1prwX
         gcJYjc39n076hebaLPv3HEOXQpbVQAi+KdkOGZZ5ZhbC/5ZkVuTfrNfZL9UTknSh1yCF
         35kQ==
X-Gm-Message-State: AA+aEWZ2Y57lDMGB/heeTvvYNSA22J5JLM1ot9c/0nV18WmO5qbNilY1
        40Mg5fCfqmmAbvRAVQAKjaz0BLD7
X-Google-Smtp-Source: AFSGD/V/ixur0lkZWlIli5+mBZCKOXLNExiCtLCrVjOGd0iJ/SWrNDK8T2qrxrCV2BGnyjcCIiiWxQ==
X-Received: by 2002:a63:20e:: with SMTP id 14mr11406289pgc.161.1544460166147;
        Mon, 10 Dec 2018 08:42:46 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id e24sm15661827pfi.153.2018.12.10.08.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:42:45 -0800 (PST)
Date:   Mon, 10 Dec 2018 08:42:45 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 16:42:36 GMT
Message-Id: <571b2e278439531b92ea6b80cb812ec0d176a8d4.1544460159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v3.git.gitgitgadget@gmail.com>
References: <pull.89.v2.git.gitgitgadget@gmail.com>
        <pull.89.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 4/6] revision: implement sparse algorithm
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
trees and blobs are uninteresting. Finally, we walk trees to find
the interesting trees.

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
recursion unless the oidset contains some intersting trees and
some uninteresting trees. Technically, we only need one interesting
tree for this to speed up in most cases, but we also will not mark
anything UNINTERESTING if there are no uninteresting trees, so
that would be wasted effort.

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
 revision.c                     | 116 ++++++++++++++++++++++++++++++---
 t/t5322-pack-objects-sparse.sh |  21 ++++--
 2 files changed, 121 insertions(+), 16 deletions(-)

diff --git a/revision.c b/revision.c
index f9eb6400f1..971f1bb095 100644
--- a/revision.c
+++ b/revision.c
@@ -99,29 +99,125 @@ void mark_tree_uninteresting(struct repository *r, struct tree *tree)
 	mark_tree_contents_uninteresting(r, tree);
 }
 
+struct paths_and_oids {
+	struct string_list list;
+};
+
+static void paths_and_oids_init(struct paths_and_oids *po)
+{
+	string_list_init(&po->list, 1);
+}
+
+static void paths_and_oids_clear(struct paths_and_oids *po)
+{
+	int i;
+	for (i = 0; i < po->list.nr; i++) {
+		oidset_clear(po->list.items[i].util);
+		free(po->list.items[i].util);
+	}
+
+	string_list_clear(&po->list, 0);
+}
+
+static void paths_and_oids_insert(struct paths_and_oids *po,
+				  const char *path,
+				  const struct object_id *oid)
+{
+	struct string_list_item *item = string_list_insert(&po->list, path);
+	struct oidset *set;
+
+	if (!item->util) {
+		set = xcalloc(1, sizeof(struct oidset));
+		oidset_init(set, 16);
+		item->util = set;
+	} else {
+		set = item->util;
+	}
+
+	oidset_insert(set, oid);
+}
+
+static void add_children_by_path(struct repository *r,
+				 struct tree *tree,
+				 struct paths_and_oids *po)
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
+			paths_and_oids_insert(po, entry.path, entry.oid);
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
+	int i;
+	unsigned has_interesting = 0, has_uninteresting = 0;
+	struct paths_and_oids po;
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
 	}
+
+	/* Do not walk unless we have both types of trees. */
+	if (!has_uninteresting || !has_interesting)
+		return;
+
+	paths_and_oids_init(&po);
+
+	oidset_iter_init(set, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		struct tree *tree = lookup_tree(r, oid);
+		add_children_by_path(r, tree, &po);
+	}
+
+	for (i = 0; i < po.list.nr; i++)
+		mark_trees_uninteresting_sparse(
+			r, (struct oidset *)po.list.items[i].util);
+
+	paths_and_oids_clear(&po);
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

