From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v3 10/11] t6300: make UTC and local dates different
Date: Thu,  3 Sep 2015 22:49:00 +0100
Message-ID: <26f3b006a7848343ccaaf3b9b9e105b24428547c.1441316394.git.john@keeping.me.uk>
References: <cover.1441144343.git.john@keeping.me.uk>
 <cover.1441316394.git.john@keeping.me.uk>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 23:51:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXcPw-0001n2-8c
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757796AbbICVvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 17:51:32 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:47344 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757781AbbICVvc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:51:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 9CAF8CDA625;
	Thu,  3 Sep 2015 22:51:31 +0100 (BST)
X-Quarantine-ID: <aCk8eDQGxRU5>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_20=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aCk8eDQGxRU5; Thu,  3 Sep 2015 22:51:29 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 49A7ACDA624;
	Thu,  3 Sep 2015 22:51:14 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
In-Reply-To: <cover.1441316394.git.john@keeping.me.uk>
References: <cover.1441316394.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277271>

By setting the UTC time to 23:18:43 the date in +0200 is the following
day, 2006-07-04.  This will ensure that the test for "short-local" to be
added in the following patch tests for different output from the "short"
format.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t6300-for-each-ref.sh | 70 ++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 6afcff6..899251e 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -8,8 +8,8 @@ test_description='for-each-ref test'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
-# Mon Jul 3 15:18:43 2006 +0000
-datestamp=1151939923
+# Mon Jul 3 23:18:43 2006 +0000
+datestamp=1151968723
 setdate_and_increment () {
     GIT_COMMITTER_DATE="$datestamp +0200"
     datestamp=$(expr "$datestamp" + 1)
@@ -61,21 +61,21 @@ test_atom head object ''
 test_atom head type ''
 test_atom head '*objectname' ''
 test_atom head '*objecttype' ''
-test_atom head author 'A U Thor <author@example.com> 1151939924 +0200'
+test_atom head author 'A U Thor <author@example.com> 1151968724 +0200'
 test_atom head authorname 'A U Thor'
 test_atom head authoremail '<author@example.com>'
-test_atom head authordate 'Mon Jul 3 17:18:44 2006 +0200'
-test_atom head committer 'C O Mitter <committer@example.com> 1151939923 +0200'
+test_atom head authordate 'Tue Jul 4 01:18:44 2006 +0200'
+test_atom head committer 'C O Mitter <committer@example.com> 1151968723 +0200'
 test_atom head committername 'C O Mitter'
 test_atom head committeremail '<committer@example.com>'
-test_atom head committerdate 'Mon Jul 3 17:18:43 2006 +0200'
+test_atom head committerdate 'Tue Jul 4 01:18:43 2006 +0200'
 test_atom head tag ''
 test_atom head tagger ''
 test_atom head taggername ''
 test_atom head taggeremail ''
 test_atom head taggerdate ''
-test_atom head creator 'C O Mitter <committer@example.com> 1151939923 +0200'
-test_atom head creatordate 'Mon Jul 3 17:18:43 2006 +0200'
+test_atom head creator 'C O Mitter <committer@example.com> 1151968723 +0200'
+test_atom head creatordate 'Tue Jul 4 01:18:43 2006 +0200'
 test_atom head subject 'Initial'
 test_atom head contents:subject 'Initial'
 test_atom head body ''
@@ -96,7 +96,7 @@ test_atom tag parent ''
 test_atom tag numparent ''
 test_atom tag object $(git rev-parse refs/tags/testtag^0)
 test_atom tag type 'commit'
-test_atom tag '*objectname' '67a36f10722846e891fbada1ba48ed035de75581'
+test_atom tag '*objectname' 'ea122842f48be4afb2d1fc6a4b96c05885ab7463'
 test_atom tag '*objecttype' 'commit'
 test_atom tag author ''
 test_atom tag authorname ''
@@ -107,18 +107,18 @@ test_atom tag committername ''
 test_atom tag committeremail ''
 test_atom tag committerdate ''
 test_atom tag tag 'testtag'
-test_atom tag tagger 'C O Mitter <committer@example.com> 1151939925 +0200'
+test_atom tag tagger 'C O Mitter <committer@example.com> 1151968725 +0200'
 test_atom tag taggername 'C O Mitter'
 test_atom tag taggeremail '<committer@example.com>'
-test_atom tag taggerdate 'Mon Jul 3 17:18:45 2006 +0200'
-test_atom tag creator 'C O Mitter <committer@example.com> 1151939925 +0200'
-test_atom tag creatordate 'Mon Jul 3 17:18:45 2006 +0200'
-test_atom tag subject 'Tagging at 1151939927'
-test_atom tag contents:subject 'Tagging at 1151939927'
+test_atom tag taggerdate 'Tue Jul 4 01:18:45 2006 +0200'
+test_atom tag creator 'C O Mitter <committer@example.com> 1151968725 +0200'
+test_atom tag creatordate 'Tue Jul 4 01:18:45 2006 +0200'
+test_atom tag subject 'Tagging at 1151968727'
+test_atom tag contents:subject 'Tagging at 1151968727'
 test_atom tag body ''
 test_atom tag contents:body ''
 test_atom tag contents:signature ''
-test_atom tag contents 'Tagging at 1151939927
+test_atom tag contents 'Tagging at 1151968727
 '
 test_atom tag HEAD ' '
 
@@ -168,16 +168,16 @@ test_date () {
 
 test_expect_success 'Check unformatted date fields output' '
 	test_date "" \
-		"Mon Jul 3 17:18:43 2006 +0200" \
-		"Mon Jul 3 17:18:44 2006 +0200" \
-		"Mon Jul 3 17:18:45 2006 +0200"
+		"Tue Jul 4 01:18:43 2006 +0200" \
+		"Tue Jul 4 01:18:44 2006 +0200" \
+		"Tue Jul 4 01:18:45 2006 +0200"
 '
 
 test_expect_success 'Check format "default" formatted date fields output' '
 	test_date default \
-		"Mon Jul 3 17:18:43 2006 +0200" \
-		"Mon Jul 3 17:18:44 2006 +0200" \
-		"Mon Jul 3 17:18:45 2006 +0200"
+		"Tue Jul 4 01:18:43 2006 +0200" \
+		"Tue Jul 4 01:18:44 2006 +0200" \
+		"Tue Jul 4 01:18:45 2006 +0200"
 '
 
 # Don't know how to do relative check because I can't know when this script
@@ -191,36 +191,36 @@ test_expect_success 'Check format "relative" date fields output' '
 '
 
 test_expect_success 'Check format "short" date fields output' '
-	test_date short 2006-07-03 2006-07-03 2006-07-03
+	test_date short 2006-07-04 2006-07-04 2006-07-04
 '
 
 test_expect_success 'Check format "local" date fields output' '
 	test_date local \
-		"Mon Jul 3 15:18:43 2006" \
-		"Mon Jul 3 15:18:44 2006" \
-		"Mon Jul 3 15:18:45 2006"
+		"Mon Jul 3 23:18:43 2006" \
+		"Mon Jul 3 23:18:44 2006" \
+		"Mon Jul 3 23:18:45 2006"
 '
 
 test_expect_success 'Check format "iso8601" date fields output' '
 	test_date iso8601 \
-		"2006-07-03 17:18:43 +0200" \
-		"2006-07-03 17:18:44 +0200" \
-		"2006-07-03 17:18:45 +0200"
+		"2006-07-04 01:18:43 +0200" \
+		"2006-07-04 01:18:44 +0200" \
+		"2006-07-04 01:18:45 +0200"
 '
 
 test_expect_success 'Check format "rfc2822" date fields output' '
 	test_date rfc2822 \
-		"Mon, 3 Jul 2006 17:18:43 +0200" \
-		"Mon, 3 Jul 2006 17:18:44 +0200" \
-		"Mon, 3 Jul 2006 17:18:45 +0200"
+		"Tue, 4 Jul 2006 01:18:43 +0200" \
+		"Tue, 4 Jul 2006 01:18:44 +0200" \
+		"Tue, 4 Jul 2006 01:18:45 +0200"
 '
 
 test_expect_success 'Check format "raw" date fields output' '
-	test_date raw "1151939923 +0200" "1151939924 +0200" "1151939925 +0200"
+	test_date raw "1151968723 +0200" "1151968724 +0200" "1151968725 +0200"
 '
 
 test_expect_success 'Check format of strftime date fields' '
-	echo "my date is 2006-07-03" >expected &&
+	echo "my date is 2006-07-04" >expected &&
 	git for-each-ref \
 	  --format="%(authordate:format:my date is %Y-%m-%d)" \
 	  refs/heads >actual &&
@@ -538,8 +538,8 @@ body contents
 $sig"
 
 cat >expected <<EOF
-$(git rev-parse refs/tags/master) <committer@example.com> refs/tags/master
 $(git rev-parse refs/tags/bogo) <committer@example.com> refs/tags/bogo
+$(git rev-parse refs/tags/master) <committer@example.com> refs/tags/master
 EOF
 
 test_expect_success 'Verify sort with multiple keys' '
-- 
2.5.0.466.g9af26fa
