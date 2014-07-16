From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] fixup for patch 2: minor style fix
Date: Wed, 16 Jul 2014 18:09:10 +0200
Message-ID: <1405526952-25019-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqha2h9tjw.fsf@anie.imag.fr>
Cc: artagnon@gmail.com, tanayabh@gmail.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 16 18:09:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Rlq-0001Ln-Ul
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 18:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbaGPQJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 12:09:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42299 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030363AbaGPQJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 12:09:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6GG9CRb028785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jul 2014 18:09:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6GG9EXA027114;
	Wed, 16 Jul 2014 18:09:14 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1X7Rla-0006cJ-0M; Wed, 16 Jul 2014 18:09:14 +0200
X-Mailer: git-send-email 2.0.0.262.gdafc651
In-Reply-To: <vpqha2h9tjw.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 16 Jul 2014 18:09:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6GG9CRb028785
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1406131754.02642@IkKhIbWFcUocuLQLTWbgJw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253672>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t1308-config-set.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 4752fd9..ea031bf 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -150,8 +150,8 @@ test_expect_success 'find value from a configset' '
 '
 
 test_expect_success 'find value with highest priority from a configset' '
-	echo hask > expect &&
-	test-config configset_get_value case.baz config2 .git/config  >actual &&
+	echo hask >expect &&
+	test-config configset_get_value case.baz config2 .git/config >actual &&
 	test_cmp expect actual
 '
 
@@ -163,7 +163,7 @@ test_expect_success 'find value_list for a key from a configset' '
 	lama
 	ball
 	EOF
-	test-config configset_get_value case.baz config2 .git/config  >actual &&
+	test-config configset_get_value case.baz config2 .git/config >actual &&
 	test_cmp expect actual
 '
 
@@ -173,7 +173,7 @@ test_expect_success 'proper error on non-existant files' '
 	test_cmp expect actual
 '
 
-test_expect_success 'proper error on non-accessible  files' '
+test_expect_success 'proper error on non-accessible files' '
 	chmod -r .git/config &&
 	test_when_finished "chmod +r .git/config" &&
 	echo "Error reading configuration file .git/config." >expect &&
@@ -184,14 +184,14 @@ test_expect_success 'proper error on non-accessible  files' '
 test_expect_success 'proper error on error in default config files' '
 	cp .git/config .git/config.old &&
 	test_when_finished "mv .git/config.old .git/config" &&
-	echo "[" >> .git/config &&
+	echo "[" >>.git/config &&
 	echo "fatal: bad config file line 35 in .git/config" >expect &&
 	test_expect_code 128 test-config get_value foo.bar 2>actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'proper error on error in custom config files' '
-	echo "[" >> syntax-error &&
+	echo "[" >>syntax-error &&
 	echo "fatal: bad config file line 1 in syntax-error" >expect &&
 	test_expect_code 128 test-config configset_get_value foo.bar syntax-error 2>actual &&
 	test_cmp expect actual
-- 
2.0.0.262.gdafc651
