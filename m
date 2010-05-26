From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 099/104] Recent MinGW has a C99 implementation of snprintf functions
Date: Wed, 26 May 2010 18:01:09 +1200
Message-ID: <1274853674-18521-99-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9li-0004ff-RE
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934061Ab0EZGGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:46 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49312 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933951Ab0EZGG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 8017E3389B;
	Wed, 26 May 2010 18:02:07 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CXQ8HAoPA7fv; Wed, 26 May 2010 18:02:05 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 2CA9D338E8;
	Wed, 26 May 2010 18:01:40 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147761>

From: Johannes Sixt <j6t@kdbg.org>

Starting with MinGW 3.14, released end of 2007, a working snprintf
is available. This means we do not need our own replacement that works
around the broken implementation in Microsoft's C runtime.

People who build git in an old MinGW environment are expected to set
SNPRINTF_RETURNS_BOGUS in their config.mak. msysgit is sufficiently
recent, of course.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index eb1d162..7a014b1 100644
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
1.7.1.rc2.333.gb2668
