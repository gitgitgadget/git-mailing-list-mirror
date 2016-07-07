Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FEC72070F
	for <e@80x24.org>; Thu,  7 Jul 2016 14:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbcGGOf4 (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:35:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:54136 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbcGGOfx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:35:53 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LfjlS-1beWqK19di-00pQ13; Thu, 07 Jul 2016 16:35:18
 +0200
Date:	Thu, 7 Jul 2016 16:35:15 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 01/16] Verify that `git pull --rebase` shows the helpful
 advice when failing
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <baa7e840b71e14aa69544ae09d3027453602a539.1467902082.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Qf30ivnJ9yrZFkOW8hyuvvOAiLwavN4+/UmF29rUM/kvVVLBE2R
 Gx9JcnIr6+am7qgzaSx4O8MnMdOIBKv49Ml8uTVuzRN89E1UXHUDAb3eYjM2Lecx5jGytrv
 bmogM8WwBNjZm1mLHOgbLJjAOSfmOlDyMY/vYZKS6uqxnOIyWfVOB6nlbnTaIs3znEJwVkf
 0R9vXttG3r13uJJ2Mm0/w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:2pq1m4S3Cv0=:qWLPidOXVyHMhX0Hn3Rt5X
 15gddYwXwHx1pZR+48ynEXtWhZh3Ey++r2RnGF4X24Sa30My1AbIzvRQodKBGDGuHmW4wNpUw
 uyhcfJCrCzeoOZf6Y/1IyR1TG73nZB5/8z9Ufh2qelUX7yHMJQCinPu6avnGI6XVumGZp5IXv
 sJI9VjD1KGdPmtYni6nih5t76FlgBSeAkVMhI+GMNtao6iqWi5OosJmqo7Lv4ALwnhc4njL1e
 mVYMF9Vn95ja8jILqNQOfp+OpilGEy7izRoFxlY+SuywN1KoyfTnoKKeE3+ZuAaJNIRqD8213
 TNj6PWT6xPFkKWL0YlYI9uOF7b2Vie5IM9FuKHeJlxZBETKBZuovavQbcxbiG7BJ+PMuplGNq
 kMnPu1b6OpXKt2dZ6p9TEXFF2GjmjmO5I7GYyflMVMn4IU2ba3VOoxI1W8WaJletGpbotyALp
 3OzENm/LyPv0UwXdL5L3nrNoTXHpfOTO3sHuP9mXZYzgjdlSldg33Glj00Gkg3ISlC8Qpas1L
 /sgdkdr1epFNsBMuVvTseZG+l0o9C/pdEqFYjmPxYG3xJ96MqSTNHSm/23ZQrwKfjoBKG/1FR
 t5xNbrUYsYocskOjyn3thcXtQpVCueVrvYGQIxw2rdoLH7jylQR9Emp+fXwHh78qC7/cO02jJ
 oc3T6vE9tYUiYtBF4WnPGhosNPLh3QD5uKgy9XapobO3DCUN8uREAxjPDAsatcEMZ+wwZou9P
 MBau3qYue3++C6LAaj4DVmYPKsuKbLfh5862OSeWvjCYvClSRqJNTYguY7nfFkppePCMK9XZI
 2yW6P6H
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5520-pull.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 5d4880e..217b416 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -255,6 +255,36 @@ test_expect_success '--rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success '--rebase with conflicts shows advice' '
+	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
+	git checkout -b seq &&
+	printf "1\\n2\\n3\\n4\\n5\\n" >seq.txt &&
+	git add seq.txt &&
+	test_tick &&
+	git commit -m "Add seq.txt" &&
+	printf "6\\n" >>seq.txt &&
+	test_tick &&
+	git commit -m "Append to seq.txt" seq.txt &&
+	git checkout -b with-conflicts HEAD^ &&
+	printf "conflicting\\n" >>seq.txt &&
+	test_tick &&
+	git commit -m "Create conflict" seq.txt &&
+	test_must_fail git pull --rebase . seq 2>err >out &&
+	grep "When you have resolved this problem" out
+'
+test_expect_success 'failed --rebase shows advice' '
+	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
+	git checkout -b diverging &&
+	test_commit attributes .gitattributes "* text=auto" attrs &&
+	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
+	git update-index --cacheinfo 0644 $sha1 file &&
+	git commit -m v1-with-cr &&
+	git checkout -f -b fails-to-rebase HEAD^ &&
+	test_commit v2-without-cr file "2" file2-lf &&
+	test_must_fail git pull --rebase . diverging 2>err >out &&
+	grep "When you have resolved this problem" out
+'
+
 test_expect_success '--rebase fails with multiple branches' '
 	git reset --hard before-rebase &&
 	test_must_fail git pull --rebase . copy master 2>err &&
-- 
2.9.0.278.g1caae67


