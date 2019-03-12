Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F229C20248
	for <e@80x24.org>; Tue, 12 Mar 2019 02:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfCLCxt (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 22:53:49 -0400
Received: from avasout04.plus.net ([212.159.14.19]:38275 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfCLCxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 22:53:48 -0400
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 3XY2hTTom2Jqz3XY3hfI3e; Tue, 12 Mar 2019 02:53:47 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=I9lLuuog c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=fOhnKkrb-HzE00bGR4EA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     liu.denton@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] sequencer: mark a file-local symbol as static
Message-ID: <d5d47b6b-25d9-a649-e13d-76e98e07ed51@ramsayjones.plus.com>
Date:   Tue, 12 Mar 2019 02:53:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF2C6EnCJjTQbBAIkkP40zJVAB1nnEkdQ4DYSsaf+tdyb4vLHoympozh8RfSCAyO7+6dKen5VH3/MCUhnEBHfJr2URxYGs6KqltMychUgFY/npRcmAvF
 bY9sRnnmvbV7Sg1kUbgsLd2uSTVFMF/Xyboc+n7UZAAoV2L2bZnJr1NgLT73LM4I4lr54B6Seulysw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Denton,

If you need to re-roll your 'dl/merge-cleanup-scissors-fix' branch,
could you please squash this into the relevant patch (commit 9bcdf520cb
("sequencer.c: define get_config_from_cleanup", 2019-03-10)).

I note also, that the get_config_from_cleanup() function is not
called outside of sequencer.c, so that this function could also
be marked static (and remove the extern declaration from the
header file) if there are no plans for future callers.

Thanks!

ATB,
Ramsay Jones


 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 19d1279fa8..833017eb2d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -166,7 +166,7 @@ struct cleanup_config_mapping {
 };
 
 /* note that we assume that cleanup_config_mapping[0] contains the default settings */
-struct cleanup_config_mapping cleanup_config_mappings[] = {
+static struct cleanup_config_mapping cleanup_config_mappings[] = {
 	{ "default", COMMIT_MSG_CLEANUP_ALL, COMMIT_MSG_CLEANUP_SPACE },
 	{ "verbatim", COMMIT_MSG_CLEANUP_NONE, COMMIT_MSG_CLEANUP_NONE },
 	{ "whitespace", COMMIT_MSG_CLEANUP_SPACE, COMMIT_MSG_CLEANUP_SPACE },
-- 
2.21.0
