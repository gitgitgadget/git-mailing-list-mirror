Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CC28850B
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749077; cv=none; b=TRHVSJSAJpBDJzjBn9uuo4qzPW6FsakPwzIvRCAKO2kh/0B+qEzGZZx/Zi4gmYQjcT2XVI1n0HdYyHJZYIR9qxsANmBjGRVqRLc6yIgbWolm+aNUQm1dD+pinI6rJy7JRs4WDbBYwFTRMsCPrUy8pX1kLFvCTTejT58fo5SCLcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749077; c=relaxed/simple;
	bh=Tp5oLre/Mo3CIc2DYQ+nPpLxKc59CoAS7ZXduBcOt6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ps/ylPlxslK7oILbxNxyvfJHMu82nEdFeqFiubqp6VhW2k09xnep0fl+vTkmR8JVSgQdih7jkK82M3q/ZgZY44MyAxkNxXmrqgTEdgUCtYAUyRy7Vgy7M+bNt5goXRAO4EfrW53dEaT35vmgHRPysfAqr9T8iFfq18us5bpCl04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmuOrv5n; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmuOrv5n"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-746d3b0f7e5so297391a34.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758749075; x=1759353875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXQfI7B8U4dtHvX6xKFCsM4pwwK4FDMJIr4ZfwpDWK8=;
        b=YmuOrv5nuo/+0bR7Xqgd9PtH/FVXI0EUoOgPS73oftj6sjSUM3XsYHCHeOtKk4Hwxs
         Rv792+YXl/lGVJOlEeBBAqca7QIF7oVGAvjTX4I/f7pKCjWHfXN/8eXtqvXSyvl5G0tO
         ON79xV+laZ3Dn1/jTuX5bVCMjMUHX90+O+08kUYbnZ+lnWJ7CNjyCH8370CRyJYNwc7A
         q+dJ+IK7pOM1m5j8I0/kVUrefViNlMoX7oMrDDuYdLAbDOm2ifWy0m3VEM7lTtyzW1R9
         5x9pzJiEICKPPQaYOacUTEqQ4vLGL+T+JY38jAFrkgjq7PcabKuHGFIZDicj+N3JytJl
         w1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749075; x=1759353875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXQfI7B8U4dtHvX6xKFCsM4pwwK4FDMJIr4ZfwpDWK8=;
        b=FnzoiuF/9kr6c7s4KZuJeePjIjwLZq8lOUeetrytCpfXYrvApcNF9S/sZ6zPXiT+JA
         jhnBBr48ocKmKFANxeT6v/0mRBUwQ8ONUhffAEElPluzdedaK2WBNdeL/yvu+MjAAWLN
         x8YpXT1uGYdilOH08032Rmh93tJxINahlyv+XNVx5huryLZtyWNYkUSmluHN9zkxkY4z
         R9Sb9HftOMmDihEgeTdsnvuxrsScmIJcNqNXBasfZd8QV+1fq8ilQkfR60IbKz3xnuHu
         xVxMa6MXpyllVphobkLwPF6cbzOlVM+pxigKrxVQYnJ0W/5u1fkXdvYWjoa+jaoryz2+
         v1QA==
X-Gm-Message-State: AOJu0Yw4bSIs0Q6vA+enFNtoPjgQvBgsSyaUesAORIE378wg48ZYc7MH
	k8bgY4YZXhWguZG2oH3JAIbMzaLac+j0OvoXFW/KpyuiekE+4DCa3We5fN+OoQ==
X-Gm-Gg: ASbGncurw7BbzNtLD+P1MLTthO+eMhIjvxQNOzMsckNwwsLCkp9uEgQWla5Iq74Seah
	q3jrv0F00odIR9YqjlFmmC0G4ZleXeX7XSmsEkEuteo9iUdAUnFllMqR5sTuFz04+2VCKh1+JVw
	B7cVqyi4r30YdiDbCtdBsq1EfZJNFwqHysUaAIRJkHZqxfMi2GHCUIbKXgcVJ/Fos554kghu8w+
	R+G78IlxFKwMDALmPv0OlZb4JtmWyMJfxeNI5xNJZVJd3uWAJ3OYlDmqi6fifz+T455zobKPEd5
	0wFVZziy5u4asKDN7+1HpmGeOhOn0tgNHmnhpix+/aRQbOHJK/P2y7tnEN9+Q11AyKhMtIhvTfQ
	XCl6+PJ7bt4est3O8GvQ4VJLzGjrcz5StTLjNQD58gg==
