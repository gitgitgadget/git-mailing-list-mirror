Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D841F1D86DC
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771381930; cv=none; b=o9wH2hgu80eFST5hMJEJnaNY/IV5v+7BlmR1AP3IowiVm/e/rl6kiLuL+tdw+BJ7TxLEy53WwZXFYpbdlBkDbqT7r0z6DtMuMdz/rhqwCl9hj8ZvV+jBcEhwmLHEQxwwoh9414b8ObjpE2DHwgRYsMF7wZGDIhr2O0yX5gsfdlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771381930; c=relaxed/simple;
	bh=ZRUY1TVjoRzpHYnsn7ZItxqN3EI5J5z6N3Zu+5LrSRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZD1xBnW5A+Bx6s08u889u5hXUmR3FzovJY5nZ1/H39gREOjkkjq4bWr2ElUtr1P8vgN0/QPOKIbpPQmxLaRjP8auzgf4xLeHHtunfGyQn5NDGTlrQ9ctnO0ABGBrnutL/mgbcNsL/t4NhQ6eZG7etehVlC9m8ap6MffhDeyM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=knYRUMm5; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="knYRUMm5"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vsXMB-00GV78-Ti; Wed, 18 Feb 2026 03:32:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=aqX5d09qTpm5bGkIN7x12FVNXRA3Vp+L0K7xcIGO9cM=; b=knYRUMm5VXLaPxfdITgEoNYf/5
	wglbn0IbDOZrYA1U5u/hMfy2yuMZqTQBvz5UjhoeyWgZrPCvU8ZqyuLBFSwIAAO+/AtwstyqBv+ba
	gq8HrLvK1F09/ZvfYNltLDYcEiYcGlY96DeIlSJ7Cee0TL6OV+RPXs6mox/hsJPgmBDvxApyjygI8
	M2eLu38xqCbY/uniRytMhS+osnElR82IhjLxebX+ufC4ZRaSHzjzg65ffcilr/uCAaWvQ6bLxc4vk
	tGdZ5ZS4zVNtDct9B9IYwPAgi5ZmZXmuNGtT8InM4i0xaFjXEXD7hIURtIVYaidJjTqSFS4AuNuYq
	xHuGmgZA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vsXMA-00047p-FN; Wed, 18 Feb 2026 03:32:03 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vsXLu-005i9g-BU; Wed, 18 Feb 2026 03:31:46 +0100
From: Colin Stagner <ask+git@howdoi.land>
Date: Tue, 17 Feb 2026 20:31:30 -0600
Subject: [PATCH v2 1/3] contrib/subtree: capture additional test-cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-cs-subtree-remove-optimization-v2-1-4299e71a30c6@howdoi.land>
References: <20260217-cs-subtree-remove-optimization-v2-0-4299e71a30c6@howdoi.land>
In-Reply-To: <20260217-cs-subtree-remove-optimization-v2-0-4299e71a30c6@howdoi.land>
To: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Zach FettersMoore <zach.fetters@apollographql.com>, 
 Christian Heusel <christian@heusel.eu>, george@mail.dietrich.pub, 
 Christian Hesse <list@eworm.de>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Colin Stagner <ask+git@howdoi.land>
X-Mailer: b4 0.15-dev

Patch series e7b07376e5 (Merge branch 'rs/subtree-fixes',
2018-10-26) corrects several defects in `git subtree split`.
The defects affect `split --rejoin` and merge commit processing.

There is no test coverage for this, and e7b07376e5 did not
introduce any.

Convert the minimum working example [1] from the original patch
submission [2] into test cases.

[1]: https://gist.github.com/FoxFireX/1b794384612b7fd5e7cd157cff96269e

[2]: <20180928183540.48968-1-roger.strain@swri.org>

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---
 contrib/subtree/t/t7900-subtree.sh | 110 +++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index e7040718f2..3ee2f95d86 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -1575,6 +1575,116 @@ test_expect_success 'push split to subproj' '
 	)
 '
 
