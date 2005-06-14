From: James Purser <purserj@winnsw.com.au>
Subject: [PATCH] Adding Correct Useage Notification and -h Help flag
Date: Tue, 14 Jun 2005 11:47:22 +1000
Message-ID: <1118713641.8712.10.camel@localhost.localdomain>
Reply-To: purserj@winnsw.com.au
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-1Et/FNabxvo/wJUxW073"
X-From: git-owner@vger.kernel.org Tue Jun 14 03:44:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di0Sf-0004VW-Kp
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 03:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVFNBsH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 21:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVFNBsH
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 21:48:07 -0400
Received: from [210.9.57.141] ([210.9.57.141]:44701 "EHLO mail.winnsw.com.au")
	by vger.kernel.org with ESMTP id S261308AbVFNBri (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2005 21:47:38 -0400
Received: from RICOHPHOTO ([156.43.201.143])
        by mail.winnsw.com.au (WIN Server 1) with ESMTP id CPJ38469
        for <git@vger.kernel.org>; Tue, 14 Jun 2005 11:46:45 +1000
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Ximian Evolution 1.4.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-1Et/FNabxvo/wJUxW073
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

okay this is my first patch so take it easy on me.

I have added both a Correct Useage notification when git is called on
its own without any other parameters and a -h help flag which lists
available scripts for the git command.

Signed-off-by: James Purser <purserj@k-sit.com>


-- 
James Purser
Winnet Developer
+61 2 4223 4131
http://www.winnet.com.au

--=-1Et/FNabxvo/wJUxW073
Content-Disposition: attachment; filename=git_patch
Content-Type: text/plain; name=git_patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Added a couple of lines to the git wrapper. Includes Correct Useage and available scripts

---
commit bfe72d41d70f9e4c0a6ab0ec6cf49347f980f4de
tree a8eed80ea2ac00ffee0b4f12ed4c931ca7761000
parent 940c1bb0181cb20454bf3573134175f86983a0ce
author James Purser <purserj@k-sit.com> Tue, 14 Jun 2005 11:40:20 +1000
committer James Purser <purserj@k-sit.com> Tue, 14 Jun 2005 11:40:20 +1000

 git |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/git b/git
--- a/git
+++ b/git
@@ -1,4 +1,29 @@
 #!/bin/sh
-cmd="git-$1-script"
-shift
-exec $cmd "$@"
+if [ "$1" = "" ]
+then
+	echo "Correct Useage: git [-h] [SCRIPT]";
+else 
+	if [ "$1" = "-h" ]
+	then
+		echo "This is a basic script wrapper for certain git functions. The available commands are:
+
+git apply-patch
+git commit
+git cvsimport
+git deltafy
+git diff
+git fetch
+git log
+git merge-one-file
+git prune
+git pull
+git status
+git tag
+";	
+	else
+		cmd="git-$1-script";
+		shift;
+		exec $cmd "$@";
+	fi
+fi
+

--=-1Et/FNabxvo/wJUxW073--

