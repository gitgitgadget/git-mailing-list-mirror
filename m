Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C8B47B423
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523201; cv=none; b=Kpvi2aSaOS1hDyRSxxGz0zPWx+xmhjBYeH1Ot93pcXg7cvn1Txmb0dUtjV+4H+WFnvwNXZAL+bhawDXpAYz2YGDcq3DCBdFb3uPdpw6DmzeIvZc56oaxbaBdl1qzvDDh4khNKNUiv/K49btni1LOg0+OsFRxnvG+vO8G95ATzkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523201; c=relaxed/simple;
	bh=6s9vLMXFKRzh0ZBb0RcPX+kFFWSuQbL1qxKbi8W8AN8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=vFy/9ruW4VAWA2rRJlUGwnYlLHEBbi9rkljS5PWqjdt4vGRAbyk2DT/AGvM6n0gxi+EgVFU0Cg6Hr/c98aroO+DHND7CM8nnMmkg+sZeH6f/LrJSIOXsQaQCK3mJ1tbEcmk/v87gZTmBEt6oP9Twq86lBFAJYEf6mZEk++GWJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUTReyS0; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUTReyS0"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51306c36c3eso42350471cf.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523198; x=1779127998; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uo623ZWHy22q/voZmXlUOrr5y/k++RZJwQ5SwmpYUrc=;
        b=fUTReyS048R9tXM66woG9mNDTOfYwNJETUrggOFbdCsqg7rK6A0FbDSUg5MYAWXqu5
         xfLzcS+nv0CGJjc2W8KyfpkhlpnLgju87J6Iu3v7K4lrdr+Sp1FPe2ilx+p/CT9LGDwN
         KvvDki85RVrahFFbDm/u+WPJapWX6LgnsmCGDGzvoMhPslPnrTfHP+hj1jMngF1nEhhk
         35zuILzJP7Nlx3LI8qFYpsNmInjaGFVzbLnS+vsPVIKLH8B5mVBtDZYFzrligEn+i+WT
         3/WdxzlFyqmTShiwdC8rCudxy++a8OMNr8+zVv456rlOMzW3F9gIztPUlfPGWe7C0iOX
         kB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523198; x=1779127998;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uo623ZWHy22q/voZmXlUOrr5y/k++RZJwQ5SwmpYUrc=;
        b=Ii1RvQudAvF7mfDMVoU7fsNInRHEi0HbHOA60wAwxB2y2Q4UI8YVju4PuOOfMTVdT5
         EUEkRyyH28uZgOKRB0eSwnLNCg/3nLI6kC3Gw2tlPxClWcri6gcqcfcmrucAZlSzlkq3
         f6TMAvxz1ZsnXcfO8bD3Zzx1RwzCiGedvP/42Sf8Jl2dBsuTOX5BmJlIp4y0tkGV3Vrq
         cZ0c+rc2V8Cf+naZnL1oO0iWv1gQkPCweXFTFxmznB0Hm6bI7Yrky7FXAoc7Q3EhxiAD
         Ywh24lpYz+aVAg0iokJqGa4Dc3V0OMn4SC1gE4kBS4VeCJwNUC1HK+3MmEO5oFcCGK7o
         Mu6g==
X-Gm-Message-State: AOJu0YwAIiUFEojrvI9nbiM1nT/mQAZ8Vmuj0boy4/FSzItV7nUJXpAz
	KdRgnHVC9HXV3Zg2BogayaxCRgyoebwKrhlwhVn9IrlqobI+gJJLq5WPUAUyxw==
