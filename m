Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E26274B26
	for <git@vger.kernel.org>; Mon, 29 Dec 2025 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033789; cv=none; b=HWfnDZVcWBkcl7QzrXJsYoaGxdNitA3xnRlHut6kCxDhCWqOoLfLDAZseqymViBxEDU5Zq8IEpgTnKBvFVsZf7Oy/CXHq4L2Ie4IkdZB38EgfWOTm2NgXg382g1sc2j/LM6zu79Wr0KCb1Rjh1J27iyPOg3N24stj4s1EgLxSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033789; c=relaxed/simple;
	bh=MAPgXrxt7b0XccbkkAtOb14d0Ek+LPbNJTvb5taH+lU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VZnBiA3ecxDXbms1SWMdGxEu7khSgplWP5OJX87l+Pw9c4S5uTQizEwAGnfY+wXgLJ2YpbuKmjPzjpPED0L75Z2VTUKaFoWkBLauExmxo40424RDb0LIMEC6oFjjxZ0QhI+lw7FvYvKPNho8QWHGNUFYTxHt2XExadTBHUTfiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDlpqWxm; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDlpqWxm"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88ffcb14e11so50701126d6.0
        for <git@vger.kernel.org>; Mon, 29 Dec 2025 10:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767033786; x=1767638586; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yTZja+x93az0UKXVY9V6f5wF+CUHhU53V0YZrHEF5bU=;
        b=GDlpqWxme59S2Y5kZ9w+aotQQQN2UQ8CPZ+uB/Xzdrw3RiI1CD4ARM4TpxF+/P6fp8
         tE0iY3XeRGD5ZiYhGXTbjw9GHRSVOoZmLJIDYZJctcAgGMqg4AnXUN9RoE14CeB8IhVh
         WCvLtQ7CUThO11wbXeaNvbnk0RNRnWaRKW8u0Anr+tz/1nySFo//5Hg6RtKmKdb/FpCd
         fNpsowYJUJHywGF64pslQFfpm+C7v28r/EQsCnbO67ufkPFlGUH7NRyGKuhlch07N6js
         SNfijfuJ2vhQmkSoUnzcmwRarFZHUL2GFj53GxTNKC4xnHU+76E7tOvq04O7SgTT9oAZ
         137Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033786; x=1767638586;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTZja+x93az0UKXVY9V6f5wF+CUHhU53V0YZrHEF5bU=;
        b=j3P4vgPN374uKXHRUEfYucUykbz5bwP4LQdMFVy7YJPHED2m6fXytQGT9o4ohcOTXh
         epKNOss8X06+jQscYBj5Zt/wSvF+zSoCmbh1tM1KHvvX+2ZJyQFHMmSUH/hNcPA4KTe7
         7jUHlAVqWVZAtngNtIOlOeRGNqN0nia2lfc+Lhqu33RDQdKl12QPZVLIGxexjf8lkx5e
         wndl7Qchlkt23R+KaNsdx3IlqhImWQBZkBkTPXH/Bkew1xC2nVHnoqmPvStI7qVpPQRo
         BtM6bfSwwPA5jnP2xqxj3D5croVYu+vZxmLy7/u1ZHX2RlzoPTK9EjHrRi5TUv9UPYqB
         wlKg==
X-Gm-Message-State: AOJu0Yzd3UU/zUR0dfMaWjiQUvS+MvpLGAEs5xQ09sl2NQ2b7siE+iNw
	hMhxuY+LuK/wvRX1KtvwL30wg8lgfaPLfKQM1jwlcqclWlaDMtbo7APyFtNp90Pj
X-Gm-Gg: AY/fxX49acRaFTyo4bX+2/uEuKRphlW+/YcUj3aym7LL32gJ6cO1Yz6otFIsIkUY321
	Z5LwqkVFHlDVuQ8gyaQYcFF188HqZ15YAqs7PGw+wFVydWtHZPDQyPoHRwbsY+oo1I2xNVWNRsF
	hUwSrXO1j9NwUKr39r1k9gEiovRdh/zEqKhQ0Z/0Y7AMsVG1P1Ny94keAxYcSoZAFL0JH+o3i5N
	Zliy0/rj5i6cWB1wavgDSNxdf9ZMJFNm2pcfkcJGnpddqRXReeTP42KLAPuX0jyOdzjhAcBvJ1I
	CrwWWawtyPHggtVBI234gREOPIYMNe3ildaG0p6XFV5WeelQoBxrGCBUrzNPTT0X8a9Hs3fGyWA
	W67b1UL1+T3hsZHCslPcuXGL7F49c84dfoJk9a8tEbqJjqGC/vV/ER73Ao/6gjREx6KwAQoOb4w
	WSWoUFtXZ1SeS7JQ==
