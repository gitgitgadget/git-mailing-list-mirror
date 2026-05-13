Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975EE2FF147
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707155; cv=none; b=e6KZ+aGyiqjcRSvkxERFn1GVAl3yyw8ZTMFveVNk8sY1tWmgXEFPdbm88+ZK0vvDMpKKPVcYBZOj/wPPvA0j4S7t6441OH1GpqPR2T2W0F+ZjxNtXE+o5TfDuT0ob34ESYUX7/+Ze9aeOxLMYMltDOHxR4P4J3rV4IrubWchDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707155; c=relaxed/simple;
	bh=Qwjpi+H2cI/2gie5PJ2/rD98wQBZOwXMsLA5UYVyAs8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Vdp7Pi/St6wSfGb2+Uby8yPbbvivhMVLGrOvqadJc0W1+29Ro+0aNMrGPHYt+oPG5GXXeT/Fp8VCtcNQUHhGmU6sI+MeS4nTGH5Ju4wsT/Oi4Dr8PlGnC/erUHSD62v3kBV9GXsrHu0ZfARF9QLwsxGfcZLqdXUpE+Vz+84IUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2h5uJZ0; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2h5uJZ0"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so17346504eec.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707151; x=1779311951; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0a/vLMwlXFwcjZSyjgTzvZ5Xs8lKgyCKHwHrhWwmjCA=;
        b=i2h5uJZ0WPD6n/m8X3LzO5fgExt5ZvSkZ2CLsJcoxhy28ySaWwJGSAAundFi91FgIh
         O8noRyJCe6uJPzXlDC9T3MSTARsFQ6u1s0+t9Nv9qasRoUDXPL/ABRDztDd/UG5Hlo4p
         WbsUtbUwsQeW1cvGvdeM3bd0ulbmdg4HD9Ecx9aWWG9XwlK4Dbmkc/rC7gJB1e72Vo9c
         rZ/t/vOmYkEspBuFbPNAdI0qDlRNS0lvxibI32H+3ZWU8uuI0P1M8E1v/4y+kHtwsExo
         HPPAl0UWS8WI3BCL2zya7UNnZ1LVQ6tmsAdeGn5jIoWZg8FmnjwP1UHM44xL0ZcYe5TI
         40NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707151; x=1779311951;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0a/vLMwlXFwcjZSyjgTzvZ5Xs8lKgyCKHwHrhWwmjCA=;
        b=PJXHyYpUAIAeTgC37qeSVLOuLC98npT7ecxerz44WgGUOvHQ/EQjOcDQ9P28oicSyV
         Tb+ULbvQtK8BU7qhR/pgqf21OOVWJIxWSwkBRK5gLtRJ8cKEy7iSp8UrJViJ6RcijPy4
         J308BKamyFHmPx6FmBmbBc9IHLOleF1Tl882U+bFgQSWm/+FMV5lX+qBPYmu8fxThXnm
         tRtuvpvBUYHSIkWS89eSC2/1im8cSrpbqYM3HjJJtwFOc7W8jrrvNnBfXU8SUcXXcpsB
         GGfSuy1YG5klpliqiPlsFHDCzyMh71sF66ILSm4Dhvf1T4LP3lBfqLyLruqjH3of2OfN
         N/Ag==
X-Gm-Message-State: AOJu0YyDQcjnomrjI1BjYu71ipR8w4o0A1z5hZs2UD6rvDxLF3//1m9t
	UTsux8aal4ClgJ9GYBzPhMy9U8l3dlZANhay/DuM1hM3guYDMXULaQlc1D+JIV20
X-Gm-Gg: Acq92OG7k5TqK2cg/bsjxQRmi6Gwe1KujBEbIDbxYxluF5LtNb+n8PELxKx8+lOPrjc
	LHPLgckzXRSQh5efGgfGfSes0KuaQUMmvpkPPPKmNrBTkFfqPdl8mTnbC5ofqkjSgyN3h4voHf+
	AzEjHE1CuHCwAAdWbjYXi6RX9nqEjZ4VHswvPAvjYW/MR6//q9AW6imTqpr5iBTVLKaLPqubQ85
	AwhhhJlBrZf6UVm1cRIPnmw7Xt83xqEgWAcbp2DUGSdJHun1ZarJtTvxmqhIk90kJCEfrvh/2bY
	izfq03wXw2QtrPkUvtxqQeKOXN+HU+57g1joxtHtbtg/g7XNherePtv6fb6x9kt3X5JohJf8vIf
	NXNooD4OOYCB8nhuVSSz6p+YDKVwV1whI0Zcc1Vs0BjfEaouXqacBoeM/Bt39IXuziT5Y2cJhpD
	i8P2K/SJOXGrkKJ+esZ81uj6dlhnfTQW+fDyiv
X-Received: by 2002:a05:7301:d09:b0:2f1:496c:94bf with SMTP id 5a478bee46e88-30118da95c6mr3039417eec.16.1778707151247;
        Wed, 13 May 2026 14:19:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302944ffdf0sm570643eec.8.2026.05.13.14.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:19:10 -0700 (PDT)
Message-Id: <0f517be8e3853e05d313258133db4eab229d3835.1778707135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
	<pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 21:18:50 +0000
Subject: [PATCH v4 08/13] path-walk: add pl_sparse_trees to control tree
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

