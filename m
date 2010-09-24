From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 04/16] t1002 (read-tree-m-u-2way): add missing &&
Date: Fri, 24 Sep 2010 16:22:44 -0600
Message-ID: <1285366976-22216-5-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGel-0000n6-8V
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758256Ab0IXWV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:27 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60844 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0IXWVY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:24 -0400
Received: by mail-qw0-f46.google.com with SMTP id 6so2090828qwh.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=N5TK7r7HKC0iuz2XPrLFVAnSFscJVmwE8JvWR+ya2MU=;
        b=D7f75F+VTuvOq0nv/KyC4Z9udBTJX0UjumRu4tkIdtH4TKhfPuvYHwu2c39jiNP/in
         NAZdWNt31QmYYiA9rwbZy3+Do2/4ar5qK00vEXsBJNryDSusPXhjiHefW6aRMrvsRx1F
         1o7yFA5Nr1Y+RENDkis0qgBuM3b795ZouOXKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E9HdrAoVb5OAt8NKKkammUeGUDgQGdi0ZaJNain9ySF1gQB1mY2dT+oVUygcHoYvzb
         sSD9Q4jJzBqjZ6PzepBUnZQGzFgyKXolA6qn4Ftdb9OAN6aPlYeqLBBOgyTuOMtXN0SK
         1PlEPuyZAi9kS4ulH1cFheqGZz29jMdcB7hFo=
Received: by 10.220.127.18 with SMTP id e18mr1440530vcs.3.1285366884109;
        Fri, 24 Sep 2010 15:21:24 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157078>

FIXME: Is it okay to replace the "|| return 1" with "&&" as I did?

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1002-read-tree-m-u-2way.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index 0241329..a9492e9 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -205,8 +205,8 @@ test_expect_success \
      echo nitfol nitfol >nitfol &&
      git update-index --add nitfol &&
      git read-tree -m -u $treeH $treeM &&
-     git ls-files --stage >14.out || return 1
-     git diff -U0 --no-index M.out 14.out >14diff.out
+     git ls-files --stage >14.out &&
+     test_might_fail git diff -U0 --no-index M.out 14.out >14diff.out &&
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
+     test_might_fail git diff -U0 --no-index M.out 15.out >15diff.out &&
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
      treeDF=`git write-tree` &&
-- 
1.7.3.95.g14291
