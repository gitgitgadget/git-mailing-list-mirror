From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 1/9] replace: cleanup redirection style in tests
Date: Sat, 19 Jul 2014 17:01:07 +0200
Message-ID: <20140719150116.9564.84555.chriscool@tuxfamily.org>
References: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 17:42:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8WmF-0008Gs-Vt
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 17:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbaGSPlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 11:41:50 -0400
Received: from [194.158.98.14] ([194.158.98.14]:33783 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754985AbaGSPlp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 11:41:45 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 8757138;
	Sat, 19 Jul 2014 17:41:23 +0200 (CEST)
X-git-sha1: 1bed7939f41abba0009370403b03625d1acbcb72 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253891>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 68b3cb2..fb07ad2 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -27,36 +27,36 @@ HASH6=
 HASH7=
 
 test_expect_success 'set up buggy branch' '
-     echo "line 1" >> hello &&
-     echo "line 2" >> hello &&
-     echo "line 3" >> hello &&
-     echo "line 4" >> hello &&
+     echo "line 1" >>hello &&
+     echo "line 2" >>hello &&
+     echo "line 3" >>hello &&
+     echo "line 4" >>hello &&
      add_and_commit_file hello "4 lines" &&
      HASH1=$(git rev-parse --verify HEAD) &&
-     echo "line BUG" >> hello &&
-     echo "line 6" >> hello &&
-     echo "line 7" >> hello &&
-     echo "line 8" >> hello &&
+     echo "line BUG" >>hello &&
+     echo "line 6" >>hello &&
+     echo "line 7" >>hello &&
+     echo "line 8" >>hello &&
      add_and_commit_file hello "4 more lines with a BUG" &&
      HASH2=$(git rev-parse --verify HEAD) &&
-     echo "line 9" >> hello &&
-     echo "line 10" >> hello &&
+     echo "line 9" >>hello &&
+     echo "line 10" >>hello &&
      add_and_commit_file hello "2 more lines" &&
      HASH3=$(git rev-parse --verify HEAD) &&
-     echo "line 11" >> hello &&
+     echo "line 11" >>hello &&
      add_and_commit_file hello "1 more line" &&
      HASH4=$(git rev-parse --verify HEAD) &&
-     sed -e "s/BUG/5/" hello > hello.new &&
+     sed -e "s/BUG/5/" hello >hello.new &&
      mv hello.new hello &&
      add_and_commit_file hello "BUG fixed" &&
      HASH5=$(git rev-parse --verify HEAD) &&
-     echo "line 12" >> hello &&
-     echo "line 13" >> hello &&
+     echo "line 12" >>hello &&
+     echo "line 13" >>hello &&
      add_and_commit_file hello "2 more lines" &&
      HASH6=$(git rev-parse --verify HEAD) &&
-     echo "line 14" >> hello &&
-     echo "line 15" >> hello &&
-     echo "line 16" >> hello &&
+     echo "line 14" >>hello &&
+     echo "line 15" >>hello &&
+     echo "line 16" >>hello &&
      add_and_commit_file hello "again 3 more lines" &&
      HASH7=$(git rev-parse --verify HEAD)
 '
@@ -95,7 +95,7 @@ test_expect_success 'tag replaced commit' '
 '
 
 test_expect_success '"git fsck" works' '
-     git fsck master > fsck_master.out &&
+     git fsck master >fsck_master.out &&
      grep "dangling commit $R" fsck_master.out &&
      grep "dangling tag $(cat .git/refs/tags/mytag)" fsck_master.out &&
      test -z "$(git fsck)"
@@ -217,14 +217,14 @@ test_expect_success 'fetch branch with replacement' '
      (
 	  cd clone_dir &&
 	  git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
-	  git log --pretty=oneline parallel3 > output.txt &&
+	  git log --pretty=oneline parallel3 >output.txt &&
 	  ! grep $PARA3 output.txt &&
-	  git show $PARA3 > para3.txt &&
+	  git show $PARA3 >para3.txt &&
 	  grep "A U Thor" para3.txt &&
 	  git fetch origin "refs/replace/*:refs/replace/*" &&
-	  git log --pretty=oneline parallel3 > output.txt &&
+	  git log --pretty=oneline parallel3 >output.txt &&
 	  grep $PARA3 output.txt &&
-	  git show $PARA3 > para3.txt &&
+	  git show $PARA3 >para3.txt &&
 	  grep "O Thor" para3.txt
      )
 '
@@ -302,7 +302,7 @@ test_expect_success 'test --format medium' '
 		echo "$PARA3 -> $S" &&
 		echo "$MYTAG -> $HASH1"
 	} | sort >expected &&
-	git replace -l --format medium | sort > actual &&
+	git replace -l --format medium | sort >actual &&
 	test_cmp expected actual
 '
 
@@ -314,7 +314,7 @@ test_expect_success 'test --format long' '
 		echo "$PARA3 (commit) -> $S (commit)" &&
 		echo "$MYTAG (tag) -> $HASH1 (commit)"
 	} | sort >expected &&
-	git replace --format=long | sort > actual &&
+	git replace --format=long | sort >actual &&
 	test_cmp expected actual
 '
 
-- 
2.0.0.421.g786a89d.dirty
