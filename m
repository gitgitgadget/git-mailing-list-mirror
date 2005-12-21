From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add suggestion to hard-to-understand error message
Date: Thu, 22 Dec 2005 00:49:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512220048360.13453@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Dec 22 00:49:23 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpDhx-0001An-Tl
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 00:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVLUXtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 18:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVLUXtF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 18:49:05 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56501 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964999AbVLUXtD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 18:49:03 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 92E9313FC80; Thu, 22 Dec 2005 00:49:02 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 79B439E2B4; Thu, 22 Dec 2005 00:49:02 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 657BD9E231; Thu, 22 Dec 2005 00:49:02 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 513D913FC80; Thu, 22 Dec 2005 00:49:02 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13920>


Dummies like me do not understand readily that "remote object abcdef...
does not exist on local" means: "Hey, you did not pull this, did you?".
So, add "(pull first?)" to that message.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Wow, my commit messages get longer, while the patches get shorter.
	Odd.

 send-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

af2d86726fe961043d0c69c4fb727689a5903b63
diff --git a/send-pack.c b/send-pack.c
index 5bc2f01..643662a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -233,7 +233,7 @@ static int send_pack(int in, int out, in
 		    !ref->force) {
 			if (!has_sha1_file(ref->old_sha1)) {
 				error("remote '%s' object %s does not "
-				      "exist on local",
+				      "exist on local (pull first?)",
 				      ref->name, sha1_to_hex(ref->old_sha1));
 				ret = -2;
 				continue;
-- 
0.99.9.GIT
