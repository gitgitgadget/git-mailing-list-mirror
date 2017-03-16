Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C53CF202C1
	for <e@80x24.org>; Thu, 16 Mar 2017 01:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750884AbdCPBFM (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 21:05:12 -0400
Received: from avasout01.plus.net ([84.93.230.227]:51522 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdCPBFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 21:05:11 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id wR211u00622aPyA01R2207; Thu, 16 Mar 2017 01:02:03 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=VXp1K049uEnckSiTuaAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] submodule.c: fix an 'using integer as NULL pointer' warning
Message-ID: <2134ffee-f144-1fb3-7e0e-325fd2873ba9@ramsayjones.plus.com>
Date:   Thu, 16 Mar 2017 01:02:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Brandon,

If you need to re-roll your 'bw/submodule-is-active' branch, could
you please squash this into the relevant patch (commit 20d59ab335,
"submodule: decouple url and submodule existence", 13-03-2017).

Thanks!

ATB,
Ramsay Jones

 submodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 800283154..a77d11cc4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -245,7 +245,7 @@ int is_submodule_initialized(const char *path)
 			argv_array_push(&args, item->string);
 		}
 
-		parse_pathspec(&ps, 0, 0, 0, args.argv);
+		parse_pathspec(&ps, 0, 0, NULL, args.argv);
 		ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
 
 		argv_array_clear(&args);
-- 
2.12.0
