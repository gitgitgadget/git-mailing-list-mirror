From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2 v3] push: better error message when no remote configured
Date: Wed,  2 Mar 2011 21:12:11 +0100
Message-ID: <1299096731-14194-2-git-send-email-Matthieu.Moy@imag.fr>
References: <7vhbbmellx.fsf@alter.siamese.dyndns.org>
 <1299096731-14194-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 02 21:13:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PusPt-0000Kc-Bi
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 21:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab1CBUMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 15:12:55 -0500
Received: from mx1.imag.fr ([129.88.30.5]:57328 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754106Ab1CBUMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 15:12:55 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p22KCMJk014227
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 2 Mar 2011 21:12:22 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PusPH-0004N6-Sq; Wed, 02 Mar 2011 21:12:23 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1PusPH-0003hm-Rl; Wed, 02 Mar 2011 21:12:23 +0100
X-Mailer: git-send-email 1.7.4.1.176.g6b069.dirty
In-Reply-To: <1299096731-14194-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Mar 2011 21:12:22 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p22KCMJk014227
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1299701544.23051@5wS5sLjhSkbK1+zm2kOhnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168337>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
No change since v2

 builtin/push.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 1b493fb..c3c2feb 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -157,7 +157,14 @@ static int do_push(const char *repo, int flags)
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
1.7.4.1.176.g6b069.dirty
