From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2 v2] push: better error message when no remote configured
Date: Tue,  1 Mar 2011 10:11:02 +0100
Message-ID: <1298970662-25828-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1298927645-2716-1-git-send-email-Matthieu.Moy@imag.fr>
 <1298970662-25828-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 10:15:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuLgB-0008Eg-L6
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 10:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab1CAJPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 04:15:32 -0500
Received: from imag.imag.fr ([129.88.30.1]:54636 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313Ab1CAJPb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 04:15:31 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p219BE6G023139
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Mar 2011 10:11:14 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PuLbu-0007rN-8h; Tue, 01 Mar 2011 10:11:14 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1PuLbu-0006jW-7d; Tue, 01 Mar 2011 10:11:14 +0100
X-Mailer: git-send-email 1.7.4.1.142.ge03e1
In-Reply-To: <1298970662-25828-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 01 Mar 2011 10:11:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168196>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
"No configured push destination." (Jay Soffian) and reword.

 builtin/push.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index c949187..b4fba7a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -156,7 +156,14 @@ static int do_push(const char *repo, int flags)
 	if (!remote) {
 		if (repo)
 			die("bad repository '%s'", repo);
-		die("No destination configured to push to.");
+		die("No configured push destination.\n"
+		    "Either specify the URL from the command-line or configure a remote repository using\n"
+		    "\n"
+		    "    git remote add <name> <url>\n"
+		    "\n"
+		    "and then push using the remote name\n"
+		    "\n"
+		    "    git push <name>\n");
 	}
 
 	if (remote->mirror)
-- 
1.7.4.1.142.ge03e1
