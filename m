Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB9720450
	for <e@80x24.org>; Fri,  3 Nov 2017 17:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756281AbdKCRFP (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 13:05:15 -0400
Received: from avasout08.plus.net ([212.159.14.20]:37113 "EHLO
        avasout08.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756253AbdKCRFM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2017 13:05:12 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by smtp with ESMTPA
        id AfP2emtHyufWkAfP3eWAAV; Fri, 03 Nov 2017 17:05:10 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=PI5/wbiC c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=GEHNxeAdH0nTW0Ym0ZUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] fix an 'dubious one-bit signed bitfield' error
Message-ID: <7b066cbc-416b-b870-5fd5-3673ece036f8@ramsayjones.plus.com>
Date:   Fri, 3 Nov 2017 17:05:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIUltB/G2AuZkhpwjnstzPaWATJG7zX9+MojJ61eAHLts8TP5Uw5p07pP+aiX4KEi9Q63PNQi4rWGEQen15fNGykcNm+RHQo4lSz3Tzaubu46H2IhqGw
 x+U5NuoW6+GqSO3eJuUfM0+EuQmSQ8ktz+cU2n7q8RL6ydlhylEuxMSdVgz2uy+BEyNequSyE8tL5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jh/object-filtering' branch, could
you please squash this into the relevant commit (b87fd93d81,
"list-objects: filter objects in traverse_commit_list", 02-11-2017).

[This error was issued by sparse]

Thanks!

ATB,
Ramsay Jones

 list-objects-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 7f2842547..d9e626be8 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -191,7 +191,7 @@ static void *filter_blobs_limit__init(
  */
 struct frame {
 	int defval;
-	int child_prov_omit : 1;
+	unsigned int child_prov_omit : 1;
 };
 
 struct filter_sparse_data {
-- 
2.15.0
