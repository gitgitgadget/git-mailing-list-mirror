From: "David J. Mellor" <dmellor@whistlingcat.com>
Subject: [PATCH 2/4] Documentation: reworded the "Description" section of git-blame.txt.
Date: Mon, 16 Mar 2009 23:16:15 -0700
Message-ID: <1237270577-17261-2-git-send-email-dmellor@whistlingcat.com>
References: <1237270577-17261-1-git-send-email-dmellor@whistlingcat.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 17 07:20:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjSfE-0004Lb-13
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 07:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbZCQGSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 02:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762053AbZCQGSw
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 02:18:52 -0400
Received: from quartz.whistlingcat.com ([67.223.228.111]:52838 "EHLO
	quartz.whistlingcat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbZCQGSs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 02:18:48 -0400
Received: from whistlingcat.com (whistlingcat.com [99.12.234.57])
	by quartz.whistlingcat.com (Postfix) with ESMTP id C1EBD48800B;
	Mon, 16 Mar 2009 23:18:46 -0700 (PDT)
Received: from sandstone.whistlingcat.com (sandstone.whistlingcat.com [192.168.0.2])
	by whistlingcat.com (Postfix) with ESMTP id 648CC38E7573;
	Mon, 16 Mar 2009 23:18:45 -0700 (PDT)
Received: by sandstone.whistlingcat.com (Postfix, from userid 500)
	id EC80F17A48; Mon, 16 Mar 2009 23:16:17 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1237270577-17261-1-git-send-email-dmellor@whistlingcat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113420>

Reworded this section to make it less chatty. Also made minor grammatical
fixes.

Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
---
 Documentation/git-bisect.txt |  154 +++++++++++++++++++++---------------------
 1 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index e65c1ca..df0ed36 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -3,7 +3,7 @@ git-bisect(1)
 
 NAME
 ----
-git-bisect - Find the change that introduced a bug by binary search
+git-bisect - Find by binary search the change that introduced a bug
 
 
 SYNOPSIS
@@ -39,7 +39,8 @@ help" or "git bisect -h" to get a long usage description.
 Basic bisect commands: start, bad, good
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The way you use it is:
+Using the Linux kernel tree as an example, basic use of the bisect
+command is as follows:
 
 ------------------------------------------------
 $ git bisect start
@@ -48,61 +49,62 @@ $ git bisect good v2.6.13-rc2    # v2.6.13-rc2 was the last version
                                  # tested that was good
 ------------------------------------------------
 
-When you give at least one bad and one good versions, it will bisect
-the revision tree and say something like:
+When you have specified at least one bad and one good version, the
+command bisects the revision tree and outputs something similar to:
 
 ------------------------------------------------
 Bisecting: 675 revisions left to test after this
 ------------------------------------------------
 
-and check out the state in the middle. Now, compile that kernel, and
-boot it. Now, let's say that this booted kernel works fine, then just
-do
+and then checks out the state in the middle. You would now compile
+that kernel and boot it. If the booted kernel works correctly, you
+would then issue the following command:
 
 ------------------------------------------------
 $ git bisect good			# this one is good
 ------------------------------------------------
 
-which will now say
+which would then output something similar to:
 
 ------------------------------------------------
 Bisecting: 337 revisions left to test after this
 ------------------------------------------------
 
 and you continue along, compiling that one, testing it, and depending
-on whether it is good or bad, you say "git bisect good" or "git bisect
-bad", and ask for the next bisection.
+on whether it is good or bad issuing the command "git bisect good"
+or "git bisect bad" to ask for the next bisection.
 
-Until you have no more left, and you'll have been left with the first
-bad kernel rev in "refs/bisect/bad".
+Eventually there will be no more revisions left to bisect, and you
+will have been left with the first bad kernel revision in "refs/bisect/bad".
 
 Bisect reset
 ~~~~~~~~~~~~
 
-Oh, and then after you want to reset to the original head, do a
+To return to the original head after a bisect session, you issue the
+command:
 
 ------------------------------------------------
 $ git bisect reset
 ------------------------------------------------
 
-to get back to the original branch, instead of being on the bisection
-commit ("git bisect start" will do that for you too, actually: it will
-reset the bisection state).
+This resest the tree to the original branch instead of being on the
+bisection commit ("git bisect start" will also do that, as it resets
+the bisection state).
 
 Bisect visualize
 ~~~~~~~~~~~~~~~~
 
-During the bisection process, you can say
+During the bisection process, you issue the command:
 
 ------------
 $ git bisect visualize
 ------------
 
-to see the currently remaining suspects in 'gitk'.  `visualize` is a bit
-too long to type and `view` is provided as a synonym.
+to see the currently remaining suspects in 'gitk'.  `view` may also
+be used as a synonym for `visualize`.
 
-If 'DISPLAY' environment variable is not set, 'git log' is used
-instead.  You can even give command line options such as `-p` and
+If the 'DISPLAY' environment variable is not set, 'git log' is used
+instead.  You can also give command line options such as `-p` and
 `--stat`.
 
 ------------
@@ -112,57 +114,56 @@ $ git bisect view --stat
 Bisect log and bisect replay
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The good/bad input is logged, and
+The good/bad input is logged, and:
 
 ------------
 $ git bisect log
 ------------
 
 shows what you have done so far. You can truncate its output somewhere
-and save it in a file, and run
+and save it in a file, and run:
 
 ------------
 $ git bisect replay that-file
 ------------
 
-if you find later you made a mistake telling good/bad about a
-revision.
+if you find later that you made a mistake specifying revisions as good/bad.
 
-Avoiding to test a commit
+Avoiding testing a commit
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-If in a middle of bisect session, you know what the bisect suggested
-to try next is not a good one to test (e.g. the change the commit
+If in the middle of a bisect session, you know that the next suggested
+revision is not a good one to test (e.g. the change the commit
 introduces is known not to work in your environment and you know it
 does not have anything to do with the bug you are chasing), you may
-want to find a near-by commit and try that instead.
+want to find a nearby commit and try that instead.
 
-It goes something like this:
+For example:
 
 ------------
 $ git bisect good/bad			# previous round was good/bad.
 Bisecting: 337 revisions left to test after this
 $ git bisect visualize			# oops, that is uninteresting.
-$ git reset --hard HEAD~3		# try 3 revs before what
+$ git reset --hard HEAD~3		# try 3 revisions before what
 					# was suggested
 ------------
 
-Then compile and test the one you chose to try. After that, tell
-bisect what the result was as usual.
+Then compile and test the chosen revision. Afterwards the revision
+is marked as good/bad in the usual manner.
 
 Bisect skip
 ~~~~~~~~~~~~
 
-Instead of choosing by yourself a nearby commit, you may just want git
-to do it for you using:
+Instead of choosing by yourself a nearby commit, you can ask git
+to do it for you by issuing the command:
 
 ------------
 $ git bisect skip                 # Current version cannot be tested
 ------------
 
 But computing the commit to test may be slower afterwards and git may
-eventually not be able to tell the first bad among a bad and one or
-more "skip"ped commits.
+eventually not be able to tell the first bad commit among a bad commit
+and one or more skipped commits.
 
 You can even skip a range of commits, instead of just one commit,
 using the "'<commit1>'..'<commit2>'" notation. For example:
@@ -174,30 +175,29 @@ $ git bisect skip v2.5..v2.6
 would mean that no commit between `v2.5` excluded and `v2.6` included
 can be tested.
 
-Note that if you want to also skip the first commit of a range you can
-use something like:
+Note that if you also want to skip the first commit of the range you
+would issue the command:
 
 ------------
 $ git bisect skip v2.5 v2.5..v2.6
 ------------
 
-and the commit pointed to by `v2.5` will be skipped too.
+and the commit pointed to by `v2.5` would also be skipped.
 
 Cutting down bisection by giving more parameters to bisect start
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-You can further cut down the number of trials if you know what part of
-the tree is involved in the problem you are tracking down, by giving
-paths parameters when you say `bisect start`, like this:
+You can further cut down the number of trials, if you know what part of
+the tree is involved in the problem you are tracking down, by specifying
+path parameters when issuing the `bisect start` command, like this:
 
 ------------
 $ git bisect start -- arch/i386 include/asm-i386
 ------------
 
-If you know beforehand more than one good commits, you can narrow the
-bisect space down without doing the whole tree checkout every time you
-give good commits. You give the bad revision immediately after `start`
-and then you give all the good revisions you have:
+If you know beforehand more than one good commit, you can narrow the
+bisect space down by specifying all of the good commits immediately after
+the bad commit when issuing the `bisect start` command:
 
 ------------
 $ git bisect start v2.6.20-rc6 v2.6.20-rc4 v2.6.20-rc1 --
@@ -209,38 +209,38 @@ Bisect run
 ~~~~~~~~~~
 
 If you have a script that can tell if the current source code is good
-or bad, you can automatically bisect using:
+or bad, you can bisect by issuing the command:
 
 ------------
 $ git bisect run my_script arguments
 ------------
 
-Note that the "run" script (`my_script` in the above example) should
-exit with code 0 in case the current source code is good.  Exit with a
+Note that the script (`my_script` in the above example) should
+exit with code 0 if the current source code is good, and exit with a
 code between 1 and 127 (inclusive), except 125, if the current
 source code is bad.
 
-Any other exit code will abort the automatic bisect process. (A
-program that does "exit(-1)" leaves $? = 255, see exit(3) manual page,
-the value is chopped with "& 0377".)
+Any other exit code will abort the bisect process. It should be noted
+that a program that terminates via "exit(-1)" leaves $? = 255, (see the
+exit(3) manual page), as the value is chopped with "& 0377".
 
 The special exit code 125 should be used when the current source code
-cannot be tested. If the "run" script exits with this code, the current
-revision will be skipped, see `git bisect skip` above.
+cannot be tested. If the script exits with this code, the current
+revision will be skipped (see `git bisect skip` above).
 
-You may often find that during bisect you want to have near-constant
-tweaks (e.g., s/#define DEBUG 0/#define DEBUG 1/ in a header file, or
-"revision that does not have this commit needs this patch applied to
-work around other problem this bisection is not interested in")
-applied to the revision being tested.
+You may often find that during a bisect session you want to have
+temporary modifications (e.g. s/#define DEBUG 0/#define DEBUG 1/ in a
+header file, or "revision that does not have this commit needs this
+patch applied to work around another problem this bisection is not
+interested in") applied to the revision being tested.
 
 To cope with such a situation, after the inner 'git bisect' finds the
-next revision to test, with the "run" script, you can apply that tweak
-before compiling, run the real test, and after the test decides if the
-revision (possibly with the needed tweaks) passed the test, rewind the
-tree to the pristine state.  Finally the "run" script can exit with
-the status of the real test to let the "git bisect run" command loop to
-determine the outcome.
+next revision to test, the script can apply the patch
+before compiling, run the real test, and afterwards decide if the
+revision (possibly with the needed patch) passed the test and then
+rewind the tree to the pristine state.  Finally the script should exit
+with the status of the real test to let the "git bisect run" command loop
+to determine the eventual outcome of the bisect session.
 
 EXAMPLES
 --------
@@ -264,39 +264,39 @@ $ git bisect run make test           # "make test" builds and tests
 ------------
 $ cat ~/test.sh
 #!/bin/sh
-make || exit 125                   # this "skip"s broken builds
+make || exit 125                   # this skips broken builds
 make test                          # "make test" runs the test suite
 $ git bisect start v1.3 v1.1 --    # v1.3 is bad, v1.1 is good
 $ git bisect run ~/test.sh
 ------------
 +
 Here we use a "test.sh" custom script. In this script, if "make"
-fails, we "skip" the current commit.
+fails, we skip the current commit.
 +
-It's safer to use a custom script outside the repo to prevent
+It is safer to use a custom script outside the repository to prevent
 interactions between the bisect, make and test processes and the
 script.
 +
-And "make test" should "exit 0", if the test suite passes, and
-"exit 1" (for example) otherwise.
+"make test" should "exit 0", if the test suite passes, and
+"exit 1" otherwise.
 
 * Automatically bisect a broken test case:
 +
 ------------
 $ cat ~/test.sh
 #!/bin/sh
-make || exit 125                     # this "skip"s broken builds
+make || exit 125                     # this skips broken builds
 ~/check_test_case.sh                 # does the test case passes ?
 $ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
 $ git bisect run ~/test.sh
 ------------
 +
-Here "check_test_case.sh" should "exit 0", if the test case passes,
-and "exit 1" (for example) otherwise.
+Here "check_test_case.sh" should "exit 0" if the test case passes,
+and "exit 1" otherwise.
 +
-It's safer if both "test.sh" and "check_test_case.sh" scripts are
-outside the repo to prevent interactions between the bisect, make and
-test processes and the scripts.
+It is safer if both "test.sh" and "check_test_case.sh" scripts are
+outside the repository to prevent interactions between the bisect,
+make and test processes and the scripts.
 
 * Automatically bisect a broken test suite:
 +
-- 
1.6.2.1
