From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 30/40] whitespace: remediate t9108-git-svn-glob.sh
Date: Sat,  6 Aug 2011 18:44:44 +1000
Message-ID: <1312620294-18616-30-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWW-0005FS-3V
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab1HFIqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:18 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:52375 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab1HFIqP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:15 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5183416iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=I9gbSIUCaMns0UNt6sdPCrYRthgwMeeDxWnjWAy5VuM=;
        b=oVQPR+leSRRPk2DG3zABPWm9F6+mfriNKyI/6d8MB7dtC6GIEFAhtuzNTCdJrfw6dS
         s6psOz8dVKgF9ocXskKOqNOiOW8tLHGTthBVfgoKMhfr1JYuoAfVjIImhYOz2ToHsNL3
         c3GKjJ5K9K01xMLPs92/tfrcwl4CAshWRdhng=
Received: by 10.42.97.194 with SMTP id p2mr755579icn.245.1312620375215;
        Sat, 06 Aug 2011 01:46:15 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178851>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9108-git-svn-glob.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index d732d31..a58f794 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -41,11 +41,11 @@ test_expect_success 'test refspec globbing' '
 	) &&
 	git config --add svn-remote.svn.url "$svnrepo" &&
 	git config --add svn-remote.svn.fetch \
-	                 "trunk/src/a:refs/remotes/trunk" &&
+			 "trunk/src/a:refs/remotes/trunk" &&
 	git config --add svn-remote.svn.branches \
-	                 "branches/*/src/a:refs/remotes/branches/*" &&
+			 "branches/*/src/a:refs/remotes/branches/*" &&
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
-	                 "branches/*:refs/remotes/two/branches/*" &&
+			 "branches/*:refs/remotes/two/branches/*" &&
 	git config --add svn-remote.two.tags \
-	                 "tags/*:refs/remotes/two/tags/*" &&
+			 "tags/*:refs/remotes/two/tags/*" &&
 	(
 		cd tmp &&
 		echo "try try" >> tags/end/src/b/readme &&
@@ -93,11 +93,11 @@ echo "" >> expect.three
 test_expect_success 'test disallow multi-globs' '
 	git config --add svn-remote.three.url "$svnrepo" &&
 	git config --add svn-remote.three.fetch \
-	                 trunk:refs/remotes/three/trunk &&
+			 trunk:refs/remotes/three/trunk &&
 	git config --add svn-remote.three.branches \
-	                 "branches/*/t/*:refs/remotes/three/branches/*" &&
+			 "branches/*/t/*:refs/remotes/three/branches/*" &&
 	git config --add svn-remote.three.tags \
-	                 "tags/*/*:refs/remotes/three/tags/*" &&
+			 "tags/*/*:refs/remotes/three/tags/*" &&
 	(
 		cd tmp &&
 		echo "try try" >> tags/end/src/b/readme &&
-- 
1.7.6.362.gf0e6
