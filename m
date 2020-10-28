Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9143C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 01:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9701F20714
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 01:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgJ1WFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:05:39 -0400
Received: from dd36226.kasserver.com ([85.13.153.21]:41164 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgJ1WFg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:05:36 -0400
Received: from client3368.fritz.box (i5C74478B.versanet.de [92.116.71.139])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 0D48F3C036E;
        Wed, 28 Oct 2020 10:09:29 +0100 (CET)
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
 <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
 <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
 <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
Message-ID: <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
Date:   Wed, 28 Oct 2020 10:09:28 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28.10.20 1:06, Felipe Contreras wrote:
> On Tue, Oct 27, 2020 at 5:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>>>> (they will get
>>>> their zsh/git completion from their distros---I am assuming that the
>>>> distros get theirs from us in contrib/completion/).
>>>
>>> I don't know of anyone that relies on the zsh completion shared by
>>> their distribution.
>>
>> Hmph.  If the real users don't get the completion scripts from their
>> distribution, is there still a point in having them in my tree?  You
>> are certainly not suggesting me to remove contrib/completion/ at
>> least for zsh part, but then it is unclear what you want.
> 
> I didn't say the users didn't get the scripts from the distribution, I
> said I didn't know of anyone that did. I just checked the installation
> instructions of Homebrew, and they do seem to install the zsh
> completion from contrib, whoever, by the time I see the bug reports,
> those users already downloaded the most recent version from GitHub
> [1].

I might not be the representative zsh user, but just as one data point: 
I have never downloaded the completion scripts from anywhere. I always 
use the one that comes with my "distro" (which is the Mac git installer, 
most of the time, which puts it in /usr/local/git/contrib/completion/). 
I symlink that to ~/.zfunc/_git.

> On the other hand my distribution (Arch Linux) does not enable the zsh
> script by default, it just lies dormant in /usr/share/git/completion,
> which nobody uses. So users in Arch Linux naturally would download the
> latest version from GitHub [1] as well.
> 
> So, which distributions package and enable the zsh script by default? Who knows.
> 
> I suggested you to graduate those scripts out of contrib so
> distributions would trust the scripts enough to enable them by
> default, but you refused.
> 
> What you do with the scripts is up to you, I only know what would
> happen depending on what you do. 1) If you leave them as is, some
> distributions would enable them, others don't, and people will keep
> downloading the scripts from git's GitHub [1]. 2) If you graduate
> them, more--if not all--distributions would enable them by default,
> and less people would download them. 3) If you remove them, people
> would look for another git repository to download those scripts from.

I don't think it makes a difference whether the scripts live in contrib 
or not. Bash completion is also in contrib, and yet it seems to be 
shipped and enabled by most distros, as far as I can tell.

I guess the reason why zsh completion is not enabled by default in 
distros is simply that there are far fewer zsh users than bash users, so 
packagers don't bother. That's just my unfounded guess, of course.

>> Are you saying that by adding the latest and greatest, these real
>> users who so far couldn't rely on distros now can start to do so,
>> and we'll make their life easier by updating the 29-patch series
>> (which I presume is the v2 of this 14-patch series)?
> 
> No. Many of them will keep downloading the completion from git's
> mirror in GitHub [1].
> 
> Unless you graduate the scripts out of contrib.
> 
>> In any case, some Zsh users, even though they are not active
>> developers for the completion script, may have something good to
>> say, now the 29-patch series has been posted to the list and queued.
>> I didn't look at the zsh part, but I didn't find anything glaringly
>> wrong in the changes to the bash completion.
> 
> That's great. Although I have v3 already, since I found a couple of issues.
> 
> I'll send those.
> 
> Cheers.
> 
> [1] https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh
> 
