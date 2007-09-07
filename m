From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] git-rebase: fix -C option
Date: Fri,  7 Sep 2007 10:20:51 -0400
Message-ID: <11891748511401-git-send-email-bfields@citi.umich.edu>
References: <11891748512757-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Sep 07 16:21:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITehg-0001JH-Vq
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 16:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965441AbXIGOUz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 10:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965384AbXIGOUy
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 10:20:54 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57913 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965357AbXIGOUx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 10:20:53 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1ITehX-0006it-Tn; Fri, 07 Sep 2007 10:20:51 -0400
X-Mailer: git-send-email 1.5.3
In-Reply-To: <11891748512757-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58041>

The extra shift here causes failure to parse any commandline including
the -C option.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 git-rebase.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 52c686f..c9942f2 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -221,7 +221,6 @@ do
 		;;
 	-C*)
 		git_am_opt="$git_am_opt $1"
-		shift
 		;;
 	-*)
 		usage
-- 
1.5.3
