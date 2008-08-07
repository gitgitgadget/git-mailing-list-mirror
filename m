From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: filter-branch: document how to filter all refs
Date: Thu,  7 Aug 2008 16:04:01 +0200
Message-ID: <1218117841-27398-1-git-send-email-trast@student.ethz.ch>
References: <200808070950.23754.trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 16:05:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR66s-0005gu-82
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 16:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbYHGODz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 10:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbYHGODz
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 10:03:55 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:49043 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbYHGODy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 10:03:54 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Aug 2008 16:03:53 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Aug 2008 16:03:52 +0200
X-Mailer: git-send-email 1.6.0.rc1.106.g98a7
In-Reply-To: <200808070950.23754.trast@student.ethz.ch>
X-OriginalArrivalTime: 07 Aug 2008 14:03:52.0861 (UTC) FILETIME=[6C7774D0:01C8F896]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91582>

Document the '--' option that can be used to pass rev-list options
(not just arguments), and give an example usage of '-- --all'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

[This went out to Jan and Junio already, but I forgot to CC the list.
Sorry.]

Somehow I'm imagining this is a FAQ.  Either way, I remember figuring
out this exact example by accident when I first needed it.

 Documentation/git-filter-branch.txt |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index a518ba6..1f0fcec 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	[--msg-filter <command>] [--commit-filter <command>]
 	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
 	[--original <namespace>] [-d <directory>] [-f | --force]
-	[<rev-list options>...]
+	[--] [<rev-list options>...]
 
 DESCRIPTION
 -----------
@@ -196,6 +196,17 @@ git filter-branch --index-filter 'git rm --cached filename' HEAD
 
 Now, you will get the rewritten history saved in HEAD.
 
+To rewrite the repository to look as if 'foodir/' had been its project
+root, and discard all other history:
+
+-------------------------------------------------------
+git filter-branch --subdirectory-filter foodir -- --all
+-------------------------------------------------------
+
+Thus you can, e.g., turn a library subdirectory into a repository of
+its own.  Note the '--' that separates 'filter-branch' options from
+revision options, and the '--all' to rewrite all branches and tags.
+
 To set a commit (which typically is at the tip of another
 history) to be the parent of the current initial commit, in
 order to paste the other history behind the current history:
-- 
1.6.0.rc1.106.g98a7
