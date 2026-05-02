Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023F279DC9
	for <git@vger.kernel.org>; Sat,  2 May 2026 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731364; cv=none; b=lFNPG+uuERH6ohlsEOTE2LKXl8R1udTpKJtnJow98CJFcI+K2br/QU1GbkeUJv8fmlB+BoR6vzHDQA30HTbrIhDO/AfS8Mly54Jxt591cd4OIa4qlshgwE+P90PYn8BVCranW3DcdA36mxYxKCgj6gAF3XfKdasgXudR5esRRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731364; c=relaxed/simple;
	bh=XSO5OA/zQ2xjOnd22BxHRSnzN+idwWm50aOiNBWWh+o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SNk2i23WqPEoOJwS7eAwUNNHYfs9jHqcwFZ0Bt6MBfuGDCeGvCSGWlAUSOI2u2FTdWukmDAMsoggFCr2ZMKMtWcG3JPy2MpjD+YpxTLFtkTH+v31+irnpTrjC8lW2UbgfHsmXFSC6frkHADsd9yxG1ZgJPcsr+ar8sGiKXHWok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YikYbFZh; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YikYbFZh"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12ddbe104ccso2782939c88.0
        for <git@vger.kernel.org>; Sat, 02 May 2026 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777731362; x=1778336162; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f99p1o/WiW4+CnSNrjn00JA5aelgyGbFj+vhlpfO9PI=;
        b=YikYbFZhUp1KELyle2OcMeuJidv+TQVe5X9gKcTlSTpK5b1wyNsqKSMvs/Xw3NUV3C
         VcHwV3AZHX8OtPV2qXzGHbAbd6yNVnDNuTYtMShxY9PCCXRplp05XlpWJDUOPWQASCeC
         BIZAn/WdS7wDnmk98O6izrKxhpjurKV8mMyR1vPCEJ/cr2meVsULqb4IaD9liaAGdCzX
         oC1YbEAQXkuEKDSgkJexXLeDQE553UM5lCxzajCeyo/lkqhV2qKgV7Ezo9ljtUdM4O7z
         EKw8DLX+CPblrJ3rDjy2vciqmAb9iRTjKuk2395FhRaeUI9iwKSoUIQGlTyRjRsvDcy8
         NwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777731362; x=1778336162;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f99p1o/WiW4+CnSNrjn00JA5aelgyGbFj+vhlpfO9PI=;
        b=PMNZ7Am7LCAwGMEcOWmFH4YN3Ry/fcmEvCCaxyRcDyF8xc+z3aS6UmMwCAK13WFABZ
         1KQNs+h88hddaf2itKqcdGrKxvBLnHguiu6WuSCMmFqiKN6pmsSLZgUEoJkn+Rx0rKn1
         pzp15PfSsLQUBUF2Y7iLlwyBTyXo6GEQDD5acwknMkU9ZwaUrn8oU7tP1quBsMDgqbv2
         0Jr7VusHW5O9wKLN3WqZW5HF2a1JeJQGBrKYC9NNMDLgIiIgvL/Yt1JwhAvAxALXUExt
         FlsjAGLwOm9aSLRR/JhYLh31O8cghE3lFlzUS0hvTexh+xZmnI+cDiyAeZ4uHlU4Juhx
         FRoQ==
X-Gm-Message-State: AOJu0YzJVMDM0WEoVOC9BZDnQYPBedriNZsIL+KZcWAX5OJNPWem/yzc
	1ppXNzcNWilcEy40ijS52qvItp16k0ofeeTRmCOEateRvoZr8T6xdieaEaJSBhe1
X-Gm-Gg: AeBDieuX9mnrRQsFpnE8+NUHmTiSux27S5k5/o5CDLU/vM17GtJALUAEosL4VXhpXfm
	gtpfnLYW6nabsbIQsAdOYxpkUWaRZjQsk8kVq11CZoOW2EkQKmr2N/Dv6/lKAXKPxtcTlIdpBBW
	Xt2GzuYaAxJmi/qXnNs5Z8+zQyRuDhw2RFo7ZxUmibPVgTBzSHGGJAQwEqFEfbCn891rehCxDWQ
	7ohBAkIDmPY/yb554YgPhnDp9jHgnDAu7oVM4mTQoPPUeZiTFqyUEhKSk8OM8ztEm/okdS2rudE
	HJbSRm7busP7F/PmpOJlRvN86enLt/DJ9YKV06nSZ+z9u5trDkOqDPBhFVprDHqzuKBlS+JOOX8
	TPBYPjXKT/kKYtHy1ilnIiO4VrNtbCJ6qeKk0ydmR+fVjEwePvVMX5xJcPPQMdxtyibU6jQhNeW
	Ant/9psP6pyMJoXc8t1gKPkxOXh2QLSEsrEVy3
X-Received: by 2002:a05:7022:f404:b0:12d:de3f:d852 with SMTP id a92af1059eb24-12dfd8444e9mr1349976c88.43.1777731361533;
        Sat, 02 May 2026 07:16:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.216.119])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8431037sm7661487c88.12.2026.05.02.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 07:16:00 -0700 (PDT)
Message-Id: <b7e72d5dbb8c00e3ee35da3e9853faddf8e42748.1777731354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 14:15:50 +0000
Subject: [PATCH 3/7] path-walk: support blobless filter
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

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c    |  2 +-
 path-walk.c               | 30 ++++++++++++++++++++
 path-walk.h               |  7 +++++
 t/helper/test-path-walk.c | 11 ++++++-
 t/t6601-path-walk.sh      | 60 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 108 insertions(+), 2 deletions(-)

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

