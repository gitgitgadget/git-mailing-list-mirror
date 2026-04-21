Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992119DF62
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731188; cv=none; b=UuowtTs08Covk6e7COfBKM0X13RUOAZalPANLbaoG1Cu6OKmF+Dz9xBX+SRFtJjDUkQlNes2gXwmVPBhji5Hz0fLTaq5KIMC/5IrGL/PapEFmnT3Y1vEEluNvICK8xOHCLYZHole6A/+fbOgjr0suXlg1FYZOVc59DDseNmLpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731188; c=relaxed/simple;
	bh=V0yuFY07b8V2jF2cWnBvNH7D10iDFRdNjNeRK0+eQLw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WKf/5IJ2y/hNCWcr3/zORx+hMZlK4zlYk+wAGObv8QvBz1RXY9e8pMt2y5Z6p/vdHTk2hqWuj85gSBJRcLSPYHcW8kTI+PyvwlZ+5iy+C77P7n+ZgM8oVsBzIe+3VYU86jbz/fZvcDLjOOu7NC+9/xRIGkiU7Ns8sCst02h0K1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na38OWKH; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na38OWKH"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a093c784b0so46200356d6.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 17:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776731185; x=1777335985; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKEqLTWj4tHGOob5tl/Hn6N8fBtH1FPUSP8wU0B/Bwg=;
        b=na38OWKHrKWgrkEgTADu7FBxczg5WKRufJWYapYbQbL/m1Yi936DqPXV3jX9HFfnHp
         W501wAu7v6yRZ6TU7abONtcS8nMd/vlm6xyr2pw9H6ShagQKkYoJmq4v0wOvTv/u4X1j
         fwA/rN7rgM9ic4CBMUG0UiM5d/F0KEMSizvU4Fit8v3q/4gQaEj4rgDvItzHIynKMyXt
         bWhJUdj52Ea2HZBmJHymKEjja1HJ6697jsr3VTUEfw8lQ5ZHANF7XZqPlkkar+x4vVmg
         A8l6/sUW4ijVs7IS+ILnsS1cgue9dRIEJcAz3VoTx79KPRViN4FCwXg0rZuZWaXDCL7X
         OJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776731185; x=1777335985;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zKEqLTWj4tHGOob5tl/Hn6N8fBtH1FPUSP8wU0B/Bwg=;
        b=JxLJ4njHgNnxAgVZeMP5VsHfSZ6RYVOmiCc/QYcGS6ssJJ4uIdhRKSh7N/MWIkkRMa
         VHbp5s4kP4qihO31etRu2eq5UpWzGQa087f4v673KncfKpamN0dG9w8a2btwoTgY79Iy
         POckyQQ/KHoxIOZCuJi3bu8T0We4jsFo9Vhv325c0r3gn5QU184T/45dp0VnGnVtbH6Z
         3Wqt608cSsYMd1hqC+JnXjQBene0H5i/WJwt+yYhkq8Vd/ogn00lOacNECPiDppiPEfL
         TexB5PVgKlEuIJB9J9LayhTbD63o7AxdQiIpiMLF67FkpZfUXdvSnUKvtpz1t0FqHf7g
         +rGQ==
X-Gm-Message-State: AOJu0YzYPrJDTPh/WS2mFDjfNQfJ2L6HaqY4Pyvs5V66fWCH7S1qLvTY
	Aiq1aLm41vhScb930mNMSPJjulkZ8eTgjfQNczfzJew6C1bW9Vo3NPzKIWqMlA==
X-Gm-Gg: AeBDiet6Ru1P7sgXni7pEdcEG1y7RV485hCcYwoGWlUYZbO3xecwMrPA6KpU/UlAHgl
	UAAxOMtbp2W9SfQ5azN3GDF+4eOiexZOW3TKuFgEFIRdbLt8dhEMFlXL1j4qmA5EbCE79a2I1Yn
	L3ilqQKqFkWX2VhbfP2Gg/iZ8kzVQMihwdGMFYocVajutB6Vz+uORgV8+5Hp5becMmrg4DroSFt
	vsKPysPZgl6SPSYup7oLZVh0SaaWPDivJlYpxfVjWwZDMQYYKO08flPPzSmFUINOPZ5bW91hWg1
	Fs3IhRK9fk+nO8L06N2tujp8LaklFQW3QWr2Snh+DppVYxr4ttLshWOeVuvon7ZXIRq1AhQZnCN
	k7zR6k1HLbZ+fFW2qA/R60m1DsjXDeGD1j9avoBneCs/39qXbmd9wi91GNuTuB9cXUbLxE5j3ym
	E1G9Wf6VNA81WsScNNI31UGcBR7rvyR0GnY7o/sHzm9O6N99k=
X-Received: by 2002:a05:6214:3490:b0:8ac:b4d5:50e8 with SMTP id 6a1803df08f44-8b0280f80ddmr211548066d6.26.1776731184625;
        Mon, 20 Apr 2026 17:26:24 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.117.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae86947sm116167506d6.37.2026.04.20.17.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 17:26:22 -0700 (PDT)
Message-Id: <0d81c027aafcb386398836ffc73b058b7ea4c702.1776731171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Apr 2026 00:26:10 +0000
Subject: [PATCH 4/5] merge-ort: abort merge when trees have duplicate entries
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
Cc: Elijah Newren <newren@gmail.com>,
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

