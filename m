Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20C11A0728
	for <git@vger.kernel.org>; Sat,  2 May 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731369; cv=none; b=ZQenXugURdoUfDQ+8KPIUtZjmd0jmuAKjDAPCH5xGPkDTa6J+l4nmk/yKphNSdyZa+zXHJVzOl4NKNMQlV8j0+ofqRgJwtkZqsk5RPrBxScNxrStmqCKadZ5ixNmQcsv2ax0oaGajIZr+UkVDnYmiGCWsklrEuU625gNWaQeEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731369; c=relaxed/simple;
	bh=yFoQ/63vlQXtCYBDHv3Cppgr/Yjg0+TtP0rsYivk0L8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hrMKXcMkJG7xNZQ7FL4ynh+bjetpdqR6l+nBjqaACkrufOHkpc+125mAgGgYHbb2kOT/PdY+35k9N/9yxGGxHvM2NxY386ccHyHL0gRb8EqYn5au8C42ljcVFhGZxsTYZouwBTa8N57afpD3i/HPPP+03noJKdMivQVWfD+RIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUvBRNlN; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUvBRNlN"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4211148eec.0
        for <git@vger.kernel.org>; Sat, 02 May 2026 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777731367; x=1778336167; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jAfF2esDFXRxWzCU8rcarYAPWL/gTQyL1Igdz1ZVBQ=;
        b=QUvBRNlNLx+OkM4rsq8GsdVtf4q0VM4L6VXJuOwxxQzbw0HbrU5gwoOwzb1dWUfix7
         LQx76W9bVhWMJMsglXcrYUcXuC1S/tVmSWeEj2Px6ygRpKqYTNM95G7Nob2mwc6yuVRm
         jagn1gv0zwC+xZOsVVxqsazLEB+UbyoKUIWf0k/B2rgS7bE8Ce0GvVbBLI0YavF9Ukpz
         vQ4Xkb3nnCEanF2Bb0CmY7IQIXn1dC6HF8BmFxsTdmqygZay5Lpf0FM3qZAW9iF4LEtI
         2eYqeLkn7Weg+6ZBihGbdeJCHw9zXinjJvlCpvcs64l1koIYPtxueubbucfUS3l9z+Br
         GBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777731367; x=1778336167;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7jAfF2esDFXRxWzCU8rcarYAPWL/gTQyL1Igdz1ZVBQ=;
        b=rtwOsOWb37fvf0uFfkfkO27ed6npof0cGRvjUOf8Y5r1ddG+L9G7jJxeLKKb+mhuL+
         bKGkfxbFH46Id6I1xCKk2KVLuHBGMR/dWGYSa9Ccsrv/k0SO5caqTWYi7tdjybPCeLp9
         VvJETEyaUyJxBGBU9c4SH83LQEdEsGlq+zw4yAr3MQCntTOjHS+QrZezyy2VrbeEy8Tq
         m6oNDblk3WeE2RApYNPKHBSYtu3A/DNCK4rgqj1v+GDFBBxOybbww+BpqMOrrwPXCZAh
         e3Z2TTzESrniRk+KfslAu/OIPVo2hjpUNsmh++UYK2jaBcCchlx6INBHbHFLS9ZsoLN1
         KxPg==
X-Gm-Message-State: AOJu0Yy+ygXqcgbr7Tr7P/7e8p4GgYKmN0jv1ILLLU+mFuLSM4TVCJbf
	oHpW0IhLkFY9iKOLJGLKlhhEnFMWiYJNxILQAV/qzpaDTn3cwhe8XEbtyKydNfdO
X-Gm-Gg: AeBDiev5Uqi82ApSAgI5Pw631naUOQSchSBcF2+Cwkqo8CujtTxiLh36PpBQHEBSd2i
	ZNXnZXv2ev1/GlipdWVczraPpLkvGqz3ki5B44dL1SFxv6avSOj2kSQmOcHqO9fX5uFhyUJv0Pt
	BEPfzlbcd0U59biufmU/hnrzM31W+NBNOEE9yVDZApyjw7BrIWBYinVmiTQxHuE0lIAmdeuDAm8
	Xa5ujSldNkcka15zKLJfw7wyldSJ+R3sHkbt44Xj5FmmksMsk8DXuAfkfgc8KqiKp+XdXW7m6cn
	FSlmPlQFz5/eOlo8b/17A9EMudoZkjMtqqR1qF4OpKOnk9Na3K2EVjAVnRJ5e54hXp9quQV7Mag
	DE1CI2HxTfLjEXQszfLRrTtTGMeaUYLtBhVausAzat94M5rSEJp6xpVg6sERzuERKh1e7t2iMnY
	nVt9f7XghtsmxQtV4sRhyGmqBrQDTaR1XzYYtD
X-Received: by 2002:a05:7301:678f:b0:2da:1874:f3bd with SMTP id 5a478bee46e88-2efb9c8b39fmr1628976eec.16.1777731366414;
        Sat, 02 May 2026 07:16:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.216.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm11713909eec.8.2026.05.02.07.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 07:16:05 -0700 (PDT)
Message-Id: <c5aca53b238a9d0895a3505a088a5a770fee929d.1777731354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 14:15:53 +0000
Subject: [PATCH 6/7] path-walk: add pl_sparse_trees to control tree pruning
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
index 7ef9dc305e..b661c34f7c 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -85,6 +85,7 @@ static int do_backfill(struct backfill_context *ctx)
 
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

