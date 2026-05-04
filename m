Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9E3E3D89
	for <git@vger.kernel.org>; Mon,  4 May 2026 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926092; cv=none; b=AQVujMRqlDx4cA6c8Vhl0kdgruCzRkjKdlaaI7bz9BGR+LFCAld7FTOcvbLTVF+gmzR918bNH31Y1fVZhEIrO3y+Qf/bwpE/ZdNjkYd0nCt9OCe7TrHSOU2BtJgs0VQiGyGaUdrP5GJynaU/NQcq3s/RtQ0gx2+juhvlJXNWdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926092; c=relaxed/simple;
	bh=JdD/kKwHkWLGrgxe5SHJPJ+rmGW0KRBHF3gjemaO1o0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m+GjosFqDVa+xVdsfpxmMLzZL4m7GUHhZKzmjzvtF+YzZdAwJexbaPjDTradlrdVEzpVJ/rDSZqqgNUCL2TZ5XCACdQyqWmvEehEQXBQ5ahvADv0YSdBBaandHZgrEmeIipiYZLuLS318efM4rDtKVxX7kFj36d4H6WUdPg0R6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVccQMWJ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVccQMWJ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso24362656d6.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777926089; x=1778530889; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+Tn8iRRjuDObd2wqel3ZE8ce0RR8yTR5nuWhQJA2Jc=;
        b=MVccQMWJ9NEBf6w85KVu9aSeTe+6xHpKKwFoNfisoGcUHR4H4BZ+9l3LILne2FskNS
         VuVi2a+8uqg+d864sAOk23OyWsBmy9i8CLyTN+sXAqVb9YElDFTN+EW40v7eKY1rOFag
         EsRgHFDhvtRMj6gUgWqwJFVlB6gmrBomP8+MluNTU+P4M2Acfr/YXCRXbt1w/9YaQQ7E
         nUCN/iGfdqcc5XBmon5zkUF+PXq5d5SUUafB9bDETq/3UafCxsyojgF31hwfd1OW7UTz
         Vj311xcH34++cPkOVFe/yWfbKtrG16QrHUdjfEjB/MzgWQ3iJyBeIAV9lu9u0lF+11Pv
         Q8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926089; x=1778530889;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+Tn8iRRjuDObd2wqel3ZE8ce0RR8yTR5nuWhQJA2Jc=;
        b=U052uUbs0E+2gJJa4AiD3bKW/losVLYT7Sb8bKvnrR2DtI9nJG+FeCoQ39/ykF354F
         BFNAIQa1O2RMQx3UzdDBhNiLvsnbvSnj4D9VmLThKiIVJuSyW9g0VM6udqh5K6JFhk3t
         42iW5lb/Ll8bBHbBQSAt1KeWiLkYqpKMt2DfpLWV6IBSKzswsr/tKaRWThKW1t/pOyYQ
         F91lr+UbkFOmSGZGJ7UVwbOiP6sy/q/8yJpveF5APao8UTYN3ZtimmV5MVRHKFZxvxjD
         0S9oS13ydD9LeJMH6jmDsG+OnkJd1+9uJYFQzssVCbtAgHldc2pegsBnU5okOCQ+JdYr
         XYSQ==
X-Gm-Message-State: AOJu0Yw+CpYoui+unfnt+is/EYCgXDh8w6nJK/E7OCJw7r9+c5bnyFgp
	vwxfuKQIMGFtcl3gWXzGh40HnF5B32T/51jsTxSxqYLxvY76N8HGm2vVZNYV2g==
