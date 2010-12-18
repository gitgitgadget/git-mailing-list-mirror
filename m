From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 3/4] userdiff: fix typo in ruby and python word regexes
Date: Sat, 18 Dec 2010 17:17:53 +0100
Message-ID: <a358c476187b1220bf6e2368c0723cefe60a5763.1292688058.git.trast@student.ethz.ch>
References: <cover.1292688058.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 17:18:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTzUD-0004k3-3h
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 17:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab0LRQSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 11:18:04 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:2218 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756419Ab0LRQSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 11:18:00 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 18 Dec
 2010 17:17:55 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sat, 18 Dec
 2010 17:17:59 +0100
X-Mailer: git-send-email 1.7.3.4.789.g74ad1
In-Reply-To: <cover.1292688058.git.trast@student.ethz.ch>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163918>

Both had an unclosed ] that ruined the safeguard against not matching
a non-space char.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 userdiff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index f9e05b5..2d54536 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -74,14 +74,14 @@
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"
-	 "|[^[:space:]|[\x80-\xff]+"),
+	 "|[^[:space:]]|[\x80-\xff]+"),
 	 /* -- */
 PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
 	 /* -- */
 	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"
-	 "|[^[:space:]|[\x80-\xff]+"),
+	 "|[^[:space:]]|[\x80-\xff]+"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-- 
1.7.3.4.789.g74ad1
