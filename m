From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-bisect: typofix
Date: Fri, 23 Mar 2007 14:57:10 -0700
Message-ID: <7vwt17oc7d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 22:57:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUrlg-0007e5-4C
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 22:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992578AbXCWV5O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 17:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992580AbXCWV5N
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 17:57:13 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39322 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992578AbXCWV5L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 17:57:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323215710.UUFP22511.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Mar 2007 17:57:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id eMxA1W00f1kojtg0000000; Fri, 23 Mar 2007 17:57:11 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42962>

The branch you are on while bisecting is always "bisect", and
checking for "refs/heads/bisect*" is wrong.  Only check if it is
exactly "refs/heads/bisect".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 3043f65..8eaea7c 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -50,7 +50,7 @@ bisect_start() {
 	head=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD) ||
 	die "Bad HEAD - I need a symbolic ref"
 	case "$head" in
-	refs/heads/bisect*)
+	refs/heads/bisect)
 		if [ -s "$GIT_DIR/head-name" ]; then
 		    branch=`cat "$GIT_DIR/head-name"`
 		else
-- 
1.5.1.rc1.651.g2ca06
