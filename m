From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-cvsimport: perform initial checkout correctly
Date: Sun, 18 Mar 2007 02:16:22 -0700
Message-ID: <7vlkhunc7t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 10:16:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSrVA-0000HI-4A
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 10:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbXCRJQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 05:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbXCRJQY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 05:16:24 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50973 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbXCRJQX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 05:16:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318091623.ZFGQ2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 18 Mar 2007 05:16:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c9GN1W0091kojtg0000000; Sun, 18 Mar 2007 05:16:22 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42482>

Often people wonder why cvsimport does not perform the initial
checkout even though -i option is not given.

---
 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1a1ba7b..e269e26 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -1017,7 +1017,7 @@ if ($orig_branch) {
 		unless -f "$git_dir/refs/heads/master";
 	system('git-update-ref', 'HEAD', "$orig_branch");
 	unless ($opt_i) {
-		system('git checkout');
+		system('git checkout -f));
 		die "checkout failed: $?\n" if $?;
 	}
 }
