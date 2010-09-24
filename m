From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 11/16] t6016 (rev-list-graph-simplify-history): add missing &&
Date: Fri, 24 Sep 2010 16:22:51 -0600
Message-ID: <1285366976-22216-12-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGep-0000n6-IT
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758279Ab0IXWVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:44 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45492 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758272Ab0IXWVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:39 -0400
Received: by mail-qy0-f181.google.com with SMTP id 33so4608692qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=YtjmH5/cZmNpk79ycdD2BMCqPOtCLsJf9CZ+KdQnhdU=;
        b=Cqqd3/WoT8uP+1s2/q0OCwwYwzYcvmKOrV/MqXyCK8lRhMJXBPgUuAjHOYZ+K1g+A2
         CJXhLQmzZAZlTy6mRaBFQmNY1mvBp/L8Z66wWOdNdql0Vr8bK9YjLozl8UhO817FtepP
         xFpd3xeMC7OKUF/tVXtN3dIo9iLYQrpx3S+VE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QkRYO5Eso92Las22ptB3cVpH4bB2P953RFwyYgLZFXl7PCstMjr+ZUuYr2JVOaGWhh
         FVPkdBGc4OnmBPbKCmqniwzM0iUrhh1WA5vz+vobJV8iPS2dyJ6i8JgleOgWrZg8CVF1
         UVADRDjTjpiIbK7P03O3hG0fCow+1fjE4zI08=
Received: by 10.220.126.152 with SMTP id c24mr732847vcs.160.1285366899309;
        Fri, 24 Sep 2010 15:21:39 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.37
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157084>

Also removed several repeated tag and branch deletions, since the tags and
branches had already been deleted.  FIXME: Should I just keep the repeated
deletions in there and guard them with a test_might_fail?

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6016-rev-list-graph-simplify-history.sh |   24 ++++++------------------
 1 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index 27fd52b..e640c41 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -29,7 +29,7 @@ test_expect_success 'set up rev-list --graph test' '
 	# Octopus merge B and C into branch A
 	git checkout A &&
 	git merge B C &&
-	git tag A4
+	git tag A4 &&
 
 	test_commit A5 bar.txt &&
 
@@ -39,7 +39,7 @@ test_expect_success 'set up rev-list --graph test' '
 	test_commit C4 bar.txt &&
 	git checkout A &&
 	git merge -s ours C &&
-	git tag A6
+	git tag A6 &&
 
 	test_commit A7 bar.txt &&
 
@@ -90,7 +90,7 @@ test_expect_success '--graph --all' '
 # that undecorated merges are interesting, even with --simplify-by-decoration
 test_expect_success '--graph --simplify-by-decoration' '
 	rm -f expected &&
-	git tag -d A4
+	git tag -d A4 &&
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -119,9 +119,9 @@ test_expect_success '--graph --simplify-by-decoration' '
 # Get rid of all decorations on branch B, and graph with it simplified away
 test_expect_success '--graph --simplify-by-decoration prune branch B' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
+	git tag -d B2 &&
+	git tag -d B1 &&
+	git branch -d B &&
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -143,9 +143,6 @@ test_expect_success '--graph --simplify-by-decoration prune branch B' '
 
 test_expect_success '--graph --full-history -- bar.txt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -163,9 +160,6 @@ test_expect_success '--graph --full-history -- bar.txt' '
 
 test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -181,9 +175,6 @@ test_expect_success '--graph --full-history --simplify-merges -- bar.txt' '
 
 test_expect_success '--graph -- bar.txt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "* $A5" >> expected &&
 	echo "* $A3" >> expected &&
@@ -196,9 +187,6 @@ test_expect_success '--graph -- bar.txt' '
 
 test_expect_success '--graph --sparse -- bar.txt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "* $A6" >> expected &&
 	echo "* $A5" >> expected &&
-- 
1.7.3.95.g14291
