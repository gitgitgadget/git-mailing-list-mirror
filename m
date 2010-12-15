From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/4] userdiff: fix typo in ruby word regex
Date: Wed, 15 Dec 2010 16:13:27 +0100
Message-ID: <a6566faa303d37d3ec469c8fb2501be9094168c2.1292424926.git.trast@student.ethz.ch>
References: <cover.1292424926.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Scott Johnson <scottj75074@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:13:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSt2y-0005pJ-5h
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858Ab0LOPNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 10:13:37 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:20879 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab0LOPNd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:13:33 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:13:22 +0100
Received: from localhost.localdomain (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:13:30 +0100
X-Mailer: git-send-email 1.7.3.3.807.g6ee1f
In-Reply-To: <cover.1292424926.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163781>

The regex had an unclosed ] that pretty much ruined the safeguard
against not matching a non-space char.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 userdiff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index f9e05b5..4d6433b 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -81,7 +81,7 @@
 	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"
-	 "|[^[:space:]|[\x80-\xff]+"),
+	 "|[^[:space:]]|[\x80-\xff]+"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-- 
1.7.3.3.807.g6ee1f
