From: Thomas Schwinge <tschwinge@gnu.org>
Subject: [PATCH] Support building on GNU/Hurd
Date: Sat, 28 Jul 2007 18:39:38 +0200
Message-ID: <11856407793933-git-send-email-tschwinge@gnu.org>
Cc: Thomas Schwinge <tschwinge@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 18:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEpKY-0000AV-C9
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 18:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbXG1Qjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 12:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753326AbXG1Qjp
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 12:39:45 -0400
Received: from mail-in-15.arcor-online.net ([151.189.21.55]:56654 "EHLO
	mail-in-15.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753281AbXG1Qjo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 12:39:44 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id E753EA438B
	for <git@vger.kernel.org>; Sat, 28 Jul 2007 18:39:42 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id B4A04ABAEC
	for <git@vger.kernel.org>; Sat, 28 Jul 2007 18:39:42 +0200 (CEST)
Received: from server.schwinge.homeip.net (stgt-d9beacf6.pool.mediaWays.net [217.190.172.246])
	(Authenticated sender: tschwinge@arcor.de)
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 89E7D212F68
	for <git@vger.kernel.org>; Sat, 28 Jul 2007 18:39:42 +0200 (CEST)
Received: (qmail 23763 invoked from network); 28 Jul 2007 16:39:38 -0000
Received: from leibniz.schwinge.homeip.net (192.168.111.120)
  by server.schwinge.homeip.net with SMTP; 28 Jul 2007 16:39:38 -0000
Received: (nullmailer pid 2040 invoked by uid 500);
	Sat, 28 Jul 2007 16:39:39 -0000
X-Mailer: git-send-email 1.5.3.rc3.26.g6c58-dirty
X-Virus-Scanned: ClamAV 0.91.1/3795/Sat Jul 28 04:08:57 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54041>

GNU/Hurd systems don't have strlcpy either.

Signed-off-by: Thomas Schwinge <tschwinge@gnu.org>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 2fea115..8d9a01b 100644
--- a/Makefile
+++ b/Makefile
@@ -458,6 +458,10 @@ ifeq ($(uname_S),AIX)
 	NO_STRLCPY = YesPlease
 	NEEDS_LIBICONV=YesPlease
 endif
+ifeq ($(uname_S),GNU)
+	# GNU/Hurd
+	NO_STRLCPY=YesPlease
+endif
 ifeq ($(uname_S),IRIX64)
 	NO_IPV6=YesPlease
 	NO_SETENV=YesPlease
-- 
1.5.3.rc3.26.g6c58-dirty
