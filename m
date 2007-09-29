From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Fix adding a submodule with a remote url
Date: Sat, 29 Sep 2007 19:39:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709291937240.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Sep 30 01:40:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iblul-0001S6-HH
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 01:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbXI2Xj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 19:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbXI2Xj4
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 19:39:56 -0400
Received: from iabervon.org ([66.92.72.58]:33265 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbXI2Xj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 19:39:56 -0400
Received: (qmail 15349 invoked by uid 1000); 29 Sep 2007 23:39:54 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Sep 2007 23:39:54 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59512>

Without this, a non-path URL gets lost before the clone.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I'm not sure if the use of $repo in this function is right, but this is 
definitely an improvement.

 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 727b1d3..4aaaaab 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -138,8 +138,8 @@ module_add()
 		# it is local
 		if base=$(get_repo_base "$repo"); then
 			repo="$base"
-			realrepo=$repo
 		fi
+		realrepo=$repo
 		;;
 	esac
 
-- 
1.5.3.2.1107.ge9eab8-dirty
