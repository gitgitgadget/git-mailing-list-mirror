Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806AF35CB6A
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781419058; cv=none; b=Q8Z2FVXrprdcfGuxHocLybwyrHsOzq/Mwxeon+1R0DH7UHuC7ZkZMtoq2tnvprWZCQkFjddziczF+6hxEHMuYXyyL1RBj1rHx9xeTBQwHGcqIxN9kcNiCYRRDrxfj+oiffcEzyzZVCV28h56th38rQt0Ech5dd4OVuIUBS4ZxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781419058; c=relaxed/simple;
	bh=V0yuFY07b8V2jF2cWnBvNH7D10iDFRdNjNeRK0+eQLw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=f0hd6t6fSyVhr5vfcLrNbsjZV/2GmpOxHU8533/n8PDYa0gJNCb+NOau5fgUV1VoO4I33hB0wgxxoLZMREba7wAGTVYUQCGzbUD+sZvtp0aOaDV3hR/I2qOcebqsUJ0ILfsgL3qBpBKmD9GwZGMf6evyBcaDpVyeyiLrLIuo890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUJCaMBy; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUJCaMBy"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-915e1354934so248230185a.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 23:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781419055; x=1782023855; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKEqLTWj4tHGOob5tl/Hn6N8fBtH1FPUSP8wU0B/Bwg=;
        b=rUJCaMByIUa7GezFH9IB9gBwdH9p2vX2USfinZ9UpSTK4HistiDYOJNtlIqpqHLZhF
         XmvEy1NI/RwQmskdqw4Z8idlTwDK9ZhY2/t5kOWH1ahyKj/keA15aw6S3pgTLplbGhjv
         nOmGkbXpqveMsNUgNkj/CAUKG2cKo6R7y5cELT+moSdtHolbPy+ko3GZOX4AkgoYRhUS
         D8QRnpgVG/VBNkjFrF+g4Xea6Nr7gLlNsIVyDqf20UGVTWB8ECKbqZEugKeFxviGJlLS
         REtZHWG9B+w2rJYUhx42X5fxPXHuDz6S73ifXtSOc9wTB4fK35IMHYS5s+kgwbLr1hEt
         UllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781419055; x=1782023855;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zKEqLTWj4tHGOob5tl/Hn6N8fBtH1FPUSP8wU0B/Bwg=;
        b=ATKjJfsiy70gRsY/XBw2oNQ/TlXEPorzkc37iu5mFwXR78i+FQZC2POwKNcARpE4RK
         FKozPkMQ+QzNjc8hjDHu91BHIybZbDfr8eEuwQKf5P0FaBiXcTqB7Cw5aubXpZsDT/fu
         S529/MF1gT3ZA/CrvNYIjbw8rX2TGTYSvtMTwKbWQAkcD9P1Sl4f6IB2iKUpwlUeUVkr
         CaTDwL2FLSyCuSj8ivwkosgQVuMkwBQg3IaT/tumtYni0LWqeO4CNP1MWrPElYQArcI2
         ZAdhdCxP9t4gPVdBNykAnjF830Jy8LEs8MXuBADL/N331wAWsuPNjyeQy501NzbM0NUX
         S+JQ==
X-Gm-Message-State: AOJu0YyBBNetyNv3kdL3uuvIwOy8ftzv9gEjli2jhC+bwJp14yH9NkNF
	bXCSC0bzQras1Mnl+LaKusEEX6qnXUMgQpoi6SZNZ4z5G8OoFb1cPsF5nvqaMA==
X-Gm-Gg: Acq92OFcFUNlOtxwulgbmWcKSWScEX6UTR3cBRTiLAoMDv1YW4LRKEBa8J8XJM3aaN9
	4CLxNJEtKJO8+SpZYPDtr5YQQblYmZfuAaZF7Xe7+0PU0vnv5nyrKPDZW30dkUtnlRozf0C4ALj
	aQw4yV/lV+WkMm9ucIo+f993ReB3lN5oyCRRjRbCl1B9P0gJNMrFQ6JexsE65syQhdti/jsHRPO
	6M9Hvtxz6KJ0XdJx5p90XBDHzTfnaSQ0z0ZIfgLwUMN5K5PwJtWutS77LG1pYbQh/NC+ByWnOKl
	LsClfTvo3kNGE6Q6sMrJS6LFSN1BZVzGoa3a3jEJQgCO+XMA0W3LVgZ8V2BPvz+UIUuul3mVjH0
	4mU16Q9vSc0NA78ZAhn5E+UXiC2EKmFjpqbo6iN13DRE7yHwz8PfN4C/Cc2VYLqr2E88jf4BK+p
	g/HnJ1tSEveV/RDgHvar3RWg==
