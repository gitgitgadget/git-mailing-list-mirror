Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC0BF1FAE2
	for <e@80x24.org>; Thu,  8 Feb 2018 17:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeBHRCq (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 12:02:46 -0500
Received: from grym.ekleog.org ([94.23.42.210]:53448 "EHLO smtp.gaspard.ninja"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeBHRCp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 12:02:45 -0500
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTP id f0f4c7d9;
        Thu, 8 Feb 2018 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gaspard.io; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=
        grym-20170528; bh=1ESFupT/2BgVh7RtVqsS10U3l3I=; b=fNgt1H6oyOcr4S
        B7D2x252uRWPGPI4bHSkbDJvmraxdzHomrBobYH84/TQiREXs9eK5OHw1CNDpT/U
        jCKtN2XKmcEjUIxJuUxaJMhi0qHibQ9GPjlbAcNwVnBBgjX9YI16/Zn/WZEpEJQ0
        twQfy6UqvpLpsScQ3eGr7xBs4sg2c=
Received: by smtp.gaspard.ninja (OpenSMTPD) with ESMTPSA id 3e10b14f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 8 Feb 2018 17:02:44 +0000 (UTC)
Subject: Re: Fetch-hooks
To:     Joey Hess <id@joeyh.name>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
 <87inb8mn0w.fsf@evledraar.gmail.com>
 <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
 <20180208153040.GA5180@kitenet.net>
From:   Leo Gaspard <leo@gaspard.io>
Message-ID: <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
Date:   Thu, 8 Feb 2018 18:02:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208153040.GA5180@kitenet.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/08/2018 04:30 PM, Joey Hess wrote:
> Leo Gaspard wrote:
>> That said, I just came upon [1] (esp. the description [2] and the patch
>> [3]), and wondered: it looks like the patch was abandoned midway in
>> favor of a hook refactoring. Would you happen to know whether the hook
>> refactoring eventually took place, and/or whether this patch was
>> resubmitted later, and/or whether it would still be possible to merge
>> this now? (not having any experience with git's internals yet, I don't
>> really know whether these are stupid questions or not)
>>
>> PS: Cc'ing Joey, as you most likely know best what eventually happened,
>> if you can remember it?
> 
> I don't remember it well, but reviewing the thread, I think it foundered
> on this comment by Junio:
> 
>> That use case sounds like that "git fetch" is called as a first class UI,
>> which is covered by "git myfetch" (you can call it "git annex fetch")
>> wrapper approach, the canonical example of a hook that we explicitly do
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> not want to add.
>   ^^^^^^^^^^^^^^^
> 
> While I still think a fetch hook would be a good idea for reasons of
> composability, I then just went off and implemented such a wrapper for
> my own particular use case, and the wrapper program then grew to cover
> use cases that a hook would not have been able to cover, so ...

Hmm, OK, so I guess I'll try to update the patch when I get some time to
delve into git's internals, as my use case (forbidding some fetches)
couldn't afaik be covered by a wrapper hook.

Thanks for the feedback!
Leo
