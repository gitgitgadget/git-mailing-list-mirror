From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 5/5] Recent MinGW has a C99 implementation of snprintf functions
Date: Thu, 20 May 2010 20:57:55 +0200
Message-ID: <439f0b3d51f9548b72e0e719d590cc9bcf4c0084.1274380838.git.j6t@kdbg.org>
References: <cover.1274380838.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 20 21:01:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFAzn-00009b-5H
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 21:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab0ETTBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 15:01:17 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:15528 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752889Ab0ETTBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 15:01:16 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1FE9B1001F;
	Thu, 20 May 2010 21:01:15 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A018219F5F0;
	Thu, 20 May 2010 20:58:32 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.64.ga1799.dirty
In-Reply-To: <cover.1274380838.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147411>

Date: Mon, 20 Jul 2009 22:15:07 +0200

Starting with MinGW 3.14, released end of 2007, a working snprintf
is available. This means we do not need our own replacement that works
around the broken implementation in Microsoft's C runtime.

People who build git in an old MinGW environment are expected to set
SNPRINTF_RETURNS_BOGUS in their config.mak. msysgit is sufficiently
recent, of course.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 The Date: line is deliberate to show how long I carry this patch. :-)

 Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 910f471..c36c5b0 100644
--- a/Makefile
+++ b/Makefile
@@ -1026,7 +1026,6 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
-	SNPRINTF_RETURNS_BOGUS = YesPlease
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	RUNTIME_PREFIX = YesPlease
-- 
1.7.1.64.ga1799.dirty
