Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE632377000
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474290; cv=none; b=kD9K+oWrR97nZzyF8XDJYVVeEuCEZyTyGTXJ2+tNZaYY3yFbmzOK8t4nxy/4lJekmtGRkY1VFMPShZFBQi7x39blCKgF33IuTVaFWruEjJg6UICkK548kUGU4/r1X5PfzszymwIz0PW4C1Lb8Sru9c4we9UtwWoU53ziszFVdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474290; c=relaxed/simple;
	bh=Qwjpi+H2cI/2gie5PJ2/rD98wQBZOwXMsLA5UYVyAs8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nF29jUNseKNb/t3d9MwP3vn/BovmtUUK2klKxjYC30w3uatvEWHhkEC0at6QHz90NPATUYhhLWxTGFhimVJrm1i46yQtD7zh6do9r7l0YxmFOcjmTWFpDDfq5+8CKvdrqslK9cg1ojcymw1vX7mWI3Ygy30ApNIsDtueLN1rSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxPoibtx; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxPoibtx"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so102016916d6.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474288; x=1780079088; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0a/vLMwlXFwcjZSyjgTzvZ5Xs8lKgyCKHwHrhWwmjCA=;
        b=YxPoibtxCL13UWrF+BCiS3eD+9Ir3K+3pzoRm3qd8JLafsQ+IHYzO9QFN9kllG8drx
         q1iIXuCfzrNYthiWFY3fRDE0AS4DbNqF5NTFn25k8dstS0htb/i3gXQilnJH5ONi3noK
         fNCp7XzJMC96ECcbCnETCz/8U7P7xNZCjdpq8pPwSpDPqP8ZRSMK/qIOJuCnijcLl0NR
         h9UYw6d22ljlM/Q4ZdSVUzZ5/+lG/QhUD8u162zdYf5WUCUg9bEcCK1Y31rAqlihqmGz
         JitNZD/hPuQkbRy89WplSZM8CKifFiFCfLtEB6+E7YyTnUwA5EzjkYa/4X5ioZBJ1XiZ
         Bhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474288; x=1780079088;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0a/vLMwlXFwcjZSyjgTzvZ5Xs8lKgyCKHwHrhWwmjCA=;
        b=dZCCcYSYtyKPDyRKnaa0LKhMvGVQ7HJSfByL1QAKcW854Cq2Pw9Xx35rqfsunRegNs
         2kewkZhpocNoreamlV3a2tqGtMCQyx5Yv5/4/eEJKeM/EZcxR6GqWxrJ5UUAjUlepmPL
         NhCm3HUsNEQ78b8zdshLvBsYk6bErKRFhy2d0zdwEyvmuxNuD5bcXaxqyc2D1SgSCgYe
         h1Ce3PV0rCk89A/pg2WUUsEvGyDHczhj50O/P3phZ0+2QNJDPmid28t0SyjWtXwkXapZ
         rjgDVv+VpRxNR8jDf6v9bVuZsFugHZFm4bkbOleZjRrrRN+gHTaqv64kfVLWw2bGTGsv
         X+Tw==
X-Gm-Message-State: AOJu0YyxYRr9hlQe7v3aqroTK7OBj1Uj3u/kuWPg95Ys7lavfRrfYSNP
	XJSNPDRSzyATShK/671RxD8A0Ixu3p96VIYfRHBiJcfB9OEW2bsRVLNKzpoBerUA
X-Gm-Gg: Acq92OF5XoTbnHZKQ2siR4zJ9QTQv9Jn7VKrJCIaBuE1NaK8QJ08nqNWrKgFHWb7Xod
	/2CNnym07Mi6GkK9wK/32BM/a3uyusdVEVKvTOAqJj84jTkckXJQnloT4aotsjs7OsHQbhcloD9
	lVLC38WWAVLv68WrKw2R39UwqQffQ6eJX3SDyPFk3Z3jbRbBgFyo09E+3hEsERVvgn3lCE6ZLoZ
	kH+JcAu8Sdw/tgu5XKLcAE2fHpv2sA3HcRP4GWK/ME6yXyTNc/aHnPMz8G2w2X1UITTQ/wv/R7c
	ow+Rnm3QQH6HzX6QYN4NYkHHFU6k9K3zYP/ftnQC4jGqetQaJuTFgn9TIofJ26dhUBWkCV91APB
	/2VPba3d7sLIOAtFZ+xge2AY3jRG2UOn6Pzj7cJbzFG+mG7UZfgkSAJWe3YSPhe4tV5h3fFclKA
	wSc03/2A69C5xAjptmd8zh5/yPkMs=
X-Received: by 2002:a05:620a:a418:20b0:914:b850:bbe7 with SMTP id af79cd13be357-914b850c0ebmr395882385a.48.1779474287651;
        Fri, 22 May 2026 11:24:47 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9f199dsm189921885a.36.2026.05.22.11.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:47 -0700 (PDT)
Message-Id: <31b4ef0fa10acc284ce31cd030dc788173471ee1.1779474277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:32 +0000
Subject: [PATCH v5 08/13] path-walk: add pl_sparse_trees to control tree
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
    Taylor Blau <me@ttaylorr.com>,
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
index 04b924d4de..225857bbc8 100644
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
index 60ceb65433..7e57ae5f65 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -76,8 +76,14 @@ struct path_walk_info {
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
index 45f366d738..02ad83dfb0 100755
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

