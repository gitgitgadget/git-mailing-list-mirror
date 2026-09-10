Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F27381B0F
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060075; cv=none; b=rUCda4iCJemnNgmn1Xag/LyaNjkb78AYMhcme5+W2GdaTssJUOnM5BaiBh0Fo8GP+OJRzxexMc6OCAreq/POwnyXWbgafx5UuO8TjgWm6FGvuIWXmmTMHPWRqAeqAAhCmoARmNQD4HklMcAXfiKCLVEPvZqlga6Fv9FiLqWI4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060075; c=relaxed/simple;
	bh=zvZEXLq2paBTpMXqaSjHPDN5ADvTL+gTcoGfDZFRYrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfC3AKmzXWQU5C8lnZ31UzsvFp/Fn1zNB30fszayJ8MPdnrBkxzHw4SxjbkQHeGq9bjGYopgunsmTFOO9/BSmDZJih6lK9SpM5rsLRyRPkUELLFOuPOMobx5ceSc8/Q8DtHtgQZ5wyHdIkrX70RgIwN2XqpdVlOQGx2ugANVqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeEpMqyX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeEpMqyX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30042C2BCFB;
	Thu, 10 Sep 2026 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789060072;
	bh=zvZEXLq2paBTpMXqaSjHPDN5ADvTL+gTcoGfDZFRYrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EeEpMqyX/R8Zxsb3yHkvdObhOcmwfMvvhuRpGctrvqOVxmXjGCFJ7gx8qPOBMdZYf
	 n8VzLL7WgBkMkskPW057sXvctgIOT3guLzzW2TC17E//yCK6HLoTiLLpbGl9hrJguw
	 zzEq8W+R9VaEngmE5rUeZt/+yIwOI6Oj9kSEB//HMlMWyDSK5rXZi6I1HYZdWHlSO9
	 XRxTeKczJA/STbodqPJERd6S3fEtqu17avTO9LQBWxsWTyjFjPy2K5nSbtFDulUsqR
	 u2EKbN/Lj9LVUnqrecWjSZU0vzdt80wLXbITJbuFbS7uABFwNimECSevkzVhh6NPLO
	 d/CEiL2pE8PSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CF3C79FBF;
	Thu, 10 Sep 2026 17:07:52 +0000 (UTC)
From: "Mark C. Chu-Carroll via B4 Relay" <devnull+markchucarroll.fastmail.com@kernel.org>
Date: Thu, 10 Sep 2026 13:07:35 -0400
Subject: [PATCH v2 3/3] Update t4010 to use modern style.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-modernize-t4001-v2-3-ac53e9f5d717@fastmail.com>
References: <20260910-modernize-t4001-v2-0-ac53e9f5d717@fastmail.com>
In-Reply-To: <20260910-modernize-t4001-v2-0-ac53e9f5d717@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3836;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=jbDFKk5FP41wRp0ysubaMC1p6nuvLVe5p07ZV5O63Pw=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIWPX5Wrl9cqvjq1neLJayyCn9cE+dGfFy88OICR6FbM
 8zvL/oZ1lHKwiDGxSArpsjy/59A4yuWBxJ+Qe8+wcxhZQIZwsDFKQATOSjFyHBMujlB4ec2v4Kt
 DrdvLQhW+im7W6cj5nlyKOPcdwKycXcYGXb1COzscrnG3ZJR32DeoVd3eNLDXy9rbBb2303vW75
 BiAcA
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE
X-Endpoint-Received: by B4 Relay for markchucarroll@fastmail.com/default
 with auth_id=1002
X-Original-From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Reply-To: markchucarroll@fastmail.com

From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>

---
 t/t4010-diff-pathspec.sh | 88 +++++++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 57 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 8d980823b0..76ddd3ff4e 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -13,60 +13,34 @@ Prepare:
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
-test_expect_success \
-    setup \
-    'echo frotz >file0 &&
-     mkdir path1 &&
-     echo rezrov >path1/file1 &&
-     before0=$(git hash-object file0) &&
-     before1=$(git hash-object path1/file1) &&
-     git update-index --add file0 path1/file1 &&
-     tree=$(git write-tree) &&
-     echo "$tree" &&
-     echo nitfol >file0 &&
-     echo yomin >path1/file1 &&
-     after0=$(git hash-object file0) &&
-     after1=$(git hash-object path1/file1) &&
-     git update-index file0 path1/file1'
-
-cat >expected <<\EOF
-EOF
-test_expect_success \
-    'limit to path should show nothing' \
-    'git diff-index --cached $tree -- path >current &&
-     compare_diff_raw current expected'
-
-cat >expected <<EOF
-:100644 100644 $before1 $after1 M	path1/file1
-EOF
-test_expect_success \
-    'limit to path1 should show path1/file1' \
-    'git diff-index --cached $tree -- path1 >current &&
-     compare_diff_raw current expected'
-
-cat >expected <<EOF
-:100644 100644 $before1 $after1 M	path1/file1
-EOF
-test_expect_success \
-    'limit to path1/ should show path1/file1' \
-    'git diff-index --cached $tree -- path1/ >current &&
-     compare_diff_raw current expected'
-
-cat >expected <<EOF
-:100644 100644 $before1 $after1 M	path1/file1
-EOF
-test_expect_success \
-    '"*file1" should show path1/file1' \
-    'git diff-index --cached $tree -- "*file1" >current &&
-     compare_diff_raw current expected'
-
-cat >expected <<EOF
-:100644 100644 $before0 $after0 M	file0
-EOF
-test_expect_success \
-    'limit to file0 should show file0' \
-    'git diff-index --cached $tree -- file0 >current &&
-     compare_diff_raw current expected'
+
+test_expect_success 'limit to path should show nothing' '
+	echo frotz >file0 &&
+	mkdir path1 &&
+	echo rezrov >path1/file1 &&
+	before0=$(git hash-object file0) &&
+	before1=$(git hash-object path1/file1) &&
+	git update-index --add file0 path1/file1 &&
+	tree=$(git write-tree) &&
+	echo "$tree" &&
+	echo nitfol >file0 &&
+	echo yomin >path1/file1 &&
+	after0=$(git hash-object file0) &&
+	after1=$(git hash-object path1/file1) &&
+	git update-index file0 path1/file1 &&
+	: >expected &&
+	git diff-index --cached $tree -- path >current &&
+	compare_diff_raw current expected
+'
+
+test_expect_success 'limit to path1 should show path1/file1' '
+	cat >expected <<-EOF &&
+	:100644 100644 $before1 $after1 M	path1/file1
+	EOF
+
+	git diff-index --cached $tree -- path1 >current &&
+	compare_diff_raw current expected
+'
 
 test_expect_success 'limit to path1/ should show path1/file1' '
 	cat >expected <<-EOF &&
@@ -80,7 +54,7 @@ test_expect_success '"*file1" should show path1/file1' '
 	cat >expected <<-EOF &&
 	:100644 100644 $before1 $after1 M	path1/file1
 	EOF
-    
+
 	git diff-index --cached $tree -- "*file1" >current &&
 	compare_diff_raw current expected
 '
@@ -89,13 +63,13 @@ test_expect_success 'limit to file0 should show file0' '
 	cat >expected <<-EOF &&
 	:100644 100644 $before0 $after0 M	file0
 	EOF
-    
+
 	git diff-index --cached $tree -- file0 >current &&
 	compare_diff_raw current expected
 '
 
 test_expect_success 'limit to file0/ should emit nothing.' '
-    : >expected &&     
+    : >expected &&
 	git diff-index --cached $tree -- file0/ >current &&
 	compare_diff_raw current expected
 '

-- 
2.53.0


