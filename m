Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB3E1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 14:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965634AbeFOOHT (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 10:07:19 -0400
Received: from avasout07.plus.net ([84.93.230.235]:47400 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965593AbeFOOHS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 10:07:18 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id TpNkfjm1NjlDzTpNlfEc2U; Fri, 15 Jun 2018 15:07:17 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=8fxVlBTiyQpnWFMuvA8A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/3] ewah: drop ewah_serialize_native function
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Jeff King <peff@peff.net>, Luat Nguyen <root@l4w.io>
Cc:     git@vger.kernel.org
References: <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615033228.GC20390@sigill.intra.peff.net>
 <afbd5335-ef0d-5ca5-84ab-bdfa8bdc50bb@ramsayjones.plus.com>
Message-ID: <f25c0798-7778-7146-5349-ae2c2fb560dd@ramsayjones.plus.com>
Date:   Fri, 15 Jun 2018 15:07:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <afbd5335-ef0d-5ca5-84ab-bdfa8bdc50bb@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJRyJlAvJ3YKGb3875bX8L1zc+tiozS5L2Z9gGaz/26Z7cfG/jnVnCrUkdcGlBgWBv3VS48SmoDRqY6dJZIEXXdVs4J5pGzGi8eeNgYCgSOJcOn9i5xk
 FHYX4nYyU1Ov6sodeRUw94tTC5dz9qzbyZ02WxWZYmVkjnJsBPbE5vQWNF91DrMkr3VMLM6cVEM8ww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/06/18 14:56, Ramsay Jones wrote:
> 
> 
> On 15/06/18 04:32, Jeff King wrote:
>> We don't call this function, and never have. The on-disk
>> bitmap format uses network-byte-order integers, meaning that
>> we cannot use the native-byte-order format written here.
>>
>> Let's drop it in the name of simplicity.
> 
> Hmm, if you are in the mood to drop ewah dead code, how about:
> 
>   ewah/bitmap.o   - bitmap_clear
>   ewah/bitmap.o   - bitmap_each_bit
>   ewah/ewah_bitmap.o      - ewah_and
>   ewah/ewah_bitmap.o      - ewah_and_not
>   ewah/ewah_bitmap.o      - ewah_not
>   ewah/ewah_bitmap.o      - ewah_or
> 
> ... in addition to these *(de)serialize* functions. ;-)

Hmm, I didn't spot it at first, but ewah_serialize() also
seems to be unused!

ATB,
Ramsay Jones

