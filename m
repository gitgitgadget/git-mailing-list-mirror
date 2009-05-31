From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 05/11] winansi: fix compile warnings
Date: Sun, 31 May 2009 18:15:19 +0200
Message-ID: <1243786525-4493-6-git-send-email-prohaska@zib.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
 <1243786525-4493-2-git-send-email-prohaska@zib.de>
 <1243786525-4493-3-git-send-email-prohaska@zib.de>
 <1243786525-4493-4-git-send-email-prohaska@zib.de>
 <1243786525-4493-5-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAniN-0001nG-Cc
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758917AbZEaQQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 12:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758884AbZEaQQc
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:16:32 -0400
Received: from mailer.zib.de ([130.73.108.11]:58657 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758134AbZEaQQW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:16:22 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4VGFV1Z006798;
	Sun, 31 May 2009 18:15:36 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4VGFPVC021220;
	Sun, 31 May 2009 18:15:31 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243786525-4493-5-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120413>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 compat/win32.h   |    1 +
 compat/winansi.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/compat/win32.h b/compat/win32.h
index c26384e..d531130 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -1,5 +1,6 @@
 /* common Win32 functions for MinGW and Cygwin */
 #include <windows.h>
+#include <conio.h>
 
 static inline int file_attr_to_st_mode (DWORD attr)
 {
diff --git a/compat/winansi.c b/compat/winansi.c
index 4bee335..9217c24 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -80,7 +80,7 @@ static void set_console_attr(void)
 static void erase_in_line(void)
 {
 	CONSOLE_SCREEN_BUFFER_INFO sbi;
-	long dummy; /* Needed for Windows 7 (or Vista) regression */
+	DWORD dummy; /* Needed for Windows 7 (or Vista) regression */
 
 	if (!console)
 		return;
-- 
1.6.3.1.54.g99dd
