Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675361F404
	for <e@80x24.org>; Fri,  2 Mar 2018 02:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164468AbeCBCyG (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 21:54:06 -0500
Received: from avasout01.plus.net ([84.93.230.227]:47954 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164430AbeCBCyF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 21:54:05 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id rapfeQPr2yLu5rapgeuir1; Fri, 02 Mar 2018 02:54:04 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QqtwI26d c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=eHqsBDHSK0Bq16MoYM8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ungureanupaulsebastian@gmail.com,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/2] ref-filter: mark a file-local symbol as static
Message-ID: <1d28d866-535c-6d37-4cb9-5decedab3acb@ramsayjones.plus.com>
Date:   Fri, 2 Mar 2018 02:54:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH7Q+D5RpHpf0wPBz3CzPrM06J0xo7UM8pYta4w6c+DnqqMcY8nfFs/3ibErV15ZuUW5Y7yxbDVc+K27sye98/Xqj9q21rpf4lQq0mtBwK0mnMhdGw2y
 vGgAm5yxMyA+/ecJcnQA+ksfp0W3sG+hb3XRew5VnqLpM+xmMy6Ix4vmJkgvYwUrPU+k9XZKgFzzZw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit fcfba37337 ('ref-filter: make "--contains <id>" less chatty if
<id> is invalid', 2018-02-23) added the add_str_to_commit_list()
function, which causes sparse to issue a "... not declared. Should it
be static?" warning for that symbol.

In order to suppress the warning, mark that function as static.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index f375e7670..69bf7b587 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2000,7 +2000,7 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 	free(to_clear);
 }
 
-int add_str_to_commit_list(struct string_list_item *item, void *commit_list)
+static int add_str_to_commit_list(struct string_list_item *item, void *commit_list)
 {
 	struct object_id oid;
 	struct commit *commit;
-- 
2.16.0
