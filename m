From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Makefile: enable SNPRINTF_RETURNS_BOGUS for HP-UX
Date: Sun, 24 Aug 2008 00:07:55 +0200
Message-ID: <1219529275-8194-1-git-send-email-vmiklos@frugalware.org>
References: <20080823220358.GH23800@genesis.frugalware.org>
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 00:10:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX1Ha-0004KR-2d
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 00:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbYHWWH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYHWWH0
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 18:07:26 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:38847 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbYHWWH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 18:07:26 -0400
Received: from vmobile.example.net (dsl5401CFDD.pool.t-online.hu [84.1.207.221])
	by yugo.frugalware.org (Postfix) with ESMTP id 256E61DDC5B;
	Sun, 24 Aug 2008 00:07:24 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 76A7796FA; Sun, 24 Aug 2008 00:07:55 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc3.17.gc14c8.dirty
In-Reply-To: <20080823220358.GH23800@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93494>

In 81cc66a, customization has been added to Makefile for supporting
HP-UX, but git commit is still problematic. This should fix the issue.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5e944d8..e5a4985 100644
--- a/Makefile
+++ b/Makefile
@@ -735,6 +735,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_UNSETENV = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_SYS_SELECT_H = YesPlease
+	SNPRINTF_RETURNS_BOGUS = YesPlease
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_MMAP = YesPlease
-- 
1.6.0.rc3.17.gc14c8.dirty
