From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 01/21] bisect: write about `bisect next` in documentation
Date: Sun, 10 Apr 2016 15:18:54 +0200
Message-ID: <1460294354-7031-2-git-send-email-s-beyer@gmx.net>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:20:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFHh-0008VL-Dn
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbcDJNUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:57672 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbcDJNUC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:02 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MYcJi-1bJRIk24pO-00VSKW; Sun, 10 Apr 2016 15:19:56
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
In-Reply-To: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:bqTL+xBsqD2u2LaAZQ7A74ZvIC+rMP9P9dPbTahXdm8mCMaHQuP
 AniUa5QlYWze9GE7CvgvrFauAaJ41gi1VxbXmxX7Eu9msixhNU4cVxL2Otcny9eEHGpZQL/
 z6BVxfAoHbmZz0MQMMaVjH2gSWN8pQDgvwfPnPNyFeyDZiHKO2JNi1Z2JjoCUYJez0DZzkp
 3D78Kl+5X45gjQB1n2L8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zDIPeARa8uw=:AXeEsAq93wYmrcLOjHpGk6
 V1qrxuWC7romtWVjRg+zxpCceyMmZdcWmrQ+owLmx1HZLE72jWVimKIHKkJQGnr0aoZcKypqn
 Iokl4ctOGhGN5eVt6J4zJG7GdxddyNdFnGnFuf7LBFpeevPcnrMDFOvhd8qc5z/iY9yLjbZ6b
 f5sj9V9NclWuWwPgsl1c1g8uxSsf9hsZmdCJBW3u97VDqV6N/tgwByzg81n2vusBxYcZuQcHM
 G5nr6W9cBWzAy6WD3oRmL/wVWrUtN3uHoddxJBwub/mulUK0A0kixr+sHXSw4CkDJW4rD6SXE
 OWEZQpoBchac6fCItxiwDENma7jmJ+J7WJc2ewLAcfnSuZVZTzZteY05otgUnI3hyNdGiPeNg
 gqv7+ZQ5y5hOPoxUyFYaP0l9lsoRw6x5LXx2Z3UmR668cG9KCqWLJVYhwAwAqIAPcNPxt544e
 lu8zEJce0ecC2SeSrwJIbYqUtIDV0pQDO1XD8ZMs3svDxCkZK6q/U0oPRokAL+tFbcP+SELxb
 gD4bqHHW/vvUoIRQ/ZvIhFEktnm3RoyigOy7q+VNjmnnuQrL8VoUeqYR3QZxOWwNFh4ahVgm0
 4GSPlesWFD2CSV5O8aFzEciyC8y0km3RrITvM9Nf0wQazv5EEhHWEQWdoaAmvQa8sScUWpEyI
 pN5hj9unscp4wUGzNTv0SQmtZ35AXM2cd8tB0vGhLVbJNjaheI0WNT51LpOFMM1z6HHMGw7Ex
 T64ZP8nfx7VLgMgwagzI4ZjRvFZ+gt53T2weE6/Vj1Huf3kMQE68izS7r7U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291149>

Mention `bisect next` in the documentation of bisect.
`bisect next` is only useful in rare cases and the result
can also be accomplished using other utilities (like reflog).
However, it is available as a bisect command and should hence be
documented.

Also mention the use case when no good commit is known.
Some user message in git-bisect.sh is changed to reflect that
use case. It is also simplified: there is no need to mention
running `bisect start` explicitly, because it can be done
indirectly using `bisect bad`.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Notes:
    I rephrased the "Bisect next" section: no encouragement of checking
    out another branch (or commit) but mention that it recomputes the next
    commit, if one accidentally checked out another commit.

 Documentation/git-bisect.txt | 24 ++++++++++++++++++++++++
 git-bisect.sh                | 15 ++++-----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 7e79aae..c76765f 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -27,6 +27,7 @@ on the subcommand:
  git bisect replay <logfile>
  git bisect log
  git bisect run <cmd>...
+ git bisect next
  git bisect help
 
 This command uses a binary search algorithm to find which commit in
@@ -66,6 +67,15 @@ checks it out, and outputs something similar to the following:
 Bisecting: 675 revisions left to test after this (roughly 10 steps)
 ------------------------------------------------
 
+Note that in cases you do not know a good commit,
+you can also start with:
+
+------------------------------------------------
+$ git bisect start
+$ git bisect bad                 # current version is bad
+$ git bisect next                # check out another commit
+------------------------------------------------
+
 You should now compile the checked-out version and test it. If that
 version works correctly, type
 
@@ -353,6 +363,20 @@ rewind the tree to the pristine state.  Finally the script should exit
 with the status of the real test to let the `git bisect run` command loop
 determine the eventual outcome of the bisect session.
 
+Bisect next
+~~~~~~~~~~~
+
+In case you have marked a commit as bad but you do not know a good
+commit, you do not have to crawl through the commit history yourself to
+find a good commit. Simply issue the command:
+
+------------
+$ git bisect next
+------------
+
+In general, the command computes the next commit for the bisection and
+checks it out.
+
 OPTIONS
 -------
 --no-checkout::
diff --git a/git-bisect.sh b/git-bisect.sh
index 5d1cb00..5c93a27 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -334,16 +334,10 @@ bisect_next_check() {
 	*)
 		bad_syn=$(bisect_voc bad)
 		good_syn=$(bisect_voc good)
-		if test -s "$GIT_DIR/BISECT_START"
-		then
-
-			eval_gettextln "You need to give me at least one \$bad_syn and one \$good_syn revision.
-(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
-		else
-			eval_gettextln "You need to start by \"git bisect start\".
-You then need to give me at least one \$good_syn and one \$bad_syn revision.
-(You can use \"git bisect \$bad_syn\" and \"git bisect \$good_syn\" for that.)" >&2
-		fi
+		eval_gettextln "You need to give me at least one \$bad_syn revision.
+Use \"git bisect \$bad_syn\" for that. One \$good_syn revision is also helpful
+for bisecting (use \"git bisect \$good_syn\"). If you do not know one \$good_syn
+revision, you can use \"git bisect next\" to find one." >&2
 		exit 1 ;;
 	esac
 }
@@ -677,7 +671,6 @@ case "$#" in
 	skip)
 		bisect_skip "$@" ;;
 	next)
-		# Not sure we want "next" at the UI level anymore.
 		bisect_next "$@" ;;
 	visualize|view)
 		bisect_visualize "$@" ;;
-- 
2.8.1.137.g522756c