X-Gm-Gg: AeBDiesR6Dg1W/FLs4s0kS2zYuoTlJ/86tQrb3lqU6LiK8fRrxLw19OiYLuuuE2cDYG
	+6qgHM1Z8pEmJ2krd887RC+7wzYKPLzIaFmCxJipG7GSgJPQCxK4gg6Hpbw4Vg07zTJB2jq9hm3
	npMSiXf6nHquAr9jOq5xQJnwmnjjVxcsjd3mKLEoqVcI8/eXcp12mnK0o6hb/GHB65JNZhL0Ruc
	AG0/2p2+wfDLy+JkGHhZhL5fBRSqECfPndfRAJUoOG1mFOTv870JX8KwFQa221FKdNBTxTtmUCy
	9WIvmQPd89Yiz9jtyNJBitJBWVeaCgENAbvhZi72/rX8qFYYKhAq9z8ymDz74HRECyaRPfL8QGV
	Glo8yH2f1LiDk6im/avZtCTErNZPuUqLrUsslj7bY4OQb8UNtAHZzAkW7x4WiwA9uLCV6Id7ma9
	7xkNHihB59dyBR8Zc24qbFOVVBgCPjMbsyl1Za
X-Received: by 2002:a05:6214:3d85:b0:8ac:a57e:ec1f with SMTP id 6a1803df08f44-8b6682578c9mr195077466d6.29.1777926089079;
        Mon, 04 May 2026 13:21:29 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c0e6d72sm143033306d6.26.2026.05.04.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:21:28 -0700 (PDT)
Message-Id: <55ed02772b5c0aecebfb2a99416555d647d0cb77.1777926079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 20:21:15 +0000
Subject: [PATCH v2 06/10] path-walk: add pl_sparse_trees to control tree
 pruning
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The path-walk API prunes trees and blobs when a sparse-checkout pattern
list is provided, which is the correct behavior for 'git backfill
--sparse' since it only needs to fill in objects at paths within the
sparse cone.

However, a future change will use the path-walk API with a sparse:<oid>
filter that restricts only blobs while retaining all reachable trees.
To support both behaviors, add a 'pl_sparse_trees' flag to
path_walk_info. When set (as in 'git backfill --sparse' and the
--stdin-pl test helper mode), the sparse patterns prune both trees and
blobs. When unset, only blobs are filtered and all trees are walked and
reported.

Additionally, move the SEEN flag assignment in add_tree_entries() to
after the sparse pattern and pathspec checks. Previously, SEEN was set
immediately upon discovering an object, before checking whether its path
matched the sparse patterns. When the same object ID appeared at
multiple paths (e.g. sibling directories with identical contents), the
first path to be visited would mark the object as SEEN. If that path was
outside the sparse cone, the object would be skipped there but also
never discovered at its in-cone path.

