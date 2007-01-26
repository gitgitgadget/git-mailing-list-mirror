From: rael@zopyra.com
Subject: [PATCH] Document check option to git diff.
Date: Fri, 26 Jan 2007 11:42:52 -0600
Message-ID: <1169833372823-git-send-email-rael@zopyra.com>
Cc: Bill Lear <rael@zopyra.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 18:42:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAV6H-00068a-Pn
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 18:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbXAZRmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 12:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbXAZRmz
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 12:42:55 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60788 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161066AbXAZRmy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 12:42:54 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0QHgq004346;
	Fri, 26 Jan 2007 11:42:52 -0600
X-Mailer: git-send-email 1.4.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37878>

From: Bill Lear <rael@zopyra.com>


Signed-off-by: Bill Lear <rael@zopyra.com>
---
 Documentation/SubmittingPatches |    3 ++-
 Documentation/diff-options.txt  |    5 +++++
 Documentation/git-diff.txt      |    6 ++++++
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 41b76d8..ce85d06 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -23,7 +23,8 @@ probably need to split up your commit to finer grained pieces.
 
 Oh, another thing.  I am picky about whitespaces.  Make sure your
 changes do not trigger errors with the sample pre-commit hook shipped
-in templates/hooks--pre-commit.
+in templates/hooks--pre-commit.  To help ensure this does not happen,
+run git diff --check on your changes before you commit.
 
 
 (2) Generate your patch using git tools out of your commits.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index da1cc60..501e0df 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -58,6 +58,11 @@
 	Turn off rename detection, even when the configuration
 	file gives the default to do so.
 
+--check::
+	Check whether differences form a valid patch.  Warns if
+	differences include a space before a tab or a space at the end
+	of a line.
+
 --full-index::
 	Instead of the first handful characters, show full
 	object name of pre- and post-image blob on the "index"
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 6a098df..5054fb7 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -70,6 +70,7 @@ Various ways to check your working tree::
 $ git diff            <1>
 $ git diff --cached   <2>
 $ git diff HEAD       <3>
+$ git diff --check    <4>
 ------------
 +
 <1> changes in the working tree not yet staged for the next commit.
@@ -77,6 +78,11 @@ $ git diff HEAD       <3>
 would be committing if you run "git commit" without "-a" option.
 <3> changes in the working tree since your last commit; what you
 would be committing if you run "git commit -a"
+<4> display whether what you are about to commit is a valid patch,
+including whether you have spaces at the end of lines, or spaces
+before tabs.  Violations are displayed in this form:
+
+<file name>:<line number>:<violation>:<offending line>
 
 Comparing with arbitrary commits::
 +
-- 
1.5.0-rc2.GIT-dirty
