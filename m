Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409303B2FC8
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707165; cv=none; b=opNRE4r04h0wbkbAFUmh9lU8aibzfbVvSc0EUUnVuYWpvixEAl55MB/KpKJXZGn8iEQR+eqVSf5u+iXQp6A0PPvviV2+PrA4FO9OBjjYdTCrBLZcViZDNfARdswl7U1FUFO3UJDnu6kg82y4OWJDzYjG63tFDiT3LsPK+4rqXGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707165; c=relaxed/simple;
	bh=FxZg/3kotyKBT2CWq0KEPDk0lBEstniBmbw3CKfjbm4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LDH9EUGNN7TBGaEcFy0FESMpeRGOL4rpVsCo/XCXfr2jGz0CMNlK5vPg+EgoFOHVaNGglq4851DUsm3lJVglp8DfS2wsAVhBmBhk0gYdca13wYYOeZs6DlLVkvWZYlYyw5djX2E7+znobifr3hoqCZXBVriB7eVxCf9WxcfrBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGlFt/41; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGlFt/41"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f30a4601bbso7959805eec.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707157; x=1779311957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx0FZ0WNKgmQzobi3COcu1Nt6LR8fIIM+adZuXvVfuQ=;
        b=OGlFt/41twM+E2tvwM88r6KwFDa2W7TbEDAWJyHQzmqxTr1upDikBn9rv0wE88/uvD
         bUOUVGiFsW5v7R0uPxXYt7kjH96CSqkwxSM+9gCskmHSuHfzRZsANBi/8eHEzJgp/fD5
         LDPf8a2SyuLHmTR7JV4a+fVTJaAc3I+zzXh+4/8RhWMfIDo2anN8+U7pY3EXa5hRa+2a
         fG9fMTw5fvnqSm/4xz+mAQ1J27KUghXLOzMT/SwZFIiqFUjULO82e9IWC97kxhIMYYxo
         I7mRCAzOBn8WZ9tMsOWr3qcb3vU16NC9wHeX/49eb1RTLFXPF36g/4RXb76J7qbTCmyM
         ze5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707157; x=1779311957;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fx0FZ0WNKgmQzobi3COcu1Nt6LR8fIIM+adZuXvVfuQ=;
        b=Z8GvkNt+rZhE0/g8vGwT3mUAgZJyYITfAmkhJrxIGr+jcwgA/mnRoqq2BAXqHK5Vpy
         ut1VbkZUwP/c3VHfIXKDvxWBu42vrIWbx8VcDJFtC6ndWRTMNPqF0JvZAPHKpellpQZC
         sgdZH6hwJadJS8rrp+pSN5cbkzI3uWMGF007y39GQbfSanTpu73nu1UvgTs0FcLG+r9b
         kgt+rY2APWuQkOKn6buCBitueHmRWtz7OJxPctIdQr2LXeuh7QGnLR5+3nZYqM+Z7Ija
         ND/JdOuh/6VWnHXiEMsAt/H+1UonHoPrS/54kd8UtBTMy0Sr2gqfVs+W9ja5MmWcDlZ7
         etNw==
X-Gm-Message-State: AOJu0Yw/BKGf42ea5iJcRz6xh4qK2H5czb5e5uSSNXL+fuzzKHMj3jr9
	EveskUbf7dKHKVOIJtNPgeDc8CevM8ELDIiHfh+uCHTPRTs1ErJ9Dlu3i540whao
X-Gm-Gg: Acq92OFgIkxc9EEm5hAtDezyCYtB4PGgWCJE0UlI3ArygAs9EyXckvhQeEsdUVfWfi5
	xJExVION7cQO63Mgj3vLQCoTxdxnBkv0Qq/O5zQblObwMhjZgFPXiuVJyglLKstFv5fH1mzY7ms
	PM721QEVZFheVneZALFmh+FurM0sc9Y0mpbUymW5R0b4qzyXrWV3lc6IqYAC7PwJVIeYPR6FKJw
	96iQ8Hj7J4Nh7Dcw7dhzaD/TsC+Aor/SJnN5A17FaGoaWHGhB3v1GW0rbveefE5KNxjmYuARoJo
	OG4jf9yQiVs1QkCmUOA5yFxGE9ZYglaOv8bjMYLnkAMEbc4HjnU9FE4UTBTgfvZurVi6mII4KWO
	+n7+LjCjubcA+NOw03IP93BHQEQMh0T3dg5kO8p+pGuQ+fswU3RV3OO1x9uKfF4YqPBE2A/xAQ6
	8WJQsy8rvg+85la3WF/NFy5mRyGg==
