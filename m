Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E69420281
	for <e@80x24.org>; Sun,  1 Oct 2017 07:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750992AbdJAH3B (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 03:29:01 -0400
Received: from mout.web.de ([217.72.192.78]:53931 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750849AbdJAH3A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 03:29:00 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQNma-1dt9qB3HcC-00TiHx; Sun, 01
 Oct 2017 09:28:51 +0200
Subject: [PATCH 4/3] refs: pass NULL to refs_resolve_refdup() if hash is not
 needed
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <366c778c-b587-de62-1d19-145d46fb1989@web.de>
Date:   Sun, 1 Oct 2017 09:28:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:u7J6CvVT5iE3AAZGUbRvTyb3JhuVH0m+ZhMTAndaQ3Mkdl9Tns6
 aovT9lSWTi1eYqHvsasrL6+pbbl0KynxRZVURj+4kt4GePl2p+jmxlZ6nWtP13exTj2c8IT
 X+pQUNOnCurKrv5sLHw8i38UHoVnCHzULuWulIK4rkV2H3t8w4HmZdwDyahbL/RdPm+N1P7
 fCQFYnA+9S2fA19MQRBbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t83tI+W77Nw=:sVI7FgWJwt9wbgFauE/xtp
 9weGq90Cx2osDwe27NmDVeBmx60HXUyGT6HtZ0uyiiVI8exHsFOu/3F37XLk9ycCKf5yFiq9d
 21d3OTyIZFHiC5BYSGkexwDwMniVXA5tMQX/uaCznus/xZGiH4RFK2YWgMKISiSTaFlhhwFrJ
 kq9taIVvZySFQ3Bmy6r1d22opQDC/EwUnjUXq+2hffCy9CFLMqIGM+WvZY1q6xGB7oYBUZ9ia
 SIKkWLeEhe9+oh3JUcCtpghtPjBz36ld3Stwo8G2wC0xhf4u3xpa3m6OrsoYfxxT/azono0/0
 gSlWcuqo4LtOhddhtzjLYldgn3sKH9KitVX4S2Xtzt+TvxT57qR6dMp8XV45mnUfzVAJe4YxV
 VkXwAe3p6O0RrJrWNAsenhBeC7RlPXA86nZKNix5BTEeTfaSSF4q95a8y3rviVM80QA/do5Ut
 MwkiOKp+0LR7aeqcIfomPEqG2sesWD2ytMbD/bqlXM5FNfuQWlwC5Yc+S0Or//quk/Ih5MS5X
 2cugp9QNPabiUxx0WK+1cuyiuHTjGzbcVqeDFFRXvqat/sTcxzfQjYqZd7/pd1AgvTJdY3Ccw
 fFvXyV3cC8f9lmCIy0p/g1DWKy/rzFFdUCo4+b67UGrGBiTjnA2K2UlpWDh/PyCvEBhSHa5Li
 uo1PztpzfnbM48xbX3p8qu1hD5ZPnJLXKyqZyYKrkCKyfRDY5ZghzQcWDlHFZGwjmDpd7/RF9
 +mEtonzqpsBFKmvhNbwTQyd726goC6VrcHromTfi0AVoFrlcyHE8ApYjrUuHspdz3H+IRxOH6
 j6oqhpXll1Z+pIxVAMBp3BJCJiBNAAUg2/nAEAEJt2QItno2vg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This gets us rid of a write-only variable.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 refs/files-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fec77744b4..ed00ddab1a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2499,7 +2499,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	char *head_ref = NULL;
 	int head_type;
-	struct object_id head_oid;
 	struct files_transaction_backend_data *backend_data;
 	struct ref_transaction *packed_transaction = NULL;
 
@@ -2556,7 +2555,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 */
 	head_ref = refs_resolve_refdup(ref_store, "HEAD",
 				       RESOLVE_REF_NO_RECURSE,
-				       head_oid.hash, &head_type);
+				       NULL, &head_type);
 
 	if (head_ref && !(head_type & REF_ISSYMREF)) {
 		FREE_AND_NULL(head_ref);
-- 
2.14.2

