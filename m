From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Subject: [PATCH 5/5] init_buffer(): Kill buf pointer
Date: Wed, 25 Apr 2007 11:18:41 -0300
Organization: Mandriva
Message-ID: <20070425111841.2c491281@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Apr 25 16:19:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgiKq-0004GZ-Dj
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 16:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbXDYOTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 10:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbXDYOTE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 10:19:04 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:46452 "EHLO
	perninha.conectiva.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbXDYOTC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 10:19:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 5391017ADB;
	Wed, 25 Apr 2007 11:19:00 -0300 (BRT)
X-Virus-Scanned: amavisd-new at conectiva.com.br
Received: from perninha.conectiva.com.br ([127.0.0.1])
	by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id EjE26c4PzI0G; Wed, 25 Apr 2007 11:19:00 -0300 (BRT)
Received: from localhost (doriath.conectiva [10.0.2.48])
	by perninha.conectiva.com.br (Postfix) with ESMTP id C473217AED;
	Wed, 25 Apr 2007 11:18:42 -0300 (BRT)
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i586-mandriva-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45529>

We don't need it, it's possible to assign the block of memory to bufp

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>
---
 builtin-commit-tree.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 4a8d8d8..ccbcbe3 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -16,9 +16,8 @@
  */
 static void init_buffer(char **bufp, unsigned int *sizep)
 {
-	char *buf = xmalloc(BLOCKING);
+	*bufp = xmalloc(BLOCKING);
 	*sizep = 0;
-	*bufp = buf;
 }
 
 static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
-- 
1.5.1.1.320.g1cf2
