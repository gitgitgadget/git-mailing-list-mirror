From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Sort howto documents in howto-index.txt
Date: Sat, 22 Dec 2012 19:34:27 +0100 (CET)
Message-ID: <1870890640.302608.1356201267202.JavaMail.ngmail@webmail13.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 19:34:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmTuI-0001H8-PW
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 19:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab2LVSea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 13:34:30 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:42483 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751790Ab2LVSe2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Dec 2012 13:34:28 -0500
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 3F39B3AEF65
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 19:34:27 +0100 (CET)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 361C211204A;
	Sat, 22 Dec 2012 19:34:27 +0100 (CET)
Received: from webmail13.arcor-online.net (webmail13.arcor-online.net [151.189.8.66])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 30F7CD8149;
	Sat, 22 Dec 2012 19:34:27 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-03.arcor-online.net 30F7CD8149
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1356201267; bh=cYbKbvfo6Q7fsFEM+1/Etv8w3p/MJjQYVzzMVlMT8lM=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=EOILB1uwdYU+ZlTu6btRvYw2Vgj/FRzKIVpamAIR9R6CFWSh/pXiPDdAfu4h76aMy
	 SYcLgBoxQ0rdFnPQffaMr4bSsH8LsWnWd445s5d3dRabn41AF05pKKfk6tt7Ih0st2
	 tukbAQ+bnxb+uTKce23DDjVecGrU9EomwQqlvDRc=
Received: from [94.217.21.153] by webmail13.arcor-online.net (151.189.8.66) with HTTP (Arcor Webmail); Sat, 22 Dec 2012 19:34:27 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.21.153
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212064>


Howto documents in howto-index.txt were listed in a rather
random order. So better sort them.

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d7417b8..ff8ad9a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -348,7 +348,7 @@ $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	$(QUIET_GEN)$(RM) $@+ $@ && \
-	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
+	'$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
 	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-- 
1.8.0.msysgit.0



---
Thomas
