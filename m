X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] Documentation: updates to "Everyday GIT"
Date: Wed, 25 Oct 2006 22:43:47 -0400
Message-ID: <20061026024347.GB534@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 02:44:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30131>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcvDl-0005Wg-BY for gcvg-git@gmane.org; Thu, 26 Oct
 2006 04:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932224AbWJZCnt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 22:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWJZCnt
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 22:43:49 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33990 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S932224AbWJZCns (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 22:43:48 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GcvDf-0003B3-7W; Wed, 25 Oct 2006
 22:43:47 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Remove the introduction: I think it should be obvious why
we have this.  (And if it isn't obvious then we've got other
problems.)

Replace reference to git whatchanged by git log.

Miscellaneous style and grammar fixes.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/everyday.txt |   43 ++++++++++++-------------------------------
 1 files changed, 12 insertions(+), 31 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index b935c18..99e24a4 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -1,22 +1,7 @@
 Everyday GIT With 20 Commands Or So
 ===================================
 
-GIT suite has over 100 commands, and the manual page for each of
-them discusses what the command does and how it is used in
-detail, but until you know what command should be used in order
-to achieve what you want to do, you cannot tell which manual
-page to look at, and if you know that already you do not need
-the manual.
-
-Does that mean you need to know all of them before you can use
-git?  Not at all.  Depending on the role you play, the set of
-commands you need to know is slightly different, but in any case
-what you need to learn is far smaller than the full set of
-commands to carry out your day-to-day work.  This document is to
-serve as a cheat-sheet and a set of pointers for people playing
-various roles.
-
-<<Basic Repository>> commands are needed by people who has a
+<<Basic Repository>> commands are needed by people who have a
 repository --- that is everybody, because every working tree of
 git is a repository.
 
@@ -25,28 +10,27 @@ essential for anybody who makes a commit
 works alone.
 
 If you work with other people, you will need commands listed in
-<<Individual Developer (Participant)>> section as well.
+the <<Individual Developer (Participant)>> section as well.
 
-People who play <<Integrator>> role need to learn some more
+People who play the <<Integrator>> role need to learn some more
 commands in addition to the above.
 
 <<Repository Administration>> commands are for system
-administrators who are responsible to care and feed git
-repositories to support developers.
+administrators who are responsible for the care and feeding
+of git repositories.
 
 
 Basic Repository[[Basic Repository]]
 ------------------------------------
 
-Everybody uses these commands to feed and care git repositories.
+Everybody uses these commands to maintain git repositories.
 
   * gitlink:git-init-db[1] or gitlink:git-clone[1] to create a
     new repository.
 
-  * gitlink:git-fsck-objects[1] to validate the repository.
+  * gitlink:git-fsck-objects[1] to check the repository for errors.
 
-  * gitlink:git-prune[1] to garbage collect cruft in the
-    repository.
+  * gitlink:git-prune[1] to remove unused objects in the repository.
 
   * gitlink:git-repack[1] to pack loose objects for efficiency.
 
@@ -78,8 +62,8 @@ Repack a small project into single pack.
 $ git prune
 ------------
 +
-<1> pack all the objects reachable from the refs into one pack
-and remove unneeded other packs
+<1> pack all the objects reachable from the refs into one pack,
+then remove the other packs.
 
 
 Individual Developer (Standalone)[[Individual Developer (Standalone)]]
@@ -93,9 +77,6 @@ following commands.
 
   * gitlink:git-log[1] to see what happened.
 
-  * gitlink:git-whatchanged[1] to find out where things have
-    come from.
-
   * gitlink:git-checkout[1] and gitlink:git-branch[1] to switch
     branches.
 
@@ -120,7 +101,7 @@ following commands.
 Examples
 ~~~~~~~~
 
-Extract a tarball and create a working tree and a new repository to keep track of it.::
+Use a tarball as a starting point for a new repository:
 +
 ------------
 $ tar zxf frotz.tar.gz
@@ -203,7 +184,7 @@ Clone the upstream and work on it.  Feed
 $ edit/compile/test; git commit -a -s <1>
 $ git format-patch origin <2>
 $ git pull <3>
-$ git whatchanged -p ORIG_HEAD.. arch/i386 include/asm-i386 <4>
+$ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <4>
 $ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL <5>
 $ git reset --hard ORIG_HEAD <6>
 $ git prune <7>
-- 
1.4.3.2
