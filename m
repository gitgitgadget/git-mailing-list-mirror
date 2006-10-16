From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] svnimport: Fix broken tags being generated
Date: Mon, 16 Oct 2006 03:00:37 +0200
Message-ID: <20061016010037.27259.26157.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 03:00:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZGqS-0006Ub-0j
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 03:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWJPBAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 21:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWJPBAj
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 21:00:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57498 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750837AbWJPBAj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 21:00:39 -0400
Received: (qmail 27269 invoked from network); 16 Oct 2006 03:00:37 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 16 Oct 2006 03:00:37 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28939>

Currently git-svnimport generates broken tags missing the timespec in the
'tagger' line. This is a random stab at a minimal fix.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-svnimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index 988514e..aca0e4f 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -838,7 +838,7 @@ #	}
 		print $out ("object $cid\n".
 		    "type commit\n".
 		    "tag $dest\n".
-		    "tagger $committer_name <$committer_email>\n") and
+		    "tagger $committer_name <$committer_email> 0 +0000\n") and
 		close($out)
 		    or die "Cannot create tag object $dest: $!\n";
 
