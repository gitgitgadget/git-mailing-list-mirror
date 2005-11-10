From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix confusing git-update-ref error message
Date: Thu, 10 Nov 2005 20:55:13 +0100
Message-ID: <20051110195513.25573.31064.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 20:57:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaIW0-0005u2-1e
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVKJTzR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVKJTzR
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:55:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:35727 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751172AbVKJTzP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 14:55:15 -0500
Received: (qmail 25591 invoked from network); 10 Nov 2005 20:55:13 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 10 Nov 2005 20:55:13 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11516>

When git-update-ref has hit the "Ref %s changed to %s" error, I just stare
at it, left puzzled. This patch attempts to reword that to a more useful
and less confusing error message.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 update-ref.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/update-ref.c b/update-ref.c
index 65dc3d6..d79dc52 100644
--- a/update-ref.c
+++ b/update-ref.c
@@ -42,7 +42,7 @@ int main(int argc, char **argv)
 
 	if (oldval) {
 		if (memcmp(currsha1, oldsha1, 20))
-			die("Ref %s changed to %s", refname, sha1_to_hex(currsha1));
+			die("Ref %s is at %s but expected %s", refname, sha1_to_hex(currsha1), sha1_to_hex(oldsha1));
 		/* Nothing to do? */
 		if (!memcmp(oldsha1, sha1, 20))
 			exit(0);
