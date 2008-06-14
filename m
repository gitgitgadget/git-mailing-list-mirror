From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Add SVN->Git conversion example to documentation
Date: Sat, 14 Jun 2008 21:09:29 +0300
Message-ID: <20080614180929.GA26449@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 20:10:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7aDD-0006PM-7f
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 20:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbYFNSJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbYFNSJb
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:09:31 -0400
Received: from zakalwe.fi ([80.83.5.154]:38681 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533AbYFNSJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:09:30 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 8B2E12BBF3; Sat, 14 Jun 2008 21:09:29 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85026>

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
This is a correction to the earlier patch that had a typo.

 Documentation/git-svn.txt |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f4cbd2f..dcf1e25 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -11,9 +11,12 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-git-svn is a simple conduit for changesets between Subversion and git.
-It is not to be confused with linkgit:git-svnimport[1], which is
-read-only.
+git-svn is a simple bidirectional conduit for changesets between
+Subversion and git. It is used to develop projects with Git tools,
+but commit changes to a Subversion repository. It can also be used to
+convert a Subversion repository to a Git repository. It should not
+be confused with linkgit:git-svnimport[1], which does Subversion to
+Git conversion, but not the other direction.
 
 git-svn was originally designed for an individual developer who wants a
 bidirectional flow of changesets between a single branch in Subversion
@@ -520,6 +523,26 @@ have each person clone that repository with 'git clone':
 	git-svn rebase
 ------------------------------------------------------------------------
 
+CONVERTING A SUBVERSION REPOSITORY TO A GIT REPOSITORY
+------------------------------------------------------
+
+When converting a Subversion repository to a Git repository
+--no-metadata removes "git-svn-id:" comments from the log.
+-A option is used to convert SVN pseudonyms to real names
+and email addresses. The whole repository, or a part of it can be
+converted. Two examples below show how to convert the whole repo
+with all branches, or only the SVN trunk.
+
+------------------------------------------------------------------------
+# Convert all branches of an SVN repository to a Git repository:
+
+	git svn clone --no-metadata -A authors.txt SVN_URL foo.git
+
+# Convert only the trunk of an SVN repository to a Git repository:
+
+	git svn clone --no-metadata -A authors.txt SVN_URL/trunk foo.git
+------------------------------------------------------------------------
+
 REBASE VS. PULL/MERGE
 ---------------------
 
-- 
1.5.5.1.1.ga5e5c
