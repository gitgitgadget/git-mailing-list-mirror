From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH] git: remove usage of xargs -r, a non-portable gnu extension
Date: Sat, 16 Jul 2005 19:18:35 -0400
Message-ID: <20050716231825.7315.30191.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 01:18:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtvvq-0007Db-Qr
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 01:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVGPXSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 19:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVGPXSs
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 19:18:48 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:2444 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261846AbVGPXSf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 19:18:35 -0400
Received: (qmail 59873 invoked from network); 16 Jul 2005 23:18:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=RmHWvV2swOerQlSW1xxIrV4fPS8f/DzXxGG2IUob8ZOaqZmPo7BnY0eqL9Z1UHJ5DZwwJVTNgpUum8Z94SR3LClcnPPxVa8KHv2eLiB5uJOGzQkD2XzevHJNx0vGsKxjY2izE1JRa3le0DblnnB/8iHS7/oP9uewFMJUnFBCUMo=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@65.93.75.85 with plain)
  by smtp102.mail.sc5.yahoo.com with SMTP; 16 Jul 2005 23:18:30 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Remove usage of xargs -r, a non-portable gnu extension.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 git-prune-script |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-prune-script b/git-prune-script
--- a/git-prune-script
+++ b/git-prune-script
@@ -20,6 +20,6 @@ sed -ne '/unreachable /{
     s|\(..\)|\1/|p
 }' | {
 	cd "$GIT_OBJECT_DIRECTORY" || exit
-	xargs -r $dryrun rm -f
+	xargs $dryrun rm -f ""
 }
 
