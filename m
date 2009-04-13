From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] doc: refer to tracking configuration as "upstream"
Date: Mon, 13 Apr 2009 07:11:56 -0400
Message-ID: <20090413111156.GB15982@coredump.intra.peff.net>
References: <20090413110947.GA15647@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 13:13:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtK6V-0007iP-2m
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 13:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbZDMLL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 07:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753687AbZDMLL5
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 07:11:57 -0400
Received: from peff.net ([208.65.91.99]:43856 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462AbZDMLL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 07:11:57 -0400
Received: (qmail 31724 invoked by uid 107); 13 Apr 2009 11:12:00 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Apr 2009 07:12:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Apr 2009 07:11:56 -0400
Content-Disposition: inline
In-Reply-To: <20090413110947.GA15647@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116428>

The term "tracking" often creates confusion between remote
tracking branches and local branches which track a remote
branch. The term "upstream" captures more clearly the idea
of "branch A is based on branch B in some way", so it makes
sense to mention it.

At the same time, upstream branches are used for more
than just git-pull these days; let's mention that here.

Signed-off-by: Jeff King <peff@peff.net>
---
I think this matches nicely with Santi's recent addition of upstream to
the glossary.

 Documentation/git-branch.txt   |   24 +++++++++++++-----------
 Documentation/git-checkout.txt |    2 +-
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 19f1b0d..cbd4275 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -112,19 +112,21 @@ OPTIONS
 	Display the full sha1s in the output listing rather than abbreviating them.
 
 --track::
-	When creating a new branch, set up the configuration so that 'git-pull'
-	will automatically retrieve data from the start point, which must be
-	a branch. Use this if you always pull from the same upstream branch
-	into the new branch, and if you do not want to use "git pull
-	<repository> <refspec>" explicitly. This behavior is the default
-	when the start point is a remote branch. Set the
-	branch.autosetupmerge configuration variable to `false` if you want
-	'git-checkout' and 'git-branch' to always behave as if '--no-track' were
-	given. Set it to `always` if you want this behavior when the
-	start-point is either a local or remote branch.
+	When creating a new branch, set up configuration to mark the
+	start-point branch as "upstream" from the new branch. This
+	configuration will tell git to show the relationship between the
+	two branches in `git status` and `git branch -v`. Furthermore,
+	it directs `git pull` without arguments to pull from the
+	upstream when the new branch is checked out.
++
+This behavior is the default when the start point is a remote branch.
+Set the branch.autosetupmerge configuration variable to `false` if you
+want `git checkout` and `git branch` to always behave as if '--no-track'
+were given. Set it to `always` if you want this behavior when the
+start-point is either a local or remote branch.
 
 --no-track::
-	Do not set up tracking configuration, even if the
+	Do not set up "upstream" configuration, even if the
 	branch.autosetupmerge configuration variable is true.
 
 --contains <commit>::
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4992fc6..16d3c87 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -90,7 +90,7 @@ guessing results in an empty name, the guessing is aborted.  You can
 explicitly give a name with '-b' in such a case.
 
 --no-track::
-	Do not set up tracking configuration, even if the
+	Do not set up "upstream" configuration, even if the
 	branch.autosetupmerge configuration variable is true.
 
 -l::
-- 
1.6.3.rc0.148.g141203.dirty