X-Received: by 2002:a05:620a:454b:b0:915:c4de:7ad8 with SMTP id af79cd13be357-917f11744a4mr992206885a.38.1781419055345;
        Sat, 13 Jun 2026 23:37:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.15.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f05fe7sm723722385a.12.2026.06.13.23.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 23:37:34 -0700 (PDT)
Message-Id: <b5421244d41ed90a66f64c619d18935a71475bc7.1781419047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
	<pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 06:37:25 +0000
Subject: [PATCH v2 4/5] merge-ort: abort merge when trees have duplicate
 entries
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Christian Couder <christian.couder@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Trees with duplicate entries are malformed; fsck reports "contains
duplicate file entries" for them.  merge-ort has from the beginning
assumed that we would never hit such trees.  It was written with the
assumption that traverse_trees() calls collect_merge_info_callback() at
most once per path.  The "sanity checks" in that callback (added in
d2bc1994f363 (merge-ort: implement a very basic collect_merge_info(),
2020-12-13)) verify properties of each individual call but not that
invariant.  The strmap_put() in setup_path_info() silently overwrites
the entry from any prior call for the same path, because it assumed
there would be no other path.  Unfortunately, supplemental data
structures for various optimizations could still be tweaked before the
extra paths were overwritten, and those data structures not matching
expected state could trip various assertions.

Change the return type of setup_path_info() from void to int to allow us
to detect this case, and abort the merge with a clear error message when
it occurs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                          | 61 ++++++++++++++++------------
 t/t6422-merge-rename-corner-cases.sh | 54 ++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 27 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8f911cb639..be0829bbb7 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1026,18 +1026,18 @@ static int traverse_trees_wrapper(struct index_state *istate,
 	return ret < 0 ? ret : 0;
 }
 
-static void setup_path_info(struct merge_options *opt,
-			    struct string_list_item *result,
-			    const char *current_dir_name,
-			    int current_dir_name_len,
-			    char *fullpath, /* we'll take over ownership */
-			    struct name_entry *names,
-			    struct name_entry *merged_version,
-			    unsigned is_null,     /* boolean */
-			    unsigned df_conflict, /* boolean */
-			    unsigned filemask,
-			    unsigned dirmask,
-			    int resolved          /* boolean */)
+static int setup_path_info(struct merge_options *opt,
+			   struct string_list_item *result,
+			   const char *current_dir_name,
+			   int current_dir_name_len,
+			   char *fullpath, /* we'll take over ownership */
+			   struct name_entry *names,
+			   struct name_entry *merged_version,
+			   unsigned is_null,     /* boolean */
+			   unsigned df_conflict, /* boolean */
+			   unsigned filemask,
+			   unsigned dirmask,
+			   int resolved          /* boolean */)
 {
 	/* result->util is void*, so mi is a convenience typed variable */
 	struct merged_info *mi;
@@ -1081,9 +1081,11 @@ static void setup_path_info(struct merge_options *opt,
 			 */
 			mi->is_null = 1;
 	}
-	strmap_put(&opt->priv->paths, fullpath, mi);
+	if (strmap_put(&opt->priv->paths, fullpath, mi))
+		return error(_("tree has duplicate entries for '%s'"), fullpath);
 	result->string = fullpath;
 	result->util = mi;
+	return 0;
 }
 
 static void add_pair(struct merge_options *opt,
@@ -1350,9 +1352,10 @@ static int collect_merge_info_callback(int n,
 	 */
 	if (side1_matches_mbase && side2_matches_mbase) {
 		/* mbase, side1, & side2 all match; use mbase as resolution */
-		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
-				names, names+0, mbase_null, 0 /* df_conflict */,
-				filemask, dirmask, 1 /* resolved */);
+		if (setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				    names, names+0, mbase_null, 0 /* df_conflict */,
+				    filemask, dirmask, 1 /* resolved */))
+			return -1; /* Quit traversing */
 		return mask;
 	}
 
