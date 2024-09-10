Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37A558BA
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935342; cv=none; b=DtkK3AHfVdZKRmuiXrOzGQaztI8byhC9YSxnRwU659ZYsx1vtkYwqcnPS04B4chP9Or6zKoN1MxDCnJ0YfYOZSBNqiaALSXpsU8V5brQwQEqTxkNUwxd0nlWiwz+Z05yPViHRmd1hfZPTkWKmxdk+lieyso4cvLuwZqnrczRSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935342; c=relaxed/simple;
	bh=6bAXoeDab+vsodc2K4BXkLNy/Uln74I4PM95nrVpQpc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WzCr9LUMfVhVP4DO4NHULaz2fGHLomNC73XtzO9hCuMTtovoKVEpy4d5y7cSyd2Ni6d3AUDQaENypYxBiLjMPNC/7uQ+ePnjI66apzugcECPMyX2LEy2+LBwBcOAX7yoZFoL5ZQgK3lyGxFOSSJaHceGE9ASwFActOolS+/bB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+i3SVMl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+i3SVMl"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a80eab3945eso472231566b.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935338; x=1726540138; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WWOMy4WIUWhxeKz0gGI2lTYbTiCTB1FXD5uAnefrxM=;
        b=J+i3SVMl9NPzZwco46r0+XTSytu56VN4bOhnZ2J3GDe7PTWbhpzjjatgi+tNUE68iE
         HCg3HM/kGdAStryEZNZONBoMJvGmPH8BQAqLfTtwT7Iitq7b2lBk76Bj1pRVQJDRpw9c
         p/fXyz8hArUSZdzysbNlMQUAU91ShUN1CHIKtNcJeAiNGisxSYDlU4gVjCXH88SCzrsa
         kajQwMWa7AT0uzfyt7PSyOUSdHrOKeNRroXQNEZuQv16NanoAq9rfs7WyFIyCeh8DdIx
         kNc0hpPRyHm8twqFfM0Z3q0olglSmyr2EpP01ytKqax2iimB0dNuHOWZsc02s3Cl53dL
         x4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935338; x=1726540138;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WWOMy4WIUWhxeKz0gGI2lTYbTiCTB1FXD5uAnefrxM=;
        b=Ev2Iqf6ci4AGDc5ZuDEreOh9mOO//3GZHBE2KdVJ95xx/fF77EqAgHk9RNg5H5yoPb
         KCtAPLzkQJ/QFFo1BuHFXlCe4tOiNuZAhuCj0Q0Bm9mnKlafouyOv9ixBsJzu31y1kPV
         fEQXxzybZn1YsoNmb1+LjmvpwXaS6HG/kFFWiNZgs/h1e5RUyPtCg/OjWB4UomVmg471
         FQeMjs/eyr7VxSucq+MZsvIK6TCVu4yAGjGAe7vqP79t75MRRkSIiDlVYtod3e7F6k0h
         SFPc1bBvzRunpMQ7HP+Ikm37MKUeS61QJ5uanX/K0uUN07zqbW10zsZkBS5ni9qHigX5
         bzfA==
X-Gm-Message-State: AOJu0YyVYc73KOpAixYogvggh+HtOMyF4NH4UPw7ojaIiKFQ0L7aZhQO
	4qEKm9Q7yZRTbTOtjeLIfuTKms1RRh0gW++98pNqzBexeo3vNhdiW3q8Xg==
X-Google-Smtp-Source: AGHT+IEYUH3tlJ9ahlXl/x93XoK8gBLBLcr+O8Y0PehmXwnURxXMjt+BuFvhcKUDennPHMVI2Wd6BQ==
X-Received: by 2002:a17:907:3687:b0:a86:b923:4a04 with SMTP id a640c23a62f3a-a8a887fcdbemr1007695366b.50.1725935337745;
        Mon, 09 Sep 2024 19:28:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c61258sm413909166b.116.2024.09.09.19.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:28:57 -0700 (PDT)
Message-Id: <a53bd0d37606c890d2fd2b715ce0bc92ff787b66.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:26 +0000
Subject: [PATCH 01/30] path-walk: introduce an object walk by path
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In anticipation of a few planned applications, introduce the most basic form
of a path-walk API. It currently assumes that there are no UNINTERESTING
objects, and does not include any complicated filters. It calls a function
pointer on groups of tree and blob objects as grouped by path. This only
includes objects the first time they are discovered, so an object that
appears at multiple paths will not be included in two batches.

There are many future adaptations that could be made, but they are left for
future updates when consumers are ready to take advantage of those features.

RFC TODO: It would be helpful to create a test-tool that allows printing of
each batch for strong testing.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Makefile    |   1 +
 path-walk.c | 235 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 path-walk.h |  43 ++++++++++
 3 files changed, 279 insertions(+)
 create mode 100644 path-walk.c
 create mode 100644 path-walk.h

