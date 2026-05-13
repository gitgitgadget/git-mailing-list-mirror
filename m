Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835983AEB37
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707156; cv=none; b=YvRl1QBjZy7Ewf4Rg68iu4QHgHBymYqkRt3saBHtdNu9YGhtEkauLOM705pk3uaOzEviTcBZDea1qgUWZultDsccq+MtFIa21gF6fYqWfRLKOwORmckQkBC4QLLkBDSMirPclKQaGLR8q4JyPIPxso353wKFJmtkmtyPYYrqMho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707156; c=relaxed/simple;
	bh=OznUi/jRSDq9KLvDCDSab3qEnc9PITC6fcCEBy3tczU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I6VMWQdGKiyTGASO74magtzhdiblml58MDEjTfDnGg1fXeqbzVyyHkBuX6LL71C0BKCZ4+nKCfkNEJnGnyJkF2irqVCyiwjG+qHbjzsoPgaxzjy+FAho/viwKOd8y1c8YzxiFVMlN9CiNAm57wV3qPycP2pGY1brGL/WspNosYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPh80Lwk; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPh80Lwk"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so17346559eec.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707153; x=1779311953; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzdJL1vhGI1xSmre1xbrExkVoSKcFiwzTW0HZrmJF0Y=;
        b=iPh80LwkBjXl+1Z95Gxzp8mZutFi59hzrKORQkAiihDXnc7Dbr2T7xnUOUqYtD7kjs
         J7SDTIFE8dyconYgBARAgTk/j5Hd5M6ufQQj700XoGiczcN+hWCJ45GV5rVJw+wA04MF
         SLARw+LSOLfmepm99eXEuJBOYmviLm4w98FjmEyAUzLX9NkP//Qi+DMECttfhPa5SZde
         HbteVykQp7wnp+uVksoO7uj8r8VCzgQ7RsPVnqYllNX+FpyXO2KbQ2uq6VYGiTUrekLY
         21Fr+ILPCOVPcYQ8ipqspf4DfvkD1KSjmVXx2AJv5zvxG79GamwriFMUpUwJoXLSwSia
         0Tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707153; x=1779311953;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qzdJL1vhGI1xSmre1xbrExkVoSKcFiwzTW0HZrmJF0Y=;
        b=KW8q6QF4vxYkEAlV3CUsdhj5GfAajUw2U2st7uz4xZo9Z7QFl+UD3ApLXWPEzKyAUx
         zYeEJZa2Ip6P5kkq2jEu1gM0m1x6Ktx5Q1yOODcRXdhXdSxo8+XD7q9tto9MPaB+cqjq
         Il9Ob5VBs+1bf1Z1fUHO8dkbdhmwTvO8YTNv4bIodqUEgBJnpT9Su1eDUDWNVuQZlyTi
         sEwzJEm3IjjcFGaJLePeTqFhriawmajN6ajX7e/icgFjQOuhl6LNWJKl8vqyuCHr+haZ
         7rfxekABDm5iwlXdvn2wWo/smuqUeWBTNdVyWiqhro96VICdLAXA3DDHN+Qu0HLpKFFb
         54wg==
X-Gm-Message-State: AOJu0YxlDMYSmyIuJAOXIm0gJ3OWgTiL4ezyul+c/XCfiFoDCDZ78Cft
	TgUKgeibWJLCC7LB+QGUTHQ6w8ZZ99oOhuHZDk0hLarWXWmW9KIZCaHgsmQUk30C
X-Gm-Gg: Acq92OF0rqleTQ/4iXa8BiC1NpyNIK/rF8MgcEGQz2BqDCDim+ZlBsh3/eSRkJBN8x3
	SEige9NnVwQUPmmAoQlPjPJ806Xiumr5PMoispCG2gj/8N5BP4yr/+W4vBMaozpnVypmGexpQGg
	oWhMEfWkrxLehC97bdjObyoqkR8VtZfHtN1QMUCvxKgLOQaTXOcJRIlvWsEIJJChp+QaQrhPRWd
	vSkn75Pk1ckrmP1wol7oveqgoPgwugJHQd9yIYQE/ElPrQkydknNdEeHGIR6qqOaOClAUuI2EDe
	Y5ri7G6F58PGLi9tye/ZiSlLEs5lW4/385LWVZKZBZ02ilByjpyhHdgzxwffn1Rr/IDypjS3wvO
	Iw2wtKChT6vkLjLW7hnLL2aqoplkPO2Dn9jeCWDhQwfnMB2C3QEcYbkIowypolBI2z5YbH4jIvR
	+M2azT2D6Qv6RXOiq2RH9501OklyNxU0MIehEE4X7franWFhQ=
