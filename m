Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC73E20357
	for <e@80x24.org>; Sun, 16 Jul 2017 11:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdGPLK4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 07:10:56 -0400
Received: from mout.web.de ([212.227.15.3]:58897 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbdGPLKz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 07:10:55 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lk8fS-1e3HJB3R98-00cDIB; Sun, 16
 Jul 2017 13:10:51 +0200
Subject: Re: [PATCH] t: handle EOF in test_copy_bytes()
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20170716104532.zyni62mvzz6rglu6@sigill.intra.peff.net>
 <20170716104718.i4nyphyzqh2mzhxt@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c79eeaec-64e6-db27-d590-ab94a47394d1@web.de>
Date:   Sun, 16 Jul 2017 13:10:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170716104718.i4nyphyzqh2mzhxt@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BmPWjeEMmKYutIMxwQb5Kvi2HKmnskz3UOz/kjUDk4N20NNhLYH
 PsiG9Gyypnzs6zEzfs183pBzXuuXZh5SNkESeH1MHi/VrkW6LYfKuw9PzJATKs9NSQR7rJm
 8ZJ6IF/cgl55DnPW3qoLbbIZx6A/LLCMasi06F+Zkq5R5wBd6u77p3akkW9xeD8xLUpUfXO
 KwVhoiy6rSvgZoMTTDoCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+vPKDTLQg9s=:vJiA5ALR2UJs56NbwkFffU
 SzYO05dI8JDQlqJNOFsnIZOtP5jYARMmXc1ApPyGlQQGOHH8tThsnnoI/twRH+nwBZqGWsT/B
 8PjoihjzOLKHg/76nD7oMMVJbOS3rqbQqc1rorZ20Ev1bVAQhaoDp37mCjWXakKdBUXo5mzUx
 YdndD+yy4QAFGVVsj/ZJzIMgQIr58Vh3hqjaVZtaXmhXzWF94TcbL6zUUfqZIN/Cd8bNYM9Tb
 Vuo8CcdYr1wdwvpz7c0M0moZxC3ptOpIe42VCE05oDScCMNAX51+zAd708N7uqdDuHJpbEzMm
 NCVTMOmH9EntUgKFB0H+y++RgxSOtQ14vzjih0SJE+5GUbBB/w8tiF4KVKkWUChdKSPbpyeOJ
 KiIR9JfR7akwpMGxGHGBaHmScfaK67r5mR9jyk70kFT6OXNfKuuoIik9dD6v03Bl47w5dGGBh
 C0nW5Kn7QaLkaQEv9d4KnB3K+SD8TonbJZzcEcqzrX92+hMgAKVt7jDEpulX6YtenaL351rp+
 tLpEa0lNTMIhyv2oCAMDm1Pl8blS4JpULGR2h1d9jFpkD5iZfcCmbNGGCVJyTeeq3bH/YxKp4
 pjnq+AjyqdYdewyFl2CpNGqAJjAXxYF5J/QSMbjRAG/rsyh+bzfdUF+lLg6Ec15EEtgKStQ8O
 wS2CHBx5OFTm7r6WaOMfkfa7zKIXV/GgvemGIEYX2rS0otJeEDV1Dftga7gtS0nNggzNzpSq+
 8agAWSeRGttxSVeGV2QXS639mb2hrODCGrQlEZLlVCKDePVsjEvEEoWZiJ8WxnwQBo/7pQiwM
 PvfnxeSh9CrNNWHzrM2Htm171gAA1cmZhOCBoZ+el4KCVYep+8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.07.2017 um 12:47 schrieb Jeff King:
> On Sun, Jul 16, 2017 at 06:45:32AM -0400, Jeff King wrote:
> 
>> I was playing with SANITIZE=undefined after René's patches to see how
>> far we had left to go. I forgot to turn off sha1dc, which causes most
>> programs to die due to the unaligned loads. That means git-archive in
>> t5000 generates no output, triggering the bug. :)
> 
> And I was pleased to see that after setting OPENSSL_SHA1, the answer to
> "how far" is "we are there". Yay.

True with GCC, but not with Clang 3.9.  A patch for alignment issues in
dir.c is coming up..

René
