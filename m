Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6CFE1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 14:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfFTOVq (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 10:21:46 -0400
Received: from avasout04.plus.net ([212.159.14.19]:59356 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfFTOVq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 10:21:46 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id dxwchLMfiaslVdxwdhkSrd; Thu, 20 Jun 2019 15:21:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1561040505; bh=UWrR7paVjeyXcICyHEahgoQZrvTFNo0Bye2P6jJfmF0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EkAIBDb6+8Hp+FwZPn1CuJ3rgkRnxLitn4sVC0LEpHb59odV2shZwEv0R9kHiLcIA
         HkIk8N/lVAYKh7gOJvuKfsGYwrc4ztLwLMZvcfqEHcFEgM6IcX28spEiVQhRD2S6Er
         vnnDNqYh+aL+FWMiYPTfLYP4tno5VU1WKV/oLxkH58sRSHHzzoVA/jK3185DWr9mPa
         /2LYho15vP07V6Hd6qhnwwPovflqWmO4DGQeA1TH3Z2Yi2ZrnGu339G3jYBCglC+cP
         8pvSfHUTDwF7E8cfTrl/Ec3VyNVz/nLba0dgQ+NvcZOV6cn/SZdsJrJYUIej4WCn3E
         zp/b2MGmXtuUA==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=bfsVr9HB c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=WRhvg1l36unL36H3UhoA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 09/17] object: convert create_object() to use object_id
To:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20190620073952.GA1539@sigill.intra.peff.net>
 <20190620074121.GI3713@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b69ddbda-b24f-bb67-30b3-206fd21c2e53@ramsayjones.plus.com>
Date:   Thu, 20 Jun 2019 15:21:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620074121.GI3713@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNvr7k8feShS5RyoLoIYrfkB44VEuTA+Af8kKa+MLbsYZNRKmMxIqtixz19S0+NYplOYz4ccLehw827zNW1VGYd3VTI/Z8wV9iwDePCUho+VLwJDitY6
 mxMtM+ZICwPvvUwHMrkQer6gly3jLwRq062p+VL9pre83yLDKxAN463COS9059T8dfOvKqIcU6gmdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/06/2019 08:41, Jeff King wrote:
> There are no callers left of lookup_object() that aren't just passing us

s/lookup_object/create_object/

ATB,
Ramsay Jones