X-Received: by 2002:a05:7300:e105:b0:2f6:811e:c840 with SMTP id 5a478bee46e88-30118daa1f4mr3252489eec.18.1778707152706;
        Wed, 13 May 2026 14:19:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e3c0sm644310eec.3.2026.05.13.14.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:19:12 -0700 (PDT)
Message-Id: <b4dc09ab6903251164f85ea2827448564cca2f7c.1778707135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
	<pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 21:18:51 +0000
Subject: [PATCH v4 09/13] pack-objects: support sparse:oid filter with
 path-walk
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The --filter=sparse:<oid> option to 'git pack-objects' allows focusing
an object set to a sparse-checkout definition. This reduces the set of
matching blobs while retaining all reachable trees. No server currently
supports fetching with this filter because it is expensive to compute
and reachability bitmaps do not help without a significant effort to
extend the bitmap feature to store bitmaps for each supported sparse-
checkout definition.

Without focusing on serving fetches and clones with these filters, there
are still benefits that could be realized by making this faster. With
the sparse index, it's more realistic now than ever to be able to
operate a local clone that was bootstrapped by a packfile created with
a sparse filter, because the missing trees are not needed to move a
sparse-checkout from one commit to another or to view the history of any
path in scope. Such clones could perhaps be bootstrapped by partial
bundles.

Previously, constructing these sparse packs has been incredibly
computationally inefficient. The revision walk that explores which
objects are in scope spends a lot of time checking each object to see if
it matches the sparse-checkout patterns, causing quadratic behavior
(number of objects times number of sparse-checkout patterns). This
improves somewhat when using cone-mode sparse-checkout patterns that can
use hashtables and prefix matches to determine containment. However, the
check per object is still too expensive for most cases.

This is where the path-walk feature comes in. We can proceed as normal
by placing objects in bins by path and _then_ check a group of objects
all at once. Since sparse:<oid> only restricts blobs, the path-walk must
include all reachable trees while using the cone-mode patterns to skip
blobs at paths outside the sparse scope. This establishes a baseline for
a potential future "treesparse:<oid>" filter that would also restrict
trees, but introducing such a new filter is deferred to a later change.

The implementation here is focused around loading the sparse-checkout
patterns from the provided object ID and checking that the patterns are
indeed cone-mode patterns. We can then load the correct pattern list
into the path walk context and use the logic that already exists from
bff45557675 (backfill: add --sparse option, 2025-02-03), though that
feature loads sparse-checkout patterns from the worktree's local
settings and also restricts tree objects. We use a combination of errors
and warnings to signal problems during this load. The difference is that
errors are likely fatal for the non-path-walk version while the warnings
are probably just implementation details for the path-walk version and
the 'git pack-objects' command can fall back to the revision walk
version.

Now that the SEEN flag is deferred until after pattern checks (from the
previous commit), handle the case where a tree with a shared OID appears
at both an out-of-cone and in-cone path. When trees are not being pruned
(pl_sparse_trees == 0), the path-walk re-walks the tree at the in-cone
path so that in-cone blobs within it are discovered. The new tests in
t5317 and t6601 demonstrate this behavior and would fail without these
changes.

The performance test p5315 shows the impact of this change when using
sparse filters:

Test                                              HEAD~1     HEAD
----------------------------------------------------------------------
5315.10: repack (sparse:oid)                      77.98    77.47  -0.7%
5315.11: repack size (sparse:oid)                187.5M   187.4M  -0.0%
5315.12: repack (sparse:oid, --path-walk)         77.91    31.41 -59.7%
5315.13: repack size (sparse:oid, --path-walk)   187.5M   161.1M -14.1%

