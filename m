Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C6210F59
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596230; cv=none; b=QXstIvws2IWccJK8g33I+dqnlIb2r7a7wjWJwzrYzywajAb+uLqN/AV0VPsdx5xFt2lxdaBku1mQuGK35821rXyGcfBz791GJJdmiZ7ygtkMnD1ybrn1KR+ignbwFmhXggdxhyEkeVHgX57hjBC/+mFS0HOPFYqq660cQg5WBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596230; c=relaxed/simple;
	bh=i3XNIguDAAZ8SR1VDm8+utsDr3HYnjv+IAeMc6EF63o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnFeCw6kWvTW/y2/ZVithubNL3JdjjT6pxgKlfblVfJnWUz0E3CX690QrRvoTgS8dIN0O8Ir9XOpYg8wePb1m5O9BJs8siiZ7k+yEvh+bmp5zfEN0EJUbhsFO4MLMIBzEtsk3DJkenQMqr/L2arEE8Rr8SbvD5J2ikZ9GLBLq/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HywiqQ9x; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HywiqQ9x"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-31d6b8be249so4715734fac.0
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 19:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758596227; x=1759201027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ics1wQ4DXeJRB2kfp6XvXrArCS+erR5it3jxuaZFils=;
        b=HywiqQ9xAGw7/0qDEo11N8YNSJMGMqwJDUNbx3/eK9fB9SMdbNApay+aEcdCOb0BHu
         Ks3cGey7sPoqAwKrE5uUygMdwvQyw1Bhd+l3uOUvUezmcrcpjwqk3NhWfr3aDjbjDdv+
         rssALFpfNlr7xS5erOhMvrdxJ6Pl4Px00oiRnH0px0m7WtmhfYSlawrljBMEwMzB7Llj
         O911XnMegfiEW69q5daiKeJAivXG6EYxiEhbwwoKXteaJ7Rdl7LsmXpSlhwEY/Ma84Jf
         +x5phNnMQ+uUJbriNaMkM8JIsFzj2lGEDEuG8CvpiGyUxlQsSgQdIfcVisQ4S991YJqy
         RrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758596227; x=1759201027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ics1wQ4DXeJRB2kfp6XvXrArCS+erR5it3jxuaZFils=;
        b=hPQFBXrkMQ4g6ESUJVxGxTfH0vl2aaLhuPeT3TsO0CrbebJSMy+fFgr+ysKpWWc6Dp
         JMeBIOyFCFkNHXLrJsQ+ou6fb7PIgqw8EMKePQl+ymnQsjfoDlpYJZkQEHgzYdBJsdGp
         dortzi6+RByws0w52S8O/sgnEcvRcRHn0WM1eGw+p56gIUZ5kDmfkLLOoCLVPdDSTW4F
         st3WiXDtDVmTBktFZ7pZrrNGtRPJgqBtF3gtzomJBezv+6JMYcwZAqw+ilB2eI1bXqPF
         5DCCue5Sr70UWLF0YfbVV/kF6gGujBA+P4S82W5k1xmq2VHCgr8+2CIfbxEvNNukqR31
         MvIQ==
X-Gm-Message-State: AOJu0YxMNUSQAESiYUohQLdU3/yHRo/7Va7cQVEY1L0Qj37T3m25+LJ8
	KHmbF2E/BSLLwk7oLeIVio1AvwoV7XUQ0dO+NIdnnzCScuGXtwFFYb7zC1AFGw==
X-Gm-Gg: ASbGncsA2KTeIqF8Mz/B8yD7r7M8x0/mnH5hDyhTaBkGgFVTfo2jzIGIYzPPiLL4ixr
	g4duP9azHZIgQReIqAzz5C+tNc8bMV3CNttJ7nGhIpvHSOg/nPc3ZFZOhwCyc9lArvzeYLC5o0U
	w3tjdTJS2qKiK4quv0hV+dFPG97vCyOYGod0VjEqK77M+lN3W9sv1QXp5MIquFzn/cPOFWnehV9
	hsLKjPOXzAkjj75Vlx4uTw5eHWspNuzS0LlmORg3i0OnOO6/mc3Eacla79LTf2YHJpWIYtOLr5P
	5y2+d/qNiksS0IFumjD1jUaVOyAcVNKE4ec7OsjAVFVrpYruppuj/ZLAJWq4DA8I2TD5b/ykdNw
	PRN/1V/iRTXL87jSGRXGKjHyiQCKmchE=
