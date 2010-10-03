From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 11/16] t6016 (rev-list-graph-simplify-history): add missing &&
Date: Sat,  2 Oct 2010 23:10:39 -0600
Message-ID: <1286082644-31595-12-git-send-email-newren@gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 07:10:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Gps-0001zH-Ux
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 07:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381Ab0JCFJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 01:09:41 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60045 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab0JCFJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 01:09:40 -0400
Received: by pzk34 with SMTP id 34so1066499pzk.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 22:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KtVzf2P2//g8euhc4B2BRg0aFKi1+SPj+wKRkCF2Hqo=;
        b=Y7d2pqu/xpIlvMdTLOJzv+E66HuvRzLVvI5NV2RVvfYl2kxG1WaYsoXjSPfuLmBecs
         u04cJUHqe69LXZ4K5JpYgZ1aDPaP+4fWiDGAsDeZGpMCOM6/qL6kGr+a4d2corRFB3Pd
         zTh5geZZn20wcIkMcVjktZ4IBjdB+6P+RnTic=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kiqA1WYguh8fyMm3VAM3eu3FDtN6vpFzYdOEwfZdYgNy4XlK7pXKt4qdK/6SsOO4Yy
         9Hf+kKtpRQuxKJEe0y3ZzbWZdNNH/GvLgQMxJCJmGju2MezGASV5PO74j6zN2o4EAZDP
         EVmy9hY8kmy6HNSsw0v23tqMDQiflcQn+trD8=
Received: by 10.142.147.10 with SMTP id u10mr1370684wfd.67.1286082579655;
        Sat, 02 Oct 2010 22:09:39 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o16sm4140250wfh.19.2010.10.02.22.09.37
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 22:09:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157835>

Also move repeated tag and branch deletions into a separate setup test,=
 to
avoid failures from tags and branches having already been deleted.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
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
