Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF83A199E89
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770180092; cv=none; b=SiEnb3TfK3NobrsEP+Fec0m5mnR7qLZnqnMwik4z1P8KJH/bzNletJPYpmpB11FI3xARkDUSuP17jGsjbBgZ7/rabX26dgx1ZuBz9hvWrV1TbO4JNU/mI2Pz/4LNXEaKlW0v0CsedYtamFq/xOovSbxNrgUULWoyZO6le+WmHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770180092; c=relaxed/simple;
	bh=Ibsl6lT6fSgZehW7ddai5a+Z0wC8E7JOq5+aOgk+xuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP95yXbM3mn/rOpYiWVAzY/8hem8NA6lWe2Fzs5b6/NDnC7LjpKLhuw7oAxJFZRGpwmjbtmJWHa8bOrSj8JbFBCzXZzTkHX+eaZS0JONVTSuc5rlVO/+PLmST6BrFTnMlScOXs4WiRZkg9SVLpZJPwbrkxiYCOvHwCdKzE2h33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=QHhNfE4I; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="QHhNfE4I"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vnUhc-00HCky-6j; Wed, 04 Feb 2026 05:41:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=h6qxGRF4pUweWwjVf2H1rKsS7N39l7Gz/IOhzDs8T1Y=; b=QHhNfE4Ixq+pEfcVLm5bwF6HxN
	M64Jj4GQXf9tii9S9DNhx+kmgNBrvbs5r4QnJY6L17bEMLLnOeuIa08qqfgC0LS5V6d6uBeDf9Acl
	SbxT+H8kpEtYJMUJfssTFw3LNcdpHfQCrfzyxQT9GprKLxPdYXcAzF4V/7XNBZpo3dgqLyshqWTww
	mK+rj8AJ/LkOzJdQZDU826RKK2o15ER7oJ/ohL0ArxB3QcetZ+oXr0JSlrOUSD3qAnLq3IG3j4zaU
	WHVZmbUcAoNxykgXFtDdGnxiyiHbVeYM+0lxCyNnpWlepNj/1tLpxIhSb37eLBIpy4b3NuW5oknCx
	qKI8fg9Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vnUhb-0005pC-68; Wed, 04 Feb 2026 05:41:19 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vnUhW-000TMt-Np; Wed, 04 Feb 2026 05:41:15 +0100
From: Colin Stagner <ask+git@howdoi.land>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Colin Stagner <ask+git@howdoi.land>,
	Patrik Weiskircher <patrik@pspdfkit.com>,
	Adam Dinwoodie <adam@dinwoodie.org>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re* [RFH] adding test coverage for contrib/ in CI jobs
Date: Tue,  3 Feb 2026 22:38:11 -0600
Message-ID: <20260204043812.814884-3-ask+git@howdoi.land>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <xmqqjywtu58j.fsf_-_@gitster.g>
References: <xmqqjywtu58j.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> I didn't look into CI failures but spotted an easy one by
> eyeballing.

[snip]

>--- c/contrib/subtree/t/t7900-subtree.sh
>+++ w/contrib/subtree/t/t7900-subtree.sh
>@@ -1597,7 +1597,8 @@ test_expect_success 'push split to subproj' '
> 
> test_expect_success 'subtree descendant check' '
> 	subtree_test_create_repo "$test_count" &&
>-	defaultBranch=$(sed "s,ref: refs/heads/,," "$test_count/.git/HEAD") &&
>+
>+	defaultBranch=$(git -C "$test_count" symbolic-ref --short HEAD) &&

The subtree tests set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME, so
this is one alternative.

I'll see what I can do about any remaining failures. I'd like to
improve the test coverage for subtree split. split has a lot of
complicated logic that needs to be preserved across updates.

-- >8 --

Subject: contrib/subtree: fix tests with reftable backend

One git-subtree test-case relies on git internals to infer the
default branch name. This test fails with the new reftable
backend.

    GIT_TEST_DEFAULT_REF_FORMAT=reftable \
      meson test t7900-subtree

This test script already sets

    GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main

which eliminates the need to infer a branch name at runtime.
Hardcode the branch name.

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---
 contrib/subtree/t/t7900-subtree.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 316dc5269e..e7040718f2 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -1597,7 +1597,6 @@ test_expect_success 'push split to subproj' '
 
 test_expect_success 'subtree descendant check' '
 	subtree_test_create_repo "$test_count" &&
-	defaultBranch=$(sed "s,ref: refs/heads/,," "$test_count/.git/HEAD") &&
 	test_create_commit "$test_count" folder_subtree/a &&
 	(
 		cd "$test_count" &&
@@ -1614,7 +1613,7 @@ test_expect_success 'subtree descendant check' '
 	(
 		cd "$test_count" &&
 		git cherry-pick $cherry &&
-		git checkout $defaultBranch &&
+		git checkout main &&
 		git merge -m "merge should be kept on subtree" branch &&
 		git branch no_subtree_work_branch
 	) &&
@@ -1626,10 +1625,10 @@ test_expect_success 'subtree descendant check' '
 	test_create_commit "$test_count" not_a_subtree_change &&
 	(
 		cd "$test_count" &&
-		git checkout $defaultBranch &&
+		git checkout main &&
 		git merge -m "merge should be skipped on subtree" no_subtree_work_branch &&
 
-		git subtree split --prefix folder_subtree/ --branch subtree_tip $defaultBranch &&
+		git subtree split --prefix folder_subtree/ --branch subtree_tip main &&
 		git subtree split --prefix folder_subtree/ --branch subtree_branch branch &&
 		test $(git rev-list --count subtree_tip..subtree_branch) = 0
 	)
-- 
2.43.0

