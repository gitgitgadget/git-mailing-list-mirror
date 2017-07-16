Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2070120357
	for <e@80x24.org>; Sun, 16 Jul 2017 11:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbdGPLG4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 07:06:56 -0400
Received: from mout.web.de ([212.227.15.14]:51825 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdGPLGz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 07:06:55 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LyUy6-1dkZeL1nwk-015pw9; Sun, 16
 Jul 2017 13:06:47 +0200
Subject: Re: [PATCH] ls-files: don't try to prune an empty index
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <bbc51fb0-70ce-3b02-274b-31b5dc035e29@web.de>
 <20170716104114.7tfcuilsy3ab74n6@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e91c204d-0bcb-9614-b62d-cd87c03b92e1@web.de>
Date:   Sun, 16 Jul 2017 13:06:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170716104114.7tfcuilsy3ab74n6@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:HPpJ7Cdmmx4QkOFHQ7S96nQdHhKALzXQ7kb6pOQocLvlJGcZXW9
 6CVckZIwJPJt9LT64mW+I4SBJ62iEBYmkdo4b8AAmKF50aE0yrqK8fw5k9/IG8XlDd1Bagb
 5ITyayyHtTHLI+KNqHkeAy3vRMo12BI56PAhtSThtTEog2urks590ArNbWTMxU3syWDaPdY
 10dTUVo6xIKi88WOgEr1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ngCEQVf2qPY=:4ye7PObVqe4acxHdS95Anm
 qQCmklgEixo6/Od/AjmCxsBy1HubiRWVG2Sl3t21j1fQ8LV/bYOoUZGM8D9edSnTqgFXyNaGf
 KiulCFhk1MGhaAFHlqTZ5MJRRlR5iPCKRNjPcJaHfZaLGHluzHjZ3YahoB1pC3MGBwyYQKvA3
 Lyvc2C9wr82is84AzXQ3VmPiGRtwxxljkQTiGKX8o5yTxaCG/HdGmv+2pkn3XNc75qbPePvwY
 cEpsgv+JKbVtrbbx+c1eMHb+nuDkg5DfB+AgWNkMsQvaLss0E6dQtf+jnLHwRvCNIUFhXK5l0
 A6DP1UO/nBEeTFkFszOTnRINElL4/y8VQl1ukgvu4EhKKdeLHXeOsKMdfWslfhWvT+hbSztSX
 wKDfYAZZg4WvS4VLIFt0EPARR8oxRAIjgSWKMuUiap6YsDdCCLG95os/VRXomnySeQn9/WoOg
 XH25MWDt0E5l5Gs6kZTbS+hmrZkH3NPxg99hv6G/VOmWLW7n7JUZXgso+qTglLW+BC+41qlJU
 /BrCtpQi8t/Qxqrk81TtGPnkm1G8d8GOi4doAMLP75pnEyEBgRQisYEO12CwOI0/ozO4Z6e4o
 hvjP+iGxc7Sxu81vWCxb0pIgYD0ZT1VeEbesrXQJQPOsyDvxeKV2jb756K85tgyrGp53GRYxw
 Sd0Q8BC2nbpLSPz0KyS+WmzyCT6saZ/vnxGAHESNsGbQrG48zftMfbIirqzSAnY072tnrqI4Q
 5uR9eBSH4ZLrGgNxHpozeFb+Wi1+GuMPdEiIG5uztHUpurDmM9bBdTv66rZ5C4nZXZpNsuYI1
 OiAOqtC3C2KH7HhbsVipmSi+hPkR6+6cAA4WdL7iivDt0e5/yQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.07.2017 um 12:41 schrieb Jeff King:
> On Sat, Jul 15, 2017 at 10:11:20PM +0200, René Scharfe wrote:
> 
>> Exit early when asked to prune an index that contains no
>> entries to begin with.  This avoids pointer arithmetic on
>> istate->cache, which is possibly NULL in that case.
>>
>> Found with Clang's UBSan.
> 
> Makes sense. We could use MOVE_ARRAY() here, but this is a sensible
> short-circuit to the whole function.
> 
> Looks like a good solution.
> 
>> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>> index b8514a0029..adf572da68 100644
>> --- a/builtin/ls-files.c
>> +++ b/builtin/ls-files.c
>> @@ -362,7 +362,7 @@ static void prune_index(struct index_state *istate,
>>   	int pos;
>>   	unsigned int first, last;
>>
>> -	if (!prefix)
>> +	if (!prefix || !istate->cache_nr)
>>   		return;
>>   	pos = index_name_pos(istate, prefix, prefixlen);
>>   	if (pos < 0)
> 
> "git am" complained that this does not apply to its blobs. Did you
> hand-edit?

I didn't, but perhaps I messed up the order of patches?  MOVE_ARRAY
patch 2 touches the same file, but I wouldn't expect the two changes to
conflict.  So not sure what's going on.

René