X-Google-Smtp-Source: AGHT+IH0VGCUjXRJ/9vp5Su8XwUbNCWbB286DbsVEYJQaRhQ90m0V6TPmpQnllzn2WOeE5moe4hgUA==
X-Received: by 2002:a05:6808:1998:b0:437:eb1d:cddb with SMTP id 5614622812f47-43f4cbf33e9mr794828b6e.1.1758749074637;
        Wed, 24 Sep 2025 14:24:34 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f46f5dbdcsm400117b6e.12.2025.09.24.14.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:24:34 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/6] builtin/repo: add object counts in stats output
Date: Wed, 24 Sep 2025 16:24:24 -0500
Message-ID: <20250924212426.2930029-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250924212426.2930029-1-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The amount of objects in a repository can provide insight regarding its
shape. To surface this information, use the path-walk API to count the
number of reachable objects in the repository by object type. All
regular references are used to determine the reachable set of objects.
The object counts are appended to the same table containing the
reference information.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  1 +
 builtin/repo.c              | 91 +++++++++++++++++++++++++++++++++++--
 t/t1901-repo-stats.sh       | 51 +++++++++++++--------
 3 files changed, 121 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index a009bf8cf1..0b8d74ed3e 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -49,6 +49,7 @@ supported:
 	of information are reported:
 +
 * Reference counts categorized by type
+* Reachable object counts categorized by type
 
 +
 The table output format may change and is not intended for machine parsing.
diff --git a/builtin/repo.c b/builtin/repo.c
index 32ddf2350e..8f130bca66 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -3,9 +3,11 @@
 #include "builtin.h"
 #include "environment.h"
 #include "parse-options.h"
+#include "path-walk.h"
 #include "quote.h"
 #include "ref-filter.h"
 #include "refs.h"
+#include "revision.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "shallow.h"
@@ -166,6 +168,18 @@ struct ref_stats {
 	size_t others;
 };
 
+struct object_stats {
+	size_t tags;
+	size_t commits;
+	size_t trees;
+	size_t blobs;
+};
+
+struct repo_stats {
+	struct ref_stats refs;
+	struct object_stats objects;
+};
+
 struct stats_table {
 	struct string_list rows;
 
@@ -213,8 +227,11 @@ static void stats_table_add_count(struct stats_table *table, const char *format,
 	stats_table_add(table, format, name, entry);
 }
 
-static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
+static void stats_table_setup(struct stats_table *table, struct repo_stats *stats)
 {
+	struct object_stats *objects = &stats->objects;
+	struct ref_stats *refs = &stats->refs;
+	size_t object_total;
 	size_t ref_total;
 
 	ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
@@ -224,6 +241,15 @@ static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
 	stats_table_add_count(table, "    * %s", _("Tags"), refs->tags);
 	stats_table_add_count(table, "    * %s", _("Remotes"), refs->remotes);
 	stats_table_add_count(table, "    * %s", _("Others"), refs->others);
+
+	object_total = objects->commits + objects->trees + objects->blobs + objects->tags;
+	stats_table_add(table, "%s", "", NULL);
+	stats_table_add(table, "* %s", _("Reachable objects"), NULL);
+	stats_table_add_count(table, "  * %s", _("Count"), object_total);
+	stats_table_add_count(table, "    * %s", _("Commits"), objects->commits);
+	stats_table_add_count(table, "    * %s", _("Trees"), objects->trees);
+	stats_table_add_count(table, "    * %s", _("Blobs"), objects->blobs);
+	stats_table_add_count(table, "    * %s", _("Tags"), objects->tags);
 }
 
 static inline size_t max_size_t(size_t a, size_t b)
@@ -310,25 +336,82 @@ static void stats_count_references(struct ref_stats *stats, struct ref_array *re
 	}
 }
 
