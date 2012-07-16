From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH v2 5/8] t4012: Make --shortstat test more robust
Date: Mon, 16 Jul 2012 22:45:10 +0200
Message-ID: <4b210ed8738abd946521883ae14a885543d720da.1342468069.git.eclipse7@gmx.net>
References: <cover.1342468069.git.eclipse7@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 16 22:45:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqsAX-0002kd-K0
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 22:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab2GPUpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 16:45:19 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:41748 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753917Ab2GPUpR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 16:45:17 -0400
Received: (qmail invoked by alias); 16 Jul 2012 20:45:14 -0000
Received: from p5DC37C42.dip.t-dialin.net (EHLO gmx.net) [93.195.124.66]
  by mail.gmx.net (mp004) with SMTP; 16 Jul 2012 22:45:14 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX18wP2BbgeAwu3RTLc9WZd2ucsoj+UJO5bvG+8rnJI
	1pX8KWu4qwcufc
Received: by gmx.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 22:45:10 +0200
Content-Disposition: inline
In-Reply-To: <cover.1342468069.git.eclipse7@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201572>

The --shortstat test depends on the same scenario as the --stat
test. Use the part of the same expected result for the --stat test
to avoid duplicating it manually.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4012-diff-binary.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index daf8234..4767761 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -38,9 +38,9 @@ test_expect_success 'apply --stat output for binary file change' '
 '
 
 test_expect_success 'diff --shortstat output for binary file change' '
-	echo " 4 files changed, 2 insertions(+), 2 deletions(-)" >expected &&
+	tail -n 1 expected >expect &&
 	git diff --shortstat >current &&
-	test_i18ncmp expected current
+	test_i18ncmp expect current
 '
 
 test_expect_success 'diff --shortstat output for binary file change only' '
-- 
1.7.10.2.552.gaa3bb87
