Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CC11F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbeGLPmb (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 11:42:31 -0400
Received: from avasout07.plus.net ([84.93.230.235]:39104 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeGLPmb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 11:42:31 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id ddZxfSLdPjlDzddZyfTDah; Thu, 12 Jul 2018 16:32:27 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=7vvq5RCAhBOpVVYpc8cA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] t6036: fix broken && chain in sub-shell
Message-ID: <c9201ced-34a8-98f4-2da6-9c36c408b501@ramsayjones.plus.com>
Date:   Thu, 12 Jul 2018 16:32:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNiTbooyI8y1wfCyq98goNP30ApSeJiQ8H9rk2f2xt1WDpvW6WHQfvLg0valwJZ0rJVjZcUZ+b5jkwYSkDWA7CxBGNRVEFdrGrw2/uLRtALPjQQinO5c
 7CIQjpdMNcsRheooGbDt3/LMQ/0hQ5Xpsl/nxs6cnBYV0poor1OgYUJZqKyNXX37Nd6bRaeX94VSPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

I had a test failure on 'pu' today - Eric's chain-lint series
found another broken chain in one of Elijah's new tests (on the
'en/t6036-recursive-corner-cases' branch).

ATB,
Ramsay Jones

 t/t6036-recursive-corner-cases.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 2a44acace..59e52c5a0 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -495,7 +495,7 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 		test_write_lines 1 2 3 4 5 6 7 8 >a &&
 		git add a &&
 		git commit -m E3 &&
-		git tag E3
+		git tag E3 &&
 
 		git checkout C^0 &&
 		test_must_fail git merge B^0 &&
-- 
2.18.0
