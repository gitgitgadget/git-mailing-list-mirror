Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8471F42D
	for <e@80x24.org>; Tue, 29 May 2018 20:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966524AbeE2UBx (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 16:01:53 -0400
Received: from avasout01.plus.net ([84.93.230.227]:46937 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966179AbeE2UBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 16:01:52 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id NkoWfR1sMtHtgNkoXfoCmj; Tue, 29 May 2018 21:01:51 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Iv0wjo3g c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=0TLOQc9KmrmeN7npydgA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] commit-graph: fix a sparse 'integer as NULL pointer' warning
Message-ID: <b22d20c2-f084-1727-cb98-06707e874ef1@ramsayjones.plus.com>
Date:   Tue, 29 May 2018 21:01:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBux0Ri59ITsLZQKVSg4CFG7ds0R9MEd7AkPacdmnunGHqeED7hduwWeMdixF7WB82JWXg4uMn1uWtQ48UUa9sfI/tBmL1JjPGtbiOV76UncIPhPaVSy
 qmgyzTPme1hqfuSpI4MlZIcM9KlRK9RHVxnBSgTtTXd1Nt0con+8o4FjVv3i2RUBD//yxj5T5i/JOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Derrick,

If you need to re-roll your 'ds/commit-graph-fsck' branch (pu@a84e06bc0f),
could you please squash this into the relevant patch (commit 80453b4529,
"commit-graph: add 'verify' subcommand", 2018-05-24).

[No, No, that was the one in graph_read(). :-D ]

Thanks!

ATB,
Ramsay Jones

 builtin/commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 20ce6437a..6abfde5e6 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -39,7 +39,7 @@ static struct opts_commit_graph {
 
 static int graph_verify(int argc, const char **argv)
 {
-	struct commit_graph *graph = 0;
+	struct commit_graph *graph = NULL;
 	char *graph_name;
 
 	static struct option builtin_commit_graph_verify_options[] = {
-- 
2.17.0
