From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v3 1/2] Makefile: Add a target to generate C preprocessor
 output files
Date: Thu, 10 Dec 2009 18:41:34 +0000
Message-ID: <4B2140DE.5080100@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 20:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIoKv-00069F-AI
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 20:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761556AbZLJTFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 14:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761551AbZLJTFv
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 14:05:51 -0500
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:37557 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761405AbZLJTFv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 14:05:51 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1NIoKq-0004K1-iL; Thu, 10 Dec 2009 19:05:57 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135038>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

No changes from version 1 (apart from re-basing onto a more recent
commit).

ATB,
Ramsay Jones

 Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 4a1e5bc..fdd9ce8 100644
--- a/Makefile
+++ b/Makefile
@@ -1584,6 +1584,8 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
+%.i: %.c .ALWAYS
+	$(QUIET_CC)$(CC) -E $(ALL_CFLAGS) $< >$*.i
 %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS
@@ -1924,7 +1926,7 @@ endif
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
-.PHONY: .FORCE-GIT-BUILD-OPTIONS
+.PHONY: .FORCE-GIT-BUILD-OPTIONS .ALWAYS
 
 ### Check documentation
 #
-- 
1.6.5
