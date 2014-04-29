From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 07/12] MINGW: config.mak.uname: reorganize MINGW settings
Date: Tue, 29 Apr 2014 13:12:01 +0400
Message-ID: <1398762726-22825-8-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:13:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf46w-0006m1-6g
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933202AbaD2JNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:13:54 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:45075 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756773AbaD2JMV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:12:21 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45K-0006BN-6O; Tue, 29 Apr 2014 13:12:18 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247542>

HAVE_LIBCHARSET_H and NO_R_TO_GCC_LINKER are not specific to
msysGit, they're general MinGW settings.

Logic behind HAVE_LIBCHARSET_H: if user is on MinGW and has iconv,
we expect him to have libcharset.h. If user doesn't have iconv,
he has to explicitly say so via NO_ICONV=1.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 50c1114..b68a7d1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -516,11 +516,11 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	prefix =
 	INSTALL = /bin/install
 	EXTLIBS += /mingw/lib/libz.a
-	NO_R_TO_GCC_LINKER = YesPlease
 	INTERNAL_QSORT = YesPlease
-	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
 endif
+	HAVE_LIBCHARSET_H = YesPlease
+	NO_R_TO_GCC_LINKER = YesPlease
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS += -DSA_RESTART=0
-- 
1.9.1
