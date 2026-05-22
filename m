Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFD372048
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474287; cv=none; b=YnXBkKsZ4/+Y6/nhn4M6uw5BhGOXP1cTlGzzLZhLIHNGGDO3SIuetckLwbJtb6Dc7Ulsa8dv4krlPzNoBkMTjO1hhye5brQNnC74phVbMpGyRabCePXrUnSoAGjGSbSwlsWtVQi4l+PrpmZmQ9k8wd3zkA7nrnwYFPNd3jA9weM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474287; c=relaxed/simple;
	bh=p3NUXQtf6zohD1T1PmrOmB+W3K/ZJ8ui/X0PQcsROoA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nNizgDbu74PwVB+/9gV46+0cTS1tPKDgOWi+NAoFNCr9jCuV+DGv5DjdhQAwyJQtEPU9A9EEbz0EBiVLFTD3+bshliZNnYbA8gyBiNMjFpmo3k4gCNPTovNs17CkjC72PUJ4Ds+cVjKMAdCy6kTi8GkbhJIWwsIe3UMKUy4UAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xwdd2YLe; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xwdd2YLe"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-912475287a5so835262585a.2
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474285; x=1780079085; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8pqQyOwZo7y9n705M79b/8WUdr1hTZg+lfOm4hG0yc=;
        b=Xwdd2YLe529bef+xkPW8Hdz8Q5fi89h8thGCWBdQtZF4d0QTc/P74aK4uUgchfSjDn
         oLyBXI10nLzIatBRJu8vMjHMNx4+gVvzWZ0b/GLlXztHlCeZrarNFRQnvr3TufNmtdEB
         ErPNgZBdyd+Dr6NuzpoMA4SJVuLHs7uQriJL/yz75OPbpgXzJV3FkGIiU04GT1OyWlTi
         d2uuYjoZPHbvu2oiyA/D5uwlWLrsQB0vjsaI50VcczgKohXwFPHtBhT3GlCJdS4FwJ9s
         ESStokgi4HM3VvpxZFv2AzmFoG/9K1Sc+9YtltRs6b8fwgA7ZDJAlotCVd2kwzZ3YDkW
         jnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474285; x=1780079085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t8pqQyOwZo7y9n705M79b/8WUdr1hTZg+lfOm4hG0yc=;
        b=aU7SRb8s3TeFQ2WK7xiOEhycQr9XfKgvT3JGlQmHwNvaN4mUEXmnhZ4Kr+zHmK6iL0
         qh7UfuzLHaG0n4/bwg7PkcurtEuifxWVG7NGi4ioLg3/DOoBFLNvZTRN1AggNOdB9fP5
         fDHEkL4piKhMJKCkcHOiODMlIUjQlkdSV/F/AQEoj4evS5tZtYzDvJG7WYrlZ7eYC2jV
         KdEO8jSwPW6BWExnm9WnNy1m06raWx5Yk7kDsNCqab+mpX2A8c8nFOzg4Zo7Jg837vLK
         TfOddWpOxRy2SplkTdOj62ncS1ZeNo4utJ2hGOAySNK02vCNeD4cvaMH4kiHkg5iUngI
         KwgQ==
X-Gm-Message-State: AOJu0YyyPdmLDcd8Om/4FgHCchrabyTRL3qxaijzTyvbmXPiI51n87SL
	vM9t02ALEO4MHWGg4Jw6cOTHl8+IdEdltulu3sZjGCAIy1J6r2tPiPcPXhXc2p03
X-Gm-Gg: Acq92OFeSY3x4x8zc6Ejszeh9LvLhaNg8Y9k+I8S2/wDeUlsPieOJt+B9f5/kSWwM83
	Xlfy01s8vpC7ottfLKIQoyV0M92sp4sNTzEaCLfkjeXXqU45FRY9Arpt3cJmvL/IJw+UOvi4AHD
	9DkKtfmtHYS5gt57L2nJsZXl9iq2yOmIxFLPElWWPLiWK9fjGKrT4XOk60QUB5eKcAUSXh17sbQ
	kewZDnwccaF84M/dT+QIAiK8jGC5XLFDATpCuqu/tY0DKIMTMLUqMR3sTnd4/VCa9CoVaAGdJZt
	F59pqoO0RfJ3VB4phJW1673mkanee7qE1JpOKbklS0bknO4o5Zgc5w5sb/IjRktk13SYsWL/LBU
	ZAUF7PxTxRDJzqPxfYrdiY/VS8ShdPe4knxKanS2f9vPzPEztzxhw1ptqxi1d+Q8P2PobcUrsSE
	fo3xb/T+WZLIyTIfK6dkPFA0u5tXc=
X-Received: by 2002:a05:620a:a49c:b0:914:bf8a:ba72 with SMTP id af79cd13be357-914bf8ac18dmr226029485a.57.1779474284583;
        Fri, 22 May 2026 11:24:44 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bba1b49csm189628885a.44.2026.05.22.11.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:44 -0700 (PDT)
Message-Id: <fdb936119817f9bf36edd60dfb8d2ea8c7a660f0.1779474277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:29 +0000
Subject: [PATCH v5 05/13] path-walk: support blobless filter
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
index b78175fbe1..2994faf988 100644
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
+ignored in the presence of `--path-walk`. The `--path-walk` option
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
index 05bfc1c114..bd81508163 100644
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
@@ -495,6 +496,32 @@ static int setup_pending_objects(struct path_walk_info *info,
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
@@ -522,6 +549,9 @@ int walk_objects_by_path(struct path_walk_info *info)
 
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

