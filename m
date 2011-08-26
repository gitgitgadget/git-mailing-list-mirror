From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] fast-import: initialize variable require_explicit_termination
Date: Fri, 26 Aug 2011 19:11:28 +0200
Message-ID: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 26 19:11:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwzwW-0007dx-PN
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 19:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab1HZRLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 13:11:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60785 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab1HZRLj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 13:11:39 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p7QHBApv007234
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 26 Aug 2011 19:11:10 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1QwzwL-0002WK-BZ; Fri, 26 Aug 2011 19:11:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1QwzwL-0002Wp-0J; Fri, 26 Aug 2011 19:11:33 +0200
X-Mailer: git-send-email 1.7.6.585.g5929f.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Aug 2011 19:11:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7QHBApv007234
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1314983472.55963@evGMjqiD/Qj90qauElDRRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180180>

The uninitialized variable seems harmless in practice, but let's still be clean.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
For some reason, remote helpers seem to be forced to use the "done"
command now. Investing why, I found this, but that wasn't what I was
looking for.

 fast-import.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7cc2262..ed8f3cd 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -355,7 +355,7 @@ static unsigned int cmd_save = 100;
 static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
 static int seen_data_command;
-static int require_explicit_termination;
+static int require_explicit_termination = 0;
 
 /* Signal handling */
 static volatile sig_atomic_t checkpoint_requested;
-- 
1.7.6.585.g5929f.dirty