X-Google-Smtp-Source: AGHT+IHh6n9g9aIBIrkJZb5+9jwT+WHP9xj95nGg/yYkJ4vj69wyKiPodkAU14/6wVg3ED6BSibXAQ==
X-Received: by 2002:a05:622a:1e85:b0:4ee:4aa5:4bc8 with SMTP id d75a77b69052e-4f4abdbe4bamr534193141cf.64.1767033785488;
        Mon, 29 Dec 2025 10:43:05 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac563f66sm220632321cf.15.2025.12.29.10.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:43:04 -0800 (PST)
Message-Id: <pull.2023.git.1767033783800.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Dec 2025 18:43:03 +0000
Subject: [PATCH] merge-ort: fix corner case recursive submodule/directory
 conflict handling
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

At GitHub, a few repositories were triggering errors of the form:

    git: merge-ort.c:3037: process_renames: Assertion `newinfo && !newinfo->merged.clean' failed.
    Aborted (core dumped)

While these may look similar to both
    a562d90a350d (merge-ort: fix failing merges in special corner case,
                  2025-11-03)
and
    f6ecb603ff8a (merge-ort: fix directory rename on top of source of other
                  rename/delete, 2025-08-06)
the cause is different and in this case the problem is not an
over-conservative assertion, but a bug before the assertion where we did
not update all relevant state appropriately.

It sadly took me a really long time to figure out how to get a simple
reproducer for this one.  It doesn't really have that many moving parts,
but there are multiple pieces of background information needed to
understand it.

First of all, when we have two files added at the same path, merge-ort
does a two-way merge of those files.  If we have two directories added
at the same path, we basically do the same thing (taking the union of
files, and two-way merging files with the same name).  But two-way
merging requires components of the same type.  We can't merge the
contents of a regular file with a directory, or with a symlink, or with
a submodule.  Nor can any of those other types be merged with each
other, e.g. merging a submodule with a directory is a bad idea.  When
two paths have the same name but their types do not match, merge-ort is
forced to move one of them to an alternate filename (using the
unique_path() function).

Second, if two commits being merged have more than one merge-base,
merge-ort will merge the merge-bases to create a virtual merge-base, and
use that as the base commit.

Third, one of the really important optimizations in merge-ort is trivial
tree-level resolution (roughly meaning merging trees without recursing
into them).  This optimization has some nuance to it that is important
to the current bug, and to understand it, it helps to first look at the
high-level overview of how merge-ort runs; there are basically three
high-level functions that the work is divided between:
    collect_merge_info() - walks the top-level trees getting individual
                           paths of interest
    detect_renames() - detect renames between paths in order to match up
                       paths for three-way merging
    process_entries() - does a few things of interest:
      * three-way merging of files,
      * other special handling (e.g. adjusting paths with conflicting
        types to avoid path collisions)
      * as it finishes handling all the files within a subdirectory,
        writes out a new tree object for that directory

If it were not for renames, we could just always do tree-level merging
whenever the tree on at least one side was unmodified.  Unfortunately,
we need to recurse into trees to determine whether there are renames.
However, we can also do tree-level merging so long as there aren't any
*relevant* renames (another merge-ort optimization), which we can
determine without recursing into trees.

We would also be able to do tree-level merging if we somehow apriori
knew what renames existed, by only recursing into the trees which we
could otherwise trivially merge if they contained files involved in
renames.  That might not seem useful, because we need to find out the
renames and we have to recurse into trees to do so, but when you find
out that the process_entries() step is more computationally expensive
than the collect_merge_info() step, it yields an interesting strategy:
   * run collect_merge_info()
   * run detect_renames()
   * cache the renames()
   * restart -- rerun collect_merge_info(), using the cached renames to
     only recurse into the needed trees
   * we already have the renames cached so no need to re-detect
   * run process_entries() on the reduced list of paths
which was implemented back in 7bee6c100431 (merge-ort: avoid recursing
into directories when we don't need to, 2021-07-16)  Crucially, this
restarting only occurs if the number of paths we could skip recursing
into exceeds the number we still need to recurse into by some safety
factor (wanted_factor in handle_deferred_entries()); forgetting this
fact is a great way to repeatedly fail to create a minimal testcase for
several days and go down alternate wrong paths).

Now, I earlier summarized this optimization as "merging trees without
recursing into them", but this optimization does not require that all
three sides of history has a directory at a given path.  So long as the
tree on one side matches the tree in the base version, we can decide to
resolve in favor of whatever the other side of history has at that path
-- be it a directory, a file, a submodule, or a symlink.  Unfortunately,
the code in question didn't fully realize this, and was written assuming
the base version and both sides would have a directory at the given
path, as can be seen by the "ci->filemask == 0" comment in
resolve_trivial_directory_merge() that was added as part of 7bee6c100431
(merge-ort: avoid recursing into directories when we don't need to,
2021-07-16).  A few additional lines of code are needed to handle cases
where we have something other than a directory on the other side of
history.

But, knowing that resolve_trivial_directory_merge() doesn't have
sufficient state updating logic doesn't show us how to trigger a bug
without combining with the other bits of information we provided above.
Here's a relevant testcase:
   * branches A & B
   * commit A1: adds "folder" as a directory with files tracked under it
   * commit B1: adds "folder" as a submodule
   * commit A2: merges B1 into A1, keeping "folder" as a directory
     (and in fact, with no changes to "folder" since A1), discarding the
     submodule
   * commit B2: merges A1 into B1, keeping "folder" as a submodule
     (and in fact, with no changes to "folder" since B1), discarding the
     directory
Here, if we try to merge A2 & B2, the logic proceeds as follows:
   * we have multiple merge-bases: A1 & B1.  So we have to merge those
     to get a virtual merge base.
   * due to "folder" as a directory and "folder" as a submodule, the
     path collision logic triggers and renames "folder" as a submodule
     to "folder~Temporary merge branch 2" so we can keep it alongside
     "folder" as a directory.
   * we now have a virtual merge base (containing both "folder"
     directory and a "folder~Temporary merge branch 2" submodule) and
     can now do the outer merge
   * in the first step of the outer merge, we attempt to defer recursing
     into folder/ as a directory, but find we need to for rename
     detection.
   * in rename detection, we note that "folder~Temporary merge branch 2"
     has the same hash as "folder" as a submodule in B2, which means we
     have an exact rename.
   * after rename detection, we discover no path in folder/ is needed
     for renames, and so we can cache renames and restart.
   * after restarting, we avoid recursing into "folder/" and realize we
     can resolve it trivially since it hasn't been modified.  The
     resolution removes "folder/", leaving us only "folder" as a
     submodule from commit B2.
   * After this point, we should have a rename/delete conflict on
     "folder~Temporary merge branch 2" -> "folder", but our marking of
     the merge of "folder" as clean broke our ability to handle that and
     in fact triggers an assertion in process_renames().

When there was a df_conflict (directory/"file" conflict, where "file"
could be submodule or regular file or symlink), ensure
resolve_trivial_directory_merge() handles it properly.  In particular:
  * do not pre-emptively mark the path as cleanly merged if the
    remaining path is a file; allow it to be processed in
    process_entries() later to determine if it was clean
  * clear the parts of dirmask or filemask corresponding to the matching
    sides of history, since we are resolving those away
  * clear the df_conflict bit afterwards; since we cleared away the two
    matching sides and only have one side left, that one side can't
    have a directory/file conflict with itself.

Also add the above minimal testcase showcasing this bug to t6422, **with
a sufficient number of paths under the folder/ directory to actually
trigger it**.  (I wish I could have all those days back from all the
wrong paths I went down due to not having enough files under that
directory...)

I know this commit has a very high ratio of lines in the commit message
to lines of comments, and a relatively high ratio of comments to actual
code, but given how long it took me to track down, on the off chance
that we ever need to further modify this logic, I wanted it thoroughly
documented for future me and for whatever other poor soul might end up
needing to read this commit message.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: fix corner case recursive submodule/directory conflict
    handling
    
    This bug dates back to ort's introduction, in particular with
    7bee6c100431 (merge-ort: avoid recursing into directories when we don't
    need to, 2021-07-16).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2023%2Fnewren%2Ffix-submodule-merge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2023/newren/fix-submodule-merge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2023

 merge-ort.c                          | 35 ++++++++++-
 t/t6422-merge-rename-corner-cases.sh | 86 ++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9e85a5e60a..2b837a58c3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1502,11 +1502,44 @@ static void resolve_trivial_directory_merge(struct conflict_info *ci, int side)
 	VERIFY_CI(ci);
 	assert((side == 1 && ci->match_mask == 5) ||
 	       (side == 2 && ci->match_mask == 3));
+
+	/*
+	 * Since ci->stages[0] matches ci->stages[3-side], resolve merge in
+	 * favor of ci->stages[side].
+	 */
 	oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
 	ci->merged.result.mode = ci->stages[side].mode;
 	ci->merged.is_null = is_null_oid(&ci->stages[side].oid);
+
+	/*
+	 * Because we resolved in favor of "side", we are no longer
+	 * considering the paths which matched (i.e. had the same hash) any
+	 * more.  Strip the matching paths from both dirmask & filemask.
+	 * Another consequence of merging in favor of side is that we can no
+	 * longer have a directory/file conflict either..but there's a slight
+	 * nuance we consider before clearing it.
+	 *
+	 * In most cases, resolving in favor of the other side means there's
+	 * no conflict at all, but if we had a directory/file conflict to
+	 * start, and the directory is resolved away, the remaining file could
+	 * still be part of a rename.  If the remaining file is part of a
+	 * rename, then it may also be part of a rename conflict (e.g.
+	 * rename/delete or rename/rename(1to2)), so we can't
+	 * mark it as a clean merge if we started with a directory/file
+	 * conflict and still have a file left.
+	 *
+	 * In contrast, if we started with a directory/file conflict and
+	 * still have a directory left, no file under that directory can be
+	 * part of a rename, otherwise we would have had to recurse into the
+	 * directory and would have never ended up within
+	 * resolve_trivial_directory_merge() for that directory.
+	 */
+	ci->dirmask &= (~ci->match_mask);
+	ci->filemask &= (~ci->match_mask);
+	assert(!ci->filemask || !ci->dirmask);
 	ci->match_mask = 0;
-	ci->merged.clean = 1; /* (ci->filemask == 0); */
+	ci->merged.clean = !ci->df_conflict || ci->dirmask;
+	ci->df_conflict = 0;
 }
 
 static int handle_deferred_entries(struct merge_options *opt,
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index f14c0fb30e..e18d5a227d 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -1439,4 +1439,90 @@ test_expect_success 'rename/rename(1to2) with a binary file' '
 	)
 '
 
+# Testcase preliminary submodule/directory conflict and submodule rename
+#   Commit O: <empty, or additional irrelevant stuff>
+#   Commit A1: introduce "folder" (as a tree)
+#   Commit B1: introduce "folder" (as a submodule)
+#   Commit A2: merge B1 into A1, but keep folder as a tree
+#   Commit B2: merge A1 into B1, but keep folder as a submodule
+#   Merge A2 & B2
+test_setup_submodule_directory_preliminary_conflict () {
+	git init submodule_directory_preliminary_conflict &&
+	(
+		cd submodule_directory_preliminary_conflict &&
+
+		# Trying to do the A2 and B2 merges above is slightly more
+		# challenging with a local submodule (because checking out
+		# another commit has the submodule in the way).  Instead,
+		# first create the commits with the wrong parents but right
+		# trees, in the order A1, A2, B1, B2...
+		#
+		# Then go back and create new A2 & B2 with the correct
+		# parents and the same trees.
+
+		git commit --allow-empty -m orig &&
+
+		git branch A &&
+		git branch B &&
+
+		git checkout B &&
+		mkdir folder &&
+		echo A>folder/A &&
+		echo B>folder/B &&
+		echo C>folder/C &&
+		echo D>folder/D &&
+		echo E>folder/E &&
+		git add folder &&
+		git commit -m B1 &&
+
+		git commit --allow-empty -m B2 &&
+
+		git checkout A &&
+		git init folder &&
+		(
+			cd folder &&
+			>Z &&
+			>Y &&
+			git add Z Y &&
+			git commit -m "original submodule commit"
+		) &&
+		git add folder &&
+		git commit -m A1 &&
+
+		git commit --allow-empty -m A2 &&
+
+		NewA2=$(git commit-tree -p A^ -p B^ -m "Merge B into A" A^{tree}) &&
+		NewB2=$(git commit-tree -p B^ -p A^ -m "Merge A into B" B^{tree}) &&
+		git update-ref refs/heads/A $NewA2 &&
+		git update-ref refs/heads/B $NewB2
+	)
+}
+
+test_expect_success 'submodule/directory preliminary conflict' '
+	test_setup_submodule_directory_preliminary_conflict &&
+	(
+		cd submodule_directory_preliminary_conflict &&
+
+		git checkout A^0 &&
+
+		test_expect_code 1 git merge B^0 &&
+
+		# Make sure the index has the right number of entries
+		git ls-files -s >actual &&
+		test_line_count = 2 actual &&
+
+		# The "folder" as directory should have been resolved away
+		# as part of the merge.  The "folder" as submodule got
+		# renamed to "folder~Temporary merge branch 2" in the
+		# virtual merge base, resulting in a
+		#    "folder~Temporary merge branch 2" -> "folder"
+		# rename in the outermerge for the submodule, which then
+		# becomes part of a rename/delete conflict (because "folder"
+		# as a submodule was deleted in A2).
+		submod=$(git rev-parse A:folder) &&
+		printf "160000 $submod 1\tfolder\n160000 $submod 2\tfolder\n" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done

base-commit: b31ab939fe8e3cbe8be48dddd1c6ac0265991f45
-- 
gitgitgadget
