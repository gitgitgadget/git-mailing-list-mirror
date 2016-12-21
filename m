Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37F11FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 09:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753368AbcLUJg5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 04:36:57 -0500
Received: from mout.web.de ([217.72.192.78]:49688 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbcLUJgx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 04:36:53 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MX0YK-1c7Vqq385s-00W0mu; Wed, 21
 Dec 2016 10:36:36 +0100
Subject: Re: [PATCH 1/3] compat: add qsort_s()
To:     Jeff King <peff@peff.net>
References: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
 <fc602a66-a06c-203e-b50b-55fd7b258b54@web.de>
 <20161201193556.j2odwy3sepaxxq5a@sigill.intra.peff.net>
 <xmqq7f7j9zkd.fsf@gitster.mtv.corp.google.com>
 <xmqqy3zz8kmq.fsf@gitster.mtv.corp.google.com>
 <b8aa28b1-e645-4cea-cc91-96f62fee6118@web.de>
 <20161212195703.nmljhwwmrn56gbyd@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2203c696-3a86-626b-c516-285daef15022@web.de>
Date:   Wed, 21 Dec 2016 10:36:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161212195703.nmljhwwmrn56gbyd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:qQMSGUJx3IHCkOv9k5bNfwl0Z1hLj1YrahrxrmpBY1H63taOyXw
 AaGJ2D9KzZyeNyE8BqfSyty7nhqFZSCmxmEPivUX9QdSZ5IEsKIPCXRcT2ljaTM9uUoXSdu
 wyRqOMIW31lYu31WHbnBODeo7wHnxNbFnzbSuroY8ht5jqYI6RuyBjxquWCMX3Ha28GnfEk
 wW24anSL9B0fYRg5isbvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wFElUM8oZVM=:gZPhVCq1tasA8qfPsBeDab
 NWvd+EzcvbX+8zYNnYWFAkf84SDU628loZ9akUQ1iHo5BQpxLP6oBbci1n1aXwRT0Z9rjiiD+
 nAR6GLBf093+JyVkcojY8MaMPfCKvUL+Hq+gmMGaXE72GrT/CRX9QkghYW2Xvx5pL/fYQrEfX
 dOe6xePa3O9TKpbB+Zl3WyCoBB/tOgJz/X/Ga964L6OtQLU2SgYxuO871CrZNY7YEMaEcJTpN
 Ppt44aEiUI2EfjpYaoN8ZVZYi6rrvxToeiGtD6tg/jQZxJrNMrh0ldywO+fFutPxfswoa6xEl
 QBNUje1FZfV0p4CoySyOZvMCvLoeUjwQCzfBFuODgWlrc180SdkVeq3iA/LfljD+FOL0NYlF5
 VGMRa0GHuz9mjWAu/xfEHadTTnCcdEaPxq5VydorRtauvnoZypIsxRT+Y5vn+tSKvZycQEKuj
 7jF5vilgqT+I07WLlRlzS2c9xka41Z7B/GsuE6Pluajz2WdHmGMtAwYxj+WVVpeSNFx1CpBAm
 6wbAPFOdn73hUkjYvRSRm4l9zcogwKRyiOsnkd5jwfOEWk0bebR+myoGloTSXm/iIEYykCnnt
 rgKN6fZtTDczy8ryuYck10JIUAtdT0NlbGuF80zrUY4asaQ4FawSw1jcSUhYYvi7bc9XbcG9R
 obVxb6dDH6NqjvnXp5CpAbFUKe5zkaYiiJ7d37VsVuvBEZBXxQ5QcpDlH+3zMv3NrwLpbd+3K
 WwaNKlrrV9LjrjPsfpuX+TbsyoqlNE46vW+AwIzq7qw+Rke8+EGPXiE9E/0vpEwfxSzKvPM55
 9+wgzTx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.12.2016 um 20:57 schrieb Jeff King:
> On Mon, Dec 12, 2016 at 08:51:14PM +0100, René Scharfe wrote:
>
>> It's kinda cool to have a bespoke compatibility layer for major platforms,
>> but the more I think about it the less I can answer why we would want that.
>> Safety, reliability and performance can't be good reasons -- if our fallback
>> function lacks in these regards then we have to improve it in any case.
>
> There may be cases that we don't want to support because of portability
> issues. E.g., if your libc has an assembly-optimized qsort() we wouldn't
> want to replicate that.

Offloading to GPUs might be a better example; I don't know of a libc 
that does any of that, though (yet).

> I dunno. I am not that opposed to just saying "forget libc qsort, we
> always use our internal one which is consistent, performant, and safe".
> But when I suggested something similar for our regex library, I seem to
> recall there were complaints.

Well, I'm not sure how comparable they are, but perhaps we can avoid 
compat code altogether in this case.  Patch coming in a new thread.

René
