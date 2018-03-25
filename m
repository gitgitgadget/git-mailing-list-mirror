Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944771F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 10:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeCYK5z (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 06:57:55 -0400
Received: from mout.web.de ([212.227.17.12]:48711 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752440AbeCYK5y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 06:57:54 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQvsg-1f9WL311lG-00UGRf; Sun, 25
 Mar 2018 12:57:51 +0200
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] run-command: use strbuf_addstr() for adding a string to a
 strbuf
Message-ID: <19c993cf-7220-42e1-6a76-d257d97d6f55@web.de>
Date:   Sun, 25 Mar 2018 12:57:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Wd5/y0+7sukNS5d0ae8Wd7M59Uj8tyYLpJNuWx9mnvSQdD3A1DZ
 RI+AMjT/aUyNhUShg44y3kYMqU+nfHL8o+cSBnvV31CjNkXoktFVunjUIa1tI4pTQKAYIxK
 KUkcQSSTRFTeWmzupvQYw1p7h/f6MeQxOUnrK7MNCB4aDRqZHit52cUr1KINpPstllq6R2c
 MP68Ydng0sbPWwChtz2KA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rhs9PC6RZJQ=:M44f61yf+sfSCvIMe+5sZZ
 bEYXSgtoK44BS5yTX2av3oRDD6i8FwgIVHXt0mN9HAd/Uu0ZcGM8Z3G/DSpUII5fCiUOpoab/
 4Qsb64meKQNfInuxriOuVUugDeOwzaBjdi9GqM2LrWBt4rKoxqMMckz/wQI3KBz4G+tgfHYR7
 AGPHj4kwRPSlgxKRThMMXRriIRh38WEl6DeTdi/m+WlC8/XG4TtGW+zXl3x0n3l2rVuSs1KQQ
 6hTyy3rmXU/cGUPkPiIpHXl+XjUhhpzaXCF0Wo8XOvcvqhvJkjf9OKnI/UycYLqFSIkzXpKsH
 ozk2PVJ40uZ8821Pz9XxUTY328KPgMlJpr9p+vKmkTCyvaUgqnXYA1p95sMca1wYR+XNjNBXS
 7kZYYvq05g01EcwoSI1zPCq73m5IA+PAe6x27PxFspLZ3Dcpv+jTktdXtzyvcmazmkKmoumOR
 cO6oXeFJtzznofX09PsREwyuwY9MQfV4FtmAh8/hdSFP7fprahuom7Oq1Rt2kaRh3ESuVYWDT
 yzGpHk4K8Ggv394u9jhpniRhH0lvJOwJ3JPqNdLLeZ0Ro4mFZzdNQgiAlCEf4/cp+J1zc5DIz
 I1uQHOSQ1SyeTZx1Xaql8rMXlYGVBNLCBf8SSngLRpQ1ICOfDXmhw3giBgPUj3FhCgJK7uIqJ
 F1GhnwXZ74bzF3y/+USfERDxYwxUBEtX9TBYp9Q+/zlmLPpkzS/slkreUsO0Zn9wXnI2G0fve
 JUmqB3NgOCYc2PgDt76lR9P5aLXFq0YDk4Lo//U/FXh8XdCLy9gQMyqwGYY2Kw8QFW5DdSQcq
 c4gnp5wF/zmftBJpt3Tk+q5zp3dDSvQ+3TMPl6jKpd6O/LNSBU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch generated with Coccinelle and contrib/coccinelle/strbuf.cocci.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
That line was added by e73dd78699 (run-command.c: introduce
trace_run_command()).

 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index a483d5904a..84899e423f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -621,7 +621,7 @@ static void trace_run_command(const struct child_process *cp)
 	if (!trace_want(&trace_default_key))
 		return;
 
-	strbuf_addf(&buf, "trace: run_command:");
+	strbuf_addstr(&buf, "trace: run_command:");
 	if (cp->dir) {
 		strbuf_addstr(&buf, " cd ");
 		sq_quote_buf_pretty(&buf, cp->dir);
-- 
2.16.3
