From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH FYI 6/5] Makefile: update IRIX64 section
Date: Fri, 10 Jul 2009 13:31:19 -0500
Message-ID: <stPsg0ZZV3g6iZzJJntBzwwYW5t-03cXjs4wphlspoOTzCVzFQjvHF1wtQgAA7hq1rWxe4CvZHs@cipher.nrlssc.navy.mil>
References: <39niBtmtFs5Sy_fjtaztVpzvYMB2VqzJqRa_5SCfycpkVR-qsHwAomyoqf7KXKH-vbxIhbJxKJM@cipher.nrlssc.navy.mil>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 20:32:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPKt9-0002cT-OA
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 20:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754914AbZGJSbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 14:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754357AbZGJSbe
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 14:31:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36383 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914AbZGJSbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 14:31:34 -0400
Received: by mail.nrlssc.navy.mil id n6AIVVU2024938; Fri, 10 Jul 2009 13:31:31 -0500
In-Reply-To: <39niBtmtFs5Sy_fjtaztVpzvYMB2VqzJqRa_5SCfycpkVR-qsHwAomyoqf7KXKH-vbxIhbJxKJM@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 10 Jul 2009 18:31:31.0017 (UTC) FILETIME=[A5155B90:01CA018C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123075>

From: Brandon Casey <drafnel@gmail.com>

---


Here's the update for the 64-bit version of IRIX.  This has been tested to
the same extent that the 32-bit version has been tested.  The 64-bit test
system is a little bit older than the 32-bit system, so a few more tests are
skipped (related to a too old gtar), and NO_STRLCPY and NO_DEFLATE_BOUND
macros are set.

-brandon


 Makefile |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index d404524..baa0296 100644
--- a/Makefile
+++ b/Makefile
@@ -844,17 +844,17 @@ ifeq ($(uname_S),IRIX)
 	NEEDS_LIBGEN = YesPlease
 endif
 ifeq ($(uname_S),IRIX64)
-	NO_IPV6=YesPlease
 	NO_SETENV=YesPlease
+	NO_UNSETENV = YesPlease
 	NO_STRCASESTR=YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKSTEMPS = YesPlease
-	NO_STRLCPY = YesPlease
-	NO_SOCKADDR_STORAGE=YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_MMAP = YesPlease
+	NO_EXTERNAL_GREP = UnfortunatelyYes
+	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
-	BASIC_CFLAGS += -DPATH_MAX=1024
-	# for now, build 32-bit version
-	BASIC_LDFLAGS += -L/usr/lib32
+	NEEDS_LIBGEN = YesPlease
 endif
 ifeq ($(uname_S),HP-UX)
 	NO_IPV6=YesPlease
-- 
1.6.4.rc0.5.g76f7cf
