From: Blake Ramsdell <blaker@gmail.com>
Subject: [PATCH] Mac OS X 10.5 does not require the OLD_ICONV flag set
Date: Thu,  1 Nov 2007 19:38:21 -0700
Message-ID: <1193971102-61907-1-git-send-email-blaker@gmail.com>
Cc: Blake Ramsdell <blaker@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 04:44:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InnSR-0000Jz-R0
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 04:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbXKBDoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 23:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbXKBDoQ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 23:44:16 -0400
Received: from c-24-17-217-200.hsd1.mn.comcast.net ([24.17.217.200]:50623 "EHLO
	Adverlingus.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752520AbXKBDoO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 23:44:14 -0400
Received: by Adverlingus.local (Postfix, from userid 501)
	id BB4AEEFDD5; Thu,  1 Nov 2007 19:38:22 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63058>

Signed-off-by: Blake Ramsdell <blaker@gmail.com>
---
 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 71479a2..5d83756 100644
--- a/Makefile
+++ b/Makefile
@@ -401,7 +401,9 @@ endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
-	OLD_ICONV = UnfortunatelyYes
+	ifneq ($(uname_R),9.0.0)
+		OLD_ICONV = UnfortunatelyYes
+	endif
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
 endif
-- 
1.5.3.GIT
