From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Fix syntax error in stg status
Date: Sun, 18 Sep 2005 20:15:51 +0200
Message-ID: <20050918181551.21145.53583.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 20:20:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH3lH-0004X2-AH
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 20:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVIRSTd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 14:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVIRSTc
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 14:19:32 -0400
Received: from ppp-62-11-79-169.dialup.tiscali.it ([62.11.79.169]:31156 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932156AbVIRSTc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 14:19:32 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id DAF204392B;
	Sun, 18 Sep 2005 20:15:53 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8803>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Uff, it's becoming annoying - why things break so often? However, more to the
point: turn a string into a list to allow appending it to another list.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -182,7 +182,7 @@ def __tree_status(files = [], tree_id = 
         base_exclude.append('--exclude-per-directory=.gitignore')
 
         if os.path.exists(exclude_file):
-            extra_exclude = '--exclude-from=%s' % exclude_file
+            extra_exclude = ['--exclude-from=%s' % exclude_file]
         else:
             extra_exclude = []
         if noexclude:
