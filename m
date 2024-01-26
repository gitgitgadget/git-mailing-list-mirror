Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4F1B801
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277700; cv=none; b=RnGnVWqzd8w1TN19QdJt/3UhBCYAEZWdEqAnNT+RYwOy2s0R3o+Fq1hiciR1er2I+TikoA5Mnu+iV9aXPURLd+aH0ahWadinc5WAywRgXstU8PQBWWaG5XfwXABGyUPso2pMRfkDKtcYcbHS342HoFPbFiTTf6WZLYWWp++zN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277700; c=relaxed/simple;
	bh=EAqnqi8IrrBFgvJmYK5SnCl2LC9xjMx0GAp9uWdNgNE=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=moZQK7nr5IPRYrzkqCEThc7xqgcxxFebDD/uIsD4VtEvxtpCdUaAAp6+F3KwLY6p4YTAnhqDj0mrtxZh2mLHgdY0DymDQ+skPBuDiWWdQpIF/kyIuxlHwFNmcQB+VVVPQwDH0XtxBS6yGTNE9qsR95wfCgfczh5gQzDov3q+mQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LThy6e2Z; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LThy6e2Z"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3392291b21bso593178f8f.1
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706277696; x=1706882496; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5GLaiM1EIV84Fl4KYOiiB9/c+pVNO2go4vdYva8bscg=;
        b=LThy6e2Zs99ByZYCv6dogcwdp0JqtPCSN8c7UQ0rC6K/y269/QaJPXv9ljPpsVgQtn
         uxvk3lR4AvtZ0/n+0nYEfeFTXykr+iqozuj6g4iceipIczpPv1jr3+jH5c3o67Qce9DE
         Qecm0IQqFWDVVG4JGl4PqmDIn+cdvmapYfHFAB/ZZ03fZV3qa0skWM0wI40lYDIJg335
         CKkRMAJPEw0CjZyDjoDSVjatsV0D6f51+DQpqKmxWLV/n4JvhDR1SsKdVbfmnsKk1WqC
         77hpvnYxiaZJGWxELYBj4TsHYBancNOmQ9C1jzU2t/G1d5EOJah8h1QE52ncFDPClvCZ
         mI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706277696; x=1706882496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GLaiM1EIV84Fl4KYOiiB9/c+pVNO2go4vdYva8bscg=;
        b=bchUk8UUqwcaeVdXxWtuMnt40D+GaabeUO8JHn9dN2JLJ/Yr3dIDaVEuXj8AkXYodg
         FwmPE0o+PnMBx72/yGeerZmm4GRiwGo/ulDIo9u131WdfRQ7Qce9cNb5lvezfA6oUaaD
         yo2s/8EVSwST/PtjSDY6Dd1jMQmtopl5MqqQmN45XUIT+sqAT6pNk12nnmsU0ntNxemC
         f7u5ZX97B4qvatSVHK0oxmJA+IbXHaBB0DZkfTZiUmamOAO4JoIXkG1PIEqjx+K5/L4f
         VQReD8wh/loMG/XES6JUr2Gorc9tIlTiALG5Drn8WUyx0GgqCYCTz9rW3IOcTxk4a7pm
         nTbg==
X-Gm-Message-State: AOJu0YwREU594yjVefGafzdjURHohKmPyYONZLoVxOIF4rtV4SZPtYK6
	3lMv05xkVUdQPsIk+nDCVpd4fMnBmVZ0UTyqJhcrx+3STOjv45dCDE+GfFf+
X-Google-Smtp-Source: AGHT+IERIGUtTCpGUc8RqHuqi90zTkl3BZONbihQKToKm1IwPqQj4BYg6qtxsHdznxvHkBzDqt8xbg==
X-Received: by 2002:a5d:4c90:0:b0:339:2f5f:58d4 with SMTP id z16-20020a5d4c90000000b003392f5f58d4mr993270wrs.20.1706277695811;
        Fri, 26 Jan 2024 06:01:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020adff745000000b003395642bc9bsm1328978wrp.117.2024.01.26.06.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 06:01:35 -0800 (PST)
Message-ID: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jan 2024 14:01:34 +0000
Subject: [PATCH] merge-tree: accept 3 trees as arguments
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When specifying a merge base explicitly, there is actually no good
reason why the inputs need to be commits: that's only needed if the
merge base has to be deduced from the commit graph.

