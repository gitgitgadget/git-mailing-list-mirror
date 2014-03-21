From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 01/10] userdiff: support C++ ->* and .* operators in the word regexp
Date: Fri, 21 Mar 2014 22:07:13 +0100
Message-ID: <293a6d890efa25bb6c2887afe75b11a47edd8810.1395433874.git.j6t@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:08:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6g4-0002jL-4t
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbaCUVI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:08:27 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:62456 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750710AbaCUVI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:08:27 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by lbmfmo03.bon.at (Postfix) with ESMTP id EF87ACEA59
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 22:08:25 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 11BAEA7EB7;
	Fri, 21 Mar 2014 22:08:15 +0100 (CET)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id BAB2D19F6A4;
	Fri, 21 Mar 2014 22:08:14 +0100 (CET)
X-Mailer: git-send-email 1.8.5.2.244.g9fb3fb1
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244739>

The character sequences ->* and .* are valid C++ operators. Keep them
together in --word-diff mode.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index 10b61ec..434535b 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -133,7 +133,7 @@
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
-	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
+	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
 PATTERNS("csharp",
 	 /* Keywords */
 	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
-- 
1.8.5.2.244.g9fb3fb1