+static int count_objects(const char *path UNUSED, struct oid_array *oids,
+			 enum object_type type, void *cb_data)
+{
+	struct object_stats *stats = cb_data;
+
+	switch (type) {
+	case OBJ_TAG:
+		stats->tags += oids->nr;
+		break;
+	case OBJ_COMMIT:
+		stats->commits += oids->nr;
+		break;
+	case OBJ_TREE:
+		stats->trees += oids->nr;
+		break;
+	case OBJ_BLOB:
+		stats->blobs += oids->nr;
+		break;
+	default:
+		BUG("invalid object type");
+	}
+
+	return 0;
+}
+
+static void stats_count_objects(struct object_stats *stats,
+				struct ref_array *refs, struct rev_info *revs)
+{
+	struct path_walk_info info = PATH_WALK_INFO_INIT;
+
+	info.revs = revs;
+	info.path_fn = count_objects;
+	info.path_fn_data = stats;
+
+	for (int i = 0; i < refs->nr; i++) {
+		struct ref_array_item *ref = refs->items[i];
+
+		switch (ref->kind) {
+		case FILTER_REFS_BRANCHES:
+		case FILTER_REFS_TAGS:
+		case FILTER_REFS_REMOTES:
+		case FILTER_REFS_OTHERS:
+			add_pending_oid(revs, NULL, &ref->objectname, 0);
+			break;
+		default:
+			BUG("unexpected reference type");
+		}
+	}
+
+	walk_objects_by_path(&info);
+	path_walk_info_clear(&info);
+}
+
 static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
-			  const char *prefix UNUSED, struct repository *repo UNUSED)
+			  const char *prefix, struct repository *repo)
 {
 	struct ref_filter filter = REF_FILTER_INIT;
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
 	};
-	struct ref_stats stats = { 0 };
+	struct repo_stats stats = { 0 };
 	struct ref_array refs = { 0 };
+	struct rev_info revs;
 
+	repo_init_revisions(repo, &revs, prefix);
 	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
 		die(_("unable to filter refs"));
 
-	stats_count_references(&stats, &refs);
+	stats_count_references(&stats.refs, &refs);
+	stats_count_objects(&stats.objects, &refs, &revs);
 
 	stats_table_setup(&table, &stats);
 	stats_table_print(&table);
 
 	stats_table_clear(&table);
+	release_revisions(&revs);
 	ref_array_clear(&refs);
 
 	return 0;
diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
index 535ac511dd..315b9e1767 100755
--- a/t/t1901-repo-stats.sh
+++ b/t/t1901-repo-stats.sh
@@ -10,14 +10,21 @@ test_expect_success 'empty repository' '
 	(
 		cd repo &&
 		cat >expect <<-\EOF &&
-		| Repository stats | Value |
-		| ---------------- | ----- |
-		| * References     |       |
-		|   * Count        |     0 |
-		|     * Branches   |     0 |
-		|     * Tags       |     0 |
-		|     * Remotes    |     0 |
-		|     * Others     |     0 |
+		| Repository stats    | Value |
+		| ------------------- | ----- |
+		| * References        |       |
+		|   * Count           |     0 |
+		|     * Branches      |     0 |
+		|     * Tags          |     0 |
+		|     * Remotes       |     0 |
+		|     * Others        |     0 |
+		|                     |       |
+		| * Reachable objects |       |
+		|   * Count           |     0 |
+		|     * Commits       |     0 |
+		|     * Trees         |     0 |
+		|     * Blobs         |     0 |
+		|     * Tags          |     0 |
 		EOF
 
 		git repo stats >out 2>err &&
@@ -27,28 +34,36 @@ test_expect_success 'empty repository' '
 	)
 '
 
-test_expect_success 'repository with references' '
+test_expect_success 'repository with references and objects' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
 		cd repo &&
-		git commit --allow-empty -m init &&
+		test_commit_bulk 42 &&
 		git tag -a foo -m bar &&
 
 		oid="$(git rev-parse HEAD)" &&
 		git update-ref refs/remotes/origin/foo "$oid" &&
 
+		# Also creates a commit, tree, and blob.
 		git notes add -m foo &&
 
 		cat >expect <<-\EOF &&
-		| Repository stats | Value |
-		| ---------------- | ----- |
-		| * References     |       |
-		|   * Count        |     4 |
-		|     * Branches   |     1 |
-		|     * Tags       |     1 |
-		|     * Remotes    |     1 |
-		|     * Others     |     1 |
+		| Repository stats    | Value |
+		| ------------------- | ----- |
+		| * References        |       |
+		|   * Count           |     4 |
+		|     * Branches      |     1 |
+		|     * Tags          |     1 |
+		|     * Remotes       |     1 |
+		|     * Others        |     1 |
+		|                     |       |
+		| * Reachable objects |       |
+		|   * Count           |   130 |
+		|     * Commits       |    43 |
+		|     * Trees         |    43 |
+		|     * Blobs         |    43 |
+		|     * Tags          |     1 |
 		EOF
 
 		git repo stats >out 2>err &&
-- 
2.51.0.193.g4975ec3473b

