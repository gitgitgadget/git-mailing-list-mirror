From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 06/12] MSVC: config.mak.uname: drop -D__USE_MINGW_ACCESS from compile definitions
Date: Mon, 28 Apr 2014 17:51:31 +0400
Message-ID: <1398693097-24651-7-git-send-email-marat@slonopotamus.org>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:52:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Welya-0003iG-H4
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 15:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbaD1Nvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 09:51:54 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:56236 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbaD1Nvw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 09:51:52 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WelyG-0004qo-NM; Mon, 28 Apr 2014 17:51:49 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247333>

-D__USE_MINGW_ACCESS only affects MinGW and does nothing when
MSVC is used.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index e5edae6..dc87e21 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -363,7 +363,7 @@ ifeq ($(uname_S),Windows)
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
+	COMPAT_CFLAGS = -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib invalidcontinue.obj
 	PTHREAD_LIBS =
-- 
1.9.1
