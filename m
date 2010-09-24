From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 03/16] t1001 (read-tree-m-2way): add missing &&
Date: Fri, 24 Sep 2010 16:22:43 -0600
Message-ID: <1285366976-22216-4-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:21:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGe0-0000U4-LP
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758252Ab0IXWVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:23 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48207 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0IXWVW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:22 -0400
Received: by mail-qy0-f174.google.com with SMTP id 36so1937273qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fJ7/O/u50SqMp8ELn4qnfOC7HDbyjDgSFF/kZqtmEVg=;
        b=unAzrAYa5gsj/Zp2mkNJGOdE++EQiFQNorXni+r5UGpMd3bkzsjdru9cXb1wbiT/R4
         BIRnNHQ3ZB5zQtz//hRAfDY5HkEb/OZRmWizK/Ab75bjIy9Cge+H5/OUQI7xnr1ToKvu
         IuukXvHiY29Et3vZSwALqUUpVIQWEl4+lb7Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O9aCLDyXBoF9AFhNLETIHWrS/3tgs0H6Or9TNi5b2if1xVou42ZYQhZbv+T1C0sozo
         IEFIHeKF7sQhfFxyBPFW7IdTbiQO8VB9hnyZtCKxnVw2+uuuQ4urJtq4XPlb07suL2P3
         neySox34au8KwgK6Oy2D10K0AxXDyT3vOw73g=
Received: by 10.220.124.104 with SMTP id t40mr1360272vcr.221.1285366881876;
        Fri, 24 Sep 2010 15:21:21 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157074>

FIXME: Is it okay to replace the "|| return 1" with "&&" as I did?

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1001-read-tree-m-2way.sh |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 93ca84f..ce8112c 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -98,8 +98,8 @@ test_expect_success \
      git checkout-index -u -f -q -a &&
      git update-index --add yomin &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >4.out || return 1
-     git diff --no-index M.out 4.out >4diff.out
+     git ls-files --stage >4.out &&
+     test_might_fail git diff --no-index M.out 4.out >4diff.out &&
      compare_change 4diff.out expected &&
      check_cache_at yomin clean'
 
@@ -112,8 +112,8 @@ test_expect_success \
      git update-index --add yomin &&
      echo yomin yomin >yomin &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >5.out || return 1
-     git diff --no-index M.out 5.out >5diff.out
+     git ls-files --stage >5.out &&
+     test_might_fail git diff --no-index M.out 5.out >5diff.out &&
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty'
 
@@ -213,8 +213,8 @@ test_expect_success \
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >14.out || return 1
-     git diff --no-index M.out 14.out >14diff.out
+     git ls-files --stage >14.out &&
+     test_might_fail git diff --no-index M.out 14.out >14diff.out &&
      compare_change 14diff.out expected &&
      check_cache_at nitfol clean'
 
@@ -227,8 +227,8 @@ test_expect_success \
      git update-index --add nitfol &&
      echo nitfol nitfol nitfol >nitfol &&
      read_tree_twoway $treeH $treeM &&
-     git ls-files --stage >15.out || return 1
-     git diff --no-index M.out 15.out >15diff.out
+     git ls-files --stage >15.out &&
+     test_might_fail git diff --no-index M.out 15.out >15diff.out &&
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty'
 
@@ -377,7 +377,7 @@ test_expect_success \
      git ls-files --stage >treeM.out &&
 
      rm -f a &&
-     mkdir a
+     mkdir a &&
      : >a/b &&
      git update-index --add --remove a a/b &&
      treeH=`git write-tree` &&
-- 
1.7.3.95.g14291
