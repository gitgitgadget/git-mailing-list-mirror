From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 09/16] host-IRIX.patch
Date: Tue, 27 Apr 2010 13:57:17 +0000
Message-ID: <20100427135848.944844000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 15:59:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lJU-0002hJ-VG
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 15:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab0D0N6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:58:50 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:52780 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698Ab0D0N6t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:58:49 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id D62105CDC
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:19:56 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com D62105CDC
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 25912ADC;
	Tue, 27 Apr 2010 13:58:49 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 1974D11D4D1; Tue, 27 Apr 2010 13:58:49 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-IRIX.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145910>

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
