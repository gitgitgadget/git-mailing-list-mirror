From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 08/16] host-SunOS56.patch
Date: Tue, 27 Apr 2010 13:57:16 +0000
Message-ID: <20100427135843.788721000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 15:59:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lJU-0002hJ-B3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 15:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027Ab0D0N6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:58:45 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:58388 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0D0N6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:58:44 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id A71585CD9
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:19:51 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com A71585CD9
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id EADC2ADA;
	Tue, 27 Apr 2010 13:58:43 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id E1CBD11D4D1; Tue, 27 Apr 2010 13:58:43 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-SunOS56.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145909>

Although configure takes care of most of this, set some default values
for Solaris 2.6 (aka SunOS-5.6) to ensure git compiles even when
configure is not used to build it.
---
 Makefile |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -806,6 +806,16 @@ ifeq ($(uname_S),SunOS)
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_REGEX = YesPlease
+	ifeq ($(uname_R),5.6)
+		NO_IPV6 = YesPlease
+		NO_SOCKADDR_STORAGE = YesPlease
+		NO_UNSETENV = YesPlease
+		NO_SETENV = YesPlease
+		NO_STRLCPY = YesPlease
+		NO_C99_FORMAT = YesPlease
+		NO_STRTOUMAX = YesPlease
+		GIT_TEST_CMP = cmp
+	endif
 	ifeq ($(uname_R),5.7)
 		NEEDS_RESOLV = YesPlease
 		NO_IPV6 = YesPlease

-- 
Gary V. Vaughan (gary@thewrittenword.com)
