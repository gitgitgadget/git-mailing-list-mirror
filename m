From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 11/16] t6016 (rev-list-graph-simplify-history): add missing &&
Date: Sun,  3 Oct 2010 14:00:09 -0600
Message-ID: <1286136014-7728-12-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Uid-0002yx-GC
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab0JCT7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:59:11 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58678 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab0JCT7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:59:08 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so946630pwj.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zMdNWJxpwVMTSbxGzuiVhmYtPzNfKpzL19G2mRFbVZg=;
        b=x4vZyksq+zQryh+ZViN1/NQg3hFarrlTgdFyGMPTBFlc9sAQM1EYr7T25BEgBr00Ne
         7pXlCggpZM6u2wQD/xAdkWFjpu4L/SRinLDgzUiT9WuEiVQLtb2IqdRglhcsVT1pxIeW
         4kdCXDk4t43RrNaowU5hbl8oB7L0tG/K34AB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OMLpWRzN2OfAiY2gObnetggfmS1Hoi7YZuFZ7rIePHoVukSRLXWVIc7thKyUFnv0vp
         33aTCIiGJZu+qdf1jxaLfMhDhrhPU1TKVftE/v3yYHuLg45rPaPs+vXRI6HYVA3QLijC
         IpHbrdKPGRQPeNdZfGD9ySi0AcFa45x25WrFU=
Received: by 10.114.36.2 with SMTP id j2mr10073224waj.117.1286135948574;
        Sun, 03 Oct 2010 12:59:08 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.59.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:59:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157912>

Also move repeated tag and branch deletions into a separate setup test,=
 to
avoid failures from tags and branches having already been deleted.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6016-rev-list-graph-simplify-history.sh |   29 +++++++++-----------=
-------
 1 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-l=
ist-graph-simplify-history.sh
index 27fd52b..f7181d1 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -29,7 +29,7 @@ test_expect_success 'set up rev-list --graph test' '
 	# Octopus merge B and C into branch A
 	git checkout A &&
 	git merge B C &&
-	git tag A4
+	git tag A4 &&
=20
 	test_commit A5 bar.txt &&
=20
@@ -39,7 +39,7 @@ test_expect_success 'set up rev-list --graph test' '
 	test_commit C4 bar.txt &&
 	git checkout A &&
 	git merge -s ours C &&
-	git tag A6
+	git tag A6 &&
=20
 	test_commit A7 bar.txt &&
=20
@@ -90,7 +90,7 @@ test_expect_success '--graph --all' '
 # that undecorated merges are interesting, even with --simplify-by-dec=
oration
 test_expect_success '--graph --simplify-by-decoration' '
 	rm -f expected &&
-	git tag -d A4
+	git tag -d A4 &&
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -116,12 +116,15 @@ test_expect_success '--graph --simplify-by-decora=
tion' '
 	test_cmp expected actual
 	'
=20
-# Get rid of all decorations on branch B, and graph with it simplified=
 away
+test_expect_success 'setup: get rid of decorations on B' '
+	git tag -d B2 &&
+	git tag -d B1 &&
+	git branch -d B
+'
+
+# Graph with branch B simplified away
 test_expect_success '--graph --simplify-by-decoration prune branch B' =
'
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -143,9 +146,6 @@ test_expect_success '--graph --simplify-by-decorati=
on prune branch B' '
=20
 test_expect_success '--graph --full-history -- bar.txt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -163,9 +163,6 @@ test_expect_success '--graph --full-history -- bar.=
txt' '
=20
 test_expect_success '--graph --full-history --simplify-merges -- bar.t=
xt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -181,9 +178,6 @@ test_expect_success '--graph --full-history --simpl=
ify-merges -- bar.txt' '
=20
 test_expect_success '--graph -- bar.txt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "* $A5" >> expected &&
 	echo "* $A3" >> expected &&
@@ -196,9 +190,6 @@ test_expect_success '--graph -- bar.txt' '
=20
 test_expect_success '--graph --sparse -- bar.txt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "* $A6" >> expected &&
 	echo "* $A5" >> expected &&
--=20
1.7.3.1.66.gab790
