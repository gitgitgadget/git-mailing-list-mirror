From: Matt Kraai <kraai@ftbfs.org>
Subject: [PATCH] git-credential-gnome-keyring: Remove die
Date: Sat, 10 Nov 2012 16:08:04 -0800
Message-ID: <1352592485-32477-1-git-send-email-kraai@ftbfs.org>
Cc: Matt Kraai <kraai@ftbfs.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 01:19:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXLGk-0007HU-2Z
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 01:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab2KKATI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 19:19:08 -0500
Received: from zoom.lafn.org ([108.92.93.123]:31192 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578Ab2KKATG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 19:19:06 -0500
X-Greylist: delayed 624 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Nov 2012 19:19:06 EST
Received: from hpe-490t.ftbfs.org (anon-188-19.vpn.ipredator.se [93.182.188.19])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id qAB08avM058268;
	Sat, 10 Nov 2012 16:08:38 -0800 (PST)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by hpe-490t.ftbfs.org with local (Exim 4.80)
	(envelope-from <kraai@ftbfs.org>)
	id 1TXL6E-0008W0-R2; Sat, 10 Nov 2012 16:08:30 -0800
X-Mailer: git-send-email 1.7.10.4
X-Virus-Scanned: clamav-milter 0.97 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209315>

git-credential-gnome-keyring defines die, but it is unused and
incorrect (it passes a va_list to error, which does not expect one),
so remove it.

Signed-off-by: Matt Kraai <kraai@ftbfs.org>
---
 .../credential/gnome-keyring/git-credential-gnome-keyring.c  |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 41f61c5..3eaafba 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -104,16 +104,6 @@ static inline void error(const char *fmt, ...)
 	va_end(ap);
 }
 
-static inline void die(const char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap,fmt);
-	error(fmt, ap);
-	va_end(ap);
-	exit(EXIT_FAILURE);
-}
-
 static inline void die_errno(int err)
 {
 	error("%s", strerror(err));
-- 
1.7.10.4
