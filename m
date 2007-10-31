From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-diff.txt: add section "output format" describing the diff formats
Date: Wed, 31 Oct 2007 13:59:16 +0000
Message-ID: <20071031135916.5625.qmail@134c5e95d8ec4d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 14:59:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InE6B-0003y8-IQ
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 14:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbXJaN65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 09:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbXJaN65
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 09:58:57 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:33938 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753002AbXJaN64 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 09:58:56 -0400
Received: (qmail 5626 invoked by uid 1000); 31 Oct 2007 13:59:16 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62831>

git-diff.txt includes diff-options.txt which for the -p option refers
to a section "generating patches.." which is missing from the git-diff
documentation.  This patch adapts diff-format.txt to additionally
mention the git-diff program, and includes diff-format.txt into
git-diff.txt.

Tino Keitel noticed this problem.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/diff-format.txt |   22 +++++++++++-----------
 Documentation/git-diff.txt    |    3 +++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 0015032..a580f18 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -1,5 +1,5 @@
-The output format from "git-diff-index", "git-diff-tree" and
-"git-diff-files" are very similar.
+The output format from "git-diff-index", "git-diff-tree",
+"git-diff-files" and "git diff --raw" are very similar.
 
 These commands all compare two sets of things; what is
 compared differs:
@@ -62,9 +62,9 @@ respectively.
 diff format for merges
 ----------------------
 
-"git-diff-tree" and "git-diff-files" can take '-c' or '--cc' option
-to generate diff output also for merge commits.  The output differs
-from the format described above in the following way:
+"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
+'--cc' option to generate diff output also for merge commits.  The
+output differs from the format described above in the following way:
 
 . there is a colon for each parent
 . there are more "src" modes and "src" sha1
@@ -86,10 +86,10 @@ Generating patches with -p
 --------------------------
 
 When "git-diff-index", "git-diff-tree", or "git-diff-files" are run
-with a '-p' option, they do not produce the output described above;
-instead they produce a patch file.  You can customize the creation
-of such patches via the GIT_EXTERNAL_DIFF and the GIT_DIFF_OPTS
-environment variables.
+with a '-p' option, or "git diff" without the '--raw' option, they
+do not produce the output described above; instead they produce a
+patch file.  You can customize the creation of such patches via the
+GIT_EXTERNAL_DIFF and the GIT_DIFF_OPTS environment variables.
 
 What the -p option produces is slightly different from the traditional
 diff format.
@@ -137,8 +137,8 @@ file made it into the new one.
 combined diff format
 --------------------
 
-git-diff-tree and git-diff-files can take '-c' or '--cc' option
-to produce 'combined diff', which looks like this:
+"git-diff-tree", "git-diff-files" and "git-diff" can take '-c' or
+'--cc' option to produce 'combined diff', which looks like this:
 
 ------------
 diff --combined describe.c
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index ce0f502..11c4216 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -82,6 +82,9 @@ include::diff-options.txt[]
 	the diff to the named paths (you can give directory
 	names and get diff for all files under them).
 
+Output format
+-------------
+include::diff-format.txt[]
 
 EXAMPLES
 --------
-- 
1.5.3.4
