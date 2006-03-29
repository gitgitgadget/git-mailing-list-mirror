From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Pass --directory to git-ls-files for stg status
Date: Wed, 29 Mar 2006 16:25:31 +0200
Message-ID: <20060329142531.12017.29353.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 16:50:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FObzr-0006Ox-V5
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 16:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWC2Otp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 09:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWC2Oto
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 09:49:44 -0500
Received: from [151.97.230.9] ([151.97.230.9]:57782 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1750714AbWC2Oto (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 09:49:44 -0500
Received: (qmail 16376 invoked by uid 508); 29 Mar 2006 16:49:42 +0200
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 29 Mar 2006 16:49:42 +0200
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 654FE258CC;
	Wed, 29 Mar 2006 16:25:32 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18169>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Requires GIT 1.1.0 at least (don't know if this was backported in 1.0).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/git.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 40d54ef..e8c816d 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -194,8 +194,8 @@ def __tree_status(files = None, tree_id 
         if noexclude:
             extra_exclude = base_exclude = []
 
-        lines = _output_lines(['git-ls-files', '--others'] + base_exclude
-                        + extra_exclude)
+        lines = _output_lines(['git-ls-files', '--others', '--directory']
+                        + base_exclude + extra_exclude)
         cache_files += [('?', line.strip()) for line in lines]
 
     # conflicted files
