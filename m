From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 31/40] whitespace: remediate t9109-git-svn-multi-glob.sh
Date: Sat,  6 Aug 2011 18:44:45 +1000
Message-ID: <1312620294-18616-31-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:47:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcXP-0005kJ-6Q
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab1HFIq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:57 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:43546 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414Ab1HFIqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:17 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5183461iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=l5Uf1yEeywvskYQGbOLXw7EcM6z9czlBMn/S+ktibTc=;
        b=Ss876zE0st3O81l8g3KMfPoXLYJ7DPGHR60WXJNN6l2JkXW2/o67U7s7c4S0G1vYKP
         gqj8By1GDWwGy2/8oKCqMqABgQ1z41Q6EbaM63MgEN7Zk8xHZRbRvQA7marCvPUvdLot
         1Gqn9X85flPldfxdieOc8YBD4x0e/Slnv2Afs=
Received: by 10.231.43.18 with SMTP id u18mr924035ibe.30.1312620377481;
        Sat, 06 Aug 2011 01:46:17 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178866>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9109-git-svn-multi-glob.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t9109-git-svn-multi-glob.sh b/t/t9109-git-svn-multi-glob.sh
index c318f9f..5c48f46 100755
--- a/t/t9109-git-svn-multi-glob.sh
+++ b/t/t9109-git-svn-multi-glob.sh
@@ -41,11 +41,11 @@ test_expect_success 'test refspec globbing' '
 	) &&
 	git config --add svn-remote.svn.url "$svnrepo" &&
 	git config --add svn-remote.svn.fetch \
-	                 "trunk/src/a:refs/remotes/trunk" &&
+			 "trunk/src/a:refs/remotes/trunk" &&
 	git config --add svn-remote.svn.branches \
-	                 "branches/*/*/src/a:refs/remotes/branches/*/*" &&
+			 "branches/*/*/src/a:refs/remotes/branches/*/*" &&
 	git config --add svn-remote.svn.tags\
-	                 "tags/*/src/a:refs/remotes/tags/*" &&
+			 "tags/*/src/a:refs/remotes/tags/*" &&
 	git svn multi-fetch &&
 	git log --pretty=oneline refs/remotes/tags/end | \
 	    sed -e "s/^.\{41\}//" > output.end &&
@@ -65,9 +65,9 @@ test_expect_success 'test left-hand-side only globbing' '
 	git config --add svn-remote.two.url "$svnrepo" &&
 	git config --add svn-remote.two.fetch trunk:refs/remotes/two/trunk &&
 	git config --add svn-remote.two.branches \
-	                 "branches/*/*:refs/remotes/two/branches/*/*" &&
+			 "branches/*/*:refs/remotes/two/branches/*/*" &&
 	git config --add svn-remote.two.tags \
-	                 "tags/*:refs/remotes/two/tags/*" &&
+			 "tags/*:refs/remotes/two/tags/*" &&
 	(
 		cd tmp &&
 		echo "try try" >> tags/end/src/b/readme &&
@@ -120,9 +120,9 @@ test_expect_success 'test another branch' '
 	git config --add svn-remote.four.url "$svnrepo" &&
 	git config --add svn-remote.four.fetch trunk:refs/remotes/four/trunk &&
 	git config --add svn-remote.four.branches \
-	                 "branches/*/*:refs/remotes/four/branches/*/*" &&
+			 "branches/*/*:refs/remotes/four/branches/*/*" &&
 	git config --add svn-remote.four.tags \
-	                 "tags/*:refs/remotes/four/tags/*" &&
+			 "tags/*:refs/remotes/four/tags/*" &&
 	git svn fetch four &&
 	test `git rev-list refs/remotes/four/tags/next | wc -l` -eq 5 &&
 	test `git rev-list refs/remotes/four/branches/v2/start | wc -l` -eq 3 &&
@@ -142,11 +142,11 @@ echo "" >> expect.three
 test_expect_success 'test disallow multiple globs' '
 	git config --add svn-remote.three.url "$svnrepo" &&
 	git config --add svn-remote.three.fetch \
-	                 trunk:refs/remotes/three/trunk &&
+			 trunk:refs/remotes/three/trunk &&
 	git config --add svn-remote.three.branches \
-	                 "branches/*/t/*:refs/remotes/three/branches/*/*" &&
+			 "branches/*/t/*:refs/remotes/three/branches/*/*" &&
 	git config --add svn-remote.three.tags \
-	                 "tags/*:refs/remotes/three/tags/*" &&
+			 "tags/*:refs/remotes/three/tags/*" &&
 	(
 		cd tmp &&
 		echo "try try" >> tags/end/src/b/readme &&
-- 
1.7.6.362.gf0e6
