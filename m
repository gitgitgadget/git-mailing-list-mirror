From: Michael Fischer <michael@visv.net>
Subject: [PATCH] request-pull: Show the information for the terminating
 commit id if passed
Date: Wed, 1 Sep 2010 15:59:17 -0400
Message-ID: <20100901195917.GA29593@blinkenlights.visv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Fischer <michael@visv.net>, ryan@michonline.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:10:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqtdX-0004CS-Qg
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877Ab0IAUKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 16:10:14 -0400
Received: from www.visv.net ([64.81.194.132]:46237 "EHLO
	blinkenlights.visv.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754002Ab0IAUKO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:10:14 -0400
X-Greylist: delayed 655 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Sep 2010 16:10:13 EDT
Received: by blinkenlights.visv.net (Postfix, from userid 1000)
	id A29425F81FA; Wed,  1 Sep 2010 15:59:17 -0400 (EDT)
Mail-Followup-To: Michael Fischer <michael@visv.net>, git@vger.kernel.org,
	ryan@michonline.com, gitster@pobox.com
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155074>

This makes it somewhat easier for a developer to know at what commit
his/her *next* pull request might start.

Signed-off-by: Michael Fischer <michael@visv.net>
---
 git-request-pull.sh |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 6fdea39..a13eeda 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -70,7 +70,17 @@ git show -s --format='The following changes since commit %H:
 
   %s (%ci)
 
-are available in the git repository at:' $baserev &&
+' $baserev
+
+if [ -z "$3" ]; then
+git show -s --format='and up to commit %H:
+
+  %s (%ci)
+
+' $headrev
+fi
+
+echo "are available in the git repository at:" &&
 echo "  $url $branch" &&
 echo &&
 


Michael
-- 
Michael Fischer
michael@visv.net
