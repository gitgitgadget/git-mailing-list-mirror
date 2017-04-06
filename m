Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07B031FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 13:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934936AbdDFNxd (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 09:53:33 -0400
Received: from siwi.pair.com ([209.68.5.199]:51117 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934832AbdDFNxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 09:53:16 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 18EFF8464A;
        Thu,  6 Apr 2017 09:53:15 -0400 (EDT)
Subject: Re: [PATCH v2 0/7] thread lazy_init_name_hash
To:     Duy Nguyen <pclouds@gmail.com>
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
 <CACsJy8CCb+i3xjtEY=6_dWCGw8VJHT1Mo5973YmQ-6xpTd=z=g@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c89de108-916e-49a1-934c-0fb5d8901f3a@jeffhostetler.com>
Date:   Thu, 6 Apr 2017 09:53:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CCb+i3xjtEY=6_dWCGw8VJHT1Mo5973YmQ-6xpTd=z=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/5/2017 10:22 PM, Duy Nguyen wrote:
> On Thu, Mar 23, 2017 at 8:46 PM,  <git@jeffhostetler.com> wrote:
>> This patch series is a performance optimization for
>> lazy_init_name_hash() in name-hash.c on very large
>> repositories.
>>
>> This change allows lazy_init_name_hash() to optionally
>> use multiple threads when building the the_index.dir_hash
>> and the_index.name_hash hashmaps.  The original code path
>> has been preserved and is used when the repo is small or
>> the system does not have sufficient CPUs.
>
> If sha1 verification in the index file can now be optionally skipped,
> I wonder if you would have faster startup time by storing hashes in
> the index as an extension. I have never tried it (though I planned to
> have some sort of caching for this) but I would guess loading hashes
> would cost less than 0.27 seconds, hopefully closer to 0.05 seconds.
>

I've thought about doing that, but haven't gotten around to
actually trying it yet.  It's on my TODO list though.

Thanks
Jeff
