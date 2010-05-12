From: Eli Barzilay <eli@barzilay.org>
Subject: [PATCH] Reorganize `git-log' man page to clarify common diff options.
Date: Wed, 12 May 2010 10:12:17 -0400
Message-ID: <1273673537-29300-1-git-send-email-eli@barzilay.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 12 16:12:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCCfg-0004Fg-Qo
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 16:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab0ELOMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 10:12:19 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:49168 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849Ab0ELOMS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 10:12:18 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OCCfZ-0007d3-5G; Wed, 12 May 2010 10:12:17 -0400
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146949>

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
 Documentation/git-log.txt |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 57aa574..7336364 100644
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
-	Continue listing the history of a file beyond renames.
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
