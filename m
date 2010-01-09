From: Bart Trojanowski <bart@jukie.net>
Subject: [PATCH] hg-to-git: fix COMMITTER type-o
Date: Fri,  8 Jan 2010 19:54:39 -0500
Message-ID: <1262998479-24269-1-git-send-email-bart@jukie.net>
Cc: bart@jukie.net, Stelian Pop <stelian@popies.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 02:05:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTPlU-0000VO-ST
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 02:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab0AIBFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 20:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474Ab0AIBFK
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 20:05:10 -0500
Received: from tau.jukie.net ([216.239.93.128]:54730 "EHLO tau.jukie.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752396Ab0AIBFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 20:05:09 -0500
X-Greylist: delayed 624 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jan 2010 20:05:09 EST
Received: from localhost.localdomain (quark.jukie.net [10.10.10.220])
	by tau.jukie.net (Postfix) with ESMTP id 96299C0090B;
	Fri,  8 Jan 2010 19:54:41 -0500 (EST)
X-Mailer: git-send-email 1.6.6.2.g9ad4f53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136506>

This script passes the author and committer to git-commit via environment
variables, but it was missing the seccond T of COMMITTER in a few places.

Signed-off-by: Bart Trojanowski <bart@jukie.net>
---
 contrib/hg-to-git/hg-to-git.py |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 2a6839d..854cd94 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -59,14 +59,14 @@ def getgitenv(user, date):
     elems = re.compile('(.*?)\s+<(.*)>').match(user)
     if elems:
         env += 'export GIT_AUTHOR_NAME="%s" ;' % elems.group(1)
-        env += 'export GIT_COMMITER_NAME="%s" ;' % elems.group(1)
+        env += 'export GIT_COMMITTER_NAME="%s" ;' % elems.group(1)
         env += 'export GIT_AUTHOR_EMAIL="%s" ;' % elems.group(2)
-        env += 'export GIT_COMMITER_EMAIL="%s" ;' % elems.group(2)
+        env += 'export GIT_COMMITTER_EMAIL="%s" ;' % elems.group(2)
     else:
         env += 'export GIT_AUTHOR_NAME="%s" ;' % user
-        env += 'export GIT_COMMITER_NAME="%s" ;' % user
+        env += 'export GIT_COMMITTER_NAME="%s" ;' % user
         env += 'export GIT_AUTHOR_EMAIL= ;'
-        env += 'export GIT_COMMITER_EMAIL= ;'
+        env += 'export GIT_COMMITTER_EMAIL= ;'
 
     env += 'export GIT_AUTHOR_DATE="%s" ;' % date
     env += 'export GIT_COMMITTER_DATE="%s" ;' % date
-- 
1.6.6.2.g9ad4f53
