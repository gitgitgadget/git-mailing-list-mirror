Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395F3A1A3B
	for <git@vger.kernel.org>; Mon,  4 May 2026 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926088; cv=none; b=a8hCA5FLO4EeM0pyTt46pf4iQbKt2vN8uARdNmlCpt9ytMNY/7GKSG5zIU7DD9fYQS1SC9MElqGPZ1L5vmFpN3sNhzTb+8btM3cadbeaPGdr0Mcsz9+heTpYjSp+2pJxIpFFcZt/SCRwt9fWV98jkNCovD9ZwSd3GpTE9+cBzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926088; c=relaxed/simple;
	bh=wog7HmIlKDTGhmNVi7u2Zx/5RB0vkVdwgYo+vSt6hWg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VrhlCq6W8TjIQNOc87vVsJ4TG998JDzqIuIxkEhYqH7eOyXcccLTKUWQ0nDQcHhG+c0D1mOFr6Rlo4SZfNORxgk7Pj0NZt0nNUxtVtVVKCbC5Oz7S8Q9hdSmEhQokqMdLuXrJveibco6Rwr2IYCon1mBtc5QDOKqYQ+Yw76MxNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVu/78Mi; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVu/78Mi"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ef2118b478so449651785a.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 13:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777926085; x=1778530885; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjDgWDifGVU/sIa4yoS1/fJyWY+acmcqpttSDolzmEM=;
        b=IVu/78MiUSpWGM6rmnvvWENaYuW8mwgm//G9yzOQmHW/LVLHAkz5gtTRSg4gc/k8AA
         VHgTrhnRlsMzWtju4s4u3GfnC8FK94YPxasrvFtYyB90qXWxBs7HTiMMZcPO55stSc6e
         fiaLE3DPt1w2DIcxfAJ5XEubcivQi1MmV2DleRhxUEQH2rdvMr2Z5OAgleJyJ1Rap1sx
         3q3A4mM5js5knLr578/5aMgO80MmWVXW/AyRFx7+xZEilY0Ug6ytyVw6t4DTKgR60mFG
         F0eOEuGcmjVyz/WFYlHr1jQrNeTs1pqlF+ZrBfQiBEKwstBIMtz2YNSBTlaZiiFZAKue
         YBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926085; x=1778530885;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kjDgWDifGVU/sIa4yoS1/fJyWY+acmcqpttSDolzmEM=;
        b=hZhOwILt6x12tpHCSvAb+kBr8RMcPEUcIba9N/DXVgcOkqFb5oqTOgGaQPL1JWsWix
         baidvoWaQGIgmSD4Mc+WyMGTTCqMdvi94rKBMa4pKlHSzKDuPirep06W+AgDPNBhsV8E
         mV0NpmMfdEA9KGyYvfpDk3InorSnYfSjgO47oNhbIMeQXB0BrbG4SRMR304svkxD4XCZ
         IjXA5xy5ve5iqrDnMjMowp3m51AejHZRhTleo704cb179u7zuKkD+s7PvgLdJdQZNIXj
         xKYJ9i39fqeZzrGORJaITgQxZ8zhWB9TKyWGkCm2IDVeMxb7pFquKRuTd1kJFGBQXQ8t
         ooeg==
X-Gm-Message-State: AOJu0YwaPq8HQJCpkbX+0AJFfpYl1Nw1zLKYoCENL0IiIy0ysTw6kxLt
	PLKMkjFkZjfQKB27iY272FAWH34KOfxl/T9H9ribUZ9BXvhG0xruQcjbyFfGjg==
X-Gm-Gg: AeBDievmFESLckNiiHsqIy4GFdprNv5SKim+fT9+rOO/OcMB0OVv71NmJTG2HdS8vA7
	UJHW70f0HVhl6f6z4NE0R5cX394lUurqKDtiNYt8h/2XkZtB4uT2KefNMZMz3JtX/frCwvMAmz3
	y/7LQKzOXEFxAILq2eEf5uNz4MvoQUXWBqxcLZU6L62QliT11qcD4/1zIOUvgh83Q0mXfFkgdMW
	RDlbTdBOCdp8o+8KyGsPgc0knAVhZH1pglLzjc9gwMN7Z7Dorf1XMYRMbsZWDYD5y55/EMAF2z6
	mgLoZw47SXAFSh04mCMSHR/w5j7RTSTawM2gxEOFAfw116dQM8H1lueORpdgXSWB05LxeEcoXUX
	STVycbj/q2KQrSuy63I+A1AtiWAvHUoCO3fqWe3XFvFeq9oGrbDh3ZhFvFCVHRlWMmElkgyb8Ng
	ZbEdqKfgNK2slnWefbgXNng5ckm3VsVQqPW3o5
X-Received: by 2002:a05:620a:4443:b0:8fb:1ba7:bdf3 with SMTP id af79cd13be357-8fd160d19f0mr1747659585a.14.1777926085192;
        Mon, 04 May 2026 13:21:25 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cdfbsm1164738085a.34.2026.05.04.13.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:21:24 -0700 (PDT)
Message-Id: <ed4d277a2c7dff0566acaf7b902e7474214fbab4.1777926079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 20:21:12 +0000
Subject: [PATCH v2 03/10] path-walk: support blobless filter
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
setup_revisions() to avoid the --objects requirement check.

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
 path-walk.c                         | 30 +++++++++++++++
 path-walk.h                         |  7 ++++
 t/helper/test-path-walk.c           | 11 +++++-
 t/t6601-path-walk.sh                | 60 +++++++++++++++++++++++++++++
 6 files changed, 111 insertions(+), 5 deletions(-)

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
index 6e426af433..a4dd197c37 100644
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
@@ -485,6 +486,32 @@ static int setup_pending_objects(struct path_walk_info *info,
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
@@ -512,6 +539,9 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 	trace2_region_enter("path-walk", "commit-walk", info->revs->repo);
 
+	if (!prepare_filters(info, &info->revs->filter))
+		return -1;
+
 	CALLOC_ARRAY(commit_list, 1);
 	commit_list->type = OBJ_COMMIT;
 
diff --git a/path-walk.h b/path-walk.h
index 5ef5a8440e..be8d27b398 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -85,3 +85,10 @@ void path_walk_info_clear(struct path_walk_info *info);
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
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 56bd1e3c5b..94df309987 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -415,4 +415,64 @@ test_expect_success 'trees are reported exactly once' '
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
+	2:tree::$(git rev-parse topic^{tree})
+	2:tree::$(git rev-parse base^{tree})
+	2:tree::$(git rev-parse base~1^{tree})
+	2:tree::$(git rev-parse base~2^{tree})
+	2:tree::$(git rev-parse refs/tags/tree-tag^{})
+	2:tree::$(git rev-parse refs/tags/tree-tag2^{})
+	3:tree:a/:$(git rev-parse base:a)
+	4:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	5:tree:left/:$(git rev-parse base:left)
+	5:tree:left/:$(git rev-parse base~2:left)
+	6:tree:right/:$(git rev-parse topic:right)
+	6:tree:right/:$(git rev-parse base~1:right)
+	6:tree:right/:$(git rev-parse base~2:right)
+	blobs:0
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

