From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 7/7] Windows: Revert to default paths and convert them by RUNTIME_PREFIX
Date: Sun, 21 Sep 2008 18:24:38 +0200
Message-ID: <1222014278-11071-8-git-send-email-prohaska@zib.de>
References: <1222014278-11071-1-git-send-email-prohaska@zib.de>
 <1222014278-11071-2-git-send-email-prohaska@zib.de>
 <1222014278-11071-3-git-send-email-prohaska@zib.de>
 <1222014278-11071-4-git-send-email-prohaska@zib.de>
 <1222014278-11071-5-git-send-email-prohaska@zib.de>
 <1222014278-11071-6-git-send-email-prohaska@zib.de>
 <1222014278-11071-7-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 21 18:27:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhRm8-0001PG-Ma
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 18:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbYIUQZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYIUQZk
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 12:25:40 -0400
Received: from mailer.zib.de ([130.73.108.11]:50427 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbYIUQZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 12:25:40 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m8LGOdKX005004;
	Sun, 21 Sep 2008 18:24:45 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m8LGOcxU015855;
	Sun, 21 Sep 2008 18:24:39 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1222014278-11071-7-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96403>

The RUNTIME_PREFIX mechanism allows us to use the default (absolute) paths
on Windows too.  Defining RUNTIME_PREFIX explicitly requests for
translation of paths during runtime, depending on the path to the
executable.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 8181f74..98278f0 100644
--- a/Makefile
+++ b/Makefile
@@ -767,6 +767,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
+	RUNTIME_PREFIX = YesPlease
 	NO_POSIX_ONLY_PROGRAMS = YesPlease
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
@@ -775,9 +776,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
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
1.6.0.2.GIT
