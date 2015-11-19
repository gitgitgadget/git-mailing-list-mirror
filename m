From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 4/7] modernize t9300: wrap lines after &&
Date: Thu, 19 Nov 2015 20:09:46 +0100
Message-ID: <5b25e5967f28ee953145bb80c5d5bfc3b699baa3.1447959452.git.j6t@kdbg.org>
References: <cover.1447959452.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 20:11:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzUcC-0008Q4-6M
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 20:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161239AbbKSTLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 14:11:17 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:57953 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161159AbbKSTK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 14:10:26 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3p1rDt5r44z5tlG;
	Thu, 19 Nov 2015 20:10:22 +0100 (CET)
Received: from dx.site (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id 8136729D8;
	Thu, 19 Nov 2015 20:10:22 +0100 (CET)
X-Mailer: git-send-email 2.6.2.337.ga235d84
In-Reply-To: <cover.1447959452.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281490>

It is customary to have each command in test snippets on its own line.
Fix those instances that do not follow this guideline.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9300-fast-import.sh | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ceb3db3..c36afdb 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -130,17 +130,20 @@ test_expect_success 'A: verify tree' '
 
 echo "$file2_data" >expect
 test_expect_success 'A: verify file2' '
-	git cat-file blob master:file2 >actual && test_cmp expect actual
+	git cat-file blob master:file2 >actual &&
+	test_cmp expect actual
 '
 
 echo "$file3_data" >expect
 test_expect_success 'A: verify file3' '
-	git cat-file blob master:file3 >actual && test_cmp expect actual
+	git cat-file blob master:file3 >actual &&
+	test_cmp expect actual
 '
 
 printf "$file4_data" >expect
 test_expect_success 'A: verify file4' '
-	git cat-file blob master:file4 >actual && test_cmp expect actual
+	git cat-file blob master:file4 >actual &&
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -1656,10 +1659,14 @@ INPUT_END
 test_expect_success 'P: superproject & submodule mix' '
 	git fast-import <input &&
 	git checkout subuse1 &&
-	rm -rf sub && mkdir sub && (cd sub &&
-	git init &&
-	git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
-	git checkout master) &&
+	rm -rf sub &&
+	mkdir sub &&
+	(
+		cd sub &&
+		git init &&
+		git fetch --update-head-ok .. refs/heads/sub:refs/heads/master &&
+		git checkout master
+	) &&
 	git submodule init &&
 	git submodule update
 '
@@ -1697,7 +1704,8 @@ INPUT_END
 
 test_expect_success 'P: verbatim SHA gitlinks' '
 	git branch -D sub &&
-	git gc && git prune &&
+	git gc &&
+	git prune &&
 	git fast-import <input &&
 	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
 '
@@ -1942,17 +1950,20 @@ test_expect_success 'Q: verify first notes tree' '
 
 echo "$note1_data" >expect
 test_expect_success 'Q: verify first note for first commit' '
-	git cat-file blob refs/notes/foobar~2:$commit1 >actual && test_cmp expect actual
+	git cat-file blob refs/notes/foobar~2:$commit1 >actual &&
+	test_cmp expect actual
 '
 
 echo "$note2_data" >expect
 test_expect_success 'Q: verify first note for second commit' '
-	git cat-file blob refs/notes/foobar~2:$commit2 >actual && test_cmp expect actual
+	git cat-file blob refs/notes/foobar~2:$commit2 >actual &&
+	test_cmp expect actual
 '
 
 echo "$note3_data" >expect
 test_expect_success 'Q: verify first note for third commit' '
-	git cat-file blob refs/notes/foobar~2:$commit3 >actual && test_cmp expect actual
+	git cat-file blob refs/notes/foobar~2:$commit3 >actual &&
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -1980,17 +1991,20 @@ test_expect_success 'Q: verify second notes tree' '
 
 echo "$note1b_data" >expect
 test_expect_success 'Q: verify second note for first commit' '
-	git cat-file blob refs/notes/foobar^:$commit1 >actual && test_cmp expect actual
+	git cat-file blob refs/notes/foobar^:$commit1 >actual &&
+	test_cmp expect actual
 '
 
 echo "$note2_data" >expect
 test_expect_success 'Q: verify first note for second commit' '
-	git cat-file blob refs/notes/foobar^:$commit2 >actual && test_cmp expect actual
+	git cat-file blob refs/notes/foobar^:$commit2 >actual &&
+	test_cmp expect actual
 '
 
 echo "$note3_data" >expect
 test_expect_success 'Q: verify first note for third commit' '
-	git cat-file blob refs/notes/foobar^:$commit3 >actual && test_cmp expect actual
+	git cat-file blob refs/notes/foobar^:$commit3 >actual &&
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -2015,7 +2029,8 @@ test_expect_success 'Q: verify third notes tree' '
 
 echo "$note1c_data" >expect
 test_expect_success 'Q: verify third note for first commit' '
-	git cat-file blob refs/notes/foobar2:$commit1 >actual && test_cmp expect actual
+	git cat-file blob refs/notes/foobar2:$commit1 >actual &&
+	test_cmp expect actual
 '
 
 cat >expect <<EOF
@@ -2041,7 +2056,8 @@ test_expect_success 'Q: verify fourth notes tree' '
 
 echo "$note2b_data" >expect
 test_expect_success 'Q: verify second note for second commit' '
-	git cat-file blob refs/notes/foobar:$commit2 >actual && test_cmp expect actual
+	git cat-file blob refs/notes/foobar:$commit2 >actual &&
+	test_cmp expect actual
 '
 
 cat >input <<EOF
-- 
2.6.2.337.ga235d84
