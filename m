Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6D511F453
	for <e@80x24.org>; Wed,  3 Oct 2018 13:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeJCTzP (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 15:55:15 -0400
Received: from mout.web.de ([212.227.15.4]:56271 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbeJCTzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 15:55:15 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKwFs-1g7grc2LFQ-0003lq; Wed, 03
 Oct 2018 15:06:52 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKwFs-1g7grc2LFQ-0003lq; Wed, 03
 Oct 2018 15:06:52 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sequencer: use return value of oidset_insert()
Message-ID: <18bf2384-694c-f98b-1c31-3c80c07bde2a@web.de>
Date:   Wed, 3 Oct 2018 15:06:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pOmdjP04JFz3+gfkx0AbrXvzCf3seTnEoy7OI9sdHQEBae633SM
 v303jZNljANCfdP5fAUbjjLINihfqDXhV3tWrh7X/RRDeFjhEbqVrPbKE244PDv4q5KP1vr
 elb8l5k++zHdWB/gM1kpBYZsK5NFU2zGfAz7L3LRYLVclqnUdEwepewO+T5vdomifelYguj
 mO8dDWjMK7bvs5k3ASOfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2Dpz0C/e5H8=:tjGEujPk108wIU3vEatw2n
 jDQ9DPmKiSG02p2UjP0AS08dpaW9cy69NaZvxau6UeyifCgvU1pdAsY4jBikx6jDiSeDNaq75
 Lgdv1U3vvM+THWEYitrnPlyVkC//BJTj7s0QAhx3BzvhEHSt2TSa9U1UGtPQwl+oYp8HkCFPl
 RndpNTmMCz7iNH7UchmzOX7KMSenhnLSJN86jKkJgzfieGdfSAgwywdeveWS2nB+IHk6vwpCo
 ESQ1FACTF9LYwFjgd45bYrq1DSPedysQRwVNQRdBPHXdgyBNEYsZoMuN0NEZgp/we1jGEaGgG
 S2WwVLHcFKDUwgelyrTIwTP40Kj/6qnOR3naTrYnNGAFpoGcMvyyAJ5tv1yMFh2s9jYyVXNJn
 m+tgMlPUbudoX3VmiqcC6lNWfNm4Pqo6kGQm4WTKG+iC1KlNxywvcp+HGlzQXyiWrUdrK81XB
 e9UyrarK2ps7UE5Nbbg6lfHJuCaGm+VpPTo7LtmKgWIo8PumCLbCQkLcGtkrfGce2vz5mXbUY
 jiK4Dq/AI0dRZYak9AMVwKViwx/bVOu8M7+BVYZCyCLydxQxMkJcFHaMcRiU493tRvhksYDt/
 DgsLBU8IqWogF4WA4N5VLzrU1gZzQu+sTg67UEmEvxVtbweLFxGvZYi9HtlW6TJG8Eg+eGVa9
 SZLXjPX3dpLo31aY1g75BFuae0hRzXuqWtExiowOULvkn3NFBt9TCuW1lqs3C2oLZ4JonS/Ba
 RNrccj7QO7bO316aQ+zf6HuXFJOiZODzWPJNoAyt8XKS9xypKlfkOyhRfRv9OfrLLIg148Kk3
 ex31R09WrnLGcfYOXKqYl7bCiwPAz0sf2SS0bHDc09dJY2d6xA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

oidset_insert() returns 1 if the object ID is already in the set and
doesn't add it again, or 0 if it hadn't been present.  Make use of that
fact instead of checking with an extra oidset_contains() call.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sequencer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ddb41a62d9..6387c9ee6e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4146,9 +4146,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			struct object_id *oid = &parent->item->object.oid;
 			if (!oidset_contains(&interesting, oid))
 				continue;
-			if (!oidset_contains(&child_seen, oid))
-				oidset_insert(&child_seen, oid);
-			else
+			if (oidset_insert(&child_seen, oid))
 				label_oid(oid, "branch-point", &state);
 		}
 
-- 
2.19.0
