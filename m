Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A137820A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbdJAOpt (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:45:49 -0400
Received: from mout.web.de ([212.227.15.3]:59375 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbdJAOps (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:45:48 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MS29q-1dsVO748l8-00TCR9; Sun, 01
 Oct 2017 16:45:46 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] graph: use strbuf_addchars() to add spaces
Message-ID: <16d71d5b-6abf-4dcf-0a0b-c09fda7407f7@web.de>
Date:   Sun, 1 Oct 2017 16:45:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:CVrmNGtGc7aVuSTsOaLIvugX6CYqrNwIWXQlRaknm/ihnZ9n2rZ
 /+GhJsqP5D4CWBx/v3d9qo67EQeROdP/gBYz3Q2SWor3zZma5Kpkvm8yw8bfNVu02o33P0d
 NaYGmJ458UTthGTg7DbDtT7/W9Xf2ssQxr0CZcE+Epw6RYzsJ8tqUDw+NJ2JVjfEL0n3lml
 HzlCy7eiebdOH4GNqNFrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kqKmXSFoPpk=:DuRd6zyenDjgKgRB9yJlDV
 fSfC73gkRlsBJv6HFNfHGoGskKbXEO2Xviywd974169RHSfqs0BKv49F01x5LKiOH8JpHlmzK
 C+Vc4VFpb5lXD0nRPy2UFj8Xrpp1FrnlDVyf1Mtf9wGwj4mU7pGii4lToaH6K1n1p8e6rheEs
 eIWMSp9/xYwqC0/VKDnJZw/glUwIoM3JbHtm5B96SKsnAF5+H4v2flCyf+fah30054204kqFk
 BkHd8z0B2ZPmd3cZ1vXjyFHDnM/Mzu8Eb5cy58bcbwuNpA19iO+Ezqhmtg7uEtf8eTE0kpy4U
 ByZWG/dtll70HuvPq0/y/riNIBkbsJqryR5x/MBZ/Z5BA5qBEvzRQCZ93u2GT8HoABaOrSOmC
 bOd+c+cvdcjvsc/1UbJLGnPW1mj0hwXoLHbxFZYK4U1QzlQdBgw3gC2vPKPQgDgSurDh5DmsD
 bAdQ5SxrsdYSk+Rcs71hrKz9sLxTesPb+5t1MqJkD+t3RR04+PWB8H7RUzuPTU17HbR0Gj0i2
 +hG1pkNYtb6FFigSznBIr2Axqju7P1nTOEYvZbRw98TNCTxKx0Lq/1USEBoNtud2rPV8+uUpB
 gImQvRU+0MOTQblVMFDkjpXJhm4gbi0Xf3MEs4H4pLR9wDhCBsDbeSEOUCUz/QZq80jmT5FJj
 8qUktp8AqKfGIoazvc5xUbekjQIjAaW5c4FwJiAf8JY9WrRFYr0gP0r1qwbkq5wy+vVXzvxRf
 egN5nFQ7psuAfJ0N+bAnJs/MZQnZPNHXe+GYyUuNBogiNO0Uz8XJ+GgMUBBP7Ce8hxIWZDfjc
 uX2xJEA//O+jX6518WDoW1sn+5Kc1t1GOwGzFFL93wcmsbTiRU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_addf() can be used to add a specific number of space characters
by using the format "%*s" with an empty string and specifying the
desired width.  Use strbuf_addchars() instead as it's shorter, makes the
intent clearer and is a bit more efficient.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 graph.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/graph.c b/graph.c
index e7e20650da..e1f6d3bddb 100644
--- a/graph.c
+++ b/graph.c
@@ -696,12 +696,8 @@ static void graph_pad_horizontally(struct git_graph *graph, struct strbuf *sb,
 	 * This way, fields printed to the right of the graph will remain
 	 * aligned for the entire commit.
 	 */
-	int extra;
-	if (chars_written >= graph->width)
-		return;
-
-	extra = graph->width - chars_written;
-	strbuf_addf(sb, "%*s", (int) extra, "");
+	if (chars_written < graph->width)
+		strbuf_addchars(sb, ' ', graph->width - chars_written);
 }
 
 static void graph_output_padding_line(struct git_graph *graph,
@@ -787,7 +783,7 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 		if (col->commit == graph->commit) {
 			seen_this = 1;
 			strbuf_write_column(sb, col, '|');
-			strbuf_addf(sb, "%*s", graph->expansion_row, "");
+			strbuf_addchars(sb, ' ', graph->expansion_row);
 			chars_written += 1 + graph->expansion_row;
 		} else if (seen_this && (graph->expansion_row == 0)) {
 			/*
-- 
2.14.2

