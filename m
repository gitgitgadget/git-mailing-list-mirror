X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [Patch to DRAFT 2 (1/2)] Branching and merging with git
Date: Wed, 22 Nov 2006 03:02:49 -0800
Message-ID: <7vr6vvu4km.fsf@assigned-by-dhcp.cox.net>
References: <7vslghftix.fsf@assigned-by-dhcp.cox.net>
	<20061120235136.4841.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 11:03:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32079>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmpsX-0003oH-JJ for gcvg-git@gmane.org; Wed, 22 Nov
 2006 12:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162053AbWKVLCw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 06:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162063AbWKVLCw
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 06:02:52 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53157 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1162053AbWKVLCv
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 06:02:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061122110250.RCBA97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Wed, 22
 Nov 2006 06:02:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id pn2x1V00Q1kojtg0000000; Wed, 22 Nov 2006
 06:02:58 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

This installment is ispell only.

--- a/doc
+++ b/doc
@@ -81,7 +81,7 @@
 * A brief digression on command names
 
 All git commands can be invoked as "git-foo" and "git foo".  This document
-uses them interchangably.  But you have to ask for the "git-foo" man page.
+uses them interchangeably.  But you have to ask for the "git-foo" man page.
 Git provides a few other ways to get the man page as well:
 	man git-foo
 	git help foo
@@ -120,13 +120,13 @@
 
 Since the wrapper was developed, some simple commands have been made
 "builtin", so for example, "git diff" is done internally.  There's a
-git-diff link to retain compatability.
+git-diff link to retain compatibility.
 
 
 * Git's representation of history
 
 As you recall from Git 101 (or the git(7) man page), git's largest
-data strucure is the object database, holding exactly four kidnds
+data structure is the object database, holding exactly four kinds
 of objects.  Each of them has a globally unique 40-character hex name
 (a.k.a. object IDs) made by hashing its type and contents.  Since this is
 an (effectively unforgeable) cryptographic hash, the name of an object
@@ -141,11 +141,11 @@
 Tree objects record directory contents; they contain file names,
 permissions, and the associated tree or blob object names.
 
-Tag objects are shareable pointers to other objects; they're generally
+Tag objects are sharable pointers to other objects; they're generally
 used to store a digital signature, and generally point to commits.
 (Although you can tag any object, including another tag.)
 
-Finaly, there are commit objects.  Every commit points to (contains the
+Finally, there are commit objects.  Every commit points to (contains the
 name of) an associated tree object which records the state of the source
 code at the time of the commit, and some descriptive data (time, author,
 committer, commit comment) about the commit.
@@ -172,7 +172,7 @@
 common, but git allows many more.  There's a limit of sixteen in
 the source code, and the most anyone's ever used in real life is 12,
 which was generally regarded as overdoing it.  The famous "dodecapus"
-is commit 9fdb62af in the linux kernel repository.
+is commit 9fdb62af in the Linux kernel repository.
 
 
 Finally, there are references, stored in the .git/refs directory.
@@ -184,7 +184,7 @@
 - Tags are references that are intended to be immutable.
   A tag like "v1.2" is a historical record.  Tag references may or may not
   point to tag objects!  If they do, this is called a "heavyweight tag";
-  the tag can hold a digital signature and can be shared between repositores.
+  the tag can hold a digital signature and can be shared between repositories.
   "Lightweight tags" point to commits directly, and are not automatically
   shared.
 - Heads are references that are intended to be updated.
@@ -808,7 +808,7 @@
 it's generally easier to set up a short-cut by placing the options in
 .git/remotes/<name>.
 
-The syntax is explained in the git-fetch man page.  When this is st
+The syntax is explained in the git-fetch man page.  When this is set
 up, "git fetch <name>" will retrieve all the branches listed in the
 .git/remotes/<name> file.  The ability to fetch multiple branches at
 once (such as release, beta, and development) is an advantage of using
@@ -838,7 +838,7 @@
 If you want to watch a project that's hosted on a git server, the easiest
 way is to use "git clone".
 
-git-clone creates a new repository, sets up a remotes file to reack
+git-clone creates a new repository, sets up a remotes file to track
 every branch in the remote repository, and fetches all those branches.
 By default, it maps them to local heads as follows:
 
@@ -868,7 +868,7 @@
 
 Then the fetch will be done, but the results will be written nowhere
 but .git/FETCH_HEAD.  This is actually the earliest form of git_fetch
-impllemented; everything else is a later addition.  It's not something
+implemented; everything else is a later addition.  It's not something
 you'd do on purpose much, except as part of a script that uses FETCH_HEAD,
 but it's worth mentioning it in case you type it and wonder what the
 heck happened.
@@ -920,8 +920,8 @@
    has the same strictures and limitations.
 
 3) The git protocol.  This is represented with a git:// URL, and talks