X-Gm-Gg: Acq92OEh4wBg15GYWybbk6UzhYcJ01enOQHP8Va8OzO9+Q9Zmv7GIzm6OkcyGUIDK8E
	4D9fqKgz27ka5nkNZS3X2en3VDK1I5aHZ4t/6XoLZezT1yG+nMJMCzAys/PxKwxeH+Md3ApCnP7
	9ZqTcQG3tKqnagDJd1wyrY6D0doNpxyCd+ipmJGSGSDgYHtm6VRvu6ZcMEbe22Lklj8s1rfinGM
	0YKGQBhLlMNxItI1MKFJ2K67Vau8ffnshS4y7hOH3x6Pq0gJL307I24dtNg5Jdx0VZaXETte7f/
	18TtjkW7Ta3SjsPQfG1QvxNJxEnFk+pM8jNfLqUeMDX74hF84KQg+wZdeAUWrE/BmTzMbZ3b0Ot
	iL8BiqARKEGTRRsQ0HincnjKJPZPp7MjH2oaEyB5SJcV4fTYjJFkOsIqhSaXC7A4nMMJERbdBnB
	iaZ6I44pWhn5agbQA6IN94Ht0Gkw==
X-Received: by 2002:ac8:5fc9:0:b0:50f:c36a:3826 with SMTP id d75a77b69052e-51461c04f86mr372827011cf.16.1778523197925;
        Mon, 11 May 2026 11:13:17 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7c0fa5sm103486861cf.16.2026.05.11.11.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:17 -0700 (PDT)
Message-Id: <b2deb7f81939d6ed03f0ea5c8be5ec515c1c99ab.1778523189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
	<pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 18:13:02 +0000
Subject: [PATCH v3 05/12] path-walk: support blobless filter
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

The 'git pack-objects' command can opt-in to using the path-walk API for
scanning the objects. Currently, this option is dynamically disabled if
combined with '--filter=<X>', even when using a simple filter such as
'blob:none' to signal a blobless packfile. This is a common scenario for
repos at scale, so is worth integrating.

Also, users can opt-in to the '--path-walk' option by default through
the pack.usePathWalk=true config option. When using that in a blobless
partial clone, the following warning can appear even though the user did
not specify either option directly:

  warning: cannot use --filter with --path-walk

Teach the path-walk API to handle the 'blob:none' object filter
natively. When revs->filter.choice is LOFC_BLOB_NONE, the path-walk
sets info->blobs to 0 (skipping all blob objects) and clears the
filter from revs so that prepare_revision_walk() does not reject the
configuration.

This check is implemented in the static prepare_filters() method, which
will simultaneously check if the input filters are compatible and will
make the appropriate mutations to the path_walk_info and filters if the
path_walk_info is non-NULL. This allows us to use this logic both in the
API method path_walk_filter_compatible() for use in
builtin/pack-objects.c and as a prep step in walk_objects_by_path().

Update the test helper (test-path-walk) to accept --filter=<spec>
as a test-tool option (before '--'), applying it to revs after
setup_revisions() to avoid the --objects requirement check. We can also
revert recent GIT_TEST_PACK_PATH_WALK overrides in t5620.

Also switch test-path-walk from REV_INFO_INIT with manual repo
assignment to repo_init_revisions(), which properly initializes
the filter_spec strbuf needed for filter parsing.

Add tests for blob:none with --all and with a single branch.

The performance test p5315 shows the impact of this change when using
blobless filters:

Test                                           HEAD~1     HEAD
---------------------------------------------------------------------
5315.6: repack (blob:none)                      13.53   13.87  +2.5%
5315.7: repack size (blob:none)                137.7M  137.8M  +0.1%
5315.8: repack (blob:none, --path-walk)         13.51   23.43 +73.4%
5315.9: repack size (blob:none, --path-walk)   137.7M  115.2M -16.3%

These performance tests were run on the Git repository. The --path-walk
feature shows meaningful space savings (16% smaller for blobless packs)
at the cost of increased computation time due to the two compression
passes. This data demonstrates that the feature is engaged and provides
real compression benefits when --no-reuse-delta forces fresh deltas.

Co-Authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc |  6 +--
 builtin/pack-objects.c              |  2 +-
 path-walk.c                         | 30 ++++++++++++++
 path-walk.h                         |  7 ++++
 t/helper/test-path-walk.c           | 11 ++++-
 t/t5620-backfill.sh                 |  9 -----
 t/t6601-path-walk.sh                | 62 +++++++++++++++++++++++++++++
 7 files changed, 113 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index b78175fbe1..917045d5c3 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -402,9 +402,9 @@ will be automatically changed to version `1`.
 	of filenames that cause collisions in Git's default name-hash
 	algorithm.
 +
