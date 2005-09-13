From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 3/5] Adjust git-merge-recursive.py for the new tool names.
Date: Tue, 13 Sep 2005 23:40:47 +0200
Message-ID: <20050913214047.GD10953@c165.ib.student.liu.se>
References: <20050913213730.GA10953@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Sep 13 23:42:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFIWd-0006Xy-EG
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 23:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVIMVkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 17:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVIMVkt
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 17:40:49 -0400
Received: from [85.8.31.11] ([85.8.31.11]:14983 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751009AbVIMVks (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 17:40:48 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 92579411B; Tue, 13 Sep 2005 23:45:52 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EFIWF-0002uT-00; Tue, 13 Sep 2005 23:40:47 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050913213730.GA10953@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8492>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

c8d10db0a5380fc52681255b78433390b357c4d0
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -41,7 +41,7 @@ def merge(h1, h2, branch1Name, branch2Na
     if callDepth == 0:
         if len(ca) > 1:
             runProgram(['git-read-tree', h1.tree()])
-            runProgram(['git-update-cache', '-q', '--refresh'])
+            runProgram(['git-update-index', '-q', '--refresh'])
         # Use the original index if we only have one common ancestor
         
         cleanCache = False
@@ -205,14 +205,14 @@ def processEntry(entry, branch1Name, bra
                 assert(False)
 
         if updateWd and updateCache:
-            runProgram(['git-update-cache', '--add', '--', path])
+            runProgram(['git-update-index', '--add', '--', path])
         elif updateCache:
-            runProgram(['git-update-cache', '--add', '--cacheinfo',
+            runProgram(['git-update-index', '--add', '--cacheinfo',
                         '0%o' % mode, sha, path])
 
     def removeFile(clean, path):
         if cleanCache or (not cleanCache and clean):
-            runProgram(['git-update-cache', '--force-remove', '--', path])
+            runProgram(['git-update-index', '--force-remove', '--', path])
 
         if not cleanCache and clean:
             try:
