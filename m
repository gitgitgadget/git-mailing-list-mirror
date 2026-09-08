Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5948E0E7
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896703; cv=none; b=A2wtGe7NUqT9oNqirJMw718DazvsLwqeJxOZK8HP7SQeYx4UuXKKZI8IiTF9eSWfFG68Q2c6RrSazn8p/HOIo3HZMP+1o2P6Wnc25ex3OVOHfnjXdc+nNDSUsbEb2hb5NpL8NAobFDQ12frHfa2P7e/OtGp7/BmiXJvoKkfRzIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896703; c=relaxed/simple;
	bh=a7tnD2rXcww/Ws88XfYnwB7PgqljBoRjEd6AQuucPls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDentWKiB8F+5koTETczFW9mjwThm4nL9CCECjLbZJGnXbpqP4f2bkN0b6Yd9W6btpVG5dmsHzVAIZtCBVrrXhjxqn15hGj21TkfM4j3vDwGrzrO4jIKGCUuyeC8pZtp4olbbHALRQEGKfizVDhfqd/87UmKXxCNIoSh6or2acc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCdf7siC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCdf7siC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 978BFC2BCFC;
	Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788896702;
	bh=a7tnD2rXcww/Ws88XfYnwB7PgqljBoRjEd6AQuucPls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XCdf7siCBSqic78pxsPoIRkx0cI9thow/wqEFWaHyslFrYCOlC1Aet0U5xgQBs9Uz
	 wZTFXEvfGMyvEsN7zSd0vH+7EI8QUnc81peDGcHr2MeOT5gLEs1lTf4RfSB9pmnxGD
	 MXbrfKXEjBPlaVnBfNHtwGKeIAJbmjPLTw9XP+9WdV1IKP7HFITGbsOUTCNS2Dry9S
	 bJX0JbdL1M6kejaIAJ9zurX2qA6J/cVyXeBHqXbjcYTsEnyas9CAxKSJyefsm38Ziv
	 Q7EhEyAoQJkD0gS/7sPTgHFWMkExoMkJvUl5B6KWaiNMr7NOeyOhhHI5kT8TlWlPfq
	 Gi662yw2wT5Ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B2CC79FAD;
	Tue,  8 Sep 2026 19:45:02 +0000 (UTC)
From: "Mark C. Chu-Carroll via B4 Relay" <devnull+markchucarroll.fastmail.com@kernel.org>
Date: Tue, 08 Sep 2026 15:44:55 -0400
Subject: [PATCH 3/3] Update t4010 to use modern style.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-modernize-t4001-v1-3-cab3933a173f@fastmail.com>
References: <20260908-modernize-t4001-v1-0-cab3933a173f@fastmail.com>
In-Reply-To: <20260908-modernize-t4001-v1-0-cab3933a173f@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3914;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=bAxyW5cKMBKDeqjkUFMgQbzWUqVHI8lm4LH44N6SDEE=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLIWpO5Zmu1sKcF5Iv2U8/VAx2aZGX+W2GbuVlxmdaJTX
 eF7cp9RRykLgxgXg6yYIsv/fwKNr1geSPgFvfsEM4eVCWQIAxenAEzk0W2GfwoHdn/JuC4tvjM5
 sfnnjbvXrn1+eGKV6wmtpocPDjWGVSoxMqx6MLudcdq6ex+lXJpufClQv8nYIl1lYfPofKxI/ix
 VAy4A
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE
X-Endpoint-Received: by B4 Relay for markchucarroll@fastmail.com/default
 with auth_id=1002
X-Original-From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Reply-To: markchucarroll@fastmail.com

From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>

---
 t/t4010-diff-pathspec.sh | 78 ++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index c84c3fa05b..59e4501203 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -13,67 +13,67 @@ Prepare:
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
+test_expect_success setup '
+    echo frotz >file0 &&
+    mkdir path1 &&
+    echo rezrov >path1/file1 &&
+    before0=$(git hash-object file0) &&
+    before1=$(git hash-object path1/file1) &&
+    git update-index --add file0 path1/file1 &&
+    tree=$(git write-tree) &&
+    echo "$tree" &&
+    echo nitfol >file0 &&
+    echo yomin >path1/file1 &&
+    after0=$(git hash-object file0) &&
+    after1=$(git hash-object path1/file1) &&
+    git update-index file0 path1/file1
+'
 
 cat >expected <<\EOF
 EOF
-test_expect_success \
-    'limit to path should show nothing' \
-    'git diff-index --cached $tree -- path >current &&
-     compare_diff_raw current expected'
+test_expect_success 'limit to path should show nothing' '
+    git diff-index --cached $tree -- path >current &&
+    compare_diff_raw current expected
+'
 
 cat >expected <<EOF
 :100644 100644 $before1 $after1 M	path1/file1
 EOF
-test_expect_success \
-    'limit to path1 should show path1/file1' \
-    'git diff-index --cached $tree -- path1 >current &&
-     compare_diff_raw current expected'
+test_expect_success 'limit to path1 should show path1/file1' '
+    git diff-index --cached $tree -- path1 >current &&
+    compare_diff_raw current expected
+'
 
 cat >expected <<EOF
 :100644 100644 $before1 $after1 M	path1/file1
 EOF
-test_expect_success \
-    'limit to path1/ should show path1/file1' \
-    'git diff-index --cached $tree -- path1/ >current &&
-     compare_diff_raw current expected'
+test_expect_success 'limit to path1/ should show path1/file1' '
+    git diff-index --cached $tree -- path1/ >current &&
+    compare_diff_raw current expected
+'
 
 cat >expected <<EOF
 :100644 100644 $before1 $after1 M	path1/file1
 EOF
-test_expect_success \
-    '"*file1" should show path1/file1' \
-    'git diff-index --cached $tree -- "*file1" >current &&
-     compare_diff_raw current expected'
+test_expect_success '"*file1" should show path1/file1' '
+    git diff-index --cached $tree -- "*file1" >current &&
+    compare_diff_raw current expected
+'
 
 cat >expected <<EOF
 :100644 100644 $before0 $after0 M	file0
 EOF
-test_expect_success \
-    'limit to file0 should show file0' \
-    'git diff-index --cached $tree -- file0 >current &&
-     compare_diff_raw current expected'
+test_expect_success 'limit to file0 should show file0' '
+    git diff-index --cached $tree -- file0 >current &&
+    compare_diff_raw current expected
+'
 
 cat >expected <<\EOF
 EOF
-test_expect_success \
-    'limit to file0/ should emit nothing.' \
-    'git diff-index --cached $tree -- file0/ >current &&
-     compare_diff_raw current expected'
+test_expect_success 'limit to file0/ should emit nothing.' '
+    git diff-index --cached $tree -- file0/ >current &&
+    compare_diff_raw current expected
+'
 
 test_expect_success 'diff-tree pathspec' '
 	tree2=$(git write-tree) &&

-- 
2.53.0


