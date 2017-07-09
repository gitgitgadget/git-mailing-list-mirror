Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47C22202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 14:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752350AbdGIOBs (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 10:01:48 -0400
Received: from mout.web.de ([212.227.15.3]:62297 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbdGIOBs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 10:01:48 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7bhn-1drD741Oxr-00xItb; Sun, 09
 Jul 2017 16:01:41 +0200
Subject: Re: [PATCH] use DIV_ROUND_UP
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <4d2c274a-f6cb-6ea5-304f-51a3152cc436@web.de>
 <CAN0heSr0qJv7VqaasLGNFbNDbqYOoqmi3FyLkb=co4E10Y9VOg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <be5b6900-9e5e-0796-c16a-03c1b72cfa50@web.de>
Date:   Sun, 9 Jul 2017 16:01:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSr0qJv7VqaasLGNFbNDbqYOoqmi3FyLkb=co4E10Y9VOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kA7ZGGBZ52qGDhz6EgwEwq3nfy8btNqT+7yZYDQ+I690aaMI3rC
 k095ty3zmyfgZAgI0OPwsE1HsWmkdGjsUWbloRdDGvOrIHkbvF9hk8xOWRmXWvFGmWh80Ea
 sDiuXdAwe9YnCnwa7fubfsdqR/eaJhKQIU1zKg4hlVegjvJRAroW997Z1nYuKVDNDTwP6bI
 Z56lQ64ucV9h7/JqhYl5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wp0x3viEGaI=:uMU+B2Zey3X4vt2j2tyiGw
 bqnOcKMiFgRK3b1WAkEA60r2zgduWHgPz+NuLptwku4QP0X3ICw05q35SH6W0jFzbM64invox
 RxlOQTESxJmiZVVLALf9dxXH74HZqGBEEeRs+wjhJvorzCRBGHY/1aEVmTxiGvJ1P8/lS937y
 zcacckE/F4nCMQK3j0FF0WCN8VeoawCT6MMh98azH4zwVB7FvKNNdCjNzdaL1jCSW7HeJHYQP
 DL1+kYaFzpp10xueRc6p7Hz1z1Fg7QgjYiISSNcqys5/Ax5mf9RNWcCwYgC9v2zVsJLn39X/o
 e7yAaOlkaXPevrgggYrmAuzbOabQ7qd2cw48SOC5Nk2aP8W3rGPZ4xohnwHD54LKJdPRExELo
 DX6I88bu+BuK1qikj9cZK467G4OYwUAq8+YaSVMugc9+a4cK5hr03W3GKPhOJmGy7rvGeebyA
 wQa6VAZ3Y6dA6/Ki30xypUeVlb1xpBUfX0Vig8XlS7EZ1qSCpl3iWW3H7xs2w2kr/adzGethv
 P0iK4J3YWwE31pIarB9d1RBz3j7Kv9JyzwQ0FimzL3y4wGpJkPD658gpkkoVdcUMFoDRNobAr
 bMkX87rNWKi+Rve4H7lo1MuOOeQ5ir65J3HYzPLlp3pZ+OObEGOY42wmR5qKDWXae77ztInQt
 8bM27vNGYxR2RoKFmup7InFWU+qMutqb/SlxEMTldG08uyn7iDtVVPVHS0kLC5WmcFXA00nAG
 aBgfsTiJCFvMRW32tPzPYMxIHmaWh6pfLEaDtaNWzcPoDIhe4bDIKIMjzDlr+IsLbIxNrP9es
 OEiChoy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.07.2017 um 15:25 schrieb Martin Ågren:
> On 8 July 2017 at 12:35, René Scharfe <l.s.r@web.de> wrote:
>> Convert code that divides and rounds up to use DIV_ROUND_UP to make the
>> intent clearer and reduce the number of magic constants.
> ...
>> diff --git a/sha1_name.c b/sha1_name.c
>> index e7f7b12ceb..8c513dbff6 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -492,7 +492,7 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
>>                   * together we need to divide by 2; but we also want to round
>>                   * odd numbers up, hence adding one before dividing.
>>                   */
>> -               len = (len + 1) / 2;
>> +               len = DIV_ROUND_UP(len, 2);
> 
> Since the addition is now an implementation detail of DIV_ROUND_UP,
> should the comment be adjusted, maybe simply by removing ", hence
> adding one before dividing"?
> 
> Or perhaps even better, "... divide by 2; but since len might be odd,
> we need to make sure we round up as we divide". My thinking being,
> we're not actually rounding odd numbers up (presumably to even
> numbers), but we're rounding the result of the division up (to the
> smallest larger integer).

Good point; perhaps just squash this in?

---
 sha1_name.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 8c513dbff6..74fcb6d788 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -489,8 +489,7 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 		 * We now know we have on the order of 2^len objects, which
 		 * expects a collision at 2^(len/2). But we also care about hex
 		 * chars, not bits, and there are 4 bits per hex. So all
-		 * together we need to divide by 2; but we also want to round
-		 * odd numbers up, hence adding one before dividing.
+		 * together we need to divide by 2 and round up.
 		 */
 		len = DIV_ROUND_UP(len, 2);
 		/*
-- 
2.13.2
