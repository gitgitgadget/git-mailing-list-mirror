From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC][PATCH 02/10] Sparse: fix some "using integer as NULL pointer"
 warnings
Date: Fri, 08 Jun 2007 23:10:52 +0100
Message-ID: <4669D3EC.3030501@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 05:39:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwrnW-0003Au-Lu
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 05:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbXFIDj3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 23:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbXFIDj0
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 23:39:26 -0400
Received: from anchor-fallback-94.mail.demon.net ([194.217.242.94]:51598 "EHLO
	anchor-fallback-94.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752348AbXFIDjZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 23:39:25 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1516 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-94.mail.demon.net
	with ESMTP id S2444738AbXFHWcY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 23:32:24 +0100
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1Hwmxt-0005n9-1i; Fri, 08 Jun 2007 22:29:54 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49556>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 daemon.c     |   12 ++++++------
 fetch-pack.c |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/daemon.c b/daemon.c
index e74ecac..b79e905 100644
--- a/daemon.c
+++ b/daemon.c
@@ -60,12 +60,12 @@ static unsigned int init_timeout;
 #define INTERP_SLOT_PERCENT	(5)
 
 static struct interp interp_table[] = {
-	{ "%H", 0},
-	{ "%CH", 0},
-	{ "%IP", 0},
-	{ "%P", 0},
-	{ "%D", 0},
-	{ "%%", 0},
+	{ "%H" },
+	{ "%CH" },
+	{ "%IP" },
+	{ "%P" },
+	{ "%D" },
+	{ "%%" },
 };
 
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 06f4aec..75649a6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -642,7 +642,7 @@ static int remove_duplicates(int nr_heads, char **heads)
 			heads[dst] = heads[src];
 		dst++;
 	}
-	heads[dst] = 0;
+	heads[dst] = NULL;
 	return dst;
 }
 
-- 
1.5.2