These performance tests were run on the Git repository. The --path-walk
feature shows meaningful space savings (14% smaller for sparse packs)
and dramatic time savings (60% faster) by leveraging the path-walk's
ability to skip blobs outside the sparse scope.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blaue <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.adoc        |   4 +
 Documentation/git-pack-objects.adoc    |   3 +-
 builtin/pack-objects.c                 |  16 ++-
 path-walk.c                            |  81 ++++++++++++++-
 t/t5317-pack-objects-filter-objects.sh | 125 +++++++++++++++++++++++
 t/t6601-path-walk.sh                   | 131 +++++++++++++++++++++++++
 6 files changed, 350 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
index c0a3b80615..82d6a1969d 100644
--- a/Documentation/git-backfill.adoc
+++ b/Documentation/git-backfill.adoc
@@ -80,6 +80,10 @@ OPTIONS
 +
 You may also use commit-limiting options understood by
 linkgit:git-rev-list[1] such as `--first-parent`, `--since`, or pathspecs.
++
+Most `--filter=<spec>` options don't work with the purpose of
+`git backfill`, but the `sparse:<oid>` filter is integrated to provide a
+focused set of paths to download, distinct from the `--sparse` option.
 
 SEE ALSO
 --------
diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 85ae48b699..e38853391b 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -404,7 +404,8 @@ will be automatically changed to version `1`.
 +
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. The `--path-walk` option
-supports the `--filter=<spec>` forms `blob:none` and `blob:limit=<n>`.
+supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`, and
+`sparse:<oid>`.
 
 
 DELTA ISLANDS
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index bc9fb5b457..b783dc62bc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4754,7 +4754,7 @@ static int add_objects_by_path(const char *path,
 	return 0;
 }
 
-static void get_object_list_path_walk(struct rev_info *revs)
+static int get_object_list_path_walk(struct rev_info *revs)
 {
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
 	unsigned int processed = 0;
@@ -4777,8 +4777,9 @@ static void get_object_list_path_walk(struct rev_info *revs)
 	result = walk_objects_by_path(&info);
 	trace2_region_leave("pack-objects", "path-walk", revs->repo);
 
-	if (result)
-		die(_("failed to pack objects via path-walk"));
+	path_walk_info_clear(&info);
+
+	return result;
 }
 
 static void get_object_list(struct rev_info *revs, struct strvec *argv)
@@ -4841,8 +4842,13 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 		fn_show_object = show_object;
 
 	if (path_walk) {
-		get_object_list_path_walk(revs);
-	} else {
+		if (get_object_list_path_walk(revs)) {
+			warning(_("failed to pack objects via path-walk"));
+			path_walk = 0;
+		}
+	}
+
+	if (!path_walk) {
 		if (prepare_revision_walk(revs))
 			die(_("revision walk setup failed"));
 		mark_edges_uninteresting(revs, show_edge, sparse);
diff --git a/path-walk.c b/path-walk.c
index 225857bbc8..ce38dcf1e9 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -10,6 +10,7 @@
 #include "hex.h"
 #include "list-objects.h"
 #include "list-objects-filter-options.h"
+#include "object-name.h"
 #include "odb.h"
 #include "object.h"
 #include "oid-array.h"
@@ -180,10 +181,6 @@ static int add_tree_entries(struct path_walk_context *ctx,
 			return -1;
 		}
 
-		/* Skip this object if already seen. */
-		if (o->flags & SEEN)
-			continue;
-
 		strbuf_setlen(&path, base_len);
 		strbuf_add(&path, entry.path, entry.pathlen);
 
@@ -194,6 +191,40 @@ static int add_tree_entries(struct path_walk_context *ctx,
 		if (type == OBJ_TREE)
 			strbuf_addch(&path, '/');
 
+		if (o->flags & SEEN) {
+			/*
+			 * A tree with a shared OID may appear at multiple
+			 * paths. Even though we already added this tree to
+			 * the output at some other path, we still need to
+			 * walk into it at this in-cone path to discover
+			 * blobs that were not found at the earlier
+			 * out-of-cone path.
+			 *
+			 * Only do this for paths not yet in our map, to
+			 * avoid duplicate entries when the same tree OID
+			 * appears at the same path across multiple commits.
+			 */
+			if (type == OBJ_TREE && ctx->info->pl &&
+			    ctx->info->pl->use_cone_patterns &&
+			    !ctx->info->pl_sparse_trees &&
+			    !strmap_contains(&ctx->paths_to_lists, path.buf)) {
+				int dtype;
+				enum pattern_match_result m;
+				m = path_matches_pattern_list(path.buf, path.len,
+							      path.buf + base_len,
+							      &dtype,
+							      ctx->info->pl,
+							      ctx->repo->index);
+				if (m != NOT_MATCHED) {
+					add_path_to_list(ctx, path.buf, type,
+							 &entry.oid,
+							 !(o->flags & UNINTERESTING));
+					push_to_stack(ctx, path.buf);
+				}
+			}
+			continue;
+		}
+
 		if (ctx->info->pl) {
 			int dtype;
 			enum pattern_match_result match;
@@ -544,6 +575,48 @@ static int prepare_filters(struct path_walk_info *info,
 		}
 		return 1;
 
+	case LOFC_SPARSE_OID:
+		if (info) {
+			struct object_id sparse_oid;
+			struct repository *repo = info->revs->repo;
+
+			if (info->pl) {
+				warning(_("sparse filter cannot be combined with existing sparse patterns"));
+				return 0;
+			}
+
+			if (repo_get_oid_with_flags(repo,
+						    options->sparse_oid_name,
+						    &sparse_oid,
+						    GET_OID_BLOB)) {
+				error(_("unable to access sparse blob in '%s'"),
+				      options->sparse_oid_name);
+				return 0;
+			}
+
+			CALLOC_ARRAY(info->pl, 1);
+			info->pl->use_cone_patterns = 1;
+
+			if (add_patterns_from_blob_to_list(&sparse_oid, "", 0,
+							   info->pl) < 0) {
+				clear_pattern_list(info->pl);
+				FREE_AND_NULL(info->pl);
+				error(_("unable to parse sparse filter data in '%s'"),
+				      oid_to_hex(&sparse_oid));
+				return 0;
+			}
+
+			if (!info->pl->use_cone_patterns) {
+				clear_pattern_list(info->pl);
+				FREE_AND_NULL(info->pl);
+				warning(_("sparse filter is not cone-mode compatible"));
+				return 0;
+			}
+
+			list_objects_filter_release(options);
+		}
+		return 1;
+
 	default:
 		error(_("object filter '%s' not supported by the path-walk API"),
 		      list_objects_filter_spec(options));
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 501d715b9a..dddb79ba62 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -478,4 +478,129 @@ test_expect_success 'verify pack-objects w/ --missing=allow-any' '
 	EOF
 '
 
+# Test that --path-walk produces the same object set as standard traversal
+# when using sparse:oid filters with cone-mode patterns.
+#
+# The sparse:oid filter restricts only blobs, not trees. Both standard
+# and path-walk should produce identical sets of blobs, commits, and trees.
+
+test_expect_success 'setup pw_sparse for path-walk comparison' '
+	git init pw_sparse &&
+	mkdir -p pw_sparse/inc/sub pw_sparse/exc/sub &&
+
+	for n in 1 2
+	do
+		echo "inc $n" >pw_sparse/inc/file$n &&
+		echo "inc sub $n" >pw_sparse/inc/sub/file$n &&
+		echo "exc $n" >pw_sparse/exc/file$n &&
+		echo "exc sub $n" >pw_sparse/exc/sub/file$n &&
+		echo "root $n" >pw_sparse/root$n || return 1
+	done &&
+
+	git -C pw_sparse add . &&
+	git -C pw_sparse commit -m "first" &&
+
+	echo "inc 1 modified" >pw_sparse/inc/file1 &&
+	echo "exc 1 modified" >pw_sparse/exc/file1 &&
+	echo "root 1 modified" >pw_sparse/root1 &&
+	git -C pw_sparse add . &&
+	git -C pw_sparse commit -m "second" &&
+
+	# Cone-mode sparse pattern: include root + inc/
+	printf "/*\n!/*/\n/inc/\n" |
+	git -C pw_sparse hash-object -w --stdin >sparse_oid
+'
+
+test_expect_success 'sparse:oid with --path-walk produces same blobs' '
+	oid=$(cat sparse_oid) &&
+
+	git -C pw_sparse pack-objects --revs --stdout \
+		--filter=sparse:oid=$oid >standard.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C pw_sparse index-pack ../standard.pack &&
+	git -C pw_sparse verify-pack -v ../standard.pack >standard_verify &&
+
+	git -C pw_sparse pack-objects --revs --stdout \
+		--path-walk --filter=sparse:oid=$oid >pathwalk.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C pw_sparse index-pack ../pathwalk.pack &&
+	git -C pw_sparse verify-pack -v ../pathwalk.pack >pathwalk_verify &&
+
+	# Blobs must match exactly
+	grep -E "^[0-9a-f]{40} blob" standard_verify |
+	awk "{print \$1}" | sort >standard_blobs &&
+	grep -E "^[0-9a-f]{40} blob" pathwalk_verify |
+	awk "{print \$1}" | sort >pathwalk_blobs &&
+	test_cmp standard_blobs pathwalk_blobs &&
+
+	# Commits must match exactly
+	grep -E "^[0-9a-f]{40} commit" standard_verify |
+	awk "{print \$1}" | sort >standard_commits &&
+	grep -E "^[0-9a-f]{40} commit" pathwalk_verify |
+	awk "{print \$1}" | sort >pathwalk_commits &&
+	test_cmp standard_commits pathwalk_commits
+'
+
+test_expect_success 'sparse:oid with --path-walk includes all trees' '
+	# The sparse:oid filter restricts only blobs, not trees.
+	# Both standard and path-walk should include the same trees.
+	grep -E "^[0-9a-f]{40} tree" standard_verify |
+	awk "{print \$1}" | sort >standard_trees &&
+	grep -E "^[0-9a-f]{40} tree" pathwalk_verify |
+	awk "{print \$1}" | sort >pathwalk_trees &&
+
+	test_cmp standard_trees pathwalk_trees
+'
+
+# Test the edge case where the same tree/blob OID appears at both an
+# in-cone and out-of-cone path. When sibling directories have identical
+# contents, they share a tree OID. The path-walk defers marking objects
+# SEEN until after checking sparse patterns, so an object at an out-of-cone
+# path can still be discovered at an in-cone path.
+
+test_expect_success 'setup pw_shared for shared OID across cone boundary' '
+	git init pw_shared &&
+	mkdir pw_shared/aaa pw_shared/zzz &&
+	echo "shared content" >pw_shared/aaa/file &&
+	echo "shared content" >pw_shared/zzz/file &&
+	echo "root file" >pw_shared/rootfile &&
+	git -C pw_shared add . &&
+	git -C pw_shared commit -m "aaa and zzz share tree OID" &&
+
+	# Verify they share a tree OID
+	aaa_tree=$(git -C pw_shared rev-parse HEAD:aaa) &&
+	zzz_tree=$(git -C pw_shared rev-parse HEAD:zzz) &&
+	test "$aaa_tree" = "$zzz_tree" &&
+
+	# Cone pattern: include root + zzz/ (not aaa/)
+	printf "/*\n!/*/\n/zzz/\n" |
+	git -C pw_shared hash-object -w --stdin >shared_sparse_oid
+'
+
+test_expect_success 'shared tree OID: --path-walk blobs match standard' '
+	oid=$(cat shared_sparse_oid) &&
+
+	git -C pw_shared pack-objects --revs --stdout \
+		--filter=sparse:oid=$oid >shared_std.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C pw_shared index-pack ../shared_std.pack &&
+	git -C pw_shared verify-pack -v ../shared_std.pack >shared_std_verify &&
+
+	git -C pw_shared pack-objects --revs --stdout \
+		--path-walk --filter=sparse:oid=$oid >shared_pw.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C pw_shared index-pack ../shared_pw.pack &&
+	git -C pw_shared verify-pack -v ../shared_pw.pack >shared_pw_verify &&
+
+	grep -E "^[0-9a-f]{40} blob" shared_std_verify |
+	awk "{print \$1}" | sort >shared_std_blobs &&
+	grep -E "^[0-9a-f]{40} blob" shared_pw_verify |
+	awk "{print \$1}" | sort >shared_pw_blobs &&
+	test_cmp shared_std_blobs shared_pw_blobs
+'
+
 test_done
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 02ad83dfb0..ac294867a5 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -596,4 +596,135 @@ test_expect_success 'all, blob:limit=3 filter' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'setup sparse filter blob' '
+	# Cone-mode patterns: include root, exclude all dirs, include left/
+	cat >patterns <<-\EOF &&
+	/*
+	!/*/
+	/left/
+	EOF
+	sparse_oid=$(git hash-object -w -t blob patterns)
+'
+
+test_expect_success 'all, sparse:oid filter' '
+	test-tool path-walk --filter=sparse:oid=$sparse_oid -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tag:/tags:$(git rev-parse refs/tags/first)
+	1:tag:/tags:$(git rev-parse refs/tags/second.1)
+	1:tag:/tags:$(git rev-parse refs/tags/second.2)
+	1:tag:/tags:$(git rev-parse refs/tags/third)
+	1:tag:/tags:$(git rev-parse refs/tags/fourth)
+	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
+	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:tree::$(git rev-parse topic^{tree})
+	3:tree::$(git rev-parse base^{tree})
+	3:tree::$(git rev-parse base~1^{tree})
+	3:tree::$(git rev-parse base~2^{tree})
+	3:tree::$(git rev-parse refs/tags/tree-tag^{})
+	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
+	4:blob:a:$(git rev-parse base~2:a)
+	5:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
+	6:tree:a/:$(git rev-parse base:a)
+	7:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	8:tree:left/:$(git rev-parse base:left)
+	8:tree:left/:$(git rev-parse base~2:left)
+	9:blob:left/b:$(git rev-parse base~2:left/b)
+	9:blob:left/b:$(git rev-parse base:left/b)
+	10:tree:right/:$(git rev-parse topic:right)
+	10:tree:right/:$(git rev-parse base~1:right)
+	10:tree:right/:$(git rev-parse base~2:right)
+	blobs:6
+	commits:4
+	tags:7
+	trees:13
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic only, sparse:oid filter' '
+	test-tool path-walk --filter=sparse:oid=$sparse_oid -- topic >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tree::$(git rev-parse topic^{tree})
+	1:tree::$(git rev-parse base~1^{tree})
+	1:tree::$(git rev-parse base~2^{tree})
+	2:blob:a:$(git rev-parse base~2:a)
+	3:tree:left/:$(git rev-parse base~2:left)
+	4:blob:left/b:$(git rev-parse base~2:left/b)
+	5:tree:right/:$(git rev-parse topic:right)
+	5:tree:right/:$(git rev-parse base~1:right)
+	5:tree:right/:$(git rev-parse base~2:right)
+	blobs:2
+	commits:3
+	tags:0
+	trees:7
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+# Demonstrate the SEEN flag ordering issue: when the same tree/blob OID
+# appears at two sibling paths where one is in-cone and the other is
+# out-of-cone, the path-walk must still discover blobs at the in-cone
+# path even when the shared tree OID was first encountered out-of-cone.
+# Since sparse:oid includes all trees, the out-of-cone tree (aaa/) is
+# walked first, and its blob is skipped. The path-walk then re-walks
+# the same tree OID at the in-cone path (zzz/) to find the blob there.
+
+test_expect_success 'setup shared tree OID across cone boundary' '
+	git checkout --orphan shared-tree &&
+	git rm -rf . &&
+	mkdir aaa zzz &&
+	echo "shared content" >aaa/file &&
+	echo "shared content" >zzz/file &&
+	echo "root file" >rootfile &&
+	git add aaa zzz rootfile &&
+	git commit -m "aaa and zzz have same tree OID" &&
+
+	# Verify they really share a tree OID
+	aaa_tree=$(git rev-parse HEAD:aaa) &&
+	zzz_tree=$(git rev-parse HEAD:zzz) &&
+	test "$aaa_tree" = "$zzz_tree" &&
+
+	# Cone pattern: include root + zzz/ (not aaa/)
+	cat >shared-patterns <<-\EOF &&
+	/*
+	!/*/
+	/zzz/
+	EOF
+	shared_sparse_oid=$(git hash-object -w -t blob shared-patterns)
+'
+
+test_expect_success 'sparse:oid with shared tree OID across cone boundary' '
+	test-tool path-walk \
+		--filter=sparse:oid=$shared_sparse_oid \
+		-- shared-tree >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse shared-tree)
+	1:tree::$(git rev-parse shared-tree^{tree})
+	2:blob:rootfile:$(git rev-parse shared-tree:rootfile)
+	3:tree:aaa/:$(git rev-parse shared-tree:aaa)
+	4:tree:zzz/:$(git rev-parse shared-tree:zzz)
+	5:blob:zzz/file:$(git rev-parse shared-tree:zzz/file)
+	blobs:2
+	commits:1
+	tags:0
+	trees:3
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_done
-- 
gitgitgadget

