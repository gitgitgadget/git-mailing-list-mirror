Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB02E1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 20:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeDFU20 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 16:28:26 -0400
Received: from connotech.com ([76.10.176.241]:44730 "EHLO mail.connotech.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751401AbeDFU2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 16:28:25 -0400
Received: from [192.168.1.11] (unknown [192.168.1.11])
        by mail.connotech.com (Postfix) with ESMTPA id 39B49196E4F;
        Fri,  6 Apr 2018 20:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=connotech.com; s=key3;
        t=1523046504; bh=VbTwID5/eiu16H+Qpfm6EVy+sLLfOsYuJ/rtcp6xWc0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=i0FB8e2HHqqDYm1dNHSKJmS+AyFxIbvoyDnB9Q0frapl0PQBx5lDA9GfsEI8DAZ0k
         6Vcxg0fT8CN6mhkayBlV6Q0PGiNosfaSmec2u6ezW5F5csZozsmC5Vjoj6HKuBw+q8
         azsvpKmFUz8wMg1Pl5ALPwR4UNQS/G+B5acXk8Og=
Message-ID: <5AC7D82A.8050806@connotech.com>
Date:   Fri, 06 Apr 2018 20:27:22 +0000
From:   Thierry Moreau <thierry.moreau@connotech.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>
CC:     Git Users <git@vger.kernel.org>
Subject: Re: Self-inflicted "abort" in a newbie attempt at read-only exploration
 of a cloned repository?
References: <5AC67C43.9080500@connotech.com> <CAGyf7-E9=Mm1oJdhwHTmg2byrOxMRFVEjmYHCFGqqP8pvK=vJg@mail.gmail.com> <20180406195659.GD11450@sigill.intra.peff.net>
In-Reply-To: <20180406195659.GD11450@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04/18 07:56 PM, Jeff King wrote:
> On Thu, Apr 05, 2018 at 04:18:23PM -0700, Bryan Turner wrote:
>
>> The documentation for --work-tree says:
>>
>> --work-tree=<path>
>>
>> Set the path to the working tree. It can be an absolute path or a path
>> relative to the current working directory. This can also be controlled
>> by setting the GIT_WORK_TREE environment variable and the
>> core.worktree configuration variable (see core.worktree in
>> git-config(1) for a more detailed discussion).
>>
>> So passing --work-tree tells Git where to store your _files_, but it's
>> still using the same .git directory.
>>
>> If your goal is to have worktrees for various versions, that implies
>> the git worktree [1] command might be more along the lines of what
>> you're looking for. An invocation based on above might look like this:
>> $ git -C linux-stable/ worktree add $PWD/tmp/ checkout linux-4.15.y
>
> Everything you've said here is completely accurate. But the original
> report does make me wonder if we've set up users for failure by
> overloading the term "worktree". Clearly it means two very different
> things in:
>
>    git --work-tree=foo
>
> and
>
>    git worktree add foo
>
> I'm not sure what to do about it at this point, though. :(
>

The documentation for 'git worktree add' was adequate for my problem 
solving process. My difficulty occurred because I used an earlier GIT 
version. The terminology overloading might not be a big issue.

Regards,

- Thierry

