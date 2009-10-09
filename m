From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] Makefile: use the native (Korn) shell on SunOS and IRIX/IRIX64
Date: Fri,  9 Oct 2009 13:39:57 -0500
Message-ID: <1eweIwf5YoFwmLPWwEFN67wBtSRzI_L6x3UcjRimFe5P29LRa_0y-MvfV0H0uJhx2aoVUxbZP8vdM5evsZ8aZA@cipher.nrlssc.navy.mil>
References: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
Cc: drizzd@aon.at, peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 20:47:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwKUm-0003JE-PC
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 20:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934101AbZJISlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 14:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934112AbZJISlJ
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 14:41:09 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33581 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934093AbZJISlI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 14:41:08 -0400
Received: by mail.nrlssc.navy.mil id n99IeGfM012016; Fri, 9 Oct 2009 13:40:16 -0500
In-Reply-To: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 09 Oct 2009 18:40:16.0446 (UTC) FILETIME=[F1DAB5E0:01CA490F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129830>

From: Brandon Casey <drafnel@gmail.com>

Now that the test suite supports the Korn shell, we can use it as the
default on platforms that do not ship with Bash.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 629ab35..9ada196 100644
--- a/Makefile
+++ b/Makefile
@@ -726,7 +726,7 @@ endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
 	NEEDS_NSL = YesPlease
-	SHELL_PATH = /bin/bash
+	SHELL_PATH = /usr/xpg4/bin/sh
 	SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
@@ -850,7 +850,7 @@ ifeq ($(uname_S),IRIX)
 	NO_MMAP = YesPlease
 	NO_EXTERNAL_GREP = UnfortunatelyYes
 	SNPRINTF_RETURNS_BOGUS = YesPlease
-	SHELL_PATH = /usr/gnu/bin/bash
+	SHELL_PATH = /bin/ksh
 	NEEDS_LIBGEN = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
 endif
@@ -870,7 +870,7 @@ ifeq ($(uname_S),IRIX64)
 	NO_MMAP = YesPlease
 	NO_EXTERNAL_GREP = UnfortunatelyYes
 	SNPRINTF_RETURNS_BOGUS = YesPlease
-	SHELL_PATH=/usr/gnu/bin/bash
+	SHELL_PATH=/bin/ksh
 	NEEDS_LIBGEN = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
 endif
-- 
1.6.5.rc3
