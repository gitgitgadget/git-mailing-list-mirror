From: sean <seanlkml@sympatico.ca>
Subject: [PATCH] Clarify git-cherry documentation.
Date: Fri, 5 May 2006 15:06:07 -0400
Message-ID: <BAYC1-PASMTP025E7E0DC9041B161452AAAEB50@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 05 21:11:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc5hj-0001yg-9N
	for gcvg-git@gmane.org; Fri, 05 May 2006 21:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWEETLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 15:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWEETLE
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 15:11:04 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:17650 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751206AbWEETLD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 15:11:03 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 5 May 2006 12:11:02 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id D9B98644C28
	for <git@vger.kernel.org>; Fri,  5 May 2006 15:11:01 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060505150607.0ba1c2f8.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 05 May 2006 19:11:03.0104 (UTC) FILETIME=[A6F39C00:01C67077]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>


---

 Documentation/git-cherry.txt |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

6978ad8b3935b8ce2c55da65b099c67a32ff94d0
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 9a5e371..893baaa 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -11,11 +11,20 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Each commit between the fork-point and <head> is examined, and compared against
-the change each commit between the fork-point and <upstream> introduces.
-Commits already included in upstream are prefixed with '-' (meaning "drop from
-my local pull"), while commits missing from upstream are prefixed with '+'
-(meaning "add to the updated upstream").
+The changeset (or "diff") of each commit between the fork-point and <head>
+is compared against each commit between the fork-point and <upstream>.
+
+Every commit with a changeset that doesn't exist in the other branch
+has its id (sha1) reported, prefixed by a symbol.  Those existing only
+in the <upstream> branch are prefixed with a minus (-) sign, and those
+that only exist in the <head> branch are prefixed with a plus (+) symbol.
+
+Because git-cherry compares the changeset rather than the commit id
+(sha1), you can use git-cherry to find out if a commit you made locally
+has been applied <upstream> under a different commit id.  For example,
+this will happen if you're feeding patches <upstream> via email rather
+than pushing or pulling commits directly.
+
 
 OPTIONS
 -------
-- 
1.3.1.g9c203
