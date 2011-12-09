From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 1/2] t3401: modernize style
Date: Fri,  9 Dec 2011 08:59:11 -0800
Message-ID: <1323449952-14161-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 17:59:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ3nV-0001HH-4Z
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 17:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034Ab1LIQ70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 11:59:26 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55052 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab1LIQ7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 11:59:25 -0500
Received: by iakc1 with SMTP id c1so4474464iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 08:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=sHKy1OgeuAvrixwnegpdu49hjOIqmrPi33PQxCT/oX4=;
        b=HF22rk3Aaavf0LnTKlyEl2sjnz0FZhLn4OqN6dlbVtQUrOd4b5Lfj7DFUX1mh6t0Vn
         8Fj6xvvGOqALY5rem6si/c6ZXpKagfCkaK8oCMstLZ4RIBPi1eDavxC76F9DHHuNKxiJ
         VpfZ2l3rjgekavLcY867exVqiY5l0abIkH99c=
Received: by 10.42.153.199 with SMTP id n7mr3491287icw.13.1323449965133;
        Fri, 09 Dec 2011 08:59:25 -0800 (PST)
Received: from martinvonz-glaptop.mtv.corp.google.com (dhcp-172-19-34-241.mtv.corp.google.com [172.19.34.241])
        by mx.google.com with ESMTPS id d19sm12003076ibh.8.2011.12.09.08.59.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 08:59:24 -0800 (PST)
X-Mailer: git-send-email 1.7.8.237.gcc4e3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186652>

Put the opening quote starting each test on the same line as the
test_expect_* invocation. Also make sure to use tabs for indentation.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 t/t3401-rebase-partial.sh |   67 ++++++++++++++++++++++-----------------------
 1 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
index aea6685..d7c874c 100755
--- a/t/t3401-rebase-partial.sh
+++ b/t/t3401-rebase-partial.sh
@@ -11,51 +11,50 @@ local branch.
 '
 . ./test-lib.sh
 
-test_expect_success \
-    'prepare repository with topic branch' \
-    'echo First > A &&
-     git update-index --add A &&
-     git commit -m "Add A." &&
+test_expect_success 'prepare repository with topic branch' '
+	echo First > A &&
+	git update-index --add A &&
+	git commit -m "Add A." &&
 
-     git checkout -b my-topic-branch &&
+	git checkout -b my-topic-branch &&
 
-     echo Second > B &&
-     git update-index --add B &&
-     git commit -m "Add B." &&
+	echo Second > B &&
+	git update-index --add B &&
+	git commit -m "Add B." &&
 
-     echo AnotherSecond > C &&
-     git update-index --add C &&
-     git commit -m "Add C." &&
+	echo AnotherSecond > C &&
+	git update-index --add C &&
+	git commit -m "Add C." &&
 
-     git checkout -f master &&
+	git checkout -f master &&
 
-     echo Third >> A &&
-     git update-index A &&
-     git commit -m "Modify A."
+	echo Third >> A &&
+	git update-index A &&
+	git commit -m "Modify A."
 '
 
-test_expect_success \
-    'pick top patch from topic branch into master' \
-    'git cherry-pick my-topic-branch^0 &&
-     git checkout -f my-topic-branch &&
-     git branch master-merge master &&
-     git branch my-topic-branch-merge my-topic-branch
+test_expect_success 'pick top patch from topic branch into master' '
+	git cherry-pick my-topic-branch^0 &&
+	git checkout -f my-topic-branch &&
+	git branch master-merge master &&
+	git branch my-topic-branch-merge my-topic-branch
 '
 
-test_debug \
-    'git cherry master &&
-     git format-patch -k --stdout --full-index master >/dev/null &&
-     gitk --all & sleep 1
+test_debug '
+	git cherry master &&
+	git format-patch -k --stdout --full-index master >/dev/null &&
+	gitk --all & sleep 1
 '
 
-test_expect_success \
-    'rebase topic branch against new master and check git am did not get halted' \
-    'git rebase master && test ! -d .git/rebase-apply'
+test_expect_success 'rebase topic branch against new master and check git am did not get halted' '
+	git rebase master &&
+	test ! -d .git/rebase-apply
+'
 
-test_expect_success \
-	'rebase --merge topic branch that was partially merged upstream' \
-	'git checkout -f my-topic-branch-merge &&
-	 git rebase --merge master-merge &&
-	 test ! -d .git/rebase-merge'
+test_expect_success 'rebase --merge topic branch that was partially merged upstream' '
+	git checkout -f my-topic-branch-merge &&
+	git rebase --merge master-merge &&
+	test ! -d .git/rebase-merge
+'
 
 test_done
-- 
1.7.8.237.gcc4e3
