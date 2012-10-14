From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 04/20] cvsserver update: comment about how we shouldn't remove a user-modified file
Date: Sat, 13 Oct 2012 23:42:17 -0600
Message-ID: <1350193353-19210-5-git-send-email-mmogilvi_git@miniinfo.net>
References: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:48:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNH41-0006rG-7v
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab2JNFsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:48:22 -0400
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:53104
	"EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752061Ab2JNFsU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:48:20 -0400
Received: from omta13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by qmta12.emeryville.ca.mail.comcast.net with comcast
	id Atlj1k00817UAYkACtoLgA; Sun, 14 Oct 2012 05:48:20 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta13.emeryville.ca.mail.comcast.net with comcast
	id AtjK1k0062wKXRC8ZtjKVV; Sun, 14 Oct 2012 05:43:20 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 13B111E9601A; Sat, 13 Oct 2012 23:43:19 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
In-Reply-To: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207617>

Instead of a comment, we should really add test cases and actually fix it.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 git-cvsserver.perl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 595865c..cc39b6b 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1144,6 +1144,10 @@ sub req_update
 
         if ( $meta->{filehash} eq "deleted" )
         {
+            # TODO: If it has been modified in the sandbox, error out
+            #   with the appropriate message, rather than deleting a modified
+            #   file.
+
             my ( $filepart, $dirpart ) = filenamesplit($filename,1);
 
             $log->info("Removing '$filename' from working copy (no longer in the repo)");
-- 
1.7.10.2.484.gcd07cc5
