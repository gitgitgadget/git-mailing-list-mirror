Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D62FFDFB
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562745; cv=none; b=ezLNBsg4JhH0i+RySq3ouCJrcm5TmuX1pWe0ChxkqGpZhhqbNmmONvm9iKX8+XUhlbzSvQatbw0XqyddHjOJiJqoL+j7tqnoQRUmp/29B6Ykik7Zw/GqGS2mjTtfAzTJBOv2FQ32d7qq4hgZvPE87etcA42eu1DXqzYL8LvKBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562745; c=relaxed/simple;
	bh=cyxrbEVK+Zmq0m84V6tULKeBZaIxBHaE6uYaIbQbV2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoojl7iSZZZCVkww6jISq4oHRI2ixgO0aaB/gGaJaEE0EURZZMCIjs/aOZgwolfrwT8fx0e2cJnjjGDnaaMH35673U1939KWH8S8/ysxi/KaE9nQJPp20Ej3QiUyrJxiw48fU1mq/EVbPCx1MSPX3ipM8FtMaeR3QPoEjkyiSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tui7VSQr; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tui7VSQr"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-64e5f669511so3634005eaf.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760562742; x=1761167542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQpy5uPFt5II/+IttSst8LxHeb3yGbl18ueJ1z/KlTE=;
        b=Tui7VSQr7GXDrYSMlpdPKOTq5JctdhY8Tf1WvZpCS+urEncxPx0xmwyByN3V1/TbiZ
         KUaGKE+LIxXUV0S/9E1wMnQ2LJ3RDXgaiK14jDjYSypy/haNCHAoMbGiYZ5D1SFZKoOw
         M5qU0fk9ima/fyIpO1ZCjzs1iKjBsHToAuFwFncgBlL50sZzPKgoKyKZ55gYexj9cdIE
         aF7XBg0UGhTZTpKZbZKw8JK6P90NIYoSzQwunaCCqa51HbfWqdahJ510YlY32AwJ+FW7
         UGZXqH0rlSlPH3680oFi+wY6cgnndd4hxBx8uK1tvlKaTHEYAFCGLaFFghynEKxCHFCJ
         sfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760562743; x=1761167543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQpy5uPFt5II/+IttSst8LxHeb3yGbl18ueJ1z/KlTE=;
        b=ewu8LcZ7202DnuZRbUu6VHOV1tYR7xDSz6IRJ45jDjfXqTrmzZlpToUQhvplmiVyxv
         O0EqDHys2UwU0g6UW+VcGz4JIc7x70VGwPIzPIkDCXHjLad9xorcW3O63+VHoTpudOXK
         WbX1KVI3M9qX30sjmSYH2cbjUtnFdyCIS+SPuNZFduweptIIk8N5T/YRwoY2ibc1uane
         r3Rmu141Nx3xjTw0pFDy3XGzva6/ShZcpCK/3PKQhvu5xAcWUicAsOA9tdrXy1GX16Vp
         MR/h9NqtVBURBG+KB4TL5U+Lj2AJi9Km7v38fYAZ83A32QiINbJcFB3liKariKNscV+T
         cEiA==
X-Gm-Message-State: AOJu0Yym8o8V/XaoAdt3dK2rMcXdmm45PnyuLitjN+G+SwISI66ukKxj
	Q4AqnOkBeEVEW9NUhkfHT1tJxRQwwLJp22sxcPUaLcJ3GGQ7urD67oXP9Gycqg==
X-Gm-Gg: ASbGncu3PVhKTqzWrcotWFZx6qe0uV4Boqd5DNTxhQoypGU5osGvRljyz8TIhcKlDDa
	jHgqIJ+/fJlQ0AjrLyZ49AeKuvOlcLHoGPcsTvbBrXKADLpQ7E3pX/zRflK6DtD6bQpiU+gUJRJ
	fzGpUHQ6+9hYnKH33QWp0yYbl4lsGgIfWr4BObLuSwN+EKs1vGc4KYNx3c74ZMTYLNdkaZCHgIk
	TRF1NNcf8AsyUQFUTvyWXwLVr6afAWl/eVzEYZfzLPUInE5zpbdSX/m9Q/zSU2E1KXizKYfV6NE
	HjLgn0hECAWHNurrAYQq2+9zwxot2H/US6T0BLnz53dLwj1UQhhz8QRQpAS3UEmB8Zaw1uYbfaa
	fBZ2Z0cHLKBdglOybgkDSyp6iDmxLLZcP5o1w0PllECMIVDF7oBR2qZr7KvhOhsPBPfap0JPDgy
	cE6p82GNp3gMQqDzJY58s=
X-Google-Smtp-Source: AGHT+IFUwqe0/mA6l7P87V31gaqb3owDmb1dec1f7vZLFGOO/Hj810rhxEFXoYVwY8froBYALwob2A==
X-Received: by 2002:a05:6870:e253:b0:35a:3ead:c6e1 with SMTP id 586e51a60fabf-3c0fad4fc0amr15207183fac.49.1760562742572;
        Wed, 15 Oct 2025 14:12:22 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8eecb2bsm5806932fac.20.2025.10.15.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:12:22 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 4/6] builtin/repo: add object counts in structure output
