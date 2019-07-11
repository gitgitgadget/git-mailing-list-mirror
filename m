Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E601F461
	for <e@80x24.org>; Thu, 11 Jul 2019 17:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfGKRGQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 13:06:16 -0400
Received: from avasout04.plus.net ([212.159.14.19]:42960 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfGKRGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 13:06:16 -0400
Received: from [10.0.2.15] ([146.90.155.229])
        by smtp with ESMTPA
        id lcWLhvYH1aslVlcWMhxH6G; Thu, 11 Jul 2019 18:06:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1562864775; bh=zWvFTjK+mdt6lKZ4aajvPtJZYqXu8vW2UKPLq5flo7U=;
        h=To:Cc:From:Subject:Date;
        b=pso0s2gpCfkpZrKnSek0/iv0IDIYaRL93o7cfJ2XB1bPv3eLKknb8zCUfWjw2559F
         ykwy9KxBpwwm7kiVSaEPZ3FU3LnzaEwuLojaDCQLUYHnBiTZz8XQEp3KIeKsHFfMXJ
         b9XXV6kQlW8StgRq3GQUu8q1AQ5jQWKXeUoezAbmhpC2EuNMET8PWmv4j8V75h+ODb
         MdvWDNqGTK3tO4vPcoNFxJCQTsr0DDdA9sGuQ3p0DuBJBK7Tlu2VhO2jJgXdyk70yr
         3Vv83PxdjAgbVfWPENXnA09Od0mkH6tHNLc7GUCGKcsKtHWmheuI3E8yNttFnp+/3D
         WoDU0SzEMr44w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=bfsVr9HB c=1 sm=1 tr=0
 a=vIuMZWos35SQ56IFzOfLHA==:117 a=vIuMZWos35SQ56IFzOfLHA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5rxgeBVgAAAA:8 a=GUsEZkZUHuiwrE8r0AQA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] env--helper: mark a file-local symbol as static
Message-ID: <9fe826c4-1295-d747-2ae5-e3b85a132d2b@ramsayjones.plus.com>
Date:   Thu, 11 Jul 2019 18:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLT8Tun2tu+9q9SyKzpiQ/t9qTLE6/SL7PmFp1vwDPmbTaLP8sd5GeednFV2Q30gBmPJCeHUQSaMkaAahRGh19leViUAREVlabWVu8UPExdoQQtH3wLK
 bbvW1r5+0Gc042XFNc91/cBIk7vQRBld9OG+/kUmeZX1A+zbwoWrPjnEPdgP2vmD15cEAapfrqHgAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

It seems Ævar didn't have a need to re-roll his patches [1], before
the 'ab/test-env' branch was merged to next. This version of the
patch is based on current 'next'.

Thanks!

ATB,
Ramsay Jones

[1] https://public-inbox.org/git/f576dfa8-4beb-6430-67b3-6c05f520b040@ramsayjones.plus.com/

 builtin/env--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/env--helper.c b/builtin/env--helper.c
index 1083c0f707..23c214fff6 100644
--- a/builtin/env--helper.c
+++ b/builtin/env--helper.c
@@ -7,7 +7,7 @@ static char const * const env__helper_usage[] = {
 	NULL
 };
 
-enum {
+static enum {
 	ENV_HELPER_TYPE_BOOL = 1,
 	ENV_HELPER_TYPE_ULONG
 } cmdmode = 0;
-- 
2.22.0
