Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F9520357
	for <e@80x24.org>; Sun, 16 Jul 2017 11:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbdGPLQS (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 07:16:18 -0400
Received: from mout.web.de ([212.227.15.4]:51566 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdGPLQS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 07:16:18 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MN4K8-1dYuSF3uUC-006i8x; Sun, 16
 Jul 2017 13:16:00 +0200
Subject: Re: [PATCH] ls-files: don't try to prune an empty index
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <bbc51fb0-70ce-3b02-274b-31b5dc035e29@web.de>
 <20170716104114.7tfcuilsy3ab74n6@sigill.intra.peff.net>
 <e91c204d-0bcb-9614-b62d-cd87c03b92e1@web.de>
 <20170716110831.c442ihan6tzf7gmn@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <31e6bebd-f2f5-b85d-2865-49611aecb2b8@web.de>
Date:   Sun, 16 Jul 2017 13:15:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170716110831.c442ihan6tzf7gmn@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:TNxSLiuKBN8Dtq92RZuORy3DdiZAbSzVxmVQYVli+1YuEIeh2xK
 Tm7pT+UUH0YVzRtTV/aqMRb2HGdGrrZ/9PQNMYx72Gs7kiN9iNW1M6SikMdOXVOUnAbUZn5
 cKN69lSRLreqwzxBxZufNKFPpa6aGoMnPK616RYbA/Q3lcsd+5BBd7002EC7XkYb0avdP+L
 RTQ0UBHGRxfJSYpnYGfTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AcSGYwTGVN8=:caVpERtf9g573wr0CC/0gk
 dGheGzb+skaW45HTVg+b4oROGAcrfCTBSWN+vGZ2fxF+dN61dxWmQ4suuIDwBzAZB1sXjdaLE
 3X7JhqtGGmi1LQt78L7rZtqVij2gZLT6d4LTIZX4rM6IHe3vmbsvkM2ricaQra4rCUIjjFFgO
 LrceaCrRmw1nLPcNpLEdXcOSceBa82no4PRQn1VD1mRoo9V0bAjvAE7h7U5JI7YR3r/KN0UXI
 RQ1+4ZbaK7Z9Qy+ioW300NVdPSL0inZqpLhE9VGsycPnuXMk9+/UxxHGT0SXpCkIkZAnAb+Mg
 0yvO71HTCkJVduwEQZfGNI6sltxed4rdCCHRniy06tMp+WtkeHrX+tMOBJ03GDWc0r9INZFB4
 NOHe7jOuB2+PwIAMhWWZpafjy+YZo1ckFWFZ2I/HG519HoHZEu7ivCsUMq73J2LW4RhfPD3og
 AXs8/wMB8wbvfMjNQTZl4/alskdFvyyDfKB5Y9de1VCzzS1XTdu5LOayqjBT8DdvAawhtePOQ
 c5gwZFE2SvsS0q+6FUQvsXsCUx9eRXOhKNX5mX6dD0JQrz4gDncJIi4Fqfj5+Y4vT7d1TT/63
 cU193hFCYeFUvrq6TDfs/vJtf2FNClXh3SJQlwoXwfJD9dN7wukVvUrNEWp8HVmf5I5L26IH8
 Mz48SIrrSOW4AOEQmrn3PXUJ3pRc9MikPNwQmi1vtgZ45qbxxHxfWHOEkELAhwllWfRpkJ2QE
 qHw2j+VzDL2t37sKxTPJbPrtelU0BR66m9lFPVdn60w/LwJDvJrTQv05WONCH071sPNg7Pajm
 iPp8Dx/DUkcw7snu0gyjNYqMrFxH+d2vWXWrGuEsOccDYK2PCE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.07.2017 um 13:08 schrieb Jeff King:
> On Sun, Jul 16, 2017 at 01:06:45PM +0200, René Scharfe wrote:
> 
>>>> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>>>> index b8514a0029..adf572da68 100644
>>>> --- a/builtin/ls-files.c
>>>> +++ b/builtin/ls-files.c
>>>> @@ -362,7 +362,7 @@ static void prune_index(struct index_state *istate,
>>>>    	int pos;
>>>>    	unsigned int first, last;
>>>>
>>>> -	if (!prefix)
>>>> +	if (!prefix || !istate->cache_nr)
>>>>    		return;
>>>>    	pos = index_name_pos(istate, prefix, prefixlen);
>>>>    	if (pos < 0)
>>>
>>> "git am" complained that this does not apply to its blobs. Did you
>>> hand-edit?
>>
>> I didn't, but perhaps I messed up the order of patches?  MOVE_ARRAY
>> patch 2 touches the same file, but I wouldn't expect the two changes to
>> conflict.  So not sure what's going on.
> 
> For some reason there's an extra space before the tab on each of the
> context lines. MUA issue or cut-and-paste, maybe?

That's possible.  Will resend.
