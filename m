From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH/RFC] tutorial.txt: update to use the "git clone --add"
Date: Wed, 03 Jan 2007 13:57:30 +0100
Message-ID: <87bqlgtghx.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 03 13:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H25id-0000kS-36
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 13:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbXACM7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 07:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbXACM7o
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 07:59:44 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:52252 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbXACM7n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 07:59:43 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l03CuXl24421
	for <git@vger.kernel.org>; Wed, 3 Jan 2007 13:56:33 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35862>


---

 This is a RFC because there is not such "git clone --add".

 I think it make sense to have it and to use it in the tutorial. This
 way all the branches are in the separate-layout, so newbies only have
 to understand one layout.

 Comments?

 Documentation/tutorial.txt |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index f0a5526..637d9d7 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -271,10 +271,12 @@ at /home/bob/myrepo.  She does this with:
 
 ------------------------------------------------
 $ cd /home/alice/project
-$ git pull /home/bob/myrepo master
+$ git clone --add bob /home/bob/myrepo
+$ git pull bob master
 ------------------------------------------------
 
-This merges the changes from Bob's "master" branch into Alice's
+First it clones the Bob's repository with the name "bob" and
+then it merges the changes from Bob's "master" branch into Alice's
 current branch.  If Alice has made her own changes in the meantime,
 then she may need to manually fix any conflicts.  (Note that the
 "master" argument in the above command is actually unnecessary, as it
@@ -284,18 +286,16 @@ The "pull" command thus performs two operations: it fetches changes
 from a remote branch, then merges them into the current branch.
 
 You can perform the first operation alone using the "git fetch"
-command.  For example, Alice could create a temporary branch just to
-track Bob's changes, without merging them with her own, using:
+command without merging them with her own branch, using:
 
 -------------------------------------
-$ git fetch /home/bob/myrepo master:bob-incoming
+$ git fetch bob
 -------------------------------------
 
-which fetches the changes from Bob's master branch into a new branch
-named bob-incoming.  Then
+which fetches the changes from Bob's branches.  Then
 
 -------------------------------------
-$ git log -p master..bob-incoming
+$ git log -p master..bob/master
 -------------------------------------
 
 shows a list of all the changes that Bob made since he branched from
@@ -306,21 +306,21 @@ could pull the changes into her master branch:
 
 -------------------------------------
 $ git checkout master
-$ git pull . bob-incoming
+$ git pull . bob/master
 -------------------------------------
 
-The last command is a pull from the "bob-incoming" branch in Alice's
+The last command is a pull from the "bob/master" branch in Alice's
 own repository.
 
 Alice could also perform both steps at once with:
 
 -------------------------------------
-$ git pull /home/bob/myrepo master:bob-incoming
+$ git pull bob
 -------------------------------------
 
-This is just like the "git pull /home/bob/myrepo master" that we saw
+This is just like the "git pull bob master" that we saw
 before, except that it also stores the unmerged changes from bob's
-master branch in bob-incoming before merging them into Alice's
+master branch in bob/master before merging them into Alice's
 current branch.  Note that git pull always merges into the current
 branch, regardless of what else is given on the commandline.
 
-- 
1.5.0.rc0.g91ea
