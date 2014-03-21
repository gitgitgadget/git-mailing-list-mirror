From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 02/10] userdiff: support unsigned and long long suffixes of integer constants
Date: Fri, 21 Mar 2014 22:07:14 +0100
Message-ID: <449a75237d45739084efddbcaf545db4b0a0a40a.1395433874.git.j6t@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:08:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6gJ-00036o-56
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbaCUVIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:08:43 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:23334 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750807AbaCUVIm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:08:42 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.105])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 028EDCEA66
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 22:08:42 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CB79A130072;
	Fri, 21 Mar 2014 22:08:30 +0100 (CET)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 766E119F6A4;
	Fri, 21 Mar 2014 22:08:30 +0100 (CET)
X-Mailer: git-send-email 1.8.5.2.244.g9fb3fb1
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244740>

Do not split constants such as 123U, 456ll, 789UL at the first U or
second L.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index 434535b..8830417 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -132,7 +132,7 @@
 	 "^((struct|class|enum)[^;]*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
-	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
+	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
 PATTERNS("csharp",
 	 /* Keywords */
-- 
1.8.5.2.244.g9fb3fb1
