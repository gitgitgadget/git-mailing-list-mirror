From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 03/10] Change remote tracking to remote-tracking in non-trivial places
Date: Sat, 23 Oct 2010 18:31:14 +0200
Message-ID: <1287851481-27952-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 23 18:32:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9h1N-0005ip-Hq
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 18:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967Ab0JWQch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 12:32:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37889 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757934Ab0JWQcg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 12:32:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9NGGw5U005335
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 23 Oct 2010 18:16:58 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P9h0C-0006cK-5O; Sat, 23 Oct 2010 18:31:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1P9h0C-0007Hk-3R; Sat, 23 Oct 2010 18:31:28 +0200
X-Mailer: git-send-email 1.7.3.2.537.g7e355
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 23 Oct 2010 18:16:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9NGGw5U005335
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1288455420.44165@rRUMfzH2vYYKtSe4pAwfrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159794>

To complement the straightforward perl application in previous patch,
this adds a few manual changes.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/everyday.txt    |    6 +++---
 Documentation/git-gc.txt      |    6 +++---
 Documentation/gittutorial.txt |    4 ++--
 t/t5400-send-pack.sh          |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index e0ba8cc..ae413e5 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -180,12 +180,12 @@ directory; clone from it to start a repository on the satellite
 machine.
 <2> clone sets these configuration variables by default.
 It arranges `git pull` to fetch and store the branches of mothership
-machine to local `remotes/origin/*` tracking branches.
+machine to local `remotes/origin/*` remote-tracking branches.
 <3> arrange `git push` to push local `master` branch to
 `remotes/satellite/master` branch of the mothership machine.
 <4> push will stash our work away on `remotes/satellite/master`
-tracking branch on the mothership machine.  You could use this as
-a back-up method.
+remote-tracking branch on the mothership machine.  You could use this
+as a back-up method.
 <5> on mothership machine, merge the work done on the satellite
 machine into the master branch.
 
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 315f07e..801aede 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -89,7 +89,7 @@ are not part of the current project most users will want to expire
 them sooner.  This option defaults to '30 days'.
 
 The above two configuration variables can be given to a pattern.  For
-example, this sets non-default expiry values only to remote tracking
+example, this sets non-default expiry values only to remote-tracking
 branches:
 
 ------------
@@ -128,8 +128,8 @@ Notes
 
 'git gc' tries very hard to be safe about the garbage it collects. In
 particular, it will keep not only objects referenced by your current set
-of branches and tags, but also objects referenced by the index, remote
-tracking branches, refs saved by 'git filter-branch' in
+of branches and tags, but also objects referenced by the index,
+remote-tracking branches, refs saved by 'git filter-branch' in
 refs/original/, or reflogs (which may reference commits in branches
 that were later amended or rewound).
 
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index f1f4086..0982f74 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -402,8 +402,8 @@ could merge the changes into her master branch:
 alice$ git merge bob/master
 -------------------------------------
 
-This `merge` can also be done by 'pulling from her own remote
-tracking branch', like this:
+This `merge` can also be done by 'pulling from her own remote-tracking
+branch', like this:
 
 -------------------------------------
 alice$ git pull . remotes/bob/master
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 5bcf0b8..b0b2684 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -129,7 +129,7 @@ test_expect_success 'denyNonFastforwards trumps --force' '
 	test "$victim_orig" = "$victim_head"
 '
 
-test_expect_success 'push --all excludes remote tracking hierarchy' '
+test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	mkdir parent &&
 	(
 	    cd parent &&
-- 
1.7.3.2.537.g7e355