X-Google-Smtp-Source: AGHT+IG2Qa6JRkJxnTCtUJdoumpUt9sWYRDajf7ItoZJ+WFlXXJpwjGpL/FLJpothUIxeRqPPc9JqQ==
X-Received: by 2002:a05:6871:808:b0:348:6276:f92e with SMTP id 586e51a60fabf-34c75a68e57mr486259fac.11.1758596227350;
        Mon, 22 Sep 2025 19:57:07 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692936963esm6431664a34.23.2025.09.22.19.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 19:57:07 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/4] builtin/repo: add object counts in stats output
Date: Mon, 22 Sep 2025 21:56:58 -0500
Message-ID: <20250923025700.3046260-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250923025700.3046260-1-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com>
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
 Documentation/git-repo.adoc |  5 +-
 builtin/repo.c              | 99 +++++++++++++++++++++++++++++++++----
 t/t1901-repo-stats.sh       | 46 +++++++++++++++++
 3 files changed, 139 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7762329551..2a67abfca8 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -45,8 +45,9 @@ supported:
 `-z` is an alias for `--format=nul`.
 
 stats::
-	Retrieve stats about the current repository. All references in the
-	repository are categorized and counted accordingly.
+	Retrieve stats about the current repository. All references and
+	reachable objects in the repository are categorized and counted
+	accordingly.
 +
 The table output format may change and is not intended for machine parsing.
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 15899dd74c..a24ea0e66b 100644
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
@@ -159,13 +161,25 @@ static int repo_info(int argc, const char **argv, const char *prefix,
 	return print_fields(argc, argv, repo, format);
 }
 
