From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 12/39] t6030: update to use test_i18ncmp
Date: Wed,  1 Jun 2016 16:41:02 +0000
Message-ID: <1464799289-7639-13-git-send-email-vascomalmeida@sapo.pt>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:44:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89Ft-0005CT-Uu
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161785AbcFAQnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:43:47 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:43370 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161628AbcFAQnp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:43:45 -0400
Received: (qmail 12624 invoked from network); 1 Jun 2016 16:43:27 -0000
Received: (qmail 14957 invoked from network); 1 Jun 2016 16:43:27 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:43:22 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296110>

Since the git bisect output tested here is subject to translation, the
helper function test_i18ncmp should be used over test_cmp.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 t/t6030-bisect-porcelain.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index e74662b..7012011 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -803,7 +803,7 @@ test_expect_success 'bisect terms needs 0 or 1 argument' '
 	test_must_fail git bisect terms 1 2 &&
 	test_must_fail git bisect terms 2>actual &&
 	echo "no terms defined" >expected &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success 'bisect terms shows good/bad after start' '
@@ -875,7 +875,7 @@ test_expect_success 'bisect start --term-* does store terms' '
 	Your current terms are two for the old state
 	and one for the new state.
 	EOF
-	test_cmp expected actual &&
+	test_i18ncmp expected actual &&
 	git bisect terms --term-bad >actual &&
 	echo one >expected &&
 	test_cmp expected actual &&
-- 
2.7.3