@@ -1364,9 +1367,10 @@ static int collect_merge_info_callback(int n,
 	 */
 	if (sides_match && filemask == 0x07) {
 		/* use side1 (== side2) version as resolution */
-		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
-				names, names+1, side1_null, 0,
-				filemask, dirmask, 1);
+		if (setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				    names, names+1, side1_null, 0,
+				    filemask, dirmask, 1))
+			return -1; /* Quit traversing */
 		return mask;
 	}
 
@@ -1378,18 +1382,20 @@ static int collect_merge_info_callback(int n,
 	 */
 	if (side1_matches_mbase && filemask == 0x07) {
 		/* use side2 version as resolution */
-		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
-				names, names+2, side2_null, 0,
-				filemask, dirmask, 1);
+		if (setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				    names, names+2, side2_null, 0,
+				    filemask, dirmask, 1))
+			return -1; /* Quit traversing */
 		return mask;
 	}
 
 	/* Similar to above but swapping sides 1 and 2 */
 	if (side2_matches_mbase && filemask == 0x07) {
 		/* use side1 version as resolution */
-		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
-				names, names+1, side1_null, 0,
-				filemask, dirmask, 1);
+		if (setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				    names, names+1, side1_null, 0,
+				    filemask, dirmask, 1))
+			return -1; /* Quit traversing */
 		return mask;
 	}
 
@@ -1413,8 +1419,9 @@ static int collect_merge_info_callback(int n,
 	 * unconflict some more cases, but that comes later so all we can
 	 * do now is record the different non-null file hashes.)
 	 */
-	setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
-			names, NULL, 0, df_conflict, filemask, dirmask, 0);
+	if (setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+			    names, NULL, 0, df_conflict, filemask, dirmask, 0))
+		return -1; /* Quit traversing */
 
 	ci = pi.util;
 	VERIFY_CI(ci);
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index e18d5a227d..81b645bb3b 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -1525,4 +1525,58 @@ test_expect_success 'submodule/directory preliminary conflict' '
 	)
 '
 
+# Testcase: submodule/directory conflict with duplicate tree entries
+#   One side has a path as a gitlink (submodule).  The other side replaces
+#   the gitlink with a directory.  A third-party tool creates a tree on the
+#   submodule side that has *both* a gitlink and a tree entry for the same
+#   path (adding a file inside the submodule path ignoring that there's a
+#   gitlink there).  collect_merge_info_callback() should detect the
+#   duplicate and abort rather than silently corrupting its bookkeeping.
+
+test_expect_success 'duplicate tree entries trigger an error' '
+	test_when_finished "rm -rf duplicate-entry" &&
+	git init duplicate-entry &&
+	(
+		cd duplicate-entry &&
+
+		# Base commit: "docs" is a gitlink (submodule)
+		empty_tree=$(git mktree </dev/null) &&
+		fake_commit=$(git commit-tree $empty_tree </dev/null) &&
+		git update-index --add --cacheinfo 160000,$fake_commit,docs &&
+		echo base >file.txt &&
+		git add file.txt &&
+		git commit -m base &&
+
+		# side1: remove the gitlink, replace with a directory
+		git checkout -b side1 &&
+		git rm --cached docs &&
+		mkdir -p docs &&
+		echo hello >docs/requirements.txt &&
+		git add docs/requirements.txt &&
+		git commit -m "side1: submodule to directory" &&
+
+		# side2: keep the gitlink but craft a tree that also
+		# contains a tree entry for "docs" (simulating a tool
+		# that adds files inside a submodule path without
+		# removing the gitlink first).
+		git checkout main &&
+		git checkout -b side2 &&
+		blob_oid=$(echo world | git hash-object -w --stdin) &&
+		docs_tree=$(printf "100644 blob %s\trequirements.txt\n" \
+			"$blob_oid" | git mktree) &&
+		cur_tree=$(git rev-parse HEAD^{tree}) &&
+		git cat-file -p $cur_tree >tree-listing &&
+		printf "040000 tree %s\tdocs\n" "$docs_tree" >>tree-listing &&
+		new_tree=$(git mktree <tree-listing) &&
+		side2_commit=$(git commit-tree $new_tree -p HEAD \
+			-m "side2: add file alongside submodule") &&
+		git update-ref refs/heads/side2 $side2_commit &&
+
+		# Merging must detect the duplicate and abort
+		git checkout side1 &&
+		test_must_fail git merge side2 2>err &&
+		test_grep "duplicate entries" err
+	)
+'
+
 test_done
-- 
gitgitgadget

