Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C53655ED
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554427; cv=none; b=M/hvFdCpkVeu9uTcUu7PEE7sqUW5iOG3/wjKek1JBXXjtJbAQg/U1xK9yhUJjfyCnqUOG/RacxDnPbRXFxjT7HPh/lMwO1YBdSehDTb+jELOxrxfClOSS1skQcJXdi89hEnoMZDFMUCWqaUVSsKy3hSmxJ7fg6hM4PtcVn46+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554427; c=relaxed/simple;
	bh=NtZcsN6po8kq6fD5OA0i5VqoJcfo2VVMiGIZpEV+WzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/TAhG7kMUSwCbgdwAxkbdiFraICRiv6UVJ2/kR2eWn0G+V/sie1+ZxKjBwMCPVFa0wF1UOWSoO5mC+2nuA3yYP4VoreAcyAfZe4YRis1vrqXF2PP9kVvrOn4HpD9qvSWIEVNZXCcc7njketv9FcUaOceyK9nUBd/4PbZ96VtDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwoIUYhu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwoIUYhu"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso2876420b3a.3
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791554421; x=1792159221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=goENelJqjhna4906JMU1OUfcYDV2z/mgj+qVBFL3+q8=;
        b=nwoIUYhuQcNEbpJPa+kF9KDarFuNkkGXdEj7B0diJTJQn1rQJOi6HrhctHK9FHvRip
         rTReCyAnrKys5CxRiGSothjalb6KmdLZnLVE3WUoC5WYlrRjnGP94MOSHMIm5FunoY7r
         pe+NIjuM3ziZd7HzW5ob5PO057yff+lanCDiyhF7npge1JXmMWrftLt6jlReHu2q/E7g
         /6sZx9+qj8HRqBqWJWvD4Bz3bs8Meig4kO8OXD8eUZru68J8b0RHWpvrrCePvr0Ag+Sr
         HmDhqn+ANHLkDnbvo91xIQpc2oswm8JCgP+bvWnGAXsxbJ7isPNBylOOu/VijpcPKlr7
         +tSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554421; x=1792159221;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=goENelJqjhna4906JMU1OUfcYDV2z/mgj+qVBFL3+q8=;
        b=FdgnF37Is+aJVEravN7TPmRKjpRx0pSXlIOxz2z2QQKRBOu4DAvrMnZLMLcweajnNa
         5ruNg/oN0zYfcqLLTGgeCK0VZU4nQfcwH5R9e2zrj163+Z1uFCBmx/bGr30MiyCwIdSf
         h0ckSZ0dCb8ZxWaspOrR4tZfyW4nfhcpK/Iz0x66UdOa44YuGoNYkp4fcP438gb/FmCJ
         lY7kK9VQHJ35y/eNAO3cPL5m8AGapERi1Y1fmzpzHYpPJsGeFbrsQDx2PLjaDcj0QqRX
         BY8mhZHjfkUWTMwej/zHKDd8+HYxqFcC+KPn/Sy8AysnPdhDJ2q2HpqMFbiq32OFNLEd
         1qbg==
X-Gm-Message-State: AFq9FYIxV7YLUQdWaA2CuWYyoe2qk9XizNljLEoMlFdUVGkCFoboHr0h
	UigGc/8NE4TW6XOlL0lOZsY0PVHHmc7vKWTaysaOntTOn51L9w7EYoeCE98F/OwmLG4=
X-Gm-Gg: AYBFou0OKX21MU34c17mbM+wL19jne2rwZy5Y+k0KORx03Cz7aEhum9XIexEEurY06W
	RPflzoS325KRIxWG8EysO+twz27qjmP2kM9Palyn6KT7GraovlfVxFnWW6nTfY4vVLGHbQ90V9t
	RX+gkOGV0+de28hns1BGa/5nhLvKMj3JsRLwyHvwSyPQpDY5494WGNx8ion6r6pKkVIBSbUZUEI
	Eyc0G9inVivbFD7YO3TItKf978NeI0DbFa142WaJ5j1TNP5xsRYPyNIXym/2ipYqKLd0L1WkVWL
	+4EIomBJOOr4VrNU2p/e3G+zhWfM8ccEjiFJI20D69rbkbMy7zkFyatFqkO/7dlAcUKI8sgqER2
	gWyZ4HhZp9zG5QtlGFxEY7oTk5vOAZiv5J4H/umZhocowLf2vtPZJ5oi7Wa21/9hKVRyhFEyhgg
	mW/70eRWQj798h0ErHpOg03beaa9sQNOLxfPT1boH6MZpNsRhSsIrezt8LIPAAMqkKjIVSFD/eG
	lC/P80=
X-Received: by 2002:a05:6a00:8c4:b0:88b:de09:ffc0 with SMTP id d2e1a72fcca58-897c644343dmr1937032b3a.20.1791554421247;
        Fri, 09 Oct 2026 07:00:21 -0700 (PDT)