By deferring the SEEN flag until after the checks pass, objects that are
skipped due to sparse filtering remain discoverable at other paths where
they may be in scope.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/backfill.c        |  1 +
 path-walk.c               |  5 +++--
 path-walk.h               |  6 ++++++
 t/helper/test-path-walk.c |  6 +++++-
 t/t6601-path-walk.sh      | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index 5254a42711..e71e0f4742 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -109,6 +109,7 @@ static int do_backfill(struct backfill_context *ctx)
 
 	if (ctx->sparse) {
 		CALLOC_ARRAY(info.pl, 1);
+		info.pl_sparse_trees = 1;
 		if (get_sparse_checkout_patterns(info.pl)) {
 			path_walk_info_clear(&info);
 			return error(_("problem loading sparse-checkout"));
diff --git a/path-walk.c b/path-walk.c
index 0e7dab7a6a..c25392b901 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -183,7 +183,6 @@ static int add_tree_entries(struct path_walk_context *ctx,
 		/* Skip this object if already seen. */
 		if (o->flags & SEEN)
 			continue;
-		o->flags |= SEEN;
 
 		strbuf_setlen(&path, base_len);
 		strbuf_add(&path, entry.path, entry.pathlen);
@@ -204,7 +203,8 @@ static int add_tree_entries(struct path_walk_context *ctx,
 							  ctx->repo->index);
 
 			if (ctx->info->pl->use_cone_patterns &&
-			    match == NOT_MATCHED)
+			    match == NOT_MATCHED &&
+			    (type == OBJ_BLOB || ctx->info->pl_sparse_trees))
 				continue;
 			else if (!ctx->info->pl->use_cone_patterns &&
 				 type == OBJ_BLOB &&
@@ -239,6 +239,7 @@ static int add_tree_entries(struct path_walk_context *ctx,
 				continue;
 		}
 
+		o->flags |= SEEN;
 		add_path_to_list(ctx, path.buf, type, &entry.oid,
 				 !(o->flags & UNINTERESTING));
 
diff --git a/path-walk.h b/path-walk.h
index bcb81b70a1..5fa3ff46b4 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -72,8 +72,14 @@ struct path_walk_info {
 	 * of the cone. If not in cone mode, then all tree paths will be
 	 * explored but the path_fn will only be called when the path matches
 	 * the sparse-checkout patterns.
+	 *
+	 * When 'pl_sparse_trees' is zero, the sparse patterns only restrict
+	 * blobs and all trees are included in the walk output. This matches
+	 * the behavior of the sparse:oid object filter. When nonzero, trees
+	 * are also pruned by the sparse patterns (as used by backfill).
 	 */
 	struct pattern_list *pl;
+	int pl_sparse_trees;
 };
 
 #define PATH_WALK_INFO_INIT {   \
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index 88f86ae0dc..3f2b50a9aa 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -68,7 +68,7 @@ static int emit_block(const char *path, struct oid_array *oids,
 
 int cmd__path_walk(int argc, const char **argv)
 {
-	int res, stdin_pl = 0;
+	int res, stdin_pl = 0, pl_sparse_trees = -1;
 	struct rev_info revs = REV_INFO_INIT;
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
 	struct path_walk_test_data data = { 0 };
@@ -89,6 +89,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle aggressive edge walk")),
 		OPT_BOOL(0, "stdin-pl", &stdin_pl,
 			 N_("read a pattern list over stdin")),
+		OPT_BOOL(0, "pl-sparse-trees", &pl_sparse_trees,
+			 N_("toggle pruning of trees by sparse patterns")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END(),
 	};
@@ -116,6 +118,8 @@ int cmd__path_walk(int argc, const char **argv)
 	if (stdin_pl) {
 		struct strbuf in = STRBUF_INIT;
 		CALLOC_ARRAY(info.pl, 1);
+		info.pl_sparse_trees = (pl_sparse_trees >= 0) ?
+			pl_sparse_trees : 1;
 
 		info.pl->use_cone_patterns = 1;
 
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index d9be7b9cd2..1126afaea1 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -206,6 +206,43 @@ test_expect_success 'base & topic, sparse' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'base & topic, sparse, no tree pruning' '
+	cat >patterns <<-EOF &&
+	/*
+	!/*/
+	/left/
+	EOF
+
+	test-tool path-walk --stdin-pl --no-pl-sparse-trees \
+		-- base topic <patterns >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tree::$(git rev-parse topic^{tree})
+	1:tree::$(git rev-parse base^{tree})
+	1:tree::$(git rev-parse base~1^{tree})
+	1:tree::$(git rev-parse base~2^{tree})
+	2:blob:a:$(git rev-parse base~2:a)
+	3:tree:a/:$(git rev-parse base:a)
+	4:tree:left/:$(git rev-parse base:left)
+	4:tree:left/:$(git rev-parse base~2:left)
+	5:blob:left/b:$(git rev-parse base~2:left/b)
+	5:blob:left/b:$(git rev-parse base:left/b)
+	6:tree:right/:$(git rev-parse topic:right)
+	6:tree:right/:$(git rev-parse base~1:right)
+	6:tree:right/:$(git rev-parse base~2:right)
+	blobs:3
+	commits:4
+	tags:0
+	trees:10
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'topic only' '
 	test-tool path-walk -- topic >out &&
 
-- 
gitgitgadget

