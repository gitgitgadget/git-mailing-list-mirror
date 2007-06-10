From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/5] git-push: Update description of refspecs and add examples
Date: Sat, 09 Jun 2007 23:59:17 -0700
Message-ID: <7vk5ucb8hm.fsf_-_@assigned-by-dhcp.cox.net>
References: <11813808962261-git-send-email-gitster@pobox.com>
	<11813808973041-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 08:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxHOU-0001uf-KM
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 08:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760151AbXFJG7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 02:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759496AbXFJG7V
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 02:59:21 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42213 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760074AbXFJG7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 02:59:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610065918.YFMG12207.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 02:59:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9izH1X0011kojtg0000000; Sun, 10 Jun 2007 02:59:17 -0400
In-Reply-To: <11813808973041-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Sat, 9 Jun 2007 02:21:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49656>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is primarily to describe the semantics [Patch 5/5] fixes.

 Documentation/git-push.txt |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 366c5db..665f6dc 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -53,9 +53,8 @@ side are updated.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
-A parameter <ref> without a colon is equivalent to
-<ref>`:`<ref>, hence updates <ref> in the destination from <ref>
-in the source.
+A parameter <ref> without a colon pushes the <ref> from the source
+repository to the destination repository under the same name.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
@@ -98,6 +97,26 @@ the remote repository.
 
 include::urls.txt[]
 
+
+Examples
+--------
+
+git push origin master::
+	Find a ref that matches `master` in the source repository
+	(most likely, it would find `refs/heads/master`), and update
+	the same ref (e.g. `refs/heads/master`) in `origin` repository
+	with it.
+
+git push origin :experimental::
+	Find a ref that matches `experimental` in the `origin` repository
+	(e.g. `refs/heads/experimental`), and delete it.
+
+git push origin master:satellite/master::
+	Find a ref that matches `master` in the source repository
+	(most likely, it would find `refs/heads/master`), and update
+	the ref that matches `satellite/master` (most likely, it would
+	be `refs/remotes/satellite/master`) in `origin` repository with it.
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>, later rewritten in C
-- 
1.5.2.1.938.gac3b4