Date: Wed, 15 Oct 2025 16:12:11 -0500
Message-ID: <20251015211213.361797-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251015211213.361797-1-jltobler@gmail.com>
References: <20250927145049.723341-1-jltobler@gmail.com>
 <20251015211213.361797-1-jltobler@gmail.com>
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
 builtin/repo.c              | 97 +++++++++++++++++++++++++++++++++++--
 t/t1901-repo-structure.sh   | 19 +++++++-
 3 files changed, 111 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 8193298dd5..ae62d2415f 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -49,6 +49,7 @@ supported:
 	following kinds of information are reported:
 +
 * Reference counts categorized by type
+* Reachable object counts categorized by type
 
 +
 The table output format may change and is not intended for machine parsing.
diff --git a/builtin/repo.c b/builtin/repo.c
index 4575cf9467..0bc3c1e458 100644
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
@@ -167,6 +169,18 @@ struct ref_stats {
 	size_t others;
 };
 
+struct object_stats {
+	size_t tags;
+	size_t commits;
+	size_t trees;
+	size_t blobs;
+};
+
+struct repo_structure {
+	struct ref_stats refs;
+	struct object_stats objects;
+};
+
 struct stats_table {
 	struct string_list rows;
 
@@ -229,9 +243,17 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 	va_end(ap);
 }
 
+static inline size_t get_total_object_count(struct object_stats *stats)
+{
+	return stats->tags + stats->commits + stats->trees + stats->blobs;
+}
+
 static void stats_table_setup_structure(struct stats_table *table,
-					struct ref_stats *refs)
+					struct repo_structure *stats)
 {
+	struct object_stats *objects = &stats->objects;
+	struct ref_stats *refs = &stats->refs;
+	size_t object_total;
 	size_t ref_total;
 
 	ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
@@ -241,6 +263,15 @@ static void stats_table_setup_structure(struct stats_table *table,
 	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
 	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
 	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
+
+	object_total = get_total_object_count(objects);
+	stats_table_addf(table, "");
+	stats_table_addf(table, "* %s", _("Reachable objects"));
+	stats_table_count_addf(table, object_total, "  * %s", _("Count"));
+	stats_table_count_addf(table, objects->commits, "    * %s", _("Commits"));
+	stats_table_count_addf(table, objects->trees, "    * %s", _("Trees"));
+	stats_table_count_addf(table, objects->blobs, "    * %s", _("Blobs"));
+	stats_table_count_addf(table, objects->tags, "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
@@ -319,30 +350,88 @@ static void structure_count_references(struct ref_stats *stats,
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
+static void structure_count_objects(struct object_stats *stats,
+				    struct ref_array *refs,
+				    struct rev_info *revs)
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
 static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
-			      struct repository *repo UNUSED)
+			      struct repository *repo)
 {
 	struct ref_filter filter = REF_FILTER_INIT;
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
 	};
-	struct ref_stats stats = { 0 };
+	struct repo_structure stats = { 0 };
 	struct ref_array refs = { 0 };
+	struct rev_info revs;
 	struct option options[] = { 0 };
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 	if (argc)
 		usage(_("too many arguments"));
 
+	repo_init_revisions(repo, &revs, prefix);
 	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
 		die(_("unable to filter refs"));
 
-	structure_count_references(&stats, &refs);
+	structure_count_references(&stats.refs, &refs);
+	structure_count_objects(&stats.objects, &refs, &revs);
 
 	stats_table_setup_structure(&table, &stats);
 	stats_table_print_structure(&table);
 
 	stats_table_clear(&table);
+	release_revisions(&revs);
 	ref_array_clear(&refs);
 
 	return 0;
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index e592eea0eb..c32cf4e239 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -18,6 +18,13 @@ test_expect_success 'empty repository' '
 		|     * Tags           |     0 |
 		|     * Remotes        |     0 |
 		|     * Others         |     0 |
+		|                      |       |
+		| * Reachable objects  |       |
+		|   * Count            |     0 |
+		|     * Commits        |     0 |
+		|     * Trees          |     0 |
+		|     * Blobs          |     0 |
+		|     * Tags           |     0 |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -27,17 +34,18 @@ test_expect_success 'empty repository' '
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
@@ -49,6 +57,13 @@ test_expect_success 'repository with references' '
 		|     * Tags           |     1 |
 		|     * Remotes        |     1 |
 		|     * Others         |     1 |
+		|                      |       |
+		| * Reachable objects  |       |
+		|   * Count            |   130 |
+		|     * Commits        |    43 |
+		|     * Trees          |    43 |
+		|     * Blobs          |    43 |
+		|     * Tags           |     1 |
 		EOF
 
 		git repo structure >out 2>err &&
-- 
2.51.0.193.g4975ec3473b

