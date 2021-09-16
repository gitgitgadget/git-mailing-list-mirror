Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273C9C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09568600D4
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbhIPPhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 11:37:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:42825 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239169AbhIPPhN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 11:37:13 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B509B3F40D5;
        Thu, 16 Sep 2021 11:35:52 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1004:b15a:9dd2:b528:6bb:7897:2528])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 407E33F4090;
        Thu, 16 Sep 2021 11:35:52 -0400 (EDT)
Subject: Re: [PATCH 1/7] trace2: fix memory leak of thread name
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <5f557caee004f22cee33e8753063f0315459d7e1.1631738177.git.gitgitgadget@gmail.com>
 <87fsu5m649.fsf@evledraar.gmail.com> <YULZbQgxuyw8iJ/R@nand.local>
 <87ilz1gd24.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <285a279f-85c4-06df-04cf-b998e4accbe5@jeffhostetler.com>
Date:   Thu, 16 Sep 2021 11:35:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87ilz1gd24.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/16/21 4:01 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Sep 16 2021, Taylor Blau wrote:
> 
>> On Thu, Sep 16, 2021 at 07:35:59AM +0200, Ævar Arnfjörð Bjarmason wrote:
>>> So I think this patch can be dropped from this series, since it's exact
>>> duplicate of my 48f68715b14 (tr2: stop leaking "thread_name" memory,
>>> 2021-08-27) in ab/tr2-leaks-and-fixes, currently in "next" and marked
>>> for a merge with master.
>>
>> I agree it can be dropped.
>>
>>> When submitting a series that depends on another one it's best to rebase
>>> it on top of it & indicate it as such in the cover letter, Junio can
>>> queue such a series on top of another one.
>>>
>>> In this case I'm still not sure why this fix is here, i.e. surely
>>> nothing later in the series absolutely needs this stray memory leak
>>> fix...
>>
>> But there's no need for Jeff to depend on your branch, since (as you
>> mentioned) this cleanup isn't relevant for anything else in this series,
>> which is a sort of grab-bag of miscellaneous clean-ups.
> 
> Indeed, to be clear it was just general advice about queue-on-top.
> 
> But to clarify what I was getting at here: If we just came up with the
> same diff I'd have assumed Jeff just hadn't need the change in "next",
> but since he clearly has I was confused by it being here.
> 
> I.e. it doesn't *seem* like anything in the rest of the series depends
> on it, so why have it here at all since the bug is being fixed anyway?
> Or if it does depend on it in some subtle way I've missed, perhaps it
> does need to be queued on top of ab/tr2-leaks-and-fixes, and the
> relevant commit/subtle dependency needs to be called out in a commit
> message.
> 
> Or maybe Jeff had just come up with this independently, noticed it just
> before submission and just updated the CL, not the patch or series
> itself :)
> 

I'll drop this commit since your version is already queued up
and headed to master.  I've been carrying it in my dev branch
for a while and was using it to make leak reporting a little
quieter.

And yes, I just noticed that yours had advanced when I wrote the
cover letter and ACKd it rather than dropping it.

And no, nothing in the rest of the whole FSMonitor series depends
on this, so I can leave my series based upon master rather than
your branch.

Thanks
Jeff
