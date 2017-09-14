Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A6720A21
	for <e@80x24.org>; Thu, 14 Sep 2017 13:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdINNPo (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 09:15:44 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51140 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdINNPj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 09:15:39 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue001
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MYGYa-1dx0D12syW-00Uuv8; Thu, 14
 Sep 2017 15:15:27 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 1/3] t6010: test actual test output
Date:   Thu, 14 Sep 2017 15:15:18 +0200
Message-Id: <80f7dcfaa9162dc795f8c072effea44fa83ea196.1505394278.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.712.gda4591c8a2
In-Reply-To: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
In-Reply-To: <cover.1505394278.git.git@grubix.eu>
References: <cover.1505394278.git.git@grubix.eu>
X-Provags-ID: V03:K0:pyQ7HvOl+ZDLnWdRhmh+7ojoTwet5sStkcJI7I7oDd74Pi+zqJa
 huC7Gd9qpPfyvvB1nj+eZ5nlS/LcxaluvPSfYPE7SQ5j/NZBIIRa21LDtvMkzofH0CDvjC7
 RyMFzyQSSC7CYDHOevjzni1bTHTieRqyOi/ebJFyF8n0g1YFyNcOXVzIHwGOE+P5rzR3409
 /yhkH+u3eLHuVuXiezNPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TSEX5NN/6Xo=:xo3bUxnEHYvozzhun2wNDQ
 40Mprp1s1mS305IGgAByqd09c2WkxQfojzWXh8PJ/yfa0wSNN1138a927QYARuEtIRWGp8V7/
 N1OEIlL41EVLrkEN1f/mEYGCLgODx1cgWV5EtNXn3dWnUfa49e2uRcjRSR6Z3ya1DoFRDslIy
 uzEodLYIkhe3srdVVwuTN3AwXVZ3ghgIbui+8QphChK2n+2fZ1lmaxsmBBjFSDtvt/1OM5AD2
 bV+1kWgM9AbUkkiA/gIerIIN0/uE2IqeXknHq/AIqfSdy0ykMs2riSZY3b+0EJzI1K6pCjQ4u
 T+sHOq2KTiv3CqGzMY0mBC0RDugvl20m6if4By5YhcG3AP3WqLRIY0Xqvw2MZRzb3xM9TI0VV
 k+tYH/AmlCxtDQNAll982uNJFkCTrnRNHHYq7ufDa8R6wVpx5pm03LiYdjYtxKW8YDrNiHCDF
 hbEvF0XOSsNK3TofZAhu2uJP3bI7KX+HvIql81dMYnYt5iA8VagHVXKlSZz+03YWL9d3s1SGV
 mP+US6ExefqTRfNCQWV6Zfd+uQ5xQ/kijGbAsv3/iQK+mZAzMcmmUF8ZntqpF3mH1YtJ6xJZ2
 fXhGKGsFcsxYrhdU5Lu9WO2kn3eP8C3haTHk6l/iqOBvM8+OrfhUIeZNmr0E5T2nWn42NWaUb
 fQ1UAxJok4JhwmIrOeph2V0kKpgIRGvyuj+BCB1qlpTUadkzt7t+Cp6w76NquHuMyWtcVzxhB
 WSzJ4rp5DCPfB1QF0N2VGcnwiwlp67gxPEARcQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

4f21454b55 ("merge-base: handle --fork-point without reflog",
2016-10-12) introduced a fix for merge-base --fork-point without reflog
and a test. While that test is fine, it did not update expected nor actual
output and tested that of the previous test instead.

Fix the test to test the merge-base output, not just its return code.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 t/t6010-merge-base.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 31db7b5f91..17fffd7998 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -262,8 +262,9 @@ test_expect_success 'using reflog to find the fork point' '
 
 test_expect_success '--fork-point works with empty reflog' '
 	git -c core.logallrefupdates=false branch no-reflog base &&
-	git merge-base --fork-point no-reflog derived &&
-	test_cmp expect3 actual
+	git rev-parse base >expect &&
+	git merge-base --fork-point no-reflog derived >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'merge-base --octopus --all for complex tree' '
-- 
2.14.1.712.gda4591c8a2