X-Received: by 2002:a05:7301:5807:b0:2f3:3daf:3496 with SMTP id 5a478bee46e88-30155b4e0e3mr2663730eec.26.1778707157190;
        Wed, 13 May 2026 14:19:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bcc5asm491316eec.22.2026.05.13.14.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:19:16 -0700 (PDT)
Message-Id: <7e1e503361e5d997d904ac101a776ecffdac6059.1778707135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
	<pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 21:18:54 +0000
Subject: [PATCH v4 12/13] path-walk: support `object:type` filter
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
    Taylor Blau <me@ttaylorr.com>

From: Taylor Blau <me@ttaylorr.com>

The `object:type` filter accepts only objects of a single type; it is
the second member of the object-info-only filter family that bitmap
traversal already supports.

Like `blob:none` and `tree:0`, it can be evaluated with nothing more
than the object's type, which is exactly the granularity path-walk's
existing info->{commits,trees,blobs,tags} flags already control.

Map `LOFC_OBJECT_TYPE` in `prepare_filters()` by AND-ing each flag
against the filtered type. A single `object:type=X` filter
applied to the default info (all flags = 1) leaves `info->X = 1` and
all the others 0, which is what we want.

Using an AND rather than straight assignment prepares us for a
subsequent change to implement combined object filters.

The path-walk machinery is mostly already wired for the per-type
distinction:

 - `walk_path()` calls `path_fn` for a batch only when the corresponding
   `info->X` flag is set, so unwanted types are silently not reported.

 - `add_tree_entries()` skips tree entries of type `OBJ_BLOB` when
   `info->blobs` is unset, so we don't even allocate paths for them.

 - The commit-walk loop short-circuits the root-tree fetch when
   `!info->trees && !info->blobs`, so commit-only filters don't descend
   into trees at all.

But there are a couple of side effects of the "trees off, blobs on" case
that need fixing:

 1. 'setup_pending_objects()' previously skipped pending trees as soon
    as `info->trees` was zero. For 'object:type=blob' the call site
    needs those pending trees: a lightweight tag pointing to a tree, or
    an annotated tag whose peeled target is a tree, can both reach
    blobs that are otherwise unreachable from any commit's root tree.
    Loosen the gate to "if (!info->trees && !info->blobs) continue" and
    similarly retrieve the root_tree_list whenever either trees or
    blobs are wanted.

 2. The revision machinery's `handle_commit()` drops pending trees when
    `revs->tree_objects` is zero (see the 'OBJ_TREE' handler in
    revision.c), so by the time path-walk sees the pending list
    after `prepare_revision_walk()` the tree-bearing pendings would
    already be gone. Fix this by setting

        revs->tree_objects = info->trees || info->blobs

    so pending trees survive `prepare_revision_walk()` whenever we
    need to walk into them. Path-walk still resets tree_objects to
    zero immediately after `prepare_revision_walk()` returns, so the
    rev-walk itself never enumerates trees redundantly with
    path-walk's own descent.

Add coverage in t6601 for each of the four `object:type` values. The
'object:type=blob' test in particular asserts that file2 and child/file
(both reachable only through tag-pointed trees) show up in the output,
exercising the pending-tree fix.

Update Documentation/git-pack-objects.adoc to add object:type to
the list of supported --filter forms.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc |  2 +-
 path-walk.c                         | 13 ++++-
 path-walk.h                         |  6 +++
 t/t6601-path-walk.sh                | 84 +++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index c86219be91..f2852ebd31 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -405,7 +405,7 @@ will be automatically changed to version `1`.
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. The `--path-walk` option
 supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
