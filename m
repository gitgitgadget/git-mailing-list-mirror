From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 16/40] whitespace: remediate t5402-post-merge-hook.sh
Date: Sat,  6 Aug 2011 18:44:30 +1000
Message-ID: <1312620294-18616-16-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVz-000510-Ee
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab1HFIps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:48 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53446 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460Ab1HFIpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:42 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182831iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dkjOORmI9LCAPrBV9JE0qgHj/ELWBIN0m7Cqa2vCdk0=;
        b=nNT0Km1ovef9xCG0a/4FGYvTgGd75Z6xzAdXFGQoqkQxtl7/5KI69nylinOaytxvOi
         ocEnxNd2tuWGBfgxQqwiYZZscP/7NQyQK2FFkgPsD8Rtd8rtTy1C4t2PZX4V9w93hxNa
         wporZu1eNGo5mR9gPhYSXQeFrvRRJMIEjZJC0=
Received: by 10.42.196.134 with SMTP id eg6mr2938050icb.343.1312620342563;
        Sat, 06 Aug 2011 01:45:42 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178844>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t5402-post-merge-hook.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 6eb2ffd..d3d757b 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -15,7 +15,7 @@ test_expect_success setup '
 	git update-index a &&
 	tree1=$(git write-tree) &&
 	commit1=$(echo modify | git commit-tree $tree1 -p $commit0) &&
-        git update-ref refs/heads/master $commit0 &&
+	git update-ref refs/heads/master $commit0 &&
 	git clone ./. clone1 &&
 	GIT_DIR=clone1/.git git update-index --add a &&
 	git clone ./. clone2 &&
@@ -31,26 +31,26 @@ EOF
 done
 
 test_expect_success 'post-merge does not run for up-to-date ' '
-        GIT_DIR=clone1/.git git merge $commit0 &&
+	GIT_DIR=clone1/.git git merge $commit0 &&
 	! test -f clone1/.git/post-merge.args
 '
 
 test_expect_success 'post-merge runs as expected ' '
-        GIT_DIR=clone1/.git git merge $commit1 &&
+	GIT_DIR=clone1/.git git merge $commit1 &&
 	test -e clone1/.git/post-merge.args
 '
 
 test_expect_success 'post-merge from normal merge receives the right argument ' '
-        grep 0 clone1/.git/post-merge.args
+	grep 0 clone1/.git/post-merge.args
 '
 
 test_expect_success 'post-merge from squash merge runs as expected ' '
-        GIT_DIR=clone2/.git git merge --squash $commit1 &&
+	GIT_DIR=clone2/.git git merge --squash $commit1 &&
 	test -e clone2/.git/post-merge.args
 '
 
 test_expect_success 'post-merge from squash merge receives the right argument ' '
-        grep 1 clone2/.git/post-merge.args
+	grep 1 clone2/.git/post-merge.args
 '
 
 test_done
-- 
1.7.6.362.gf0e6
