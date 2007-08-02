From: Thomas Schwinge <tschwinge@gnu.org>
Subject: [PATCH] Support building on GNU/Hurd
Date: Thu,  2 Aug 2007 11:14:22 +0200
Message-ID: <11860460622743-git-send-email-tschwinge@gnu.org>
References: <7vy7guxq8u.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org, Thomas Schwinge <tschwinge@gnu.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 02 11:18:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGWpf-0005JK-6R
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 11:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbXHBJSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 05:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbXHBJSz
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 05:18:55 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:60947 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752044AbXHBJSy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 05:18:54 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 810484C350
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 11:18:52 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 65D512D3BC2
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 11:18:52 +0200 (CEST)
Received: from server.schwinge.homeip.net (stgt-d9bebf21.pool.mediaWays.net [217.190.191.33])
	(Authenticated sender: tschwinge@arcor.de)
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 2807030ABCA
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 11:18:51 +0200 (CEST)
Received: (qmail 29294 invoked from network); 2 Aug 2007 09:18:25 -0000
Received: from leibniz.schwinge.homeip.net (192.168.111.120)
  by server.schwinge.homeip.net with SMTP; 2 Aug 2007 09:18:25 -0000
Received: (nullmailer pid 978 invoked by uid 500);
	Thu, 02 Aug 2007 09:14:22 -0000
X-Mailer: git-send-email 1.5.3.rc3.96.g70cd
In-Reply-To: <7vy7guxq8u.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.91.1, clamav-milter version 0.91.1 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54527>

GNU/Hurd systems don't have strlcpy either.

Signed-off-by: Thomas Schwinge <tschwinge@gnu.org>
---
 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 73b487f..682892f 100644
--- a/Makefile
+++ b/Makefile
@@ -456,6 +456,10 @@ ifeq ($(uname_S),AIX)
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
