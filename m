From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 10/15] host-OSF1.patch
Date: Tue, 16 Mar 2010 05:42:30 +0000
Message-ID: <20100316054347.542270000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:54:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPjN-00038F-4A
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054Ab0CPFxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:33 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:56954 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757619Ab0CPFw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:57 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id A0EA75CDC
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:03:09 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com A0EA75CDC
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id ACBA2DE5;
	Tue, 16 Mar 2010 05:43:47 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id A6DA711D4D5; Tue, 16 Mar 2010 05:43:47 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-OSF1.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142317>

Add defaults for Tru64 Unix.  Without this patch I cannot compile
git on Tru64 5.1.
---
 Makefile |    6 ++++++
 1 file changed, 6 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -695,6 +695,12 @@ EXTLIBS =
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
