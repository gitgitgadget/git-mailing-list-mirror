From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 15/18] git-compat-util.h: Irix 6.5 defines sgi but not __sgi.
Date: Fri, 14 May 2010 09:31:46 +0000
Message-ID: <20100514093838.421864000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:38:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrM4-00028C-1o
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758838Ab0ENJim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:38:42 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:57966 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758830Ab0ENJij (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:38:39 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id B9EC25C48
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:55:30 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com B9EC25C48
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 91560D00;
	Fri, 14 May 2010 09:38:38 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 8796B11D4D1; Fri, 14 May 2010 09:38:38 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-IRIX.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147073>

Irix 6.5 does not define 'sgi', but does define '__sgi'.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 git-compat-util.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/git-compat-util.h
===================================================================
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -56,7 +56,8 @@
 # define _XOPEN_SOURCE 500
 # endif
 #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
-      !defined(_M_UNIX) && !defined(sgi) && !defined(__DragonFly__)
+      !defined(_M_UNIX) && !defined(sgi) && !defined(__sgi) && \
+      !defined(__DragonFly__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif

-- 
Gary V. Vaughan (gary@thewrittenword.com)
