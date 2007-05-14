From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] user-manual: fix branch names in examples
Date: Mon, 14 May 2007 12:05:08 -0400
Message-ID: <20070514160507.GB20736@fieldses.org>
References: <20070514155111.GE5272@planck.djpig.de> <20070514160335.GA20736@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 18:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnd30-0000TR-ET
	for gcvg-git@gmane.org; Mon, 14 May 2007 18:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbXENQFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 12:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755240AbXENQFM
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 12:05:12 -0400
Received: from mail.fieldses.org ([66.93.2.214]:34628 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755150AbXENQFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 12:05:11 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Hnd2q-0005hO-2i; Mon, 14 May 2007 12:05:08 -0400
Content-Disposition: inline
In-Reply-To: <20070514160335.GA20736@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47264>

Thanks to Frank Lichtenheld for pointing out inconsistent use of branch
names in a couple examples.

Add a little more example output while I'm at it.

At some point actually it might be good for someone to figure out a good
example to use consistently throughout the manual and tutorials; it
might make them a little easier to read.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 9fc2bba..5fb86f2 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -701,7 +701,7 @@ Suppose you want to know how many commits you've made on "mybranch"
 since it diverged from "origin":
 
 -------------------------------------------------
-$ git log --pretty=oneline origin..maint | wc -l
+$ git log --pretty=oneline origin..mybranch | wc -l
 -------------------------------------------------
 
 Alternatively you may often see this sort of thing done with the
@@ -709,7 +709,7 @@ lower-level command gitlink:git-rev-list[1], which just lists the SHA1's
 of all the given commits:
 
 -------------------------------------------------
-$ git rev-list origin..maint | wc -l
+$ git rev-list origin..mybranch | wc -l
 -------------------------------------------------
 
 [[checking-for-equal-branches]]
@@ -849,19 +849,23 @@ a07157ac624b2524a059a3414e99f6f44bebc1e7 refs/heads/master
 1e87486ae06626c2f31eaa63d26fc0fd646c8af2 refs/heads/tutorial-fixes
 -------------------------------------------------
 
-We can get just the branch-head names, and remove "maint", with
+We can get just the branch-head names, and remove "master", with
 the help of the standard utilities cut and grep:
 
 -------------------------------------------------
-$ git show-ref --heads | cut -d' ' -f2 | grep -v '^refs/heads/maint'
+$ git show-ref --heads | cut -d' ' -f2 | grep -v '^refs/heads/master'
+refs/heads/core-tutorial
+refs/heads/maint
+refs/heads/tutorial-2
+refs/heads/tutorial-fixes
 -------------------------------------------------
 
-And then we can ask to see all the commits reachable from maint
+And then we can ask to see all the commits reachable from master
 but not from these other heads:
 
 -------------------------------------------------
-$ gitk maint --not $( git show-ref --heads | cut -d' ' -f2 |
-				grep -v '^refs/heads/maint' )
+$ gitk master --not $( git show-ref --heads | cut -d' ' -f2 |
+				grep -v '^refs/heads/master' )
 -------------------------------------------------
 
 Obviously endless variations are possible; to see all commits
-- 
1.5.1.4.19.g69e2
