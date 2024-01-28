Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651CA59
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706474068; cv=none; b=VD0LwlcvVHFvhK56wAZPOYLra4Ctbx+EKegmhKPTc4KYLawnjTyG6pJPJEJ5Ro34IkWjsP2nILqKIpFLy4hOA7/atMYFUXbYzMAfCY9+M4DVHcpkcqYDx7f7rHL9VDg5dhPMTWCyDPdYlDihcTSEI5tmIQnOIgzMt4c2SOQvSN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706474068; c=relaxed/simple;
	bh=r8wW28QMEuslJG2VJ2AHW9tS4c04SPpsf46u/vqy95o=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Pdy8DwNYTW81B24rECNNsNN8qxDpu/+wPxNmnCu4u2zDpL+nt4T9onP0Ie009gItvFCMeBZ1MrKIBktGevgVsSggL+SIPvPCoP8x61O88bsZFS3udQoO2QxwmJAZSEGlz28HA/02DJBR/cUXs2yj3k0PmHyPa2tYRSh/iApOBNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRZGpLQh; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRZGpLQh"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51025cafb51so2733470e87.2
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 12:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706474064; x=1707078864; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a/cAEzOPPnYAEsH0MuFGoJjkjH88PXFmhHLMz5/Zjg=;
        b=MRZGpLQhcbG5qzNQ5uru4s4CM8U+8udNq5iA2Evqqgzsn92Z2TZcy8J1m+bQwm6FGt
         mfJg7NpEyBJWgkkjT3oOBxTzcepoHV4Ce9QYXjzrLXfvsbNz5CNV+mjQlW7AnrlFKBVK
         tVCm2/cOG9KSGAbKOxLgCFcJ9v38SfCYhq1B6tWa3VKwEPWOJMKxthLYunlF5CDYAu+w
         L6sPLLnQ2PLw46GqsZVwJ/RDiuwYqpg9Xt5cNouFJDYHoLB3m9rIBMmPAnXU2rmfbIuM
         edbdOknLOTktkfjBQqvP6NvRFsxKC8s2rbzZnZi2Cyd2B30KWZZ+Nfcr9rRVHtXBQxaq
         0PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706474064; x=1707078864;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1a/cAEzOPPnYAEsH0MuFGoJjkjH88PXFmhHLMz5/Zjg=;
        b=myaSQHr/DTdxLYPpI37xNS6q+58sKWz4QA52sHg/trq38DuKJUu6SkT1RsK98rZRn+
         ChnwIsdo1cRqetnnkUqqsVr0NnXi4RcjBL+mmlLQr0DLqJXZbJiRFvaanRtG15tJg2ks
         blAMg1En+3xy2KNF1+1IpXwYFjXjSXWmwPUjGQlqlC/IC/dtvJUMLLDh2Z9o7XQXQcZO
         zQglKZYsw0nz1odtEsIQLyJDcuN3ys4fvt6gFu5EUCUWc1P9G1YyY3BM+S+sDeqP1/KW
         qPT2QvmdW/EKUUbRBcVGIBebLIQqjVjLw214Do/p01vF8E6PmjPUPZ1Idm1veordhDPh
         JWfg==
X-Gm-Message-State: AOJu0YygCIBpq3lbQ6HTe4awdNt6rpTYXUGp81QVp6BGlWPnJ3RU5z4W
	j/DfTH41cdVY1ol/L7CRiCQwYKiSwd++MjiJTLFS0vHZsNbZ9mAWIzKbi2dC
X-Google-Smtp-Source: AGHT+IFzzEGzc2OsH44k2JFdk4hGWRu0IQxl/zppLigKfZ0q+LY7riJG+bJ/pSbeLbcQoPveq4z42A==
X-Received: by 2002:a05:6512:3050:b0:50e:50ee:f378 with SMTP id b16-20020a056512305000b0050e50eef378mr2948686lfb.65.1706474064154;
        Sun, 28 Jan 2024 12:34:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b0040e541ddcb1sm8183551wmg.33.2024.01.28.12.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 12:34:23 -0800 (PST)
Message-ID: <pull.1647.v2.git.1706474063109.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
References: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jan 2024 20:34:22 +0000
Subject: [PATCH v2] merge-tree: accept 3 trees as arguments
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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
    
    Changes since v1:
    
     * Fixed a typo in the manual page, simplified the part after the
       semicolon.
     * Simplified the test case.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1647%2Fdscho%2Fallow-merge-tree-to-accept-3-trees-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1647/dscho/allow-merge-tree-to-accept-3-trees-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1647

Range-diff vs v1:

 1:  29234754c06 ! 1:  233a25e9071 merge-tree: accept 3 trees as arguments
     @@ Documentation/git-merge-tree.txt: OPTIONS
       	currently not supported. This option is incompatible with `--stdin`.
      ++
      +As the merge-base is provided directly, <branch1> and <branch2> do not need
     -+o specify commits; it is sufficient if they specify trees.
     ++to specify commits; trees are enough.
       
       [[OUTPUT]]
       OUTPUT
     @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'check the input format wh
       '
       
      +test_expect_success '--merge-base with tree OIDs' '
     -+	git merge-tree --merge-base=side1^ side1 side3 >tree &&
     -+	tree=$(cat tree) &&
     -+	git merge-tree --merge-base=side1^^{tree} side1^{tree} side3^{tree} >tree2 &&
     -+	tree2=$(cat tree2) &&
     -+	test $tree = $tree2
     ++	git merge-tree --merge-base=side1^ side1 side3 >with-commits &&
     ++	git merge-tree --merge-base=side1^^{tree} side1^{tree} side3^{tree} >with-trees &&
     ++	test_cmp with-commits with-trees
      +'
      +
       test_done


 Documentation/git-merge-tree.txt |  5 +++-
 builtin/merge-tree.c             | 42 +++++++++++++++++++-------------
 t/t4301-merge-tree-write-tree.sh |  6 +++++
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index b50acace3bc..dd388fa21d5 100644
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
+to specify commits; trees are enough.
 
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
index 12ac4368736..c5628c4e613 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -945,4 +945,10 @@ test_expect_success 'check the input format when --stdin is passed' '
 	test_cmp expect actual
 '
 
+test_expect_success '--merge-base with tree OIDs' '
+	git merge-tree --merge-base=side1^ side1 side3 >with-commits &&
+	git merge-tree --merge-base=side1^^{tree} side1^{tree} side3^{tree} >with-trees &&
+	test_cmp with-commits with-trees
+'
+
 test_done

base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
-- 
gitgitgadget
