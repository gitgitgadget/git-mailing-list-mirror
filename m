From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH] Documentation: Reworded example text in git-bisect.txt.
Date: Thu, 19 Mar 2009 20:35:34 -0700
Message-ID: <1237520134-18044-1-git-send-email-dmellor@whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 20 04:37:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkVXf-00077g-LX
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 04:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbZCTDfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 23:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbZCTDfi
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 23:35:38 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:37873 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbZCTDfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 23:35:37 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 98979488006;
	Thu, 19 Mar 2009 20:35:35 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 4BD1638E755B;
	Thu, 19 Mar 2009 20:35:35 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id 0B7B917A4B; Thu, 19 Mar 2009 20:35:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113884>

Reworded to avoid splitting sentences across examples of command usage.

Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-bisect.txt |   44 ++++++++++++++++++++++-------------------
 1 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 1a4a527..93d9fc0 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -50,28 +50,29 @@ $ git bisect good v2.6.13-rc2    # v2.6.13-rc2 was the last version
 ------------------------------------------------
 
 When you have specified at least one bad and one good version, the
-command bisects the revision tree and outputs something similar to:
+command bisects the revision tree and outputs something similar to
+the following:
 
 ------------------------------------------------
 Bisecting: 675 revisions left to test after this
 ------------------------------------------------
 
-and then checks out the state in the middle. You would now compile
-that kernel and boot it. If the booted kernel works correctly, you
-would then issue the following command:
+The state in the middle of the set of revisions is then checked out.
+You would now compile that kernel and boot it. If the booted kernel
+works correctly, you would then issue the following command:
 
 ------------------------------------------------
 $ git bisect good			# this one is good
 ------------------------------------------------
 
-which would then output something similar to:
+The output of this command would be something similar to the following:
 
 ------------------------------------------------
 Bisecting: 337 revisions left to test after this
 ------------------------------------------------
 
-and you continue along, compiling that one, testing it, and depending
-on whether it is good or bad issuing the command "git bisect good"
+You keep repeating this process, compiling the tree, testing it, and
+depending on whether it is good or bad issuing the command "git bisect good"
 or "git bisect bad" to ask for the next bisection.
 
 Eventually there will be no more revisions left to bisect, and you
@@ -81,7 +82,7 @@ Bisect reset
 ~~~~~~~~~~~~
 
 To return to the original head after a bisect session, you issue the
-command:
+following command:
 
 ------------------------------------------------
 $ git bisect reset
@@ -94,14 +95,14 @@ the bisection state).
 Bisect visualize
 ~~~~~~~~~~~~~~~~
 
-During the bisection process, you issue the command:
+To see the currently remaining suspects in 'gitk', the following command
+is issued during the bisection process:
 
 ------------
 $ git bisect visualize
 ------------
 
-to see the currently remaining suspects in 'gitk'.  `view` may also
-be used as a synonym for `visualize`.
+`view` may also be used as a synonym for `visualize`.
 
 If the 'DISPLAY' environment variable is not set, 'git log' is used
 instead.  You can also give command line options such as `-p` and
@@ -114,16 +115,17 @@ $ git bisect view --stat
 Bisect log and bisect replay
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-After having marked revisions as good or bad, then:
+After having marked revisions as good or bad, you issue the following
+command to show what has been done so far:
 
 ------------
 $ git bisect log
 ------------
 
-shows what you have done so far. If you discover that you made a mistake
-in specifying the status of a revision, you can save the output of this
-command to a file, edit it to remove the incorrect entries, and then issue
-the following commands to return to a corrected state:
+If you discover that you made a mistake in specifying the status of a
+revision, you can save the output of this command to a file, edit it to
+remove the incorrect entries, and then issue the following commands to
+return to a corrected state:
 
 ------------
 $ git bisect reset
@@ -173,8 +175,8 @@ using the "'<commit1>'..'<commit2>'" notation. For example:
 $ git bisect skip v2.5..v2.6
 ------------
 
-would mean that no commit between `v2.5` excluded and `v2.6` included
-can be tested.
+The effect of this would be that no commit between `v2.5` excluded and
+`v2.6` included could be tested.
 
 Note that if you also want to skip the first commit of the range you
 would issue the command:
@@ -183,14 +185,16 @@ would issue the command:
 $ git bisect skip v2.5 v2.5..v2.6
 ------------
 
-and the commit pointed to by `v2.5` would also be skipped.
+This would cause the commits between `v2.5` included and `v2.6` included
+to be skipped.
+
 
 Cutting down bisection by giving more parameters to bisect start
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 You can further cut down the number of trials, if you know what part of
 the tree is involved in the problem you are tracking down, by specifying
-path parameters when issuing the `bisect start` command, like this:
+path parameters when issuing the `bisect start` command:
 
 ------------
 $ git bisect start -- arch/i386 include/asm-i386
-- 
1.6.2.1
