Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8761F404
	for <e@80x24.org>; Wed, 24 Jan 2018 15:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933979AbeAXP07 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 10:26:59 -0500
Received: from siwi.pair.com ([209.68.5.199]:59287 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933936AbeAXP06 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 10:26:58 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 051948458E;
        Wed, 24 Jan 2018 10:26:58 -0500 (EST)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C73328458D;
        Wed, 24 Jan 2018 10:26:57 -0500 (EST)
Subject: Re: What's cooking in git.git (Jan 2018, #03; Tue, 23)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqefmgfbcx.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Cc:     Derrick Stolee <stolee@gmail.com>
Message-ID: <d154319e-bb9e-b300-7c37-27b1dcd2a2ce@jeffhostetler.com>
Date:   Wed, 24 Jan 2018 10:26:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqefmgfbcx.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/23/2018 5:39 PM, Junio C Hamano wrote:
> [Stalled]
> 
> * jh/status-no-ahead-behind (2018-01-04) 4 commits
>   - status: support --no-ahead-behind in long format
>   - status: update short status to respect --no-ahead-behind
>   - status: add --[no-]ahead-behind to status and commit for V2 format.
>   - stat_tracking_info: return +1 when branches not equal
> 
>   Expecting a reroll to finalize the topic.

I sent a V5 (1/9/2018) of this series that removed the config setting.
It looks like your branch on GH only has the V4 version.


WRT the reroll:
There was a long discussion on a limited calculation (option (2)).
While I appreciate how that would be nice to have (for some simple
cases -- like my current feature branch relative to my upstream),
I think that that is something we could add later if we want.

(*) This patch gives a simple on/off.  This has value by itself for
     certain situations.

(*) To implement a limit would involve hacking the merge-base
     calculation which gets into graph shape questions that I don't
     think we want to get into.  Several messages in the thread talk
     about some example shapes, but I don't think we have consensus on
     what we want here.

(*) Later this week Stolee will be submitting a patch series that add
     a client-side commit graph cache.  This allows fast calculations
     and includes generation numbers.  I'd rather wait until we have
     this in and then see if we want/need the limited option.

Thanks,
Jeff