This commit is best viewed with `--color-moved
--color-moved-ws=allow-indentation-change`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    merge-tree: accept 3 trees as arguments
    
    I was asked to implement this at $dayjob and it seems like a feature
    that might be useful to other users, too.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1647%2Fdscho%2Fallow-merge-tree-to-accept-3-trees-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1647/dscho/allow-merge-tree-to-accept-3-trees-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1647

 Documentation/git-merge-tree.txt |  5 +++-
 builtin/merge-tree.c             | 42 +++++++++++++++++++-------------
 t/t4301-merge-tree-write-tree.sh |  8 ++++++
 3 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index b50acace3bc..214e30c70ba 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -64,10 +64,13 @@ OPTIONS
 	share no common history.  This flag can be given to override that
 	check and make the merge proceed anyway.
 
---merge-base=<commit>::
+--merge-base=<tree-ish>::
 	Instead of finding the merge-bases for <branch1> and <branch2>,
 	specify a merge-base for the merge, and specifying multiple bases is
 	currently not supported. This option is incompatible with `--stdin`.
++
+As the merge-base is provided directly, <branch1> and <branch2> do not need
+o specify commits; it is sufficient if they specify trees.
 
 [[OUTPUT]]
 OUTPUT
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 3bdec53fbe5..cbd8e15af6d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -429,35 +429,43 @@ static int real_merge(struct merge_tree_options *o,
 	struct merge_options opt;
 
 	copy_merge_options(&opt, &o->merge_options);
-	parent1 = get_merge_parent(branch1);
-	if (!parent1)
-		help_unknown_ref(branch1, "merge-tree",
-				 _("not something we can merge"));
-
-	parent2 = get_merge_parent(branch2);
-	if (!parent2)
-		help_unknown_ref(branch2, "merge-tree",
-				 _("not something we can merge"));
-
 	opt.show_rename_progress = 0;
 
 	opt.branch1 = branch1;
 	opt.branch2 = branch2;
 
 	if (merge_base) {
-		struct commit *base_commit;
 		struct tree *base_tree, *parent1_tree, *parent2_tree;
 
-		base_commit = lookup_commit_reference_by_name(merge_base);
-		if (!base_commit)
-			die(_("could not lookup commit '%s'"), merge_base);
+		/*
+		 * We actually only need the trees because we already
+		 * have a merge base.
+		 */
+		struct object_id base_oid, head_oid, merge_oid;
+
+		if (repo_get_oid_treeish(the_repository, merge_base, &base_oid))
+			die(_("could not parse as tree '%s'"), merge_base);
+		base_tree = parse_tree_indirect(&base_oid);
+		if (repo_get_oid_treeish(the_repository, branch1, &head_oid))
+			die(_("could not parse as tree '%s'"), branch1);
+		parent1_tree = parse_tree_indirect(&head_oid);
+		if (repo_get_oid_treeish(the_repository, branch2, &merge_oid))
+			die(_("could not parse as tree '%s'"), branch2);
+		parent2_tree = parse_tree_indirect(&merge_oid);
 
 		opt.ancestor = merge_base;
-		base_tree = repo_get_commit_tree(the_repository, base_commit);
-		parent1_tree = repo_get_commit_tree(the_repository, parent1);
-		parent2_tree = repo_get_commit_tree(the_repository, parent2);
 		merge_incore_nonrecursive(&opt, base_tree, parent1_tree, parent2_tree, &result);
 	} else {
+		parent1 = get_merge_parent(branch1);
+		if (!parent1)
+			help_unknown_ref(branch1, "merge-tree",
+					 _("not something we can merge"));
+
+		parent2 = get_merge_parent(branch2);
+		if (!parent2)
+			help_unknown_ref(branch2, "merge-tree",
+					 _("not something we can merge"));
+
 		/*
 		 * Get the merge bases, in reverse order; see comment above
 		 * merge_incore_recursive in merge-ort.h
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 12ac4368736..71f21bb834f 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -945,4 +945,12 @@ test_expect_success 'check the input format when --stdin is passed' '
 	test_cmp expect actual
 '
 
+test_expect_success '--merge-base with tree OIDs' '
+	git merge-tree --merge-base=side1^ side1 side3 >tree &&
+	tree=$(cat tree) &&
+	git merge-tree --merge-base=side1^^{tree} side1^{tree} side3^{tree} >tree2 &&
+	tree2=$(cat tree2) &&
+	test $tree = $tree2
+'
+
 test_done

base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
-- 
gitgitgadget
