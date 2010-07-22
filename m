From: David Fries <david@fries.net>
Subject: [PATCH 2/3] gitk: improve dark background, use diffcolor 2 for link
Date: Thu, 22 Jul 2010 18:12:43 -0500
Message-ID: <20100722231243.GA25152@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 01:12:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc4wb-0005Xp-W8
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 01:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab0GVXMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 19:12:44 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:47494 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab0GVXMo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 19:12:44 -0400
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o6MNCh4O025225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 22 Jul 2010 18:12:43 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id o6MNChhU025224
	for git@vger.kernel.org; Thu, 22 Jul 2010 18:12:43 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (SpacedOut.fries.net [127.0.0.1]); Thu, 22 Jul 2010 18:12:43 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151495>

blue on a black background might as well look like dark blue on black
and is very difficult to read.  The "Diff: hunk header" keeps the
colors more consistent and both default to blue.
---
 gitk-git/gitk |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 8ca7182..a851762 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6673,7 +6673,7 @@ proc appendwithlinks {text tags} {
 }
 
 proc setlink {id lk} {
-    global curview ctext pendinglinks
+    global curview ctext pendinglinks diffcolors
 
     set known 0
     if {[string length $id] < 40} {
@@ -6687,7 +6687,7 @@ proc setlink {id lk} {
 	set known [commitinview $id $curview]
     }
     if {$known} {
-	$ctext tag conf $lk -foreground blue -underline 1
+	$ctext tag conf $lk -foreground [lindex $diffcolors 2] -underline 1
 	$ctext tag bind $lk <1> [list selbyid $id]
 	$ctext tag bind $lk <Enter> {linkcursor %W 1}
 	$ctext tag bind $lk <Leave> {linkcursor %W -1}
-- 
1.7.1
