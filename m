Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457F3C55179
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 08:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F822223F
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 08:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgJ3ILG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 04:11:06 -0400
Received: from dd36226.kasserver.com ([85.13.153.21]:38288 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3ILG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 04:11:06 -0400
Received: from client3368.fritz.box (i5C746E14.versanet.de [92.116.110.20])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 137A73C00A3;
        Fri, 30 Oct 2020 09:01:29 +0100 (CET)
From:   Stefan Haller <lists@haller-berlin.de>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
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
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
 <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
 <xmqqeelh7y23.fsf@gitster.c.googlers.com>
Message-ID: <010c6222-4365-7446-a666-333ac7b4d415@haller-berlin.de>
Date:   Fri, 30 Oct 2020 09:01:28 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqeelh7y23.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.10.20 18:16, Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>> On Wed, Oct 28, 2020 at 3:09 AM Stefan Haller <lists@haller-berlin.de> wrote:
>>>
>>> I might not be the representative zsh user, but just as one data point:
>>> I have never downloaded the completion scripts from anywhere. I always
>>> use the one that comes with my "distro" (which is the Mac git installer,
>>> most of the time, which puts it in /usr/local/git/contrib/completion/).
>>> I symlink that to ~/.zfunc/_git.
> 
> That's one data point.
> 
>>> I don't think it makes a difference whether the scripts live in contrib
>>> or not. Bash completion is also in contrib, and yet it seems to be
>>> shipped and enabled by most distros, as far as I can tell.
>>
>> Apples and oranges.
>>
>> There is no default completion for git in bash, neither in bash, nor
>> in bash-completion, so if the distribution doesn't install the
>> completion in the right place
>> (/usr/share/bash-completion/completions/git), then the user would have
>> no git completion.
> 
> True, as far as I know.  https://github.com/scop/bash-completion does not
> seem to have an entry for "git" (/usr/share/bash-completion/completions/git
> however is locally there on my box---probably the corp IT folks installed
> it there), so what we ship in contrib/ is the most used (if not the only)
> implementation of bash completion script.
> 
>> On zsh the situation is different; zsh by default has a git completion
>> (/usr/share/zsh/functions/Completion/Unix/_git), and some might argue
>> it's more complete than git's zsh completion,
> 
> How is that completion script developed, maintained and distributed?
> 
> By "by default" I believe you mean that it gets installed when you
> install zsh automatically.  Is the situation different on macOS land
> (which I can believe, unfortunately)?

It's the same on Mac; I get zsh's builtin git completion when I don't
install ours.

> Stefan?  If at least some people argue what comes with zsh by
> default is more complete than the one we have in contrib/, what led
> you choose to "symlink" the less complete one to use it instead?

I'm not sure I can answer the question which one is more complete. Ours
is certainly complete enough for my daily use, but this might not mean much.

The reason why I chose ours over the one that comes with zsh is that
ours is *way* faster. If I type "git log origin/mas<tab>", with zsh's
completion it takes between one and two seconds to auto-complete this to
"origin/master". With ours it's instantaneous.

> Another question (this is for Felipe).  Is
> 
>    https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/gitfast
> 
> the one that comes with zsh by default, or is it something else
> (perhaps it is the go-to version for those who are not satisfied
> with the version that comes with zsh by default???)?
> 
> Thanks.
> 
