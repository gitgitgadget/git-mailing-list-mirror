From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Note that '.' is a useful value for <repository> in git-pull.
Date: Mon, 31 Oct 2005 22:28:16 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0510312220230.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Nov 01 04:28:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWmpE-0006Kf-A1
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 04:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVKAD2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 22:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVKAD2h
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 22:28:37 -0500
Received: from iabervon.org ([66.92.72.58]:17164 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964967AbVKAD2h (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 22:28:37 -0500
Received: (qmail 24981 invoked by uid 1000); 31 Oct 2005 22:28:16 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Oct 2005 22:28:16 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10923>

Mention in the tutorial and in the documentation for git-pull that you can 
merge local branches with all the bells and whistles with 
"git pull . <branch>"

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

"git pull . <branch>" does, in fact, do exactly what I wanted, and, when 
the tutorial mentioned that you could do this, it didn't mention why you 
might want to.

 Documentation/git-pull.txt |    3 ++-
 Documentation/tutorial.txt |   12 ++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

applies-to: 8c8ace55eb085e930dcc9482f7cf66f9399374b4
0ba51e8c8298aff4256bd63289071f23b4d83db3
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index bae05de..fe0c18a 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Runs 'git-fetch' with the given parameters.
+Runs 'git-fetch' with the given parameters. This is effectively
+skipped if the repository is '.'
 
 When only one ref is downloaded, runs 'git resolve' to merge it
 into the local HEAD.  Otherwise uses 'git octopus' to merge them
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index b9f737e..78443a9 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -1027,8 +1027,16 @@ course, you will pay the price of more d
 multiple working trees, but disk space is cheap these days.
 
 [NOTE]
-You could even pull from your own repository by
-giving '.' as <remote-repository> parameter to `git pull`.
+
+One useful special case is
+
+	git pull . <branch-name>
+
+which does about the same thing as the `git resolve` calls for merging
+local branches, except that you don't have to type in the message or
+the side you're merging into (which is the branch that you have
+checked out).
+
 
 It is likely that you will be pulling from the same remote
 repository from time to time. As a short hand, you can store
---
0.99.8.GIT
