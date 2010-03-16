From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 07/15] host-IRIX.patch
Date: Tue, 16 Mar 2010 05:42:27 +0000
Message-ID: <20100316054331.991677000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:53:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPiW-0002vN-Pf
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835Ab0CPFxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:09 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:53412 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757490Ab0CPFw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:57 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 2D8D65CD7
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:02:54 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 2D8D65CD7
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 39606DE5;
	Tue, 16 Mar 2010 05:43:32 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 220EC11D4D5; Tue, 16 Mar 2010 05:43:32 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-IRIX.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142307>

Irix 6.5 does not define 'sgi', but does define '__sgi'.

Also, Irix 6.5 requires _BSD_TYPES to be defined in order for the BSD
u_short types et. al. to be declared properly.
---
 git-compat-util.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/git-compat-util.h
===================================================================
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -55,13 +55,14 @@
 # else
 # define _XOPEN_SOURCE 500
 # endif
-#elif !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX) && !defined(sgi)
+#elif !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !defined(_M_UNIX) && !defined(__sgi)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
 #define _ALL_SOURCE 1
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
+#define _BSD_TYPES 1 /* IRIX needs this for u_short et al */
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 

-- 
Gary V. Vaughan (gary@thewrittenword.com)
