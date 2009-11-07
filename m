From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 1/4] Makefile: merge two Cygwin configuration sections
 into one
Date: Sat, 07 Nov 2009 20:02:29 +0000
Message-ID: <4AF5D255.2090804@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 21:24:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6rq2-0000cT-QC
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 21:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbZKGUYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 15:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753062AbZKGUYi
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 15:24:38 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:60672 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753052AbZKGUYh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Nov 2009 15:24:37 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1N6rpx-0002ya-ZP; Sat, 07 Nov 2009 20:24:42 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132374>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Unchanged from v1.

 Makefile |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index fea237b..8e1cfc5 100644
--- a/Makefile
+++ b/Makefile
@@ -782,6 +782,8 @@ ifeq ($(uname_O),Cygwin)
 	NO_MMAP = YesPlease
 	NO_IPV6 = YesPlease
 	X = .exe
+	COMPAT_OBJS += compat/cygwin.o
+	UNRELIABLE_FSTAT = UnfortunatelyYes
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
@@ -891,10 +893,6 @@ ifeq ($(uname_S),HP-UX)
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 endif
-ifneq (,$(findstring CYGWIN,$(uname_S)))
-	COMPAT_OBJS += compat/cygwin.o
-	UNRELIABLE_FSTAT = UnfortunatelyYes
-endif
 ifdef MSVC
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
-- 
1.6.5
