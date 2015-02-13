From: =?UTF-8?q?=D0=94=D0=B8=D0=BB=D1=8F=D0=BD=20=D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2?= 
	<git-dpa@aegee.org>
Subject: [PATCH] Remove duplicate #include
Date: Fri, 13 Feb 2015 14:47:39 +0000
Message-ID: <1423838859-15413-1-git-send-email-git-dpa@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 16:05:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMHoI-0005W7-Ie
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 16:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbbBMPFe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2015 10:05:34 -0500
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:41871 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbbBMPFc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 10:05:32 -0500
X-Greylist: delayed 1076 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Feb 2015 10:05:31 EST
Received: from test.aegee.org (aegeepc1.aegee.uni-karlsruhe.de [129.13.131.81])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1YMHWn-0007mP-GC; Fri, 13 Feb 2015 15:47:33 +0100
Received: from test.aegee.org (localhost [127.0.0.1])
	by test.aegee.org (8.15.1/8.14.5) with ESMTP id t1DEldU3015479;
	Fri, 13 Feb 2015 14:47:39 GMT
DKIM-Filter: OpenDKIM Filter v2.10.0 test.aegee.org t1DEldU3015479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1423838860; i=dkim+sm-localhost@aegee.org;
	bh=rH//JpE9dVy5YqvoVvhbRgBRycgQZ7wFjGZu+c2u6os=;
	h=From:To:Subject:Date;
	b=ld+3Gta3rbUMkge9iJguMY+S/3Dqv7By585yyPe8HEXPppUb8yoWRctx2iV5F1YzL
	 ytZd0qk0Ld0ciVPKMZg/z8hXSKwKOuvQ3x5U/HNYOpimwyiqpPU+AN1bwuAvY4vJvj
	 4QzDyBHtmXV7wLtZIgqJ02pIf+kbZN8bjr/rehp5PJAn7aw8qz2L4L8I8ncSuKC1a5
	 t4yh6ZyEDXEzS5lGR2FAZX55VFc374LLB7wpcTxoMtz0Zequ644fcL7SV5G1tf1TlI
	 13EUgz/YmPltWtM3Mug2KvmndVIsXtp/6fQGsmWH2GD3TN2biY1j3SWoHo4JThS95/
	 MVUFkncCPwdo5oU+gPQgaEreffxLnBZvKkrnEW14gpWsvQIsf3/5FXt9zUsViIYjWh
	 9RGkVRc8cJ6FZs5eY3Dy3ypKKBr1qhF0nUFvGIJunfx1d2qnIB+0MxCrBPCp7jDrem
	 Jf24VPUe+iYOMub7AixPiLXFcUq53YAEWd6SKVGf7q9vvF5dmUQo+RuNKnPe0xUBbI
	 tdTBEdiI6+DJWEB4jjJWFgzFz/BPL9kap1xF87hr7F98KsLAUAiQm95JI0Q5+u1Bkt
	 9Evvv9yEqfZfRI3xATntXvF/CDAdVqf4nNxLaL0i61hy/c5tUvbskng1mPRXQhmAiB
	 pYYa1x5DupO 
Received: (from root@localhost)
	by test.aegee.org (8.15.1/8.14.5/Submit) id t1DEldt1015469;
	Fri, 13 Feb 2015 14:47:39 GMT
X-Mailer: git-send-email 2.3.0.1.g02b6b75
X-Virus-Scanned: clamav-milter 0.98.6 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263809>

deheader (git://gitorious.org/deheader/deheader.git) found out that
some .c files #include twice one and the same header file.

This patch removes such occurrences and hence speeds up the compilation=
=2E

Signed-off-by: =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=
=83=D0=B7=D0=BE=D0=B2 <git-dpa@aegee.org>
---
 builtin/fetch.c    | 1 -
 trailer.c          | 1 -
 transport-helper.c | 1 -
 userdiff.c         | 1 -
 4 files changed, 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7b84d35..75a55e5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -11,7 +11,6 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "sigchain.h"
-#include "transport.h"
 #include "submodule.h"
 #include "connected.h"
 #include "argv-array.h"
diff --git a/trailer.c b/trailer.c
index 623adeb..05b3859 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "string-list.h"
 #include "run-command.h"
-#include "string-list.h"
 #include "commit.h"
 #include "trailer.h"
 /*
diff --git a/transport-helper.c b/transport-helper.c
index 0224687..3652b16 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -5,7 +5,6 @@
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
-#include "quote.h"
 #include "remote.h"
 #include "string-list.h"
 #include "thread-utils.h"
diff --git a/userdiff.c b/userdiff.c
index fad52d6..2ccbee5 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "userdiff.h"
-#include "cache.h"
 #include "attr.h"
=20
 static struct userdiff_driver *drivers;
--=20
2.3.0.1.g24c2b87
