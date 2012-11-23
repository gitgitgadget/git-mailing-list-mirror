From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: [PATCH 3/4] git-svn: Expand documentation for --follow-parent
Date: Fri, 23 Nov 2012 08:13:16 +0100
Message-ID: <a9748faec2a18231ad588c1a2dedb82e74685d74.1353691892.git.Sebastian.Leske@sleske.name>
References: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name>
Cc: "Eric Wong" <normalperson@yhbt.net>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Nov 25 11:35:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcZZ1-00075K-Mp
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 11:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab2KYKfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 05:35:36 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:37793 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab2KYKff (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 05:35:35 -0500
Received: from iota.localnet (p4FD44AFD.dip.t-dialin.net [79.212.74.253])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id 16DEC1F5459D;
	Sun, 25 Nov 2012 11:35:05 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <sebastian.leske@sleske.name>)
	id 1TcZYb-0005v0-MY; Sun, 25 Nov 2012 11:35:25 +0100
In-Reply-To: <b115a546fa783b4121d118bb8fdb9270443f90fa.1353691892.git.Sebastian.Leske@sleske.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210349>

Describe what the option --follow-parent does, and what happens if it is
set or unset.

Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
---
 Documentation/git-svn.txt |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 928a961..92780ef 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -628,11 +628,19 @@ ADVANCED OPTIONS
 	Default: "svn"
 
 --follow-parent::
+	This option is only relevant if we are tracking branches (using
+	one of the repository layout options --trunk, --tags,
+	--branches, --stdlayout). For each tracked branch, try to find
+	out where its revision was copied (i.e. branched) from, and set
+	a suitable parent in the first git commit for the branch.
 	This is especially helpful when we're tracking a directory
-	that has been moved around within the repository, or if we
-	started tracking a branch and never tracked the trunk it was
-	descended from. This feature is enabled by default, use
-	--no-follow-parent to disable it.
+	that has been moved around within the repository (note that you
+	must track both the old and the new name for the whole history
+	to be imported).  If this feature is disabled, the branches
+	created by 'git svn' will all be linaear and not share any
+	history, meaning that there will be no information on where
+	branches where branched off or merged. This feature is enabled
+	by default, use --no-follow-parent to disable it.
 +
 [verse]
 config key: svn.followparent
-- 
1.7.10.4
