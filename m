Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98257209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 16:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbdFCQUk (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 12:20:40 -0400
Received: from mout.web.de ([212.227.15.14]:51868 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbdFCQUk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 12:20:40 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LZkTs-1dkjBn0R12-00lW4M; Sat, 03
 Jun 2017 18:20:19 +0200
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
To:     Ulrich Mueller <ulm@gentoo.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
 <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
 <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
 <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
 <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
 <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
 <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
 <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
 <20170602223003.6etkdnnogb2jmoh3@sigill.intra.peff.net>
 <22833.60191.771422.3111@a1i15.kph.uni-mainz.de>
 <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de>
 <22834.46566.700197.257204@a1i15.kph.uni-mainz.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <52a998be-edbc-e8fb-afa9-e0c7ab682425@web.de>
Date:   Sat, 3 Jun 2017 18:20:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <22834.46566.700197.257204@a1i15.kph.uni-mainz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:4J/jjU8R+/AXbees29gJbtkzL4y10OfFVsXBB0/hJycV8sYIdVY
 jRI3/T8K2wEEFKPlg09oidxU+vCvzuoNFzZIqjSGSmV1XqjYYV7hyzKcJpHIeTxRYuwpXKx
 4PZryH36yMWDr+IIYBEkCCu8QAfRuofxMxWnWvjV+BlWqIu78t251zyDeCeBka/WT/Wb0ME
 0QMmOmlHVcQkkFqxktHJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fjZvVMepM+c=:wn3R+BzazHwSQco6UgIxkB
 gkyLJ8scQUvasy2jD8LWD29FJJafEvlgNtcoR54sQgsowKTr3YgWlUsVbVisOgbJx8NkfqVX8
 6s7oenzRg10ZW112Qita56Drg3EqB8K40qjAbUPz6oqlq1fI+QPE+s6pxQWI/Jl3rChsROQxK
 YWgX6zZR2ZomJWR4BNF3cYZd3aZ2oMfLKfdU9l/riiErMKZq3cdoxy627wYPJ3Oiu/u2Dvcq9
 uiybmsbjuKa04U0FL5syYdea1CTmzr/PCqIENfhhJ12ecj5d+VjZhroDOsgnkJt4YNYwOTPAh
 LvnwtGbCqcBx3E0uh9qBOYi8dCt3MoL7ldHZHEzAiC0xcNVLKJOJAi18dj60FUz8IkBFFK8mC
 t0jZwT77tRhZ0JIg3p4PrS3MHRwJo/anU2X3zmv421AztOIQzWc4F8xTXZi/cwLpQq7qzyPcy
 bXgl+h/ekdAf4WmNAk42sp1PPNLCnqgiXcdI645W2m6idKOYbV7vxda3j/byNe7fJyp8CVWlo
 xVWwvYppoE6Uy4Zc1uIlOvLCSj7RXhzbGc2p6U1D1MvDv7dko44DSPqQH8wEh359HFLa0HAp+
 tOLs/r4uVwB0uVdWUZg7eGwsCdISEsT2aWfNn0n2VoXQNc7DodA2GzEQ5MiEYUsmquU0D//y3
 iij6tIqa2mCUlpSCumroVM23hhMuW7WYSh+3DzuTvY8k8NqtATxihtSUfpl4Qh+lTkpl+PqzU
 zwgvabtCrMY5Kwx6ToBIPx1/yohqgRgg8cZjTDA09I9Wbx9blLU1iC95F4VCSM8OzliiRS9d2
 tyFnDnY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.06.2017 um 15:13 schrieb Ulrich Mueller:
>>>>>> On Sat, 3 Jun 2017, René Scharfe wrote:
> 
>> +			case 'Z':
>> +				strbuf_addstr(&munged_fmt, tz_name);
> 
> Is it guaranteed that tz_name cannot contain a percent sign itself?

Currently yes, because the only caller passes an empty string.

The fact that tz_name is subject to expansion by strftime could be
mentioned explicitly in strbuf.h.  I'm not sure if that's a desirable
property, but it allows callers to expand %z internally and %Z using
strftime.

René
