Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA8BA45
	for <git@vger.kernel.org>; Mon,  4 May 2026 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777853487; cv=none; b=j9mpVeYMVvYWBroWFWid/acgt4sZ7EhlmTXGfeoxMm+QL2sd8nhU6CJ+yTVp5LhiIUQx9n452SvohkfNV77jJBKrUtq94xutS+wNZloHthnvtPUGobQKFyZEYsMsOEu1/NpSqQsJz2s2w0rFEGseGob9Wgg41nBEjEFo7X7tqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777853487; c=relaxed/simple;
	bh=gYjTUtNi/2wR9M2f3BCLpx7m9NoFWKmISOBfXTUrViA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQ+uJ/n5/4Zzo5yTE6b/7fO/pWnWxnrU0huwrzpHEC4zZSh7rFUKus8UZvwd/YciJDVLGR728wx+FHHet/K+zRov35Cf4YRDTRA2rAdphZ0l62e/SiFzDtEqaTt4eJtLgBlyXQutldVtaUwbWjVVlj+LqKGlp5RxtZPjoIih8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gJZJlgqz; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gJZJlgqz"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65492d097acso3078129d50.3
        for <git@vger.kernel.org>; Sun, 03 May 2026 17:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777853485; x=1778458285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6U3Ha+Q22x/mii9VhIr/xe778uW2uFQ1AN4g4cXBlh0=;
        b=gJZJlgqzDRFgegtsBmGH1jp+adRdvICfp5fGdh6mTXQS3SQgp6+hjzPmq60dQO81Nu
         iPKrTFG6tVWEef+5bbBFMNx6ZYt2xmEsiC7eCmfLY5GUZKtFdAHYBlySan8DVm2SDJO8
         v0bC+zGFnjur8lBMp6H6H8F2+IJ4mekYCq+38a5lpuLsQFZDheL9ROT9RPPnYWlXnY24
         cIAaAtziEnmLG7V55omnWR9zmvgsaccV8RrSBsmf3o/hwH94fe6rllDPZtbySeXHdw5A
         IQG3Kq+6UBoPwYo7/JcQQxdLAPO9C9/1W3qnaZwYHFQMy8UlbKqFGGfGI2UeGtA+WVZn
         DFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777853485; x=1778458285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6U3Ha+Q22x/mii9VhIr/xe778uW2uFQ1AN4g4cXBlh0=;
        b=YhcdNwUFqIh89CFl89/GtqaF5t4biVHdMVdDDP4fApcBPW+mVqRpT6Ah1zfmTlQW92
         RtDO0RDfP9eDv+/tD6Xu3OcyUtowqx1sZc/YcFO9yo32VsRkYkgmKndYaDUz4PEb61EC
         tkbaoPFkLmAopkYta83dWW1aAelhYccJFulR9uaZG3jygnMWpcIRWyPFGCcx13wTyYKA
         ojRdFyx2ytD+6UN0m3fERy+lEFnu1KhUHsiV6bbMP77kMglOqjuN3Zsc9xb+sMLFoSBz
         lRRwqPIPEXL+M+6iovg6kvG/5gwMo32siPTK3hrx8g93vvXW5JWMEdjv9/qPiwB/P7EK
         ubFg==
X-Gm-Message-State: AOJu0YwIzopbr3zh0AgsE5B5W20Iua1aFZRWiD5T+MdLKeC4vkDSAjSX
	Rc1ZbbZuldBJSQX8Ud1Ek50mQ6idLMzTJf7ZMOgfJYG83mj+wv/KbUdt1Lrpe8q4OcXeaRZEiSs
	8Gd5qVtzP6A==
X-Gm-Gg: AeBDieuTxQeRY5R3e++SDTlVEnBnKIkfFcZhBKANqCCZ2AYEgrIQZwc/Vv9aa0scju2
	PWEq5YxOlnRc6qbbWf68xehquLJydIUDS1tpvGD5J6HVGNBPwCCB+9vwKVZNBmPqiE4ptHmj566
	m8f02YT/5njN5iA805UMwIRwSXEL4BkOqpvFPF7EbYEwmSI6pI4OdnEitH0jhgMLzXOxjXsFGnQ
	uwSPsBtPdihxCsTOosbmzrjHvWSOgDXIcffBcLpWrZIw9t4CSQMfcKM8GMxwJ6vXqfY2z4y16Lg
	oXCkEuXYs/xpAYSRqxqqi7mvIeGidsZk3ASq2+cGGUYDD8DTRUVeTeBDP+4uGJ15zWrsX6E7UzW
	811/2p2hie5KlJlEybXcyKVRceEd4Oy+4Dgxq6fsYQdnXDEl7MPRveq/vAi+eEWU8qVuwGTDOzW
	qOhuwR4Tk8UUwMAoY55R4IrprlVcFfJ33hP5YVNTM6e1gOh6ReOEZcVZhq9FWe1PDZBl6MULy5c
	l3ZC8QJM8n6qdWRmfBhTywGqFRszk+TKfg6vXzspLlY3iBvW9/CbcvfffSmRVWDjcXLqgvxTxCX
	NiK8OEhe2PUeeFNqpUZCmWe2ts6CuO3oed1/8w==
