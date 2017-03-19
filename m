Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994FE20323
	for <e@80x24.org>; Sun, 19 Mar 2017 20:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbdCSUYG (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 16:24:06 -0400
Received: from avasout01.plus.net ([84.93.230.227]:44615 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbdCSUYG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 16:24:06 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id xwPx1u00222aPyA01wPyy3; Sun, 19 Mar 2017 20:23:58 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=ybXZWbkMijh87p0YJ2oA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/2] refs: remove unused head_ref_submodule() implementation
Message-ID: <a3c6fa20-7077-cd27-88da-fec4ded8bb30@ramsayjones.plus.com>
Date:   Sun, 19 Mar 2017 20:23:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


commit 990eaca068 ("refs: remove dead for_each_*_submodule()",
18-03-2017) removed the public declaration of head_ref_submodule(), but
forgot to remove the definition.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Duy,

If you need to re-roll your 'nd/prune-in-worktree' branch, could you please
squash this into the relevant patch.

Also, I note that this patch does not update the technical documentation to
remove references to these api functions. (see Documentation/technical/\
api-ref-iteration.txt).

Thanks!

ATB,
Ramsay Jones

 refs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/refs.c b/refs.c
index 6006d4fdb..e80425379 100644
--- a/refs.c
+++ b/refs.c
@@ -1208,11 +1208,6 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return refs_head_ref(get_submodule_ref_store(submodule), fn, cb_data);
-}
-
 int head_ref(each_ref_fn fn, void *cb_data)
 {
 	return refs_head_ref(get_main_ref_store(), fn, cb_data);
-- 
2.12.0