-`tree:0`, and `sparse:<oid>`.
+`tree:0`, `object:type=<type>`, and `sparse:<oid>`.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index cb67b8ce86..418972e753 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -382,7 +382,7 @@ static int walk_path(struct path_walk_context *ctx,
 			ret = ctx->info->path_fn(path, &filtered, list->type,
 						 ctx->info->path_fn_data);
 		oid_array_clear(&filtered);
-	} else if (path_is_for_direct_objects(path) ||
+	} else if ((!ctx->info->strict_types && path_is_for_direct_objects(path)) ||
 		   (list->type == OBJ_TREE && ctx->info->trees) ||
 		   (list->type == OBJ_BLOB && ctx->info->blobs) ||
 		   (list->type == OBJ_TAG && ctx->info->tags)) {
@@ -608,6 +608,17 @@ static int prepare_filters(struct path_walk_info *info,
 		}
 		return 1;
 
+	case LOFC_OBJECT_TYPE:
+		if (info) {
+			info->commits &= options->object_type == OBJ_COMMIT;
+			info->tags &= options->object_type == OBJ_TAG;
+			info->trees &= options->object_type == OBJ_TREE;
+			info->blobs &= options->object_type == OBJ_BLOB;
+			info->strict_types = 1;
+			list_objects_filter_release(options);
+		}
+		return 1;
+
 	case LOFC_SPARSE_OID:
 		if (info) {
 			struct object_id sparse_oid;
diff --git a/path-walk.h b/path-walk.h
index 7e57ae5f65..a2652b2d46 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -47,6 +47,12 @@ struct path_walk_info {
 	int blobs;
 	int tags;
 
+	/**
+	 * If 'strict_types' is 0, then direct object requests will no longer
+	 * override the object type restrictions.
+	 */
+	int strict_types;
+
 	/**
 	 * If non-zero, specifies a maximum blob size. Blobs with a
 	 * size equal to or greater than this limit will not be
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 566db7c7e3..0fd8e61c76 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -643,6 +643,90 @@ test_expect_success 'tree:1 filter is rejected' '
 	test_grep "tree:1 filter not supported by the path-walk API" err
 '
 
+test_expect_success 'all, object:type=commit filter' '
+	test-tool path-walk --filter=object:type=commit -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	blobs:0
+	commits:4
+	tags:0
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'all, object:type=tag filter' '
+	test-tool path-walk --filter=object:type=tag -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:tag:/tags:$(git rev-parse refs/tags/first)
+	0:tag:/tags:$(git rev-parse refs/tags/second.1)
+	0:tag:/tags:$(git rev-parse refs/tags/second.2)
+	0:tag:/tags:$(git rev-parse refs/tags/third)
+	0:tag:/tags:$(git rev-parse refs/tags/fourth)
+	0:tag:/tags:$(git rev-parse refs/tags/tree-tag)
+	0:tag:/tags:$(git rev-parse refs/tags/blob-tag)
+	blobs:0
+	commits:0
+	tags:7
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'all, object:type=tree filter' '
+	test-tool path-walk --filter=object:type=tree -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:tree::$(git rev-parse topic^{tree})
+	0:tree::$(git rev-parse base^{tree})
+	0:tree::$(git rev-parse base~1^{tree})
+	0:tree::$(git rev-parse base~2^{tree})
+	1:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{})
+	1:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2^{})
+	2:tree:a/:$(git rev-parse base:a)
+	3:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	4:tree:left/:$(git rev-parse base:left)
+	4:tree:left/:$(git rev-parse base~2:left)
+	5:tree:right/:$(git rev-parse topic:right)
+	5:tree:right/:$(git rev-parse base~1:right)
+	5:tree:right/:$(git rev-parse base~2:right)
+	blobs:0
+	commits:0
+	tags:0
+	trees:13
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'all, object:type=blob filter' '
+	test-tool path-walk --filter=object:type=blob -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	1:blob:a:$(git rev-parse base~2:a)
+	2:blob:left/b:$(git rev-parse base:left/b)
+	2:blob:left/b:$(git rev-parse base~2:left/b)
+	3:blob:right/c:$(git rev-parse base~2:right/c)
+	3:blob:right/c:$(git rev-parse topic:right/c)
+	4:blob:right/d:$(git rev-parse base~1:right/d)
+	blobs:8
+	commits:0
+	tags:0
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'setup sparse filter blob' '
 	# Cone-mode patterns: include root, exclude all dirs, include left/
 	cat >patterns <<-\EOF &&
-- 
gitgitgadget

