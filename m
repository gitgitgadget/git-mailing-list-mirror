From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation/git-filter-branch: add a new commit-filter
	example
Date: Sat, 23 Feb 2008 20:30:58 +0100
Message-ID: <20080223193058.GE31441@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 20:32:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT06F-0003FP-24
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 20:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760605AbYBWTbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 14:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760622AbYBWTbN
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 14:31:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37695 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbYBWTbM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 14:31:12 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JT05Q-0007F3-0w
	from <vmiklos@frugalware.org>; Sat, 23 Feb 2008 20:31:10 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2FDA811901F5; Sat, 23 Feb 2008 20:30:58 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.5 required=5.9 tests=BAYES_40 autolearn=no SpamAssassin version=3.2.3
	0.5 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.3581]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74842>

There is a commit-filter example already which skips commits but there is no
example on how to edit commit messages.

One can figure out this example by carefully reading the git-filter-branch and
git-commit-tree documentation but I think it isn't trivial so this example is
helpful.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

The lack of such an example was noticed by dvorak on IRC.

 Documentation/git-filter-branch.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index e22dfa5..a035b9c 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -240,6 +240,12 @@ committed a merge between P1 and P2, it will be propagated properly
 and all children of the merge will become merge commits with P1,P2
 as their parents instead of the merge commit.
 
+To remove the 'git-svn-id' strings from commit messages in a repository created
+by git-svn:
+
+------------------------------------------------------------------------------
+git filter-branch --commit-filter 'sed "/^git-svn-id:/d" |git commit-tree "$@"'
+------------------------------------------------------------------------------
 
 To restrict rewriting to only part of the history, specify a revision
 range in addition to the new branch name.  The new branch name will
-- 
1.5.4.2
