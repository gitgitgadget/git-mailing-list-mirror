Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7E01FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbcFQUYY (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:24:24 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35356 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932943AbcFQUYU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:24:20 -0400
Received: (qmail 2222 invoked from network); 17 Jun 2016 20:24:18 -0000
Received: (qmail 5022 invoked from network); 17 Jun 2016 20:24:18 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:24:18 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 12/38] t6030: update to use test_i18ncmp
Date:	Fri, 17 Jun 2016 20:21:01 +0000
Message-Id: <1466194887-18236-13-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
References: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.6.6