-   to a dedicated git daemon (see the git-daemin man page) on the
-   remote machine.  It uses TP port 9418 by default.  This is a smart
+   to a dedicated git daemon (see the git-daemon man page) on the
+   remote machine.  It uses TCP port 9418 by default.  This is a smart
    protocol that understands the git format and does sophisticated
    wire compression.
 
@@ -1066,7 +1066,7 @@
 
 That does a git fetch, updating all of the listed branches as usual,
 then merges the _first_ listed branch into HEAD.  It would be more
-cinsistent to merge all the branches, but that's almost never what
+consistent to merge all the branches, but that's almost never what
 you want.
 
 By the way: don't blink, you might miss it!  As I mentioned, pulling is
@@ -1125,7 +1125,7 @@
 In the completely trivial case when O, A and B are the same, then
 all three rules apply, they all produce the same obvious result.
 
-Git automatically finds the masrge base O as the most recent
+Git automatically finds the merge base O as the most recent
 common ancestor of the heads A and B to be merged.
 
 When doing a merge, git uses the above 2-out-of-3 merging rules
@@ -1147,10 +1147,10 @@
 and uses the same 2-out-of-3 rules to resolve each hunk separately.
 
 Only if all three commits have differing hunks that overlap (or come
-so glose that git can't be sure) is git unable to automatically resolve
+so close that git can't be sure) is git unable to automatically resolve
 the problem.  This requires manual correction, as described below.
 
-If the merge goes well, it is automatically comitted and the HEAD branch
+If the merge goes well, it is automatically committed and the HEAD branch
 updated to point to the new commit.
 
 
@@ -1207,7 +1207,7 @@
 
 * Octopus merge (advanced)
 
-The first is the "octopus" stratgy.  This is special because it can do
+The first is the "octopus" strategy.  This is special because it can do
 a three- or more-way merge.  See 5401f304 in the git repository for
 an example.  (Run gitk, double-click on the "SHA1 ID" box to select
 what's already there, enter "5401f304" instead, and click "Goto".)
@@ -1641,7 +1641,7 @@
              \
 	      y--y <-- dev2
 
-Either way, you'll have to manually figure out a list of vommits that
+Either way, you'll have to manually figure out a list of commits that
 you want in dev1 and create that branch:
 
 	git checkout -b dev1 master
@@ -1695,8 +1695,8 @@
 
 * Cherry picking and rebasing: Merging changes
 
-Suppose that you accidentally ommitted a broken source tree,
-and forgot to use "git-commit --amend" when comitting the following
+Suppose that you accidentally committed a broken source tree,
+and forgot to use "git-commit --amend" when committing the following
 one-liner.  Or say you didn't notice the brokenness immediately
 and made the fix a few commits later.  But now you want to
 rewrite history with the fix merged into the original commit.
@@ -1722,7 +1722,7 @@
 Now, we can git-rebase the remainder.  The only complication is
 that git can't tell that the change from commit2 has been applied,
 since the combined 1+2 change isn't "the same".  One option is to
-trust that there will be amerge conflict when you try and just do:
+trust that there will be a merge conflict when you try and just do:
 
 	git checkout dev
 	git rebase --onto temp <commit1>
@@ -1786,10 +1786,10 @@
 Remember that fetching from a repository on the same machine is both
 possible and fast.  So if you want to play around, just make a new
 directory, run git-init-db, and give it a try.  You can't hurt the source
-repoistory, and deleting the destination is as easy as "rm -rf".
+repository, and deleting the destination is as easy as "rm -rf".
 
 (Of course, you can hurt things with "rm -rf", so make certain you're
-in the right directory before excecuting that!)
+in the right directory before executing that!)
 
 * Experimenting with merging
 
