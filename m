From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] for-each-ref: fix off by one read.
Date: Mon, 12 Nov 2007 05:37:25 +0100
Message-ID: <20071112053725.4f0d1940.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 05:31:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrQwu-00037u-6M
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 05:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbXKLEap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 23:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753159AbXKLEao
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 23:30:44 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:52159 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbXKLEao (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 23:30:44 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E93A21AB2B1;
	Mon, 12 Nov 2007 05:30:39 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id B390A1AB2B0;
	Mon, 12 Nov 2007 05:30:39 +0100 (CET)
X-Mailer: Sylpheed 2.4.7 (GTK+ 2.12.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64558>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-for-each-ref.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 598d4e1..89ea37c 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -306,7 +306,7 @@ static const char *find_wholine(const char *who, int wholen, const char *buf, un
 		if (!eol)
 			return "";
 		eol++;
-		if (eol[1] == '\n')
+		if (*eol == '\n')
 			return ""; /* end of header */
 		buf = eol;
 	}
-- 
1.5.3.5.577.g4d1b9-dirty
