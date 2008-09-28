From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Add a basic test for the textconv filter.
Date: Sun, 28 Sep 2008 04:06:58 +0200
Message-ID: <1222567618-22156-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
 <1222567618-22156-2-git-send-email-Matthieu.Moy@imag.fr>
 <1222567618-22156-3-git-send-email-Matthieu.Moy@imag.fr>
 <1222567618-22156-4-git-send-email-Matthieu.Moy@imag.fr>
 <1222567618-22156-5-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 04:11:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjlkL-0004Jm-9P
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 04:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbYI1CJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 22:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbYI1CJj
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 22:09:39 -0400
Received: from imag.imag.fr ([129.88.30.1]:60051 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbYI1CJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 22:09:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m8S26xLv026012
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 28 Sep 2008 04:07:00 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KjlgY-0001df-9K; Sun, 28 Sep 2008 04:06:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KjlgY-00060V-6Q; Sun, 28 Sep 2008 04:06:58 +0200
X-Mailer: git-send-email 1.6.0.2.312.g1ef81a
In-Reply-To: <1222567618-22156-5-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 28 Sep 2008 04:07:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96935>

---
 t/t4020-diff-external.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index dfe3fbc..cf99912 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -99,6 +99,13 @@ test_expect_success 'no diff with -diff' '
 	git diff | grep Binary
 '
 
+test_expect_success 'textconv attribute' '
+	git config textconv.echo.command echo
+	echo >.gitattributes "file textconv=echo"
+
+	git diff | grep "^+file$"
+'
+
 echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
 
 test_expect_success 'force diff with "diff"' '
-- 
1.6.0.2.312.g1ef81a
