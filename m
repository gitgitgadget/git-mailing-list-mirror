From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: [PATCH] Fix up remaining man pages that use asciidoc "callouts".
Date: Fri, 28 Apr 2006 09:15:05 -0400
Message-ID: <BAYC1-PASMTP028F5C1C39F7EF6A6EEB95AEB20@CEZ.ICE>
References: <11462301063885-git-send-email-seanlkml@sympatico.ca>
Reply-To: Sean Estabrooks <seanlkml@sympatico.ca>
Cc: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Fri Apr 28 15:19:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZSsp-0004Y7-Q6
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 15:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWD1NTk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 09:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWD1NTk
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 09:19:40 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:59926 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1030392AbWD1NTh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 09:19:37 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from guru.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Apr 2006 06:19:36 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by guru.attic.local (Postfix) with ESMTP id 9D1137001EC;
	Fri, 28 Apr 2006 09:15:06 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <1146230106696-git-send-email-seanlkml@sympatico.ca>
X-Mailer: git-send-email 1.3.1.gc672
In-Reply-To: <11462301063885-git-send-email-seanlkml@sympatico.ca>
X-OriginalArrivalTime: 28 Apr 2006 13:19:36.0899 (UTC) FILETIME=[65B3D130:01C66AC6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Unfortunately docbook does not allow a callout to be
referenced from inside a callout list description.
Rewrite one paragraph in git-reset man page to work
around this limitation.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


---

 Documentation/everyday.txt         |   45 +++++++++++------------
 Documentation/git-checkout.txt     |   18 +++++----
 Documentation/git-diff.txt         |   38 ++++++++++---------
 Documentation/git-init-db.txt      |    8 ++--
 Documentation/git-reset.txt        |   72 ++++++++++++++++++------------------
 Documentation/git-update-index.txt |   31 ++++++++--------
 6 files changed, 104 insertions(+), 108 deletions(-)

481f9838c408f36fe74a44197865b54842174546
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 3ab9b91..4b56370 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -61,7 +61,8 @@ Check health and remove cruft.::
 $ git count-objects <2>
 $ git repack <3>
 $ git prune <4>
-
+------------
++
 <1> running without "--full" is usually cheap and assures the
 repository health reasonably well.
 <2> check how many loose objects there are and how much
@@ -69,17 +70,16 @@ diskspace is wasted by not repacking.
 <3> without "-a" repacks incrementally.  repacking every 4-5MB
 of loose objects accumulation may be a good rule of thumb.
 <4> after repack, prune removes the duplicate loose objects.
-------------
 
 Repack a small project into single pack.::
 +
 ------------
 $ git repack -a -d <1>
 $ git prune
-
+------------
++
 <1> pack all the objects reachable from the refs into one pack
 and remove unneeded other packs
-------------
 
 
 Individual Developer (Standalone)[[Individual Developer (Standalone)]]
@@ -129,10 +129,10 @@ Extract a tarball and create a working t
 $ git add . <1>
 $ git commit -m 'import of frotz source tree.'
 $ git tag v2.43 <2>
-
+------------
++
 <1> add everything under the current directory.
 <2> make a lightweight, unannotated tag.
-------------
 
 Create a topic branch and develop.::
 +
@@ -153,7 +153,8 @@ Create a topic branch and develop.::
 $ git pull . alsa-audio <10>
 $ git log --since='3 days ago' <11>
 $ git log v2.43.. curses/ <12>
-
+------------
++
 <1> create a new topic branch.
 <2> revert your botched changes in "curses/ux_audio_oss.c".
 <3> you need to tell git if you added a new file; removal and
@@ -170,7 +171,6 @@ you originally wrote.
 combined and include --max-count=10 (show 10 commits), --until='2005-12-10'.
 <12> view only the changes that touch what's in curses/
 directory, since v2.43 tag.
-------------
 
 
 Individual Developer (Participant)[[Individual Developer (Participant)]]
@@ -208,7 +208,8 @@ Clone the upstream and work on it.  Feed
 $ git reset --hard ORIG_HEAD <6>
 $ git prune <7>
 $ git fetch --tags <8>
-
+------------
++
 <1> repeat as needed.
 <2> extract patches from your branch for e-mail submission.
 <3> "pull" fetches from "origin" by default and merges into the
@@ -221,7 +222,6 @@ area we are interested in.
 <7> garbage collect leftover objects from reverted pull.
 <8> from time to time, obtain official tags from the "origin"
 and store them under .git/refs/tags/.
-------------
 
 
 Push into another repository.::
@@ -239,7 +239,8 @@ satellite$ git push origin <4>
 mothership$ cd frotz
 mothership$ git checkout master
 mothership$ git pull . satellite <5>
-
+------------
++
 <1> mothership machine has a frotz repository under your home
 directory; clone from it to start a repository on the satellite
 machine.
@@ -252,7 +253,6 @@ to local "origin" branch.
 mothership machine.  You could use this as a back-up method.
 <5> on mothership machine, merge the work done on the satellite
 machine into the master branch.
-------------
 
 Branch off of a specific tag.::
 +
@@ -262,12 +262,12 @@ Branch off of a specific tag.::
 $ git checkout master
 $ git format-patch -k -m --stdout v2.6.14..private2.6.14 |
   git am -3 -k <2>
-
+------------
++
 <1> create a private branch based on a well known (but somewhat behind)
 tag.
 <2> forward port all changes in private2.6.14 branch to master branch
 without a formal "merging".
-------------
 
 
 Integrator[[Integrator]]
@@ -317,7 +317,8 @@ My typical GIT day.::
 $ git fetch ko && git show-branch master maint 'tags/ko-*' <11>
 $ git push ko <12>
 $ git push ko v0.99.9x <13>
-
+------------
++
 <1> see what I was in the middle of doing, if any.
 <2> see what topic branches I have and think about how ready
 they are.
@@ -346,7 +347,6 @@ In the output from "git show-branch", "m
 everything "ko-master" has.
 <12> push out the bleeding edge.
 <13> push the tag out, too.
-------------
 
 
 Repository Administration[[Repository Administration]]
@@ -367,7 +367,6 @@ example of managing a shared central rep
 
 Examples
 ~~~~~~~~
-
 Run git-daemon to serve /pub/scm from inetd.::
 +
 ------------
@@ -388,13 +387,13 @@ cindy:x:1002:1002::/home/cindy:/usr/bin/
 david:x:1003:1003::/home/david:/usr/bin/git-shell
 $ grep git /etc/shells <2>
 /usr/bin/git-shell
-
+------------
++
 <1> log-in shell is set to /usr/bin/git-shell, which does not
 allow anything but "git push" and "git pull".  The users should
 get an ssh access to the machine.
 <2> in many distributions /etc/shells needs to list what is used
 as the login shell.
-------------
 
 CVS-style shared repository.::
 +
@@ -419,7 +418,8 @@ git:x:9418:alice,bob,cindy,david
 refs/heads/master	alice\|cindy
 refs/heads/doc-update	bob
 refs/tags/v[0-9]*	david
-
+------------
++
 <1> place the developers into the same git group.
 <2> and make the shared repository writable by the group.
 <3> use update-hook example by Carl from Documentation/howto/
@@ -427,7 +427,6 @@ for branch policy control.
 <4> alice and cindy can push into master, only bob can push into doc-update.
 david is the release manager and is the only person who can
 create and push version tags.
-------------
 
 HTTP server to support dumb protocol transfer.::
 +
@@ -435,7 +434,7 @@ HTTP server to support dumb protocol tra
 dev$ git update-server-info <1>
 dev$ ftp user@isp.example.com <2>
 ftp> cp -r .git /home/user/myproject.git
-
+------------
++
 <1> make sure your info/refs and objects/info/packs are up-to-date
 <2> upload to public HTTP server hosted by your ISP.
-------------
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 985bb2f..78f2fe6 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -66,19 +66,19 @@ the `Makefile` to two revisions back, de
 mistake, and gets it back from the index.
 +
 ------------
-$ git checkout master <1>
-$ git checkout master~2 Makefile <2>
+$ git checkout master             <1>
+$ git checkout master~2 Makefile  <2>
 $ rm -f hello.c
-$ git checkout hello.c <3>
-
+$ git checkout hello.c            <3>
+------------
++
 <1> switch branch
 <2> take out a file out of other commit
-<3> or "git checkout -- hello.c", as in the next example.
-------------
+<3> restore hello.c from HEAD of current branch
 +
-If you have an unfortunate branch that is named `hello.c`, the
-last step above would be confused as an instruction to switch to
-that branch.  You should instead write:
+If you have an unfortunate branch that is named `hello.c`, this
+step would be confused as an instruction to switch to that branch.  
+You should instead write:
 +
 ------------
 $ git checkout -- hello.c
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 890931c..7267bcd 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -46,40 +46,41 @@ EXAMPLES
 Various ways to check your working tree::
 +
 ------------
-$ git diff <1>
-$ git diff --cached <2>
-$ git diff HEAD <3>
-
+$ git diff            <1>
+$ git diff --cached   <2>
+$ git diff HEAD       <3>
+------------
++
 <1> changes in the working tree since your last git-update-index.
 <2> changes between the index and your last commit; what you
 would be committing if you run "git commit" without "-a" option.
 <3> changes in the working tree since your last commit; what you
 would be committing if you run "git commit -a"
-------------
 
 Comparing with arbitrary commits::
 +
 ------------
-$ git diff test <1>
-$ git diff HEAD -- ./test <2>
-$ git diff HEAD^ HEAD <3>
-
+$ git diff test            <1>
+$ git diff HEAD -- ./test  <2>
+$ git diff HEAD^ HEAD      <3>
+------------
++
 <1> instead of using the tip of the current branch, compare with the
 tip of "test" branch.
 <2> instead of comparing with the tip of "test" branch, compare with
 the tip of the current branch, but limit the comparison to the
 file "test".
 <3> compare the version before the last commit and the last commit.
-------------
 
 
 Limiting the diff output::
 +
 ------------
-$ git diff --diff-filter=MRC <1>
-$ git diff --name-status -r <2>
-$ git diff arch/i386 include/asm-i386 <3>
-
+$ git diff --diff-filter=MRC            <1>
+$ git diff --name-status -r             <2>
+$ git diff arch/i386 include/asm-i386   <3>
+------------
++
 <1> show only modification, rename and copy, but not addition
 nor deletion.
 <2> show only names and the nature of change, but not actual
@@ -88,18 +89,17 @@ which in turn also disables recursive be
 you would only see the directory name if there is a change in a
 file in a subdirectory.
 <3> limit diff output to named subtrees.
-------------
 
 Munging the diff output::
 +
 ------------
-$ git diff --find-copies-harder -B -C <1>
-$ git diff -R <2>
-
+$ git diff --find-copies-harder -B -C  <1>
+$ git diff -R                          <2>
+------------
++
 <1> spend extra cycles to find renames, copies and complete
 rewrites (very expensive).
 <2> output diff in reverse.
-------------
 
 
 Author
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index aeb1115..8a150d8 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -60,12 +60,12 @@ Start a new git repository for an existi
 +
 ----------------
 $ cd /path/to/my/codebase
-$ git-init-db <1>
-$ git-add . <2>
-
+$ git-init-db   <1>
+$ git-add .     <2>
+----------------
++
 <1> prepare /path/to/my/codebase/.git directory
 <2> add all existing file to the index
-----------------
 
 
 Author
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index b7b9798..b17cdba 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -49,10 +49,11 @@ Undo a commit and redo::
 +
 ------------
 $ git commit ...
-$ git reset --soft HEAD^ <1>
-$ edit <2>
-$ git commit -a -c ORIG_HEAD <3>
-
+$ git reset --soft HEAD^      <1>
+$ edit                        <2>
+$ git commit -a -c ORIG_HEAD  <3>
+------------
++
 <1> This is most often done when you remembered what you
 just committed is incomplete, or you misspelled your commit
 message, or both.  Leaves working tree as it was before "reset".
@@ -60,43 +61,43 @@ message, or both.  Leaves working tree a
 <3> "reset" copies the old head to .git/ORIG_HEAD; redo the
 commit by starting with its log message.  If you do not need to
 edit the message further, you can give -C option instead.
-------------
 
 Undo commits permanently::
 +
 ------------
 $ git commit ...
-$ git reset --hard HEAD~3 <1>
-
+$ git reset --hard HEAD~3   <1>
+------------
++
 <1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
 and you do not want to ever see them again.  Do *not* do this if
 you have already given these commits to somebody else.
-------------
 
 Undo a commit, making it a topic branch::
 +
 ------------
-$ git branch topic/wip <1>
-$ git reset --hard HEAD~3 <2>
-$ git checkout topic/wip <3>
-
+$ git branch topic/wip     <1>
+$ git reset --hard HEAD~3  <2>
+$ git checkout topic/wip   <3>
+------------
++
 <1> You have made some commits, but realize they were premature
 to be in the "master" branch.  You want to continue polishing
 them in a topic branch, so create "topic/wip" branch off of the
 current HEAD.
 <2> Rewind the master branch to get rid of those three commits.
 <3> Switch to "topic/wip" branch and keep working.
-------------
 
 Undo update-index::
 +
 ------------
-$ edit <1>
+$ edit                                     <1>
 $ git-update-index frotz.c filfre.c
-$ mailx <2>
-$ git reset <3>
-$ git pull git://info.example.com/ nitfol <4>
-
+$ mailx                                    <2>
+$ git reset                                <3>
+$ git pull git://info.example.com/ nitfol  <4>
+------------
++
 <1> you are happily working on something, and find the changes
 in these files are in good order.  You do not want to see them
 when you run "git diff", because you plan to work on other files
@@ -109,12 +110,11 @@ index changes for these two files.  Your
 remain there.
 <4> then you can pull and merge, leaving frotz.c and filfre.c
 changes still in the working tree.
-------------
 
 Undo a merge or pull::
 +
 ------------
-$ git pull <1>
+$ git pull                         <1>
 Trying really trivial in-index merge...
 fatal: Merge requires file-level merging
 Nope.
@@ -122,20 +122,19 @@ Nope.
 Auto-merging nitfol
 CONFLICT (content): Merge conflict in nitfol
 Automatic merge failed/prevented; fix up by hand
-$ git reset --hard <2>
-
+$ git reset --hard                 <2>
+$ git pull . topic/branch          <3>
+Updating from 41223... to 13134...
+Fast forward
+$ git reset --hard ORIG_HEAD       <4>
+------------
++
 <1> try to update from the upstream resulted in a lot of
 conflicts; you were not ready to spend a lot of time merging
 right now, so you decide to do that later.
 <2> "pull" has not made merge commit, so "git reset --hard"
 which is a synonym for "git reset --hard HEAD" clears the mess
 from the index file and the working tree.
-
-$ git pull . topic/branch <3>
-Updating from 41223... to 13134...
-Fast forward
-$ git reset --hard ORIG_HEAD <4>
-
 <3> merge a topic branch into the current branch, which resulted
 in a fast forward.
 <4> but you decided that the topic branch is not ready for public
@@ -143,7 +142,6 @@ consumption yet.  "pull" or "merge" alwa
 tip of the current branch in ORIG_HEAD, so resetting hard to it
 brings your index file and the working tree back to that state,
 and resets the tip of the branch to that commit.
-------------
 
 Interrupted workflow::
 +
@@ -155,21 +153,21 @@ need to get to the other branch for a qu
 ------------
 $ git checkout feature ;# you were working in "feature" branch and
 $ work work work       ;# got interrupted
-$ git commit -a -m 'snapshot WIP' <1>
+$ git commit -a -m 'snapshot WIP'                 <1>
 $ git checkout master
 $ fix fix fix
 $ git commit ;# commit with real log
 $ git checkout feature
-$ git reset --soft HEAD^ ;# go back to WIP state <2>
-$ git reset <3>
-
+$ git reset --soft HEAD^ ;# go back to WIP state  <2>
+$ git reset                                       <3>
+------------
++
 <1> This commit will get blown away so a throw-away log message is OK.
 <2> This removes the 'WIP' commit from the commit history, and sets
     your working tree to the state just before you made that snapshot.
-<3> After <2>, the index file still has all the WIP changes you
-    committed in <1>.  This sets it to the last commit you were
-    basing the WIP changes on.
-------------
+<3> At this point the index file still has all the WIP changes you
+    committed as 'snapshot WIP'.  This updates the index to show your 
+    WIP files as uncommitted.
 
 Author
 ------
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 0a1b0ad..d4137fc 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -247,34 +247,33 @@ To update and refresh only the files alr
 $ git-checkout-index -n -f -a && git-update-index --ignore-missing --refresh
 ----------------
 
-On an inefficient filesystem with `core.ignorestat` set:
-
+On an inefficient filesystem with `core.ignorestat` set::
++
 ------------
-$ git update-index --really-refresh <1>
-$ git update-index --no-assume-unchanged foo.c <2>
-$ git diff --name-only <3>
+$ git update-index --really-refresh              <1>
+$ git update-index --no-assume-unchanged foo.c   <2>
+$ git diff --name-only                           <3>
 $ edit foo.c
-$ git diff --name-only <4>
+$ git diff --name-only                           <4>
 M foo.c
-$ git update-index foo.c <5>
-$ git diff --name-only <6>
+$ git update-index foo.c                         <5>
+$ git diff --name-only                           <6>
 $ edit foo.c
-$ git diff --name-only <7>
-$ git update-index --no-assume-unchanged foo.c <8>
-$ git diff --name-only <9>
+$ git diff --name-only                           <7>
+$ git update-index --no-assume-unchanged foo.c   <8>
+$ git diff --name-only                           <9>
 M foo.c
-
-<1> forces lstat(2) to set "assume unchanged" bits for paths
-    that match index.
+------------
++
+<1> forces lstat(2) to set "assume unchanged" bits for paths that match index.
 <2> mark the path to be edited.
 <3> this does lstat(2) and finds index matches the path.
-<4> this does lstat(2) and finds index does not match the path.
+<4> this does lstat(2) and finds index does *not* match the path.
 <5> registering the new version to index sets "assume unchanged" bit.
 <6> and it is assumed unchanged.
 <7> even after you edit it.
 <8> you can tell about the change after the fact.
 <9> now it checks with lstat(2) and finds it has been changed.
-------------
 
 
 Configuration
-- 
1.3.1.gc672
