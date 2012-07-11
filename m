From: Alexander Strasser <eclipse7@gmx.net>
Subject: [PATCH 6/6] t4012: Make --shortstat more robust
Date: Thu, 12 Jul 2012 00:13:27 +0200
Message-ID: <20120711221327.GA21382@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 00:13:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp5AC-0005OR-Jw
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 00:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404Ab2GKWNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 18:13:35 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:48471 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753876Ab2GKWNd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 18:13:33 -0400
Received: (qmail invoked by alias); 11 Jul 2012 22:13:30 -0000
Received: from p5B06F836.dip.t-dialin.net (EHLO gmx.net) [91.6.248.54]
  by mail.gmx.net (mp034) with SMTP; 12 Jul 2012 00:13:30 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX1/1SlwjcaP1Dq2ghJUbsuQ3KTneHeYsZDSxBXDHMT
	IcYAfidlOxFIGs
Received: by gmx.net (sSMTP sendmail emulation); Thu, 12 Jul 2012 00:13:27 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201339>

The --shortstat test depends on the same scenario as the
--stat test. Use the part of the same expected result for
the --stat test to avoid duplicating it manually.

Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
---
 t/t4012-diff-binary.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 81a9e8c..a3f6030 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -38,9 +38,9 @@ test_expect_success 'apply --stat output for binary file change' '
 '
 
 test_expect_success 'diff --shortstat output for binary file change' '
-	echo " 4 files changed, 2 insertions(+), 2 deletions(-)" >expected &&
+	tail -1 expected >expect &&
 	git diff --shortstat >current &&
-	test_i18ncmp expected current
+	test_i18ncmp expect current
 '
 
 test_expect_success 'diff --shortstat output for binary file change only' '
-- 
1.7.10.2.552.gaa3bb87
