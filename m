Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A1BC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 14:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiBPOFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 09:05:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiBPOFD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 09:05:03 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE382A39F3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 06:04:51 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 453A33F4857;
        Wed, 16 Feb 2022 09:04:50 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1B3B63F4855;
        Wed, 16 Feb 2022 09:04:50 -0500 (EST)
Subject: Re: [PATCH 00/23] Builtin FSMonitor Part 3
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <xmqqv8xfy6ab.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0e9f0152-4421-976b-51ff-8687c7f5d329@jeffhostetler.com>
Date:   Wed, 16 Feb 2022 09:04:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqv8xfy6ab.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/15/22 8:00 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Here is part 3 of my builtin FSMonitor series.
>>
>> Part 3 builds upon part 2 (jh/builtin-fsmonitor-part2) which is currently in
>> "seen", so this series should be considered a preview until part 2 moves to
>> "next". (And part 2 should not graduate to "master" without this part.)
>>
>> Part 2 established the client code (used by commands like git status) and an
>> MVP implementation of the FSMonitor daemon. This was sufficient to test the
>> concepts and basic functionality.
> 
> Sounds like part 2 is sufficiently done to be eligible for being in
> 'master', waiting for an improved daemon, no?
> 
> Have people been reviewing the patches in part 2?  I haven't had a
> chance to take a deeper look myself.
> 
> Thanks.
> 

Yes, I think Part 2 could advance if we wanted to.  I just didn't
want to presume that, so I was being conservative.  I've always
treated it and Part 3 as a unit.

On the other hand, we've been distributing Part 2 V4 and an
un-submitted version of Part 3 experimentally in git-for-windows
and microsoft/git.git (gvfs) since last summer, so I think we're
good.

It would be good to get some eyes on the Part 2 V5 changes having
to do with removing `core.useBuiltinFSMonitor` and overloading
the existing `core.fsmonitor` to take either a hook path or bool.
That was the only major change between V4 and V5.  And that V5
change has not yet been shipped in GFW nor GVFS.

Thanks
Jeff
