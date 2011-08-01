From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/2] Diff patterns for POSIX shells
Date: Mon,  1 Aug 2011 12:37:48 +0200
Message-ID: <1312195069-10782-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1312195069-10782-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 12:38:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnptB-0008VH-Hb
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 12:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab1HAKiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 06:38:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63930 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab1HAKiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 06:38:15 -0400
Received: by wyg8 with SMTP id 8so1470229wyg.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Oo95eWApqL/+eluc7T+Q1XEMcO1yXNNYhEW5l7cZf+g=;
        b=UleETtyyZwnUWZyT2DqUo+kRH8h7PjlVtSRejVizOW9Xb03aMQAcIKww3cHPKAjr4F
         iwr8tkMc/gd8jlB2pYSP2D5BfeCfMYvM/qCYMsKDchfYnYNzA5qQwIeJ8+yC48MD0Ldv
         js/RGbXmr0WxVuh+5NK1vzv/GHduSAijSW4Vg=
Received: by 10.216.24.2 with SMTP id w2mr547693wew.28.1312195093718;
        Mon, 01 Aug 2011 03:38:13 -0700 (PDT)
Received: from localhost ([151.54.121.1])
        by mx.google.com with ESMTPS id l68sm3238186weq.10.2011.08.01.03.38.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 03:38:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.451.gcb935.dirty
In-Reply-To: <1312195069-10782-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178326>

All diffs following a function definition will have that function name
as chunck header, but this is the best we can do with the current
userdiff capabilities.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 userdiff.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 01d3a8b..70120c3 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -107,6 +107,9 @@
 	 "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
 	 "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
+PATTERNS("shell", "^[ \t]*([a-zA-Z_0-9]+)[ \t]*\\(\\).*",
+	 /* -- */
+	 "(--|\\$)?[a-zA-Z_0-9]+|&&|\\|\\|"),
 PATTERNS("bibtex", "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	 "[={}\"]|[^={}\" \t]+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
-- 
1.7.6.451.gcb935.dirty
