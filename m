From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Makefile: improve customization for supporting HP-UX
Date: Sat, 23 Aug 2008 21:41:24 +0200
Message-ID: <1219520484-7712-1-git-send-email-vmiklos@frugalware.org>
Cc: Robert Schiele <rschiele@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 21:42:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWyzs-0002J9-HJ
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 21:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbYHWTkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 15:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbYHWTkz
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 15:40:55 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:48011 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236AbYHWTky (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 15:40:54 -0400
Received: from vmobile.example.net (dsl5401CFDD.pool.t-online.hu [84.1.207.221])
	by yugo.frugalware.org (Postfix) with ESMTP id E4FB31DDC5B;
	Sat, 23 Aug 2008 21:40:51 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 6606496FA; Sat, 23 Aug 2008 21:41:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3.17.gc14c8.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93478>

In 81cc66a, customization has been added to Makefile for supporting
HP-UX, but two minor tweaks are still necessary, at least on older
versions like 11.11.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Cc'ing Robert, it would be interesting to know how did he succeed to
build without this patch.

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5e944d8..7fb35ca 100644
--- a/Makefile
+++ b/Makefile
@@ -735,6 +735,8 @@ ifeq ($(uname_S),HP-UX)
 	NO_UNSETENV = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_SYS_SELECT_H = YesPlease
+	NEEDS_LIBICONV = YesPlease
+	SNPRINTF_RETURNS_BOGUS = YesPlease
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_MMAP = YesPlease
-- 
1.6.0.rc3.17.gc14c8.dirty
