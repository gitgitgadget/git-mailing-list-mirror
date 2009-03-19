From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH] Documentation: reworded the "Description" section of git-bisect.txt.
Date: Thu, 19 Mar 2009 00:00:12 -0700
Message-ID: <1237446012-4533-1-git-send-email-dmellor@whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 19 08:01:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkCGD-00076j-HK
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 08:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbZCSHAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 03:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754246AbZCSHAS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 03:00:18 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:59040 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbZCSHAR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 03:00:17 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id 3F631488007;
	Thu, 19 Mar 2009 00:00:13 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 0EE0938E74F4;
	Thu, 19 Mar 2009 00:00:13 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id DA4F517A4B; Thu, 19 Mar 2009 00:00:12 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113722>

Added fixes missing from 2364259.

Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-bisect.txt |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 51d06c1..1a4a527 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -114,21 +114,22 @@ $ git bisect view --stat
 Bisect log and bisect replay
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The good/bad input is logged, and:
+After having marked revisions as good or bad, then:
 
 ------------
 $ git bisect log
 ------------
 
-shows what you have done so far. You can truncate its output somewhere
-and save it in a file, and run:
+shows what you have done so far. If you discover that you made a mistake
+in specifying the status of a revision, you can save the output of this
+command to a file, edit it to remove the incorrect entries, and then issue
+the following commands to return to a corrected state:
 
 ------------
+$ git bisect reset
 $ git bisect replay that-file
 ------------
 
-if you find later that you made a mistake specifying revisions as good/bad.
-
 Avoiding testing a commit
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -141,7 +142,7 @@ want to find a nearby commit and try that instead.
 For example:
 
 ------------
-$ git bisect good/bad			# previous round was good/bad.
+$ git bisect good/bad			# previous round was good or bad.
 Bisecting: 337 revisions left to test after this
 $ git bisect visualize			# oops, that is uninteresting.
 $ git reset --hard HEAD~3		# try 3 revisions before what
@@ -149,7 +150,7 @@ $ git reset --hard HEAD~3		# try 3 revisions before what
 ------------
 
 Then compile and test the chosen revision. Afterwards the revision
-is marked as good/bad in the usual manner.
+is marked as good or bad in the usual manner.
 
 Bisect skip
 ~~~~~~~~~~~~
@@ -240,7 +241,7 @@ before compiling, run the real test, and afterwards decide if the
 revision (possibly with the needed patch) passed the test and then
 rewind the tree to the pristine state.  Finally the script should exit
 with the status of the real test to let the "git bisect run" command loop
-to determine the eventual outcome of the bisect session.
+determine the eventual outcome of the bisect session.
 
 EXAMPLES
 --------
-- 
1.6.2.1
