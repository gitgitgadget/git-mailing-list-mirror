From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 12/16] host-OSF1.patch
Date: Tue, 27 Apr 2010 13:57:20 +0000
Message-ID: <20100427135904.486582000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 16:00:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lKY-0003LI-5M
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041Ab0D0N7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:59:06 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:62544 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0D0N7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:59:05 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 5AE3F5CD9
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:20:12 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 5AE3F5CD9
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id A093AADA;
	Tue, 27 Apr 2010 13:59:04 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 9695411D4D1; Tue, 27 Apr 2010 13:59:04 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-OSF1.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145913>

Add defaults for Tru64 Unix.  Without this patch I cannot compile
git on Tru64 5.1.
---
 Makefile |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -734,6 +734,12 @@ EXTLIBS =
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
 
+ifeq ($(uname_S),OSF1)
+	# Need this for u_short definitions et al
+	BASIC_CFLAGS += -D_OSF_SOURCE
+	NO_STRTOULL = YesPlease
+	NO_NSEC = YesPlease
+endif
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease

-- 
Gary V. Vaughan (gary@thewrittenword.com)
