From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/4] Makefile: merge two Cygwin configuration sections into
 one
Date: Tue, 27 Oct 2009 19:11:55 +0000
Message-ID: <4AE745FB.1060902@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>, dpotapov@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:37:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2rrQ-0003wp-Pa
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 20:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756722AbZJ0ThX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 15:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756716AbZJ0ThW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 15:37:22 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:49894 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756693AbZJ0ThV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 15:37:21 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1N2rrB-0002ix-Y4; Tue, 27 Oct 2009 19:37:26 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131376>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

I can't think of any potential problems with this... but I've
added Dmitry to the cc-list, since he appears to have added
the second cygwin section in adbc0b6b, just in case... ;-)

ATB,
Ramsay Jones

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
