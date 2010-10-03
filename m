From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 04/16] t100[12] (read-tree-m-2way, read_tree_m_u_2way): add missing &&
Date: Sun,  3 Oct 2010 14:00:02 -0600
Message-ID: <1286136014-7728-5-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:58:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Ui0-0002r3-Ok
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab0JCT6x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:58:53 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:52092 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab0JCT6w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:58:52 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1157426pxi.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6dXF1TD747Iv+UvR7hYHSPFqzIuOxCV7kI7ahaLnRdM=;
        b=oPb4FxZbPuqN9enkTKUa7LrMBN17l0hkOYyXp+UlsvQUq/in/MEdHg5pophDYi5F3a
         woJoPbddQ31Z3c6JtU/ETEaa2ZroEHYCSv8JMW3th6Q5WRIAaW5BF69ZhhNjYBDZAzOK
         CTQLNUewnkqU7QISqHYcLGPhu+/M0YxXBt0Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=G2DNhf5y92eDLda6WzxS5aBHsysptpGCaa4N37CoTgM2pAdsHVe4GbCk3Sob3I+DzO
         D/ye/SMMfpEk8aP2TUbOugXLoAcFnpcdXBRgCnnjVL+CTlIzg+vZNsS/C+JUkwuRBSvK
         QVuor2UNJ9ozKAjBtYjgAkzlmItebuJSKihpo=
Received: by 10.114.109.9 with SMTP id h9mr10084729wac.211.1286135932234;
        Sun, 03 Oct 2010 12:58:52 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.58.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:58:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157902>

Also, replace "|| return 1" with "&&" in order to keep commands chained=
=2E

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1001-read-tree-m-2way.sh   |   18 +++++++++---------
 t/t1002-read-tree-m-u-2way.sh |   10 +++++-----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 93ca84f..c28d790 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -98,8 +98,8 @@ test_expect_success \
      git checkout-index -u -f -q -a &&
      git update-index --add yomin &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >4.out || return 1
-     git diff --no-index M.out 4.out >4diff.out
+     git ls-files --stage >4.out &&
+     test_must_fail git diff --no-index M.out 4.out >4diff.out &&
      compare_change 4diff.out expected &&
      check_cache_at yomin clean'
=20
@@ -112,8 +112,8 @@ test_expect_success \
      git update-index --add yomin &&
      echo yomin yomin >yomin &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >5.out || return 1
-     git diff --no-index M.out 5.out >5diff.out
+     git ls-files --stage >5.out &&
+     test_must_fail git diff --no-index M.out 5.out >5diff.out &&
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty'
=20
@@ -213,8 +213,8 @@ test_expect_success \
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >14.out || return 1
-     git diff --no-index M.out 14.out >14diff.out
+     git ls-files --stage >14.out &&
+     test_must_fail git diff --no-index M.out 14.out >14diff.out &&
      compare_change 14diff.out expected &&
      check_cache_at nitfol clean'
=20
@@ -227,8 +227,8 @@ test_expect_success \
      git update-index --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >15.out || return 1
-     git diff --no-index M.out 15.out >15diff.out
+     git ls-files --stage >15.out &&
+     test_must_fail git diff --no-index M.out 15.out >15diff.out &&
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty'
=20
@@ -377,7 +377,7 @@ test_expect_success \
      git ls-files --stage >treeM.out &&
=20
      rm -f a &&
-     mkdir a
+     mkdir a &&
      : >a/b &&
      git update-index --add --remove a a/b &&
      treeH=3D`git write-tree` &&
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way=
=2Esh
index 0241329..a4a17e0 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -205,8 +205,8 @@ test_expect_success \
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
      git read-tree -m -u $treeH $treeM &&
-     git ls-files --stage >14.out || return 1
-     git diff -U0 --no-index M.out 14.out >14diff.out
+     git ls-files --stage >14.out &&
+     test_must_fail git diff -U0 --no-index M.out 14.out >14diff.out &=
&
      compare_change 14diff.out expected &&
      sum bozbar frotz >actual14.sum &&
      grep -v nitfol M.sum > expected14.sum &&
@@ -226,8 +226,8 @@ test_expect_success \
      git update-index --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
      git read-tree -m -u $treeH $treeM &&
-     git ls-files --stage >15.out || return 1
-     git diff -U0 --no-index M.out 15.out >15diff.out
+     git ls-files --stage >15.out &&
+     test_must_fail git diff -U0 --no-index M.out 15.out >15diff.out &=
&
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty &&
      sum bozbar frotz >actual15.sum &&
@@ -314,7 +314,7 @@ test_expect_success \
 # Also make sure we did not break DF vs DF/DF case.
 test_expect_success \
     'DF vs DF/DF case setup.' \
-    'rm -f .git/index
+    'rm -f .git/index &&
      echo DF >DF &&
      git update-index --add DF &&
      treeDF=3D`git write-tree` &&
--=20
1.7.3.1.66.gab790
