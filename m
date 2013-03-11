From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] add: update pathless 'add [-u|-A]' warning to reflect change of plan
Date: Mon, 11 Mar 2013 09:01:32 +0100
Message-ID: <1362988893-27539-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqk3pefjs4.fsf@grenoble-inp.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 11 09:02:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UExge-0000s6-1P
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 09:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646Ab3CKIBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 04:01:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38893 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994Ab3CKIBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 04:01:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2B81ZKO005821
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Mar 2013 09:01:35 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UExfr-0004zV-OS; Mon, 11 Mar 2013 09:01:35 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UExfr-0007Ay-Ju; Mon, 11 Mar 2013 09:01:35 +0100
X-Mailer: git-send-email 1.8.2.rc3.16.g0a33571.dirty
In-Reply-To: <vpqk3pefjs4.fsf@grenoble-inp.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Mar 2013 09:01:35 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2B81ZKO005821
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1363593698.70336@mg1pNtQJi/uPMQg3GpCDew
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217859>

We originally thought the transition would need a period where "git add
[-u|-A]" without pathspec would be forbidden, but the warning is big
enough to scare people and teach them not to use it (or, if so, to
understand the consequences).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/add.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 0dd014e..ab1c9e8 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -328,9 +328,9 @@ static void warn_pathless_add(const char *option_name, const char *short_name) {
 	 * this is not the original behavior and can't be
 	 * changed until users trained themselves not to type
 	 * "git add -u" or "git add -A". For now, we warn and
-	 * keep the old behavior. Later, this warning can be
-	 * turned into a die(...), and eventually we may
-	 * reallow the command with a new behavior.
+	 * keep the old behavior. Later, the behavior can be changed
+	 * to tree-wide, keeping the warning for a while, and
+	 * eventually we can drop the warning.
 	 */
 	warning(_("The behavior of 'git add %s (or %s)' with no path argument from a\n"
 		  "subdirectory of the tree will change in Git 2.0 and should not be used anymore.\n"
-- 
1.8.2.rc3.16.g0a33571.dirty