X-Received: by 2002:a05:690e:1303:b0:64e:f106:60e5 with SMTP id 956f58d0204a3-65c3db55f2emr6822711d50.52.1777853484768;
        Sun, 03 May 2026 17:11:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2df822c5sm4725549d50.1.2026.05.03.17.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 17:11:24 -0700 (PDT)
Date: Sun, 3 May 2026 20:11:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 3/7] path-walk: support `object:type` filter
Message-ID: <db46c1248ece57476b369a9bff920facab24be04.1777853408.git.me@ttaylorr.com>
References: <cover.1777853408.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777853408.git.me@ttaylorr.com>

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
---
 Documentation/git-pack-objects.adoc |  7 ++-
 path-walk.c                         | 23 +++++++-
 t/t6601-path-walk.sh                | 86 +++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index cfb5bc0ae16..22c782611d2 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -404,9 +404,10 @@ will be automatically changed to version `1`.
 +
 Incompatible with `--delta-islands`. Path-walk supports
 the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
-`sparse:oid=<blob>`, and `tree:0`. Other filter forms fall back to the
-regular object traversal. The `--use-bitmap-index` option will be
-ignored in the presence of `--path-walk`.
+`sparse:oid=<blob>`, `tree:0`, and `object:type=<type>`. Other filter
+forms fall back to the regular object traversal. The
+`--use-bitmap-index` option will be ignored in the presence of
+`--path-walk`.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index 36a1e5b967a..b9902abbb75 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -430,7 +430,7 @@ static int setup_pending_objects(struct path_walk_info *info,
 		CALLOC_ARRAY(tags, 1);
 	if (info->blobs)
 		CALLOC_ARRAY(tagged_blobs, 1);
-	if (info->trees)
+	if (info->trees || info->blobs)
 		root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
 
 	/*
@@ -475,7 +475,7 @@ static int setup_pending_objects(struct path_walk_info *info,
 
 		switch (obj->type) {
 		case OBJ_TREE:
-			if (!info->trees)
+			if (!info->trees && !info->blobs)
 				continue;
 			if (pending->path) {
 				char *path = *pending->path ? xstrfmt("%s/", pending->path)
@@ -577,6 +577,16 @@ static int prepare_filters(struct path_walk_info *info,
 		}
 		return 1;
 
+	case LOFC_OBJECT_TYPE:
+		if (info) {
+			info->commits &= options->object_type == OBJ_COMMIT;
+			info->tags &= options->object_type == OBJ_TAG;
+			info->trees &= options->object_type == OBJ_TREE;
+			info->blobs &= options->object_type == OBJ_BLOB;
+			list_objects_filter_release(options);
+		}
+		return 1;
+
 	case LOFC_SPARSE_OID:
 		if (info) {
 			struct object_id sparse_oid;
@@ -683,9 +693,16 @@ int walk_objects_by_path(struct path_walk_info *info)
 	/*
 	 * Set these values before preparing the walk to catch
 	 * lightweight tags pointing to non-commits and indexed objects.
+	 *
+	 * Keep tree_objects set whenever blobs are wanted: blobs may
+	 * be reachable through trees that show up as pending objects
+	 * (e.g., via lightweight tags pointing to trees, or annotated
+	 * tags whose peeled target is a tree). Without tree_objects,
+	 * prepare_revision_walk() would discard those pending trees
+	 * and we would never descend into them.
 	 */
 	info->revs->blob_objects = info->blobs;
-	info->revs->tree_objects = info->trees;
+	info->revs->tree_objects = info->trees || info->blobs;
 
 	if (prepare_revision_walk(info->revs))
 		die(_("failed to setup revision walk"));
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 72e09211e63..13016e62ab1 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -635,6 +635,92 @@ test_expect_success 'tree:1 filter is rejected' '
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
+	0:tree::$(git rev-parse refs/tags/tree-tag^{})
+	0:tree::$(git rev-parse refs/tags/tree-tag2^{})
+	1:tree:a/:$(git rev-parse base:a)
+	2:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	3:tree:left/:$(git rev-parse base:left)
+	3:tree:left/:$(git rev-parse base~2:left)
+	4:tree:right/:$(git rev-parse topic:right)
+	4:tree:right/:$(git rev-parse base~1:right)
+	4:tree:right/:$(git rev-parse base~2:right)
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
+	2:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
+	3:blob:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
+	4:blob:left/b:$(git rev-parse base:left/b)
+	4:blob:left/b:$(git rev-parse base~2:left/b)
+	5:blob:right/c:$(git rev-parse base~2:right/c)
+	5:blob:right/c:$(git rev-parse topic:right/c)
+	6:blob:right/d:$(git rev-parse base~1:right/d)
+	blobs:10
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
2.54.0.4.g6aa0d38a4ec

