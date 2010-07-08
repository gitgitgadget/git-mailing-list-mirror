From: Eli Barzilay <eli@barzilay.org>
Subject: [PATCH] Reorganize `git-log' man page to clarify common diff options.
Date: Wed, 7 Jul 2010 22:14:31 -0400
Message-ID: <19509.13447.589906.225601@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 04:14:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWgdK-0001SQ-Jr
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 04:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936Ab0GHCOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 22:14:33 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:39022 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab0GHCOc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 22:14:32 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OWgdD-0006GB-JM; Wed, 07 Jul 2010 22:14:31 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150526>

This will reduce considerably the common confusion where people miss the
`--follow' option, and wonder why `-M'/`-C' is not working.

* Move the diff options include to after the log-specific flags, and add
  a "Common diff options" subtitle before them.  (These options apply
  only when patches are shown, which is not a common use case among
  newbies, so having them first is confusing.)

* Move the `--follow' description to the top of the listed options.  The
  options before that seem less important: `--full-diff' applies only
  when patches are shown, `--source' and `--decorate' are less useful
  with many common commit specifications.

* Clarify that `--follow' works only for a single path argument.

Signed-off-by: Eli Barzilay <eli@barzilay.org>
---

This is a resend of a patch I sent about two months ago.  It seems
that there was agreement that it is useful -- but it seems that it got
lost in the noise.

 Documentation/git-log.txt |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0e6ff31..c925d36 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -23,9 +23,6 @@ each commit introduces are shown.
 OPTIONS
 -------
 
-:git-log: 1
-include::diff-options.txt[]
-
 -<n>::
 	Limits the number of commits to show.
 
@@ -37,6 +34,10 @@ include::diff-options.txt[]
 	and <until>, see "SPECIFYING REVISIONS" section in
 	linkgit:git-rev-parse[1].
 
+--follow::
+	Continue listing the history of a file beyond renames
+	(works only for a single file).
+
 --no-decorate::
 --decorate[=short|full|no]::
 	Print out the ref names of any commits that are shown. If 'short' is
@@ -56,9 +57,6 @@ include::diff-options.txt[]
 	the specified paths; this means that "<path>..." limits only
 	commits, and doesn't limit diff for those commits.
 
---follow::
-	Continue listing the history of a file beyond renames/copies.
-
 --log-size::
 	Before the log message print out its size in bytes. Intended
 	mainly for porcelain tools consumption. If git is unable to
@@ -72,6 +70,11 @@ include::diff-options.txt[]
 	to be prefixed with "\-- " to separate them from options or
 	refnames.
 
+Common diff options
+~~~~~~~~~~~~~~~~~~~
+
+:git-log: 1
+include::diff-options.txt[]
 
 include::rev-list-options.txt[]
 
-- 
1.7.1
