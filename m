From: David Brown <git@davidb.org>
Subject: [TopGit-PATCH] Force adding the .topmsg and .topdep files.
Date: Wed, 13 Aug 2008 22:15:45 -0700
Message-ID: <1218690945-10322-1-git-send-email-git@davidb.org>
Cc: git@vger.kernel.org, David Brown <git@davidb.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Aug 14 07:48:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTVhb-0005O7-LI
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 07:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbYHNFrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 01:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbYHNFrs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 01:47:48 -0400
Received: from linode.davidb.org ([72.14.176.16]:60439 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbYHNFrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 01:47:48 -0400
X-Greylist: delayed 1913 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Aug 2008 01:47:48 EDT
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KTVBZ-0002gy-ST; Wed, 13 Aug 2008 22:15:45 -0700
X-Mailer: git-send-email 1.5.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92321>

If the .gitignore in effect is ignoring the .topmsg and .topdeps
files, tg create will fail trying to add these files.  Add the
'-f option to these add commands to force the files to be added
anyway.

Signed-off-by: David Brown <git@davidb.org>
---
 tg-create.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tg-create.sh b/tg-create.sh
index 939af33..3f33fa8 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -100,7 +100,7 @@ git update-ref "refs/top-bases/$name" "HEAD" ""
 git checkout -b "$name"
 
 echo "$deps" | sed 's/ /\n/g' >"$root_dir/.topdeps"
-git add "$root_dir/.topdeps"
+git add -f "$root_dir/.topdeps"
 
 author="$(git var GIT_AUTHOR_IDENT)"
 author_addr="${author%> *}>"
@@ -118,7 +118,7 @@ author_addr="${author%> *}>"
 Signed-off-by: $author_addr
 EOT
 } >"$root_dir/.topmsg"
-git add "$root_dir/.topmsg"
+git add -f "$root_dir/.topmsg"
 
 
 
-- 
1.5.6.4
