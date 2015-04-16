From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/5] t3701-add-interactive: simplify code
Date: Thu, 16 Apr 2015 09:02:27 +0200
Message-ID: <1429167751-19398-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
 <1429167751-19398-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Tanky Woo <wtq1990@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 16 09:03:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YidpC-000452-LH
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 09:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756916AbbDPHCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 03:02:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33521 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbbDPHCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 03:02:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72b3b029306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2015 09:02:37 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72bPf021220;
	Thu, 16 Apr 2015 09:02:37 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Yidor-0005Bw-Pp; Thu, 16 Apr 2015 09:02:37 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <1429167751-19398-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Apr 2015 09:02:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3G72b3b029306
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1429772559.30098@INwpOP9m6IfVdoCDjPKoMg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267253>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t3701-add-interactive.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 24ddd8a..b63b9d4 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -326,10 +326,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	# 2. Correct version applies the (not)edited version, and asks
 	#    about the next hunk, against which we say q and program
 	#    exits.
-	for a in s e     q n q q
-	do
-		echo $a
-	done |
+	printf "%s\n" s e     q n q q |
 	EDITOR=: git add -p &&
 	git diff >actual &&
 	! grep "^+15" actual
-- 
2.4.0.rc1.42.g9642cc6
