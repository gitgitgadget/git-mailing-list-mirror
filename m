From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH] Solaris: Use OLD_ICONV to avoid compile warnings
Date: Thu,  2 Oct 2008 02:08:47 +0200
Message-ID: <1222906127-16900-1-git-send-email-sn_@gmx.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 02:10:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlBla-0000fx-GF
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 02:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbYJBAIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 20:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbYJBAIv
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 20:08:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:50681 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753227AbYJBAIu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 20:08:50 -0400
Received: (qmail invoked by alias); 02 Oct 2008 00:08:48 -0000
Received: from krlh-5d855fa5.pool.einsundeins.de (EHLO localhost.localdomain) [93.133.95.165]
  by mail.gmx.net (mp040) with SMTP; 02 Oct 2008 02:08:48 +0200
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX1+bKe8KL/ibAbRp6AjN+975dWKWF13RMNZ4dOYxPo
	Cxmqao4cvEHaGR
X-Mailer: git-send-email 1.6.0.1.451.gc8d31
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97280>

From: David Soria Parra <dsp@php.net>

Solaris systems use the old styled iconv(3) call and therefore
the OLD_ICONV variable should be set. Otherwise we get annoying compile
warnings.

Signed-off-by: David Soria Parra <dsp@php.net>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 7db2ccc..3abbb4e 100644
--- a/Makefile
+++ b/Makefile
@@ -649,6 +649,7 @@ ifeq ($(uname_S),SunOS)
 	NO_MEMMEM = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_MKDTEMP = YesPlease
+	OLD_ICONV = UnfortunatelyYes
 	ifeq ($(uname_R),5.8)
 		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
-- 
1.6.0.2.569.g798a2a
