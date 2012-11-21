From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH 2/4] Recommend use of structure options for git svn.
Date: Wed, 21 Nov 2012 08:13:51 +0100
Message-ID: <a4de87e8d09c26221eff116c3209b0a3606dfc21.1353691892.git.Sebastian.Leske@sleske.name>
References: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name>
Cc: "Eric Wong" <normalperson@yhbt.net>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Nov 25 11:36:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcZZC-0007DS-89
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 11:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab2KYKfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 05:35:42 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:37803 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab2KYKfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 05:35:40 -0500
Received: from iota.localnet (p4FD44AFD.dip.t-dialin.net [79.212.74.253])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id AC64F1F5459D;
	Sun, 25 Nov 2012 11:35:09 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1TcZYb-0005uy-Kj; Sun, 25 Nov 2012 11:35:25 +0100
In-Reply-To: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210352>

Document that when using git svn, one should usually either use the
directory structure options to import branches as branches, or only
import one subdirectory. The default behaviour of cloning all branches
and tags as subdirectories in the working copy is usually not what the
user wants.

Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
---
 Documentation/git-svn.txt |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 482d60d..928a961 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -871,6 +871,16 @@ already dcommitted.  It is considered bad practice to --amend commits
 you've already pushed to a remote repository for other users, and
 dcommit with SVN is analogous to that.
 
+When cloning an SVN repository, if none of the options for describing
+the repository layout is used (--trunk, --tags, --branches,
+--stdlayout), 'git svn clone' will create a git repository with
+completely linear history, where branches and tags appear as separate
+folders in the working copy.  For projects with many branches this will
+lead to a working copy many times larger than just the trunk.  It is
+recommended to either use the the options for trunk / tag / branch
+directory, or to only clone the trunk (or a subdirectory of the
+trunk).
+
 When using multiple --branches or --tags, 'git svn' does not automatically
 handle name collisions (for example, if two branches from different paths have
 the same name, or if a branch and a tag have the same name).  In these cases,
-- 
1.7.10.4
