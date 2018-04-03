Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515A01F404
	for <e@80x24.org>; Tue,  3 Apr 2018 23:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755454AbeDCXRK (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 19:17:10 -0400
Received: from avasout04.plus.net ([212.159.14.19]:57741 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753842AbeDCXRK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 19:17:10 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id 3VAof8m44sD7b3VAqfILYJ; Wed, 04 Apr 2018 00:17:08 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=6bEDCo-MKKkoENVtbdUA:9 a=ogSNFArtzhESAqk6:21
 a=5RqW7qs_zDF4r1Ef:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/6] commit: add generation number to struct commmit
To:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180403165143.80661-3-dstolee@microsoft.com>
 <20180403180536.GB100220@google.com>
 <20180403182800.GA8377@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <08d3c9dd-3589-5c1c-4cea-982e8ed28f3e@ramsayjones.plus.com>
Date:   Wed, 4 Apr 2018 00:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180403182800.GA8377@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOjVPWVMQAok0ydQmFW3g2mCESJaG8MavNzOMeEXQx0ZIkVVUA5xxWB1bk91YrOnKklA5cnmWmjwHgXGFi2EGM/E9iWANoHMz2JRJQFDss1oe3snyCEF
 Dn1jEY96TDTenNQf1fUAW4ZXRnEIk2Q2BZhXDHvjupKMPZJOFW+/0KJbxFSj+tpjcdmCt+l7kBQWOg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/04/18 19:28, Jeff King wrote:
> On Tue, Apr 03, 2018 at 11:05:36AM -0700, Brandon Williams wrote:
> 
>> On 04/03, Derrick Stolee wrote:
>>> The generation number of a commit is defined recursively as follows:
>>>
>>> * If a commit A has no parents, then the generation number of A is one.
>>> * If a commit A has parents, then the generation number of A is one
>>>   more than the maximum generation number among the parents of A.
>>>
>>> Add a uint32_t generation field to struct commit so we can pass this
>>
>> Is there any reason to believe this would be too small of a value in the
>> future?  Or is a 32 bit unsigned good enough?
> 
> The linux kernel took ~10 years to produce 500k commits. Even assuming
> those were all linear (and they're not), that gives us ~80,000 years of
> leeway. So even if the pace of development speeds up or we have a
> quicker project, it still seems we have a pretty reasonable safety
> margin.

I didn't read the patches closely, but isn't it ~20,000 years?

Given that '#define GENERATION_NUMBER_MAX 0x3FFFFFFF', that is. ;-)

ATB,
Ramsay Jones