Received: from archlinux ([2409:40f4:3151:37e2:36ef:bf3c:7f30:217e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c3ecb01dsm1041644b3a.36.2026.10.09.07.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:00:20 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: webstrand@gmail.com,
	newren@gmail.com,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH] unpack-trees: protect untracked files in sparse checkouts
Date: Fri,  9 Oct 2026 19:30:05 +0530
Message-ID: <a17e56acd90a931ebe95555bf62b47469ea2708a.1791543268.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CACm1TQd5b9tX368LrsD26Q6tm_mzdi1nwGtGd2V1jwYW+r2c1A@mail.gmail.com>
References: <CACm1TQd5b9tX368LrsD26Q6tm_mzdi1nwGtGd2V1jwYW+r2c1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In a sparse checkout, switching to a branch that adds a file over an
untracked local path can warn and continue, replacing the local contents.
Ordinary checkout refuses the same switch.

merged_entry() defers the check for new paths until sparse patterns are
known. The deferred check reports a sparsity warning, and unpack_trees()
clears its failure before updating the working tree.

Use the ordinary untracked overwrite error for that check. Finish checking
all new entries before applying sparsity changes, and abort through the
existing failure path if any conflict is found. Keep advisory warnings for
sparsity changes to existing entries.

Add a regression comparing full checkout, sparse checkout, and sparse-index
checkout. Check both conflicting files, complete diagnostics, HEAD, an
unrelated tracked file, and an existing staged change. Adjust the warning
test to use existing skipped entries and verify that their local contents
survive.

Reported-by: Webstrand <webstrand@gmail.com>
Link: https://lore.kernel.org/git/CACm1TQd5b9tX368LrsD26Q6tm_mzdi1nwGtGd2V1jwYW+r2c1A@mail.gmail.com/
Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh     | 16 ++++++---
 t/t1092-sparse-checkout-compatibility.sh | 41 ++++++++++++++++++++++++
 unpack-trees.c                           |  9 +++++-
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 93244ee134..54a7258b03 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -263,12 +263,15 @@ test_expect_success 'read-tree --reset removes outside worktree' '
 '
 
 test_expect_success 'print warnings when some worktree updates disabled' '
-	echo sub >.git/info/sparse-checkout &&
-	git checkout -f init &&
+	echo init.t >.git/info/sparse-checkout &&
+	git checkout -f top &&
 	mkdir sub &&
-	touch sub/added sub/addedtoo &&
+	test_write_lines local >sub/added &&
+	test_write_lines local >sub/addedtoo &&
+	echo sub >.git/info/sparse-checkout &&
+	# Keep skip-worktree bits on the materialized paths to test the warning.
 	# Use -q to suppress "Previous HEAD position" and "Head is now at" msgs
-	git checkout -q top 2>actual &&
+	git -c sparse.expectFilesOutsideOfPatterns=true checkout -q top 2>actual &&
 	cat >expected <<\EOF &&
 warning: The following paths were already present and thus not updated despite sparse patterns:
 	sub/added
@@ -276,7 +279,10 @@ warning: The following paths were already present and thus not updated despite s
 
 After fixing the above paths, you may want to run `git sparse-checkout reapply`.
 EOF
-	test_cmp expected actual
+	test_cmp expected actual &&
+	test_write_lines local >expected-content &&
+	test_cmp expected-content sub/added &&
+	test_cmp expected-content sub/addedtoo
 '
 
 test_expect_success 'checkout without --ignore-skip-worktree-bits' '
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 05b54062b3..0958af35c4 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -486,6 +486,47 @@ test_expect_success 'checkout with modified sparse directory' '
 	test_all_match git checkout base
 '
 
+test_expect_success 'checkout protects untracked files inside sparse cone' '
+	init_repos &&
+	git -C initial-repo rev-parse base >expect-head &&
+	test_write_lines local >expect-untracked &&
+	test_write_lines a >expect-tracked &&
+	test_write_lines staged >expect-staged &&
+	test_write_lines refs/heads/base >expect-branch &&
+	for repo in full-checkout sparse-checkout sparse-index
+	do
+		(
+			cd "$repo" &&
+			git checkout -b new-file &&
+			test_write_lines incoming >deep/new-file &&
+			test_write_lines incoming >deep/other-file &&
+			test_write_lines changed >deep/a &&
+			git add deep/new-file deep/other-file deep/a &&
+			git commit -m "add a file and change a tracked file" &&
+			git checkout base &&
+			test_write_lines local >deep/new-file &&
+			test_write_lines local >deep/other-file &&
+			test_write_lines staged >a &&
+			git add a &&
+			git write-tree >"../$repo-index-before"
+		) || return 1
+	done &&
+	test_all_match test_must_fail git checkout new-file &&
+	for repo in full-checkout sparse-checkout sparse-index
+	do
+		git -C "$repo" rev-parse HEAD >actual-head &&
+		test_cmp expect-head actual-head &&
+		git -C "$repo" symbolic-ref HEAD >actual-branch &&
+		test_cmp expect-branch actual-branch &&
+		test_cmp expect-untracked "$repo/deep/new-file" &&
+		test_cmp expect-untracked "$repo/deep/other-file" &&
+		test_cmp expect-tracked "$repo/deep/a" &&
+		test_cmp expect-staged "$repo/a" &&
+		git -C "$repo" write-tree >actual-index &&
+		test_cmp "$repo-index-before" actual-index || return 1
+	done
+'
+
 test_expect_success 'checkout orphan then non-orphan' '
 	init_repos &&
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 1802809ad3..f763f284a6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2058,8 +2058,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 			 * correct CE_NEW_SKIP_WORKTREE
 			 */
 			if (ce->ce_flags & CE_ADDED &&
-			    verify_absent(ce, WARNING_SPARSE_ORPHANED_NOT_OVERWRITTEN, o))
+			    verify_absent(ce,
+				ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
 				ret = 1;
+		}
+		if (ret)
+			goto return_failed;
+
+		for (i = 0; i < o->internal.result.cache_nr; i++) {
+			struct cache_entry *ce = o->internal.result.cache[i];
 
 			if (apply_sparse_checkout(&o->internal.result, ce, o))
 				ret = 1;

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.55.0

