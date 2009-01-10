From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 6/6] Windows: Revert to default paths and convert them by RUNTIME_PREFIX
Date: Sat, 10 Jan 2009 14:50:52 +0100
Message-ID: <1231595452-27698-6-git-send-email-prohaska@zib.de>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de>
 <1231595452-27698-2-git-send-email-prohaska@zib.de>
 <1231595452-27698-3-git-send-email-prohaska@zib.de>
 <1231595452-27698-4-git-send-email-prohaska@zib.de>
 <1231595452-27698-5-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 14:53:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLeH1-0006VW-VG
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 14:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbZAJNvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 08:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbZAJNv1
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 08:51:27 -0500
Received: from mailer.zib.de ([130.73.108.11]:45492 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701AbZAJNvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 08:51:23 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0ADos5M025835;
	Sat, 10 Jan 2009 14:51:03 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0ADorWQ016764;
	Sat, 10 Jan 2009 14:50:54 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1231595452-27698-5-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105110>

The RUNTIME_PREFIX mechanism allows us to use the default paths on
Windows too.  Defining RUNTIME_PREFIX explicitly requests for
translation of paths relative to the executable at runtime.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index a7728a3..a5f6cad 100644
--- a/Makefile
+++ b/Makefile
@@ -789,6 +789,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
+	RUNTIME_PREFIX = YesPlease
 	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
@@ -797,9 +798,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/regex/regex.o compat/winansi.o
 	EXTLIBS += -lws2_32
 	X = .exe
-	gitexecdir = ../libexec/git-core
-	template_dir = ../share/git-core/templates/
-	ETC_GITCONFIG = ../etc/gitconfig
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
-- 
1.6.1.85.g32c5d
