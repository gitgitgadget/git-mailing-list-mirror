From: Jeff King <peff@peff.net>
Subject: [PATCH] git-status: documentation improvements
Date: Sat, 8 Dec 2007 04:00:31 -0500
Message-ID: <20071208090030.GA5850@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 10:00:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0vYN-0008DB-Cj
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 10:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958AbXLHJAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 04:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbXLHJAe
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 04:00:34 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4623 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824AbXLHJAd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 04:00:33 -0500
Received: (qmail 17706 invoked by uid 111); 8 Dec 2007 09:00:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 08 Dec 2007 04:00:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Dec 2007 04:00:31 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67533>

This patch is the result of reading over git-status with an
editorial eye:

  - fix a few typo/grammatical errors
  - mention untracked output
  - present output types in the order they appear from the
    command

Signed-off-by: Jeff King <peff@peff.net>
---
This is on top of the documentation patch I sent a few minutes ago.

 Documentation/git-status.txt |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 645dc85..a1bb9bd 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -12,21 +12,22 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Examines paths in the working tree that has changes unrecorded
-to the index file, and changes between the index file and the
-current HEAD commit.  The former paths are what you _could_
-commit by running 'git add' before running 'git
-commit', and the latter paths are what you _would_ commit by
-running 'git commit'.
-
-If there is no path that is different between the index file and
-the current HEAD commit, the command exits with non-zero
-status.
+Displays paths that have differences between the index file and the
+current HEAD commit, paths that have differences between the working
+tree and the index file, and paths in the working tree that are not
+tracked by git (and are not ignored by gitlink:gitignore[5]). The first
+are what you _would_ commit by running `git commit`; the second and
+third are what you _could_ commit by running `git add` before running
+`git commit`.
 
 The command takes the same set of options as `git-commit`; it
 shows what would be committed if the same options are given to
 `git-commit`.
 
+If there is no path that is different between the index file and
+the current HEAD commit (i.e., there is nothing to commit by running
+`git-commit`), the command exits with non-zero status.
+
 If any paths have been touched in the working tree (that is,
 their modification times have changed) but their contents and
 permissions are identical to those in the index file, the command
@@ -38,10 +39,10 @@ contains many paths that have been touched but not modified.
 OUTPUT
 ------
 The output from this command is designed to be used as a commit
-template comments, and all the output lines are prefixed with '#'.
+template comment, and all the output lines are prefixed with '#'.
 
 The paths mentioned in the output, unlike many other git commands, are
-made relative to the current directory, if you are working in a
+made relative to the current directory if you are working in a
 subdirectory (this is on purpose, to help cutting and pasting). See
 the status.relativePaths config option below.
 
-- 
1.5.3.7.2187.gb646
