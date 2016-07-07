Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7221E2070F
	for <e@80x24.org>; Thu,  7 Jul 2016 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbcGGPxH (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 11:53:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:51461 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099AbcGGPxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 11:53:04 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MNf1y-1bE0bJ42Xq-0079V2; Thu, 07 Jul 2016 17:52:52
 +0200
Date:	Thu, 7 Jul 2016 17:52:50 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] t3404: add a test for the --gpg-sign option
In-Reply-To: <cover.1467906747.git.johannes.schindelin@gmx.de>
Message-ID: <4fe1c1b7598f3c5ddc0cf8f9c0ef89ac193a22e2.1467906747.git.johannes.schindelin@gmx.de>
References: <cover.1467210629.git.johannes.schindelin@gmx.de> <cover.1467906747.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RdKH8kLsI0WreFrj8ptdIUxxfUxU72XAyYx4XRRwfJlDqv9myhm
 a3oY3Zr+cJNZKF27JvD++Kn3XhROBy+IvxXq0XBrM20BZ0vWrHO7nPE9zW/gyEMQbvoRJf4
 8ysZe2y92pGn9i9V8cMW1Jtno2Kl+OlivydRK/gJHXtDaHG3ogPte6Sl6Udkz98NhWP+1ER
 g7/MBzOReNFwKVmDhmv7A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:l/nRu8OhTG8=:B8QV7x2GHtVccycekKSZev
 BJX8INeRZ4RkulkoA074dMHZbxkJcQSNh68//p9Cg6PO/z/I3LWHDBKVyX35EtKu41nKW0pYE
 ANAENKNaVYF6WrF1YBX9g4BfXH2qEYzEBkXpC3GMeadRRtMUvisG9CZ6slP+lgK3ZeB5HAoVJ
 M31BK4464+LGIEyTKgWb20s82MAUFYHqBeJbhZHeScszaiU1OgYNWuzUoR+Atp9m/3pjryA6D
 tdD/jXk1IMbkVsL1kcnQpK5GMr0eA0pUYxx5+UbTVvwK0mC5r+pHnQKVAos1WOQ+d//lJC2xT
 d4Aeja85fkeFjYGgjYZTZ9j25lvNC3xpIV/RIexyYfjiLh9lWhsCUrWTqmwqL/h42/TIzonu3
 OaXfo18Uqi1ubfCHXuZUiZqArM25nm50x2rlnC0mQ1eH2Io1eZWArAoXx11ZCxA5n0f/iXNjB
 iXNPhqW18VjVhg4oIc7GUg7rU/7JomcvqOINDBYD6dhooQBoP7QbYYem3i0HEJ2njCzxv/A/+
 s7Haru476959HTI/hG722Gzd8iP3KJR8I4YXCvr2S4pew6rjVJoJFrREdac3tgHGYiSNXBQYv
 1ozRxPPru5y5lNN4iWhXUwhFopfBthndi0nN026CkAvw1OS3WtzxbFkCrPcmhwup/NETtjpRm
 nrJYlgdCBFtKh1rxCic53/PCSMDFqPWgX2CmdOuXsYZB3qJnJuzx+WkjDvOPzkga/LY1h0Zxy
 rwdzSUG8vZxzh1kA3Sj3bzOQr2Ytj44Jw9MhdklyypMMr9GGDKHgjzL4xcG0wIODvu+KbQFoM
 VZArY+5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

For the upcoming rebase--helper work (which will accelerate the
interactive rebase noticably), it is important to verify that the
--gpg-sign option is handled properly.

Please note that this patch does this on the cheap, by verifying that
the expected option is printed in the message of the 'edit' operation.

We really should test that the interactive rebase signs the commits
properly, iff GPG is available. This test is left for later.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 66348f1..aa393d2 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1281,4 +1281,12 @@ test_expect_success 'editor saves as CR/LF' '
 	)
 '
 
+SQ="'"
+test_expect_success 'rebase -i --gpg-sign=<key-id>' '
+	set_fake_editor &&
+	FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" HEAD^ \
+		>out 2>err &&
+	grep "$SQ-S\"S I Gner\"$SQ" err
+'
+
 test_done
-- 
2.9.0.278.g1caae67


