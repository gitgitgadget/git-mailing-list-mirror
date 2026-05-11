Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2D47AF61
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523205; cv=none; b=FgfscNp68aSQvKvMaDUXcRDrIgfX7HD285ATil1XriHmia/SyVP+181iLWBH193d4IfGEFNe1e8t6UDMM78B13HXc3s4lW3n8psHfqyNot6UtRNviimzDmw+MqEk8ErqBGorZv7b8CfpHSnG5ACQmvNQuer6f1xJ4IpsKzwnliI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523205; c=relaxed/simple;
	bh=d2DVRHNhRxB/oQQNVRha8mpoOW/glRv0wUhfS8Qg8AU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mkVwc3EdiOMeN4qIPBkhW8LDUcSIbnHCZ4LmSERvcx7nD25xoYFGOY8Hhw9BMNAjDoMWE28jrndX8kmOnVfppgtJjAszWnJKcfY4nGZbiaFnH+VtPr3lakgUwWdSCKcN9R34YG/8JukpWyNuXF4xGSvX8GrINLRUAopkaB6oANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eleJi8DU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eleJi8DU"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7b37d84a6b3so45182087b3.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523202; x=1779128002; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdS1Huc/7DbWYb59+/1qcoOrnSr76gepnafe5vZvx+g=;
        b=eleJi8DUkpXqtBhElYceDi18u+zb3ClzRWkIm4gFqeB6FNaUsWNZdldpW4sYzeag70
         6sgGEIY4pcaBUitoLGn3/DfBR2mGahp21nwD1ODLPXL1OqhLnoQICtimMlHODrtAfLtu
         2DsrJoJhZFnAuna+x/0d2FUMzg/qVqL2iTZkw4cwh0pCDAFioCQwOwuTq/yzZ/hgwYPa
         MqEF8/+oh+v5nQeNsSZJdENnURgZnYAFWWngxtpHSCVIMSnmg5UPF71IKlgOcUggWyfK
         k/mmKOk9ILj7GiGRJ6wW11Th3ynlA3vh3KrWu4O/l19heUEEDD3gaeAKEgeK4I5Bft8z
         dSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523202; x=1779128002;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdS1Huc/7DbWYb59+/1qcoOrnSr76gepnafe5vZvx+g=;
        b=UF4vCIl3wMb3qukwXBgVV0nC7sWkMU9kE0D1hzn4wzDsZHjc/yo4ELsDXTFqeZcoyk
         0+AnuSW8Iajssy9Iav70GgOLjWvyUTmaDk9iwplhGrDi/TyDnfgY2jF5z7ZytbQRlxhv
         jS5lJvRi0kbzmvBp6pujBGxWGYyY7gOsmAOErJfODEJ1nnKMBH3NM9Jbr94G5QCr8Rjm
         zwRtnrjnFaFZgl10n68xVv8VIfMDZSDVAkNDTTjxgnVlA9cgQn+jjeI7iVe3vExjNdM7
         dmbAQOliEHOyoL7oW63ipPgWSsZlZaDXjU3y2gLdPI+h+nUL8hwqNj7mmM/DmttN0DZu
         AzBw==
X-Gm-Message-State: AOJu0YxfH/L+6mFabnKTjD8/okbPaPNdLPI2rRc2A/OPNKGIOk93pOBM
	0SvnWY4BusVjO8jfs+EbcBTmUFABn3s83AWuZTld1oa8GUeEAJUXedA6pLYs7Q==
X-Gm-Gg: Acq92OEHD8CNGXr2docbp124iML5hAdarKEZQ2XEcA8OSrYMZfHwUZ27ApgHVg09Sby
	Hh7lxGZFaQfk6/Jd7gldu7bFFd2dW+Th99aSfds7QIOpdAK2wHlHTjp1OvpZVrCQ1xBwPGlbCYV
	whTdqgx/jt0DTYn7awVn/WOw5zvUJ0lbkF5iTq/gJaZpxuwZYThigDees8rxKnnRtm/ZYuQcJZq
	aDoIzfKTjvU69QO1iK3P9DAq324sfSddrHdhLWb500rn9yl2h95oYTEbR1RDud338EUNaER6btN
	F0p8I45aGeMVeiZeybhSVxp3QNFsAlCmTicWLoH+DoXeFJYazHQe2EMHzcJrDwxRRGmDjMCNApN
	GZy7XQPU9VDsExOfloRbRm1fAEw7aHMuyhSX8XIuqVF3pGWBSOkCrteqCioa2goG0vml8SGPuBJ
	HD7VVJyXTXR0E8JNaIv1jgqwAuCg==
X-Received: by 2002:a05:690c:93:b0:7bf:107b:e77a with SMTP id 00721157ae682-7c104da8826mr99160917b3.30.1778523202430;
        Mon, 11 May 2026 11:13:22 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.164])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685bfd4sm151430047b3.33.2026.05.11.11.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:21 -0700 (PDT)
Message-Id: <2360a5be812b6f8f7e9ccb36e8b5f3347ec646f5.1778523189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
	<pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 18:13:05 +0000
Subject: [PATCH v3 08/12] path-walk: add pl_sparse_trees to control tree
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
index 16fdfd7c5a..21cc40c392 100644
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

