From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 7/7] add reflog when moving HEAD to a new branch
Date: Fri, 26 Jan 2007 17:26:11 -0500
Message-ID: <11698503731145-git-send-email-nico@cam.org>
References: <1169850371517-git-send-email-nico@cam.org>
 <11698503712588-git-send-email-nico@cam.org>
 <11698503712998-git-send-email-nico@cam.org>
 <1169850372648-git-send-email-nico@cam.org>
 <11698503722922-git-send-email-nico@cam.org>
 <1169850372410-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 23:26:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAZWn-0004YX-MC
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 23:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbXAZW0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 17:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbXAZW0U
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 17:26:20 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60997 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbXAZW0P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 17:26:15 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCH00AEPYBNA4H0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Jan 2007 17:26:13 -0500 (EST)
In-reply-to: <1169850372410-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.rc2.g6e2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37891>

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 git-checkout.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index ed344d8..5dc281f 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -250,7 +250,7 @@ if [ "$?" -eq 0 ]; then
 	fi
 	if test -n "$branch"
 	then
-		GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD "refs/heads/$branch"
+		GIT_DIR="$GIT_DIR" git-symbolic-ref -m "checkout: moving to $branch" HEAD "refs/heads/$branch"
 	elif test -n "$detached"
 	then
 		# NEEDSWORK: we would want a command to detach the HEAD
-- 
1.5.0.rc2.g6e2c
