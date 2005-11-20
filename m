From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] merge-recursive: Replace 'except:'
Date: Sun, 20 Nov 2005 13:14:37 +0100
Message-ID: <20051120121437.GD4946@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Nov 20 13:15:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edo6G-0000Vu-C8
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 13:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVKTMOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 07:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVKTMOj
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 07:14:39 -0500
Received: from [85.8.31.11] ([85.8.31.11]:33185 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751220AbVKTMOj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 07:14:39 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 865E54102; Sun, 20 Nov 2005 13:23:42 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Edo5e-0004Gf-00; Sun, 20 Nov 2005 13:14:38 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12381>

Plain except:s are evil as they will catch all kinds of exceptions
including NameError and AttrubiteError.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: c037ce1b974c7d0671312b52ed46ed405c1a8443
e90840aaf9adb880297d98e16031665b426e3987
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index 52e2ad7..3e7758d 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -243,7 +243,7 @@ def updateFileExt(sha, mode, path, updat
 
             try:
                 createDir = not stat.S_ISDIR(os.lstat(p).st_mode)
-            except: 
+            except OSError:
                 createDir = True
             
             if createDir:
---
0.99.9.GIT
