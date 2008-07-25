From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Set TAR in t/Makefile and in t4116-apply-reverse.sh
Date: Fri, 25 Jul 2008 18:37:40 +0200
Message-ID: <1217003860-10609-1-git-send-email-s-beyer@gmx.net>
References: <TE3N1FoSy-vEEv0qsAyvBwBMMq2RuJCWYw7DNLBC7mEh6PxM1LCsOw@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jul 25 18:38:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQJe-0005l4-1W
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 18:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbYGYQhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 12:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbYGYQhu
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 12:37:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:36057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751689AbYGYQhu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 12:37:50 -0400
Received: (qmail invoked by alias); 25 Jul 2008 16:37:48 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp061) with SMTP; 25 Jul 2008 18:37:48 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+C/0UF662C84/OFBcTlx4ikEM7zNnb79Gn+z0n94
	s0Yh/fXShjekm/
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMQIW-0002lV-Iu; Fri, 25 Jul 2008 18:37:40 +0200
X-Mailer: git-send-email 1.6.0.rc0.102.ga1791
In-Reply-To: <TE3N1FoSy-vEEv0qsAyvBwBMMq2RuJCWYw7DNLBC7mEh6PxM1LCsOw@cipher.nrlssc.navy.mil>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90068>

Hence, the test passes also when you run "make" in t/
or when you invoke t4116-apply-reverse.sh directly,
without $TAR being set.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 t/Makefile               |    2 +-
 t/t4116-apply-reverse.sh |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 0d65ced..b720943 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -5,7 +5,7 @@
 
 #GIT_TEST_OPTS=--verbose --debug
 SHELL_PATH ?= $(SHELL)
-TAR ?= $(TAR)
+TAR ?= tar
 RM ?= rm -f
 
 # Shell quote;
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index 2298ece..3ff5d9e 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -8,6 +8,7 @@ test_description='git apply in reverse
 '
 
 . ./test-lib.sh
+TAR=${TAR:-tar}
 
 test_expect_success setup '
 
-- 
1.6.0.rc0.102.ga1791
