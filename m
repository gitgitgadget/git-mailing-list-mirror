From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 1/5] Fix assertion failure when merging common ancestors.
Date: Mon, 12 Sep 2005 23:29:06 +0200
Message-ID: <20050912212906.GC6644@c165.ib.student.liu.se>
References: <20050912212601.GB6644@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Sep 12 23:29:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEvrT-0005Kp-FU
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 23:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVILV3I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 17:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVILV3I
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 17:29:08 -0400
Received: from [85.8.31.11] ([85.8.31.11]:4845 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932260AbVILV3H (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 17:29:07 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 3702C4115; Mon, 12 Sep 2005 23:34:07 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EEvrO-0001ut-00; Mon, 12 Sep 2005 23:29:06 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050912212601.GB6644@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8432>

Bug reported by Junio.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-fredrik.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

95251fce0dd6366478e8d51d4f187cb07d662d7a
diff --git a/git-merge-fredrik.py b/git-merge-fredrik.py
--- a/git-merge-fredrik.py
+++ b/git-merge-fredrik.py
@@ -60,7 +60,7 @@ def merge(h1, h2, branch1Name, branch2Na
                                  branch1Name, branch2Name,
                                  cleanCache, updateWd)
 
-    if clean or alwaysWriteTree:
+    if clean or cleanCache:
         res = Commit(None, [h1, h2], tree=shaRes)
         graph.addNode(res)
     else:
