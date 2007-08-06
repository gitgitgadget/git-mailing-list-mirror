From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 4/5] documentation: use the word "index" in the git-add manual page
Date: Mon,  6 Aug 2007 00:34:01 -0400
Message-ID: <6125.06629336185$1186374888@news.gmane.org>
References: 20070805222527.GB12168@fieldses.org
 <11863748422001-git-send-email->
 <1186374842108-git-send-email->
 <11863748422754-git-send-email->
 <11863748423686-git-send-email->
Cc: git@vger.kernel.org,
	"J. Bruce Fields" <bfields@pig.linuxdev.us.dell.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 06 06:34:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHuIm-00086f-Un
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 06:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbXHFEe3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 00:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbXHFEe2
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 00:34:28 -0400
Received: from mail.fieldses.org ([66.93.2.214]:38247 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbXHFEeY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 00:34:24 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IHuI6-0001mQ-Ug; Mon, 06 Aug 2007 00:34:02 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: <11863748423686-git-send-email->
Message-Id: <5f42ac921fe06bbb80df82d8fa5cb15701ec2f60.1186373089.git.bfields@pig.linuxdev.us.dell.com>
In-Reply-To: <0eb4f7cdf85273c88feb95c677a808cee9cfd859.1186373089.git.bfields@pig.linuxdev.us.dell.com>
References: <0eb4f7cdf85273c88feb95c677a808cee9cfd859.1186373089.git.bfields@pig.linuxdev.us.dell.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55109>

From: J. Bruce Fields <bfields@pig.linuxdev.us.dell.com>

It was a neat trick to show that you could introduce the git-add manual
page without using the word "index", and it was certainly an improvement
over the previous man page (which started out "A simple wrapper for
git-update-index to add files to the index...").

But it's possible to use the standard terminology without sacrificing
user-friendliness.  So, rewrite to use the word "index" when
appropriate.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/git-add.txt |   41 ++++++++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index a0c9f68..37077b5 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -3,7 +3,7 @@ git-add(1)
 
 NAME
 ----
-git-add - Add file contents to the changeset to be committed next
+git-add - Add file contents to the index
 
 SYNOPSIS
 --------
@@ -11,24 +11,27 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-All the changed file contents to be committed together in a single set
-of changes must be "added" with the 'add' command before using the
-'commit' command.  This is not only for adding new files.  Even modified
-files must be added to the set of changes about to be committed.
-
-This command can be performed multiple times before a commit. The added
-content corresponds to the state of specified file(s) at the time the
-'add' command is used. This means the 'commit' command will not consider
-subsequent changes to already added content if it is not added again before
-the commit.
-
-The 'git status' command can be used to obtain a summary of what is included
-for the next commit.
-
-This command can be used to add ignored files with `-f` (force)
-option, but they have to be
-explicitly and exactly specified from the command line.  File globbing
-and recursive behaviour do not add ignored files.
+This command adds the current content of new or modified files to the
+index, thus staging that content for inclusion in the next commit.
+
+The "index" holds a snapshot of the content of the working tree, and it
+is this snapshot that is taken as the contents of the next commit.  Thus
+after making any changes to the working directory, and before running
+the commit command, you must use the 'add' command to add any new or
+modified files to the index.
+
+This command can be performed multiple times before a commit.  It only
+adds the content of the specified file(s) at the time the add command is
+run; if you want subsequent changes included in the next commit, then
+you must run 'git add' again to add the new content to the index.
+
+The 'git status' command can be used to obtain a summary of which
+files have changes that are staged for the next commit.
+
+The 'add' command can be used to add ignored files with `-f` (force)
+option, but they have to be explicitly and exactly specified from the
+command line.  File globbing and recursive behaviour do not add ignored
+files.
 
 Please see gitlink:git-commit[1] for alternative ways to add content to a
 commit.
-- 
1.5.3.GIT
