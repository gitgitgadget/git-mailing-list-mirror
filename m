From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t9001: set TERM=dumb to prevent ANSI output
Date: Thu, 6 Mar 2008 17:53:28 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061752340.3941@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 06 17:54:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXJM7-0004mn-87
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 17:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761803AbYCFQx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 11:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbYCFQx3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 11:53:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:38470 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751986AbYCFQx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 11:53:28 -0500
Received: (qmail invoked by alias); 06 Mar 2008 16:53:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 06 Mar 2008 17:53:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184wJwXnUM4pKarrAfukLx7avVIVXSNpAsylnuYsp
	33m3GzLO5HCDfK
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76400>


At least on one of my machines, Term::ReadLine tries to be clever and
sends \x1b\x5b1034h at the end of the script when TERM is set to 'xterm'.

To prevent that, force TERM=dumb just for the test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9001-send-email.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index cbbfa9c..d6fcac3 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -68,7 +68,7 @@ Result: OK
 EOF
 
 test_expect_success 'Show all headers' '
-	git send-email \
+	TERM=dumb git send-email \
 		--dry-run \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
-- 
1.5.4.3.571.g9aec3.dirty