-struct stats {
+struct ref_stats {
 	size_t branches;
 	size_t remotes;
 	size_t tags;
 	size_t others;
 };
 
+struct object_stats {
+	size_t tags;
+	size_t commits;
+	size_t trees;
+	size_t blobs;
+};
+
+struct stats {
+	struct ref_stats refs;
+	struct object_stats objects;
+};
+
 struct stats_table {
 	struct string_list rows;
 
@@ -207,15 +221,27 @@ static void stats_table_add_count(struct stats_table *table, const char *name,
 
 static void stats_table_setup(struct stats_table *table, struct stats *stats)
 {
+	struct object_stats objects = stats->objects;
+	struct ref_stats refs = stats->refs;
+	size_t object_total;
 	size_t ref_total;
 
-	ref_total = stats->branches + stats->remotes + stats->tags + stats->others;
+	ref_total = refs.branches + refs.remotes + refs.tags + refs.others;
 	stats_table_add(table, _("* References"), NULL);
 	stats_table_add_count(table, _("  * Count"), ref_total);
-	stats_table_add_count(table, _("    * Branches"), stats->branches);
-	stats_table_add_count(table, _("    * Tags"), stats->tags);
-	stats_table_add_count(table, _("    * Remotes"), stats->remotes);
-	stats_table_add_count(table, _("    * Others"), stats->others);
+	stats_table_add_count(table, _("    * Branches"), refs.branches);
+	stats_table_add_count(table, _("    * Tags"), refs.tags);
+	stats_table_add_count(table, _("    * Remotes"), refs.remotes);
+	stats_table_add_count(table, _("    * Others"), refs.others);
+
+	object_total = objects.commits + objects.trees + objects.blobs + objects.tags;
+	stats_table_add(table, "", NULL);
+	stats_table_add(table, _("* Objects"), NULL);
+	stats_table_add_count(table, _("  * Count"), object_total);
+	stats_table_add_count(table, _("    * Commits"), objects.commits);
+	stats_table_add_count(table, _("    * Trees"), objects.trees);
+	stats_table_add_count(table, _("    * Blobs"), objects.blobs);
+	stats_table_add_count(table, _("    * Tags"), objects.tags);
 }
 
 static void stats_table_print(struct stats_table *table)
@@ -260,7 +286,7 @@ static void stats_table_print(struct stats_table *table)
 	strbuf_release(&buf);
 }
 
-static void stats_count_references(struct stats *stats, struct ref_array *refs)
+static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
 {
 	for (int i = 0; i < refs->nr; i++) {
 		struct ref_array_item *ref = refs->items[i];
@@ -282,25 +308,80 @@ static void stats_count_references(struct stats *stats, struct ref_array *refs)
 	}
 }
 
+static int count_objects(const char *path UNUSED, struct oid_array *oids,
+			 enum object_type type, void *data)
+{
+	struct object_stats *stats = data;
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
+		break;
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
+		}
+	}
+
+	walk_objects_by_path(&info);
+	path_walk_info_clear(&info);
+}
+
 static int repo_stats(int argc UNUSED, const char **argv UNUSED,
-		      const char *prefix UNUSED, struct repository *repo UNUSED)
+		      const char *prefix, struct repository *repo)
 {
 	struct ref_filter filter = REF_FILTER_INIT;
 	struct strvec ref_patterns = STRVEC_INIT;
 	struct stats_table table = { 0 };
 	struct ref_array refs = { 0 };
 	struct stats stats = { 0 };
+	struct rev_info revs;
 
+	repo_init_revisions(repo, &revs, prefix);
 	filter.name_patterns = ref_patterns.v;
 	filter_refs(&refs, &filter, FILTER_REFS_REGULAR);
 
-	stats_count_references(&stats, &refs);
+	stats_count_references(&stats.refs, &refs);
+	stats_count_objects(&stats.objects, &refs, &revs);
 
 	stats_table_setup(&table, &stats);
 	stats_table_print(&table);
 
 	string_list_clear(&table.rows, 1);
 	strvec_clear(&ref_patterns);
+	release_revisions(&revs);
 	ref_array_clear(&refs);
 
 	return 0;
diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
index 27c32ec45f..c6a7f08be5 100755
--- a/t/t1901-repo-stats.sh
+++ b/t/t1901-repo-stats.sh
@@ -20,6 +20,13 @@ test_expect_success 'empty repository stats' '
 		|     * Tags       |     0 |
 		|     * Remotes    |     0 |
 		|     * Others     |     0 |
+		|                  |       |
+		| * Objects        |       |
+		|   * Count        |     0 |
+		|     * Commits    |     0 |
+		|     * Trees      |     0 |
+		|     * Blobs      |     0 |
+		|     * Tags       |     0 |
 		EOF
 
 		test_cmp expect out &&
@@ -49,6 +56,45 @@ test_expect_success 'repository stats with references' '
 		|     * Tags       |     1 |
 		|     * Remotes    |     1 |
 		|     * Others     |     1 |
+		|                  |       |
+		| * Objects        |       |
+		|   * Count        |     5 |
+		|     * Commits    |     2 |
+		|     * Trees      |     2 |
+		|     * Blobs      |     1 |
+		|     * Tags       |     0 |
+		EOF
+
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
+test_expect_success 'repository stats with objects' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit_bulk 42 &&
+		git tag -a foo -m bar &&
+		git repo stats >out 2>err &&
+
+		cat >expect <<-EOF &&
+		| Repository stats | Value |
+		| ---------------- | ----- |
+		| * References     |       |
+		|   * Count        |     2 |
+		|     * Branches   |     1 |
+		|     * Tags       |     1 |
+		|     * Remotes    |     0 |
+		|     * Others     |     0 |
+		|                  |       |
+		| * Objects        |       |
+		|   * Count        |   127 |
+		|     * Commits    |    42 |
+		|     * Trees      |    42 |
+		|     * Blobs      |    42 |
+		|     * Tags       |     1 |
 		EOF
 
 		test_cmp expect out &&
-- 
2.51.0.193.g4975ec3473b

