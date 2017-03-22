Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5F2620323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932627AbdCVVF5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:05:57 -0400
Received: from siwi.pair.com ([209.68.5.199]:21460 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932208AbdCVVFy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:05:54 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1759E845D3;
        Wed, 22 Mar 2017 17:04:58 -0400 (EDT)
Subject: Re: [PATCH 0/6] thread lazy_init_name_hash
To:     Junio C Hamano <gitster@pobox.com>
References: <1490202865-31325-1-git-send-email-git@jeffhostetler.com>
 <xmqqshm5je4d.fsf@gitster.mtv.corp.google.com>
 <xmqq60j1jalv.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1a23fa5d-3b80-ca47-fcaa-56f794699aab@jeffhostetler.com>
Date:   Wed, 22 Mar 2017 17:04:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq60j1jalv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/2017 4:54 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> This patch series replaces my earlier
>>>      * jh/memihash-opt (2017-02-17) 5 commits
>>> patch series.
>>
>> Ahh.  I was scratching my head trying to remember why some of these
>> look so familiar.  [PATCH v2 ...] would have helped.
>>
>> Thank you for an update.
>
> One notable difference I noticed since the previous round is that
> this no longer adds precomputed hash to "struct cache_entry".  As
> you are aiming to manage an index with a large number of entries,
> this is a welcome change that makes sense.

Yes, this completely isolates the changes inside the name-hash.c
code.  And it eliminates the need to update/invalidate the precomputed
hash values as entries are changed.

>
> $ make NO_PTHREADS=NoThanks name-hash.o
>     CC name-hash.o
> name-hash.c: In function 'lazy_init_name_hash':
> ...
> still has to be addressed.  Perhaps squash pieces of these into
> appropriate patches in the series?
> ...

Will do. I wasn't sure how you specified non-threaded builds.

Thanks,
Jeff


