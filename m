Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02EA11F403
	for <e@80x24.org>; Fri, 15 Jun 2018 14:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756244AbeFOOqW (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 10:46:22 -0400
Received: from avasout07.plus.net ([84.93.230.235]:50715 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756225AbeFOOqW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 10:46:22 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id TpzXfjp2sjlDzTpzYfEczV; Fri, 15 Jun 2018 15:46:21 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=yMhMjlubAAAA:8 a=VltOJzom7pkmoNikajEA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/8] ewah/bitmap.c: delete unused 'bitmap_clear()'
To:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
References: <f25c0798-7778-7146-5349-ae2c2fb560dd@ramsayjones.plus.com>
 <20180615143018.170686-1-dstolee@microsoft.com>
 <20180615143018.170686-2-dstolee@microsoft.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <f95526b3-0f4f-ccf7-1c31-e7f48a00d1e2@ramsayjones.plus.com>
Date:   Fri, 15 Jun 2018 15:46:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615143018.170686-2-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEu3vexknxw/V1qBUcEupa0ZYApWFzNbizxIQNuf6uneZRKbdxHbwdco4kyt7TR+k0KcSEsa93WIGdt/QI2zP9YsJGCQL94zY2bHBK5WX/EaH/BoGaGW
 esbqVzKS6vRP/U2pm+RKGT12PT5tpl0Wvw3uH1c2woK/du3zFo74S0o1ZYi+5nWu8L8h1q/D9S+4Eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/06/18 15:30, Derrick Stolee wrote:
> Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  ewah/bitmap.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/ewah/bitmap.c b/ewah/bitmap.c
> index 756bdd050e..d61dc6114a 100644
> --- a/ewah/bitmap.c
> +++ b/ewah/bitmap.c
> @@ -45,14 +45,6 @@ void bitmap_set(struct bitmap *self, size_t pos)
>  	self->words[block] |= EWAH_MASK(pos);
>  }
>  
> -void bitmap_clear(struct bitmap *self, size_t pos)
> -{
> -	size_t block = EWAH_BLOCK(pos);
> -
> -	if (block < self->word_alloc)
> -		self->words[block] &= ~EWAH_MASK(pos);
> -}
> -
>  int bitmap_get(struct bitmap *self, size_t pos)
>  {
>  	size_t block = EWAH_BLOCK(pos);
> 

I haven't read all the patches yet, but what about the extern
declaration in ewah/ewok.h?

ATB,
Ramsay Jones


