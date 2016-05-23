From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2 12/22] t6030: update to use test_i18ncmp
Date: Mon, 23 May 2016 19:27:31 +0000
Message-ID: <1464031661-18988-13-git-send-email-vascomalmeida@sapo.pt>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 21:29:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vXz-0001mo-4z
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbcEWT3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:29:45 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47392 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753679AbcEWT3m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:29:42 -0400
Received: (qmail 24061 invoked from network); 23 May 2016 19:29:41 -0000
Received: (qmail 4170 invoked from network); 23 May 2016 19:29:41 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 23 May 2016 19:29:40 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295363>

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
