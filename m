From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] push: mention "git pull" in error message for non-fast forwards
Date: Mon,  2 Aug 2010 15:42:44 +0200
Message-ID: <1280756564-3932-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 02 15:47:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfvMU-0008QM-Kq
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 15:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079Ab0HBNrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 09:47:20 -0400
Received: from imag.imag.fr ([129.88.30.1]:52383 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555Ab0HBNrU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 09:47:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o72Dgn89005348
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Aug 2010 15:42:50 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OfvI1-0006tV-Q6; Mon, 02 Aug 2010 15:42:49 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OfvI1-00012q-OG; Mon, 02 Aug 2010 15:42:49 +0200
X-Mailer: git-send-email 1.7.2.1.28.g41d92
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 02 Aug 2010 15:42:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152410>

The message remains fuzzy to include "git pull", "git pull --rebase" and
others, but directs the user to the simplest solution in the vast
majority of cases.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
When the message was added, it was decided explicitely not to say
explicitely "use git pull", first because there are other ways to
merge, and then to encourage the users to read the docs.

After a few months of teaching newbies/students to use Git, the
question "it doesn't want to push, what shall I do" still comes in the
top questions asked. Each time I've been asked, the newbie's face was
enlightened by hearing just the word "pull".

So I guess those few extra characters in the error message would save
me a lot of time ;-).

 builtin/push.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index f4358b9..69bc2f2 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -130,8 +130,8 @@ static int push_with_options(struct transport *transport, int flags)
 
 	if (nonfastforward && advice_push_nonfastforward) {
 		fprintf(stderr, "To prevent you from losing history, non-fast-forward updates were rejected\n"
-				"Merge the remote changes before pushing again.  See the 'Note about\n"
-				"fast-forwards' section of 'git push --help' for details.\n");
+				"Merge the remote changes (e.g. 'git pull') before pushing again.  See the\n"
+				"'Note about fast-forwards' section of 'git push --help' for details.\n");
 	}
 
 	return 1;
-- 
1.7.2.1.28.g41d92