diff --git a/Makefile b/Makefile
index deb175a0408..e83f6de9a2c 100644
--- a/Makefile
+++ b/Makefile
@@ -1090,6 +1090,7 @@ LIB_OBJS += parse-options.o
 LIB_OBJS += patch-delta.o
 LIB_OBJS += patch-ids.o
 LIB_OBJS += path.o
+LIB_OBJS += path-walk.o
 LIB_OBJS += pathspec.o
 LIB_OBJS += pkt-line.o
 LIB_OBJS += preload-index.o
diff --git a/path-walk.c b/path-walk.c
new file mode 100644
index 00000000000..2edfa0572e4
--- /dev/null
+++ b/path-walk.c
@@ -0,0 +1,235 @@
+/*
+ * path-walk.c: implementation for path-based walks of the object graph.
+ */
+#include "git-compat-util.h"
+#include "path-walk.h"
+#include "blob.h"
+#include "commit.h"
+#include "dir.h"
+#include "hashmap.h"
+#include "hex.h"
+#include "object.h"
+#include "oid-array.h"
+#include "revision.h"
+#include "string-list.h"
+#include "strmap.h"
+#include "trace2.h"
+#include "tree.h"
+#include "tree-walk.h"
+
+struct type_and_oid_list
+{
+	enum object_type type;
+	struct oid_array oids;
+};
+
+#define TYPE_AND_OID_LIST_INIT { \
+	.type = OBJ_NONE, 	 \
+	.oids = OID_ARRAY_INIT	 \
+}
+
+struct path_walk_context {
+	/**
+	 * Repeats of data in 'struct path_walk_info' for
+	 * access with fewer characters.
+	 */
+	struct repository *repo;
+	struct rev_info *revs;
+	struct path_walk_info *info;
+
+	/**
+	 * Map a path to a 'struct type_and_oid_list'
+	 * containing the objects discovered at that
+	 * path.
+	 */
+	struct strmap paths_to_lists;
+
+	/**
+	 * Store the current list of paths in a stack, to
+	 * facilitate depth-first-search without recursion.
+	 */
+	struct string_list path_stack;
+};
+
+static int add_children(struct path_walk_context *ctx,
+			const char *base_path,
+			struct object_id *oid)
+{
+	struct tree_desc desc;
+	struct name_entry entry;
+	struct strbuf path = STRBUF_INIT;
+	size_t base_len;
+	struct tree *tree = lookup_tree(ctx->repo, oid);
+
+	if (!tree) {
+		error(_("failed to walk children of tree %s: not found"),
+		      oid_to_hex(oid));
+		return -1;
+	}
+
+	strbuf_addstr(&path, base_path);
+	base_len = path.len;
+
+	parse_tree(tree);
+	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
+	while (tree_entry(&desc, &entry)) {
+		struct type_and_oid_list *list;
+		struct object *o;
+		/* Not actually true, but we will ignore submodules later. */
+		enum object_type type = S_ISDIR(entry.mode) ? OBJ_TREE : OBJ_BLOB;
+
+		/* Skip submodules. */
+		if (S_ISGITLINK(entry.mode))
+			continue;
+
+		if (type == OBJ_TREE) {
+			struct tree *child = lookup_tree(ctx->repo, &entry.oid);
+			o = child ? &child->object : NULL;
+		} else if (type == OBJ_BLOB) {
+			struct blob *child = lookup_blob(ctx->repo, &entry.oid);
+			o = child ? &child->object : NULL;
+		} else {
+			/* Wrong type? */
+			continue;
+		}
+
+		if (!o) /* report error?*/
+			continue;
+
+		/* Skip this object if already seen. */
+		if (o->flags & SEEN)
+			continue;
+		o->flags |= SEEN;
+
+		strbuf_setlen(&path, base_len);
+		strbuf_add(&path, entry.path, entry.pathlen);
+
+		/*
+		 * Trees will end with "/" for concatenation and distinction
+		 * from blobs at the same path.
+		 */
+		if (type == OBJ_TREE)
+			strbuf_addch(&path, '/');
+
+		if (!(list = strmap_get(&ctx->paths_to_lists, path.buf))) {
+			CALLOC_ARRAY(list, 1);
+			list->type = type;
+			strmap_put(&ctx->paths_to_lists, path.buf, list);
+			string_list_append(&ctx->path_stack, path.buf);
+		}
+		oid_array_append(&list->oids, &entry.oid);
+	}
+
+	free_tree_buffer(tree);
+	strbuf_release(&path);
+	return 0;
+}
+
+/*
+ * For each path in paths_to_explore, walk the trees another level
+ * and add any found blobs to the batch (but only if they don't
+ * exist and haven't been added yet).
+ */
+static int walk_path(struct path_walk_context *ctx,
+		     const char *path)
+{
+	struct type_and_oid_list *list;
+	int ret = 0;
+
+	list = strmap_get(&ctx->paths_to_lists, path);
+
+	/* Evaluate function pointer on this data. */
+	ret = ctx->info->path_fn(path, &list->oids, list->type,
+				 ctx->info->path_fn_data);
+
+	/* Expand data for children. */
+	if (list->type == OBJ_TREE) {
+		for (size_t i = 0; i < list->oids.nr; i++) {
+			ret |= add_children(ctx,
+					    path,
+					    &list->oids.oid[i]);
+		}
+	}
+
+	oid_array_clear(&list->oids);
+	strmap_remove(&ctx->paths_to_lists, path, 1);
+	return ret;
+}
+
+static void clear_strmap(struct strmap *map)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	hashmap_for_each_entry(&map->map, &iter, e, ent) {
+		struct type_and_oid_list *list = e->value;
+		oid_array_clear(&list->oids);
+	}
+	strmap_clear(map, 1);
+	strmap_init(map);
+}
+
+/**
+ * Given the configuration of 'info', walk the commits based on 'info->revs' and
+ * call 'info->path_fn' on each discovered path.
+ *
+ * Returns nonzero on an error.
+ */
+int walk_objects_by_path(struct path_walk_info *info)
+{
+	const char *root_path = "";
+	int ret = 0;
+	size_t commits_nr = 0, paths_nr = 0;
+	struct commit *c;
+	struct type_and_oid_list *root_tree_list;
+	struct path_walk_context ctx = {
+		.repo = info->revs->repo,
+		.revs = info->revs,
+		.info = info,
+		.path_stack = STRING_LIST_INIT_DUP,
+		.paths_to_lists = STRMAP_INIT
+	};
+
+	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
+
+	/* Insert a single list for the root tree into the paths. */
+	CALLOC_ARRAY(root_tree_list, 1);
+	root_tree_list->type = OBJ_TREE;
+	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
+
+	if (prepare_revision_walk(info->revs))
+		die(_("failed to setup revision walk"));
+
+	while ((c = get_revision(info->revs))) {
+		struct object_id *oid = get_commit_tree_oid(c);
+		struct tree *t = lookup_tree(info->revs->repo, oid);
+		commits_nr++;
+
+		if (t)
+			oid_array_append(&root_tree_list->oids, oid);
+		else
+			warning("could not find tree %s", oid_to_hex(oid));
+	}
+
+	trace2_data_intmax("path-walk", ctx.repo, "commits", commits_nr);
+	trace2_region_leave("path-walk", "commit-walk", info->revs->repo);
+
+	string_list_append(&ctx.path_stack, root_path);
+
+	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
+	while (!ret && ctx.path_stack.nr) {
+		char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;
+		ctx.path_stack.nr--;
+		paths_nr++;
+
+		ret = walk_path(&ctx, path);
+
+		free(path);
+	}
+	trace2_data_intmax("path-walk", ctx.repo, "paths", paths_nr);
+	trace2_region_leave("path-walk", "path-walk", info->revs->repo);
+
+	clear_strmap(&ctx.paths_to_lists);
+	string_list_clear(&ctx.path_stack, 0);
+	return ret;
+}
diff --git a/path-walk.h b/path-walk.h
new file mode 100644
index 00000000000..c9e94a98bc8
--- /dev/null
+++ b/path-walk.h
@@ -0,0 +1,43 @@
+/*
+ * path-walk.h : Methods and structures for walking the object graph in batches
+ * by the paths that can reach those objects.
+ */
+#include "object.h" /* Required for 'enum object_type'. */
+
+struct rev_info;
+struct oid_array;
+
+/**
+ * The type of a function pointer for the method that is called on a list of
+ * objects reachable at a given path.
+ */
+typedef int (*path_fn)(const char *path,
+		       struct oid_array *oids,
+		       enum object_type type,
+		       void *data);
+
+struct path_walk_info {
+	/**
+	 * revs provides the definitions for the commit walk, including
+	 * which commits are UNINTERESTING or not.
+	 */
+	struct rev_info *revs;
+
+	/**
+	 * The caller wishes to execute custom logic on objects reachable at a
+	 * given path. Every reachable object will be visited exactly once, and
+	 * the first path to see an object wins. This may not be a stable choice.
+	 */
+	path_fn path_fn;
+	void *path_fn_data;
+};
+
+#define PATH_WALK_INFO_INIT { 0 }
+
+/**
+ * Given the configuration of 'info', walk the commits based on 'info->revs' and
+ * call 'info->path_fn' on each discovered path.
+ *
+ * Returns nonzero on an error.
+ */
+int walk_objects_by_path(struct path_walk_info *info);
-- 
gitgitgadget

