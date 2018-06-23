Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB501F516
	for <e@80x24.org>; Sat, 23 Jun 2018 13:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeFWNUv (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 09:20:51 -0400
Received: from avasout07.plus.net ([84.93.230.235]:41843 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeFWNUu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 09:20:50 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id WiT9fxNx0jlDzWiTAfJS4L; Sat, 23 Jun 2018 14:20:49 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=EJcDbRoJ1uWonukcDCMA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] diff: fix a sparse 'dubious one-bit signed bitfield' error
Message-ID: <1f29f275-1cc9-e082-bac4-6eb9e9e08484@ramsayjones.plus.com>
Date:   Sat, 23 Jun 2018 14:20:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHwpOY+Bi61Mb4HmKReqY0njmfQNzx5N5ECDwxdyGVZBthn5PbTS5jEe7QB33SCKuuuQbo6PLdqgnDlZFRXXeWWqHfIfbpAU/Rx2Oi9UO4mWkclGZWSX
 rfVhtbjk3fKfI8UCApj/+pFWkan4Gv0MdZy5MXIeKSEvDFq9kQzfa9bDRTceh8vl9tMn9hj0ta2iuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Stefan,

If you need to re-roll your 'sb/diff-color-move-more' branch, could
you please squash this into the relevant patch (commit f2d78d2c67,
"diff.c: add white space mode to move detection that allows indent
changes", 2018-06-21).

Thanks!

ATB,
Ramsay Jones

 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index c91480141..652521ff2 100644
--- a/diff.c
+++ b/diff.c
@@ -756,7 +756,7 @@ struct moved_entry {
  */
 struct ws_delta {
 	char *string;
-	int current_longer : 1;
+	unsigned int current_longer : 1;
 };
 #define WS_DELTA_INIT { NULL, 0 }
 
-- 
2.18.0