-Incompatible with `--delta-islands`, `--shallow`, or `--filter`. The
-`--use-bitmap-index` option will be ignored in the presence of
-`--path-walk.`
+Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
+ignored in the presence of `--path-walk`. Whe `--path-walk` option
+supports the `--filter=<spec>` form `blob:none`.
 
 
 DELTA ISLANDS
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4338962904..bc9fb5b457 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5177,7 +5177,7 @@ int cmd_pack_objects(int argc,
 
 	if (path_walk) {
 		const char *option = NULL;
-		if (filter_options.choice)
+		if (!path_walk_filter_compatible(&filter_options))
 			option = "--filter";
 		else if (use_delta_islands)
 			option = "--delta-islands";
diff --git a/path-walk.c b/path-walk.c
index 59a7670c5b..cc587268e7 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -9,6 +9,7 @@
 #include "hashmap.h"
 #include "hex.h"
 #include "list-objects.h"
+#include "list-objects-filter-options.h"
 #include "object.h"
 #include "oid-array.h"
 #include "path.h"
@@ -494,6 +495,32 @@ static int setup_pending_objects(struct path_walk_info *info,
 	return 0;
 }
 
+static int prepare_filters(struct path_walk_info *info,
+			   struct list_objects_filter_options *options)
+{
+	switch (options->choice) {
+	case LOFC_DISABLED:
+		return 1;
+
+	case LOFC_BLOB_NONE:
+		if (info) {
+			info->blobs = 0;
+			list_objects_filter_release(options);
+		}
+		return 1;
+
+	default:
+		error(_("object filter '%s' not supported by the path-walk API"),
+		      list_objects_filter_spec(options));
+		return 0;
+	}
+}
+
+int path_walk_filter_compatible(struct list_objects_filter_options *options)
+{
+	return prepare_filters(NULL, options);
+}
+
 /**
  * Given the configuration of 'info', walk the commits based on 'info->revs' and
  * call 'info->path_fn' on each discovered path.
@@ -521,6 +548,9 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
 
+	if (!prepare_filters(info, &info->revs->filter))
+		return -1;
+
 	CALLOC_ARRAY(commit_list, 1);
 	commit_list->type = OBJ_COMMIT;
 
diff --git a/path-walk.h b/path-walk.h
index 657eeda8ec..a1736ecb2b 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -90,3 +90,10 @@ void path_walk_info_clear(struct path_walk_info *info);
  * Returns nonzero on an error.
  */
 int walk_objects_by_path(struct path_walk_info *info);
+
+struct list_objects_filter_options;
+/**
+ * Given a set of options for filtering objects, return 1 if the options
+ * are compatible with the path-walk API and 0 otherwise.
+ */
+int path_walk_filter_compatible(struct list_objects_filter_options *options);
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index fe63002c2b..88f86ae0dc 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -4,6 +4,7 @@
 #include "dir.h"
 #include "environment.h"
 #include "hex.h"
+#include "list-objects-filter-options.h"
 #include "object-name.h"
 #include "object.h"
 #include "pretty.h"
@@ -71,6 +72,8 @@ int cmd__path_walk(int argc, const char **argv)
 	struct rev_info revs = REV_INFO_INIT;
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
 	struct path_walk_test_data data = { 0 };
+	struct list_objects_filter_options filter_options =
+		LIST_OBJECTS_FILTER_INIT;
 	struct option options[] = {
 		OPT_BOOL(0, "blobs", &info.blobs,
 			 N_("toggle inclusion of blob objects")),
@@ -86,11 +89,12 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle aggressive edge walk")),
 		OPT_BOOL(0, "stdin-pl", &stdin_pl,
 			 N_("read a pattern list over stdin")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END(),
 	};
 
 	setup_git_directory();
-	revs.repo = the_repository;
+	repo_init_revisions(the_repository, &revs, NULL);
 
 	argc = parse_options(argc, argv, NULL,
 			     options, path_walk_usage,
@@ -101,6 +105,10 @@ int cmd__path_walk(int argc, const char **argv)
 	else
 		usage(path_walk_usage[0]);
 
+	/* Apply the filter after setup_revisions to avoid the --objects check. */
+	if (filter_options.choice)
+		list_objects_filter_copy(&revs.filter, &filter_options);
+
 	info.revs = &revs;
 	info.path_fn = emit_block;
 	info.path_fn_data = &data;
@@ -129,6 +137,7 @@ int cmd__path_walk(int argc, const char **argv)
 		free(info.pl);
 	}
 
+	list_objects_filter_release(&filter_options);
 	release_revisions(&revs);
 	return res;
 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index e174290787..94f35ce190 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -298,9 +298,6 @@ test_expect_success 'backfill with prefix pathspec' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
-	# If we enable --path-walk here, we will get a warning overs stderr
-	# due to incompatibilities with --filter.
-	GIT_TEST_PACK_PATH_WALK=0 \
 	git -C backfill-path backfill HEAD -- d/f 2>err &&
 	test_must_be_empty err &&
 
@@ -318,9 +315,6 @@ test_expect_success 'backfill with multiple pathspecs' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
-	# If we enable --path-walk here, we will get a warning overs stderr
-	# due to incompatibilities with --filter.
-	GIT_TEST_PACK_PATH_WALK=0 \
 	git -C backfill-path backfill HEAD -- d/f a 2>err &&
 	test_must_be_empty err &&
 
@@ -338,9 +332,6 @@ test_expect_success 'backfill with wildcard pathspec' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
-	# If we enable --path-walk here, we will get a warning overs stderr
-	# due to incompatibilities with --filter.
-	GIT_TEST_PACK_PATH_WALK=0 \
 	git -C backfill-path backfill HEAD -- "d/file.*.txt" 2>err &&
 	test_must_be_empty err &&
 
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 56bd1e3c5b..b0ee31ee2d 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -415,4 +415,66 @@ test_expect_success 'trees are reported exactly once' '
 	test_line_count = 1 out-filtered
 '
 
+test_expect_success 'all, blob:none filter' '
+	test-tool path-walk --filter=blob:none -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tag:/tags:$(git rev-parse refs/tags/first)
+	1:tag:/tags:$(git rev-parse refs/tags/second.1)
+	1:tag:/tags:$(git rev-parse refs/tags/second.2)
+	1:tag:/tags:$(git rev-parse refs/tags/third)
+	1:tag:/tags:$(git rev-parse refs/tags/fourth)
+	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
+	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:tree::$(git rev-parse topic^{tree})
+	3:tree::$(git rev-parse base^{tree})
+	3:tree::$(git rev-parse base~1^{tree})
+	3:tree::$(git rev-parse base~2^{tree})
+	3:tree::$(git rev-parse refs/tags/tree-tag^{})
+	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
+	4:tree:a/:$(git rev-parse base:a)
+	5:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	6:tree:left/:$(git rev-parse base:left)
+	6:tree:left/:$(git rev-parse base~2:left)
+	7:tree:right/:$(git rev-parse topic:right)
+	7:tree:right/:$(git rev-parse base~1:right)
+	7:tree:right/:$(git rev-parse base~2:right)
+	blobs:2
+	commits:4
+	tags:7
+	trees:13
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic only, blob:none filter' '
+	test-tool path-walk --filter=blob:none -- topic >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tree::$(git rev-parse topic^{tree})
+	1:tree::$(git rev-parse base~1^{tree})
+	1:tree::$(git rev-parse base~2^{tree})
+	2:tree:left/:$(git rev-parse base~2:left)
+	3:tree:right/:$(git rev-parse topic:right)
+	3:tree:right/:$(git rev-parse base~1:right)
+	3:tree:right/:$(git rev-parse base~2:right)
+	blobs:0
+	commits:3
+	tags:0
+	trees:7
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_done
-- 
gitgitgadget

