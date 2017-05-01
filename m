Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F631F78F
	for <e@80x24.org>; Mon,  1 May 2017 21:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbdEAVBL (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 17:01:11 -0400
Received: from mout.web.de ([212.227.17.12]:53006 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbdEAVBK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 17:01:10 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5wzV-1e2NPR3wjZ-00xtuV; Mon, 01
 May 2017 23:01:01 +0200
Subject: Re: [PATCH] cache-tree: reject entries with null sha1
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20170421184617.lc5bioa5px6ninrj@sigill.intra.peff.net>
 <CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com>
 <12c3312c-30a1-2cb1-8f05-63bb663bd0a0@web.de>
 <20170501192212.xy5o72tinb2hy2a3@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <456378ba-a117-8003-eea2-69272ed9bb58@web.de>
Date:   Mon, 1 May 2017 23:00:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <20170501192212.xy5o72tinb2hy2a3@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:M2Po9NkSNiSf+E/MYRb9FR0pKV6ivtYWC913jR1WH6tq4riSIZ5
 B2kQGpJn8oP16dwxh5lDt/XyarIfelBOTUt5Djd9CERuTEsjqk0Du7Zo4zyEWxkPtUeqDQu
 t+1aoKXankXhO78zfw6ZXzHiokZqg95xYRhi4xL5qxpMZ39btrFChTtofBXj9x4q3GcbVq1
 do51jC3dVsCIeYaVewF+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B5qcy5K+b5E=:Yjb4nYYGxnADrcrgafdIIM
 fLueYes69x0ogDfLa5T0aOuiNHoyPfoLM8mlNK8CsqP/0CTBiSSJrDXtfzIf6GFKqgMKAxgFs
 QD84Qh0hxvpPEyJAcUbSb09zdRvOjCUh1nlXt/MDmk2iJ+99UcIejm7tv+mzlk2E2R1ab1OIP
 ZfPN+QHHYRpRKFpuu0VT3P7ultSSrBMFjYIOA5ITnKKhmpBxg7gdXkFoeZNSouY2NQsR6f6v9
 lFX5ULIo+MgOa0mC/b0H13qkpjCU9yeyoPxHi9KOFFu5CkbdoFrrj6qX2Cil2SNiErMRwMgtT
 e2v06xr/h0r7I4JO+i7o4zPo4PvBTBY6Nte9YhoOSMhUZ3G01LnW1TGBGeEUeTMVKB5sGKF/b
 lbfLiHVBPxVcoGi2TnCJPgjkv5I2Bf7jywB4jksVzQo0kmiln637CuwScWiqIY+rnDYsR2Lnq
 9UyCBCEK3F2cTLRbSg2tSHDbtbNNpn9m7dJekgbT08VqLHM+NLlZnYMryZUqwyprWp3mkamIL
 1wqWo/w5cLtuW2gYcCOh+W4A/PodLvEN/HUFvIhm3fQdkkzC8XtWRuE7A6XZd1nM2jlD0q9Qg
 VJIEodn9/tLpJWih8o0DxKFRrc+jvbrRI9LTAdyxHcaJwkcaIC/gvAKxPkJgmgfb8CTT38fHL
 uGKnPGY8DsmqpI1vAN5N+1NYLES3OflC/r2r/3jyhpN32n+wG/KWtOsPqBbV7p5uOSORwLnSG
 ugK71o5xKKWfVJzAC4ubnQTIlx512mYf+IHtcSGvpUdAOMfqH0VrrD+iWTIDZY4nF6DiSVF6K
 XVl1ov7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.05.2017 um 21:22 schrieb Jeff King:
> On Mon, May 01, 2017 at 01:23:28PM +0200, René Scharfe wrote:
>> I can only get gcc and clang to call memcpy instead of inlining it by
>> specifying -fno-builtin.  Do you use that option?  If yes, why?  (Just
>> curious.)
> 
> I do my normal edit-compile cycles with -O0 because it's fast, and
> because it makes debugging much easier.

GCC and Clang still inline memcpy with -O0 alone (at least the versions
I tested).

René