+# --ignore-joins must ignore mainline content outside of the
+# subtree. This test verifies that the logic in
+# `find_existing_splits()` correctly handles a `git subtree add`
+# In this test, the split history must not contain a commit titled
+#
+#     Add 'sub/' from commit ...
+#
+# see: dd21d43b58 (subtree: make --ignore-joins pay
+#      attention to adds, 2018-09-28)
+test_expect_success 'split --ignore-joins respects subtree add' '
+	subtree_test_create_repo "$test_count" &&
+	(
+		cd "$test_count" &&
+		test_commit main_must_not_be_in_subtree &&
+		test_create_subtree_add . mksubtree sub sub1 &&
+		test_commit sub/sub2 &&
+		test_commit main_must_not_be_in_subtree2 &&
+		git subtree split --prefix sub -b first_split --rejoin &&
+		test_commit sub/sub3 &&
+		no_ignore_joins="$(git subtree split --prefix sub -b no_ignore_joins)" &&
+		ignore_joins="$(git subtree split --prefix sub --ignore-joins -b ignore_joins)" &&
+		git checkout ignore_joins &&
+		test_path_is_file sub1.t &&
+		test_path_is_file sub2.t &&
+		test_path_is_file sub3.t &&
+		! test_path_is_file main_must_not_be_in_subtree.t &&
+		! test_path_is_file main_must_not_be_in_subtree2.t &&
+		test -z "$(git log -1 --grep "Add '''sub/''' from commit" ignore_joins)" &&
+		test "$no_ignore_joins" = "$ignore_joins" &&
+		test "$(git rev-list --count ignore_joins)" -eq 3;
+	)
+'
+
+# split excludes commits reachable from any previous --rejoin.
+# These ignored commits can still be the basis for new work
+# after the --rejoin. These commits must be processed, even
+# if they are excluded. Otherwise, the split history will be
+# incorrect.
+#
+# here, the merge
+#
+#     git merge --no-ff new_work_based_on_prejoin
+#
+# doesn't contain any subtree changes and so should not end
+# up in the split history. this subtree should be flat,
+# with no merges.
+#
+# see: 315a84f9aa (subtree: use commits before rejoins for
+#      splits, 2018-09-28)
+test_expect_success 'split links out-of-tree pre --rejoin commits with post --rejoin commits' '
+	subtree_test_create_repo "$test_count" &&
+	(
+		cd "$test_count" &&
+		test_commit main_must_not_be_in_subtree &&
+		mkdir sub &&
+		test_commit sub/sub1 &&
+		test_commit sub/sub2 &&
+		git subtree split --prefix sub --rejoin &&
+		test "$(git rev-list --count HEAD)" -eq 6 &&
+		git checkout sub/sub1 &&
+		git checkout -b new_work_based_on_prejoin &&
+		test_commit main_must_not_be_in_subtree2 &&
+		git checkout main &&
+		git merge --no-ff new_work_based_on_prejoin &&
+		test_commit sub/sub3 &&
+		git subtree split -d --prefix sub -b second_split &&
+		git checkout second_split &&
+		test_path_is_file sub1.t &&
+		test_path_is_file sub2.t &&
+		test_path_is_file sub3.t &&
+		! test_path_is_file main_must_not_be_in_subtree.t &&
+		! test_path_is_file main_must_not_be_in_subtree2.t &&
+		test "$(git rev-list --count --merges second_split)" -eq 0 &&
+		test "$(git rev-list --count second_split)" -eq 3;
+	)
+'
+
+# split must keep merge commits with unrelated histories, even
+# if both parents are treesame. When deciding whether or not
+# to eliminate a parent, copy_or_skip compares the merge-base
+# of each parent.
+#
+# in the split_of_merges branch:
+#
+#   * expect 4 commits
+#   * HEAD~ must be a merge
+#
+# see: 68f8ff8151 (subtree: improve decision on merges kept
+#      in split, 2018-09-28)
+test_expect_success 'split preserves merges with unrelated history' '
+	subtree_test_create_repo "$test_count" &&
+	(
+		cd "$test_count" &&
+		test_commit main_must_not_be_in_subtree &&
+		mkdir sub &&
+		test_commit sub/sub1 &&
+		git checkout --orphan new_history &&
+		git checkout sub/sub1 -- . &&
+		git add . &&
+		git commit -m "treesame history but not a merge-base" &&
+		git checkout main &&
+		git merge --allow-unrelated-histories --no-ff new_history &&
+		test "$(git rev-parse "HEAD^1^{tree}")" = "$(git rev-parse "HEAD^2^{tree}")" &&
+		test_commit sub/sub2 &&
+		git subtree split -d --prefix sub -b split_of_merges &&
+		test "$(git rev-list --count split_of_merges)" -eq 4 &&
+		test -n "$(git rev-list --merges HEAD~)";
+	)
+'
+
 #
 # This test covers 2 cases in subtree split copy_or_skip code
 # 1) Merges where one parent is a superset of the changes of the other

-- 
2.43.0

