From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 01/16] bisect: write about `bisect next` in documentation
Date: Fri, 26 Feb 2016 03:04:27 +0100
Message-ID: <1456452282-10325-2-git-send-email-s-beyer@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 03:06:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7nS-0007dj-LW
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbcBZCGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:06:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:54666 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbcBZCFp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:05:45 -0500
Received: from fermat.fritz.box ([188.108.247.176]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MMBiP-1aZwjI2K7h-007ynp; Fri, 26 Feb 2016 03:05:41
 +0100
X-Mailer: git-send-email 2.7.2.383.g3fb0654
In-Reply-To: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:OvdBn2641KRlti8xH+DIv6Q6Ncmny60zfCqqnnv4YMQsAbLwkEE
 LrNP5VefLs3Y9j/I3T2658r1qpZ5Qghwxjd4uMAp5h7dIAloYcKna2pUQlk+zWrsY2cYcJo
 PnVAv0X1syqS7UnFrHzImK4pnVFyn/UEKSuD7WZlDEAMrekydpihOC4/EQXzOCWKb+0H7XL
 ssUgENq/LR7jWJvjCA6SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gQ87Rfw1Gyw=:g80rNvg2+GH+lQL/E8d/bS
 mMbWlfmLTZNo471S/9DNwGC5kUpg/P4+dVNZ/nmnSzuL02vfbOrBZXehmFd4yYLNY3CrGL9Tb
 5DO9cb0KrJzoABoqbPoBUnALIEPm6Knw4Jcns1cvV1G3oVm6ypr/0JLnd8prrOKSi0iLn8nOv
 PcFTuI82/O+3f+vBdU68AUW32nFnjGRcoppMycvRa8AoTE7czp6moCAbddEeYPhinzL6Aksft
 QUGvxm6MSX4MwFFzx+zpu3oV6cHbEXTwyrQAAAgFlQiNuZ1W1hcgSBC2BWyqJM2uFNI00S05Y
 oqg3zJaMCJDpQo7DqNy/7mCG64Z7E8xLz3OCamp9bnfNmrU4M/p7Sl4fwuYdAlqM8rYLJmdBu
 2rFuK9a0W2PiP6iNAUmV6fseN+sGt4JxjPsw3O6Gqo+TOiaPXs4VRS/j0RO4wqB4mM1afTWqO
 4Tn3Cf+e7mVrZcCvqrU2NLUe32u8z5t9sBTTRcjfYz5d65KyXXYcQaeNph6qtaFqH/lND8yL4
 Z4HTvbH0ND79OXCf4//oVQ09tAds34t4wHTm7wCWFyaNxBTA8wPOvZfSPVofgPzEECqBCI74x
 Izf+KFh1A2yPa4rYLEo3S2Em6G1aHAIRssGvivXZ/u+0Y18Kdy9V1MyreYRNiPIgEvvYkk9Zd
 h0FUMV7ADeoJxUWN55W3eoJYD8D6vbryvu7xoPSfjMEMm43+Sbo7owuVQ/Q2WOHR6oMDzt/pN
 LjLLJoVyLAwmqvE5d+xEKnc9o5baE+tqF1NPdSYXi/WAju9ioQlmMJ/DvvI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287524>

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

This patch considers the source code comment that says to be
"not sure we want 'next' at the UI level anymore", and replies with
"Yes, we want it!". Therefore, the "git bisect next" functionality
is explicitly motivated and documented.

The motivation of "having no good commit" is not made up. I am
working on a big project that is several years old and nearly
no test exists. So I add a test and things go wrong. However,
I know from using (an older version of) the project that a similar
case did work. So...I want to find the bad commit...
However, to make git bisect work, I always first had to find a good
commit, so I ended up doing the whole bisection process manually
(because I did not know that "git bisect next" existed).

I think that this change will help people who are also in these
situations.

 Documentation/git-bisect.txt | 25 +++++++++++++++++++++++++
 git-bisect.sh                | 15 ++++-----------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 7e79aae..8045e6d 100644
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
 
@@ -353,6 +363,21 @@ rewind the tree to the pristine state.  Finally the script should exit
 with the status of the real test to let the `git bisect run` command loop
 determine the eventual outcome of the bisect session.
 
+Bisect next
+~~~~~~~~~~~
+
+Sometimes it can be necessary to check out other branches during a bisect
+session. If you want to check out the next commit of the bisection again,
+simply issue the command:
+
+------------
+$ git bisect next
+------------
+
+Another typical use case of this command is when you have marked a commit
+as bad but you do not know a good commit. Instead of crawling through the
+history yourself, let this command check out a commit for you.
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
2.7.1.354.gd492730.dirty
