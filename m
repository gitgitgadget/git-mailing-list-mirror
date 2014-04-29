From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 02/12] MSVC: config.mak.uname: drop -D__USE_MINGW_ACCESS from CFLAGS
Date: Tue, 29 Apr 2014 13:11:56 +0400
Message-ID: <1398762726-22825-3-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:12:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf45Y-0005GE-4N
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785AbaD2JMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:12:22 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:44918 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbaD2JMR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:12:17 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45D-0006BN-87; Tue, 29 Apr 2014 13:12:12 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247536>

-D__USE_MINGW_ACCESS only affects MinGW and does nothing when
MSVC is used.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 23a8803..faddb82 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -357,7 +357,7 @@ ifeq ($(uname_S),Windows)
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
