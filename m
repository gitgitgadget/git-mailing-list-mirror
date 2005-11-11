From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 3/3] merge-recursive: Use '~' instead of '_' to separate file names from branch names
Date: Sat, 12 Nov 2005 00:55:36 +0100
Message-ID: <20051111235536.GC9757@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Nov 12 00:56:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaikC-00007b-5p
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 00:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVKKXzi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 18:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVKKXzi
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 18:55:38 -0500
Received: from [85.8.31.11] ([85.8.31.11]:64660 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750754AbVKKXzh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 18:55:37 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 1E5BE40FD; Sat, 12 Nov 2005 01:04:11 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Eaik4-0006RT-00; Sat, 12 Nov 2005 00:55:36 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11649>


Makes it less probable that we get a clash with an existing file,
furthermore Cogito already uses '~' for this purpose.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: cd30fe9db68f151066eeadd75eb2fdcb7ff89148
188d233dddacf754d1b7e8c7154293f9a4668180
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index 21f1e92..1bf73f3 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -304,13 +304,13 @@ def uniquePath(path, branch):
                 raise
 
     branch = branch.replace('/', '_')
-    newPath = path + '_' + branch
+    newPath = path + '~' + branch
     suffix = 0
     while newPath in currentFileSet or \
           newPath in currentDirectorySet  or \
           fileExists(newPath):
         suffix += 1
-        newPath = path + '_' + branch + '_' + str(suffix)
+        newPath = path + '~' + branch + '_' + str(suffix)
     currentFileSet.add(newPath)
     return newPath
 
---
0.99.9.GIT
