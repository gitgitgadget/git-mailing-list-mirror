From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH v5 13/18] inline declaration does not work on AIX
Date: Fri, 14 May 2010 09:31:44 +0000
Message-ID: <20100514093828.066208000@mlists.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 11:38:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrLu-000236-1D
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 11:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758819Ab0ENJic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 05:38:32 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:53029 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758789Ab0ENJia (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 05:38:30 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id BF3355CC2
	for <git@vger.kernel.org>; Fri, 14 May 2010 09:55:21 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com BF3355CC2
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 0495FD00;
	Fri, 14 May 2010 09:38:28 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 3233611D4D1; Fri, 14 May 2010 09:38:28 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-AIX.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147072>

Define away inline declaration on AIX.

Signed-off-by: Gary V. Vaughan <gary@thewrittenword.com>
---
 Makefile |    3 +++
 1 file changed, 3 insertions(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -912,6 +912,9 @@ ifeq ($(uname_S),AIX)
 	else
 		PTHREAD_LIBS = -lpthread
 	endif
+	ifeq ($(shell expr "$(uname_V).$(uname_R)" : '5\.1'),3)
+		INLINE=''
+	endif
 	GIT_TEST_CMP = cmp
 endif
 ifeq ($(uname_S),GNU)

-- 
Gary V. Vaughan (gary@thewrittenword.com)
