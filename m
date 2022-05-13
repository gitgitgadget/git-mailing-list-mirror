Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2453FC433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 08:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378541AbiEMIq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 04:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378558AbiEMIqY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 04:46:24 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9113B1FA69
        for <git@vger.kernel.org>; Fri, 13 May 2022 01:46:20 -0700 (PDT)
Received: from host217-43-165-125.range217-43.btcentralplus.com ([217.43.165.125] helo=[192.168.1.168])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1npQwD-0007Dy-5c;
        Fri, 13 May 2022 09:46:18 +0100
Message-ID: <9a01bede-40d8-e7e8-6d8c-42beea8f6f35@iee.email>
Date:   Fri, 13 May 2022 09:46:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Git Submodules ref setting
Content-Language: en-US
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?B?0JLQsNC00LjQvCDQptCy0LXRgtC60L7Qsg==?= 
        <vadim.tsvetkov80@gmail.com>, git@vger.kernel.org
References: <F20FCD5B-7788-4D4C-8402-2C4CF447B2F5@gmail.com>
 <88fa7138-cb3f-ab88-525c-198396b0a262@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <88fa7138-cb3f-ab88-525c-198396b0a262@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05/2022 23:42, Philippe Blain wrote:
> Hi,
>
> Le 2022-05-12 à 16:01, Вадим Цветков a écrit :
>> Hello,
>>
>> I've started a small project which involves several git repositories, which depends on each other.
>> For dealing with these repos I wanted to use git submodules as a simple package manager.
>> However, it seems impossible to lock a submodule to particular ref, only to a branch.
> Submodules are recorded in the superproject *at a specific commit*.
> That's the data model. There is no other options.
>
> There is a 'branch' setting that you can put in '.gitmodules'.
> This *only* affects the command 'git submodule update --remote', nothing else.
>
> If you mean that you would like to have a non-branch ref recorded in '.gitmodules'
> i.e. something like refs/other-refs/example instead of 'some-branch' that corresponds
> to 'refs/heads/some-branch', then no this is not possible either.
>
>> I would like to ask if this is deliberate design choice?
> Yes, it was a deliberate design choice to have a deterministic state
> of a repository using submodules upon 'git clone'. Recording a submodule
> at a specific branch instead of at a specific commit would make this design
> choice impossible to achieve.
>
>> And if it's not, may I contribute this feature?
>>
> It depends on what you mean by 'lock submodule to a specific ref'.
>
> I encourage you to read the "Git Submodules" chapter of the Pro Git book [1]
> for an in-depth overview of how submodules work. And after that, for reference
> the Git documentation:

I didn't find the man page, or the scm chapter that great in explaining 
the overall way that sub-modules are conceived and organised.

There is an implicit assumption in the man pages that folks, in general, 
already know the background and concepts, and are just looking for the 
particular command option details. I.e that it is a reference manual. 
There has been a lot of work done over the years on sub-modules but, to 
me, the concentration has been on _implementation_ (which is obviously 
important), rather than _explanation_ of how sub-modules work and the 
newer capabilities mesh into the existing ones.

As seen here, the existing usage as a place holder for libraries at 
exact versions has been 'lost' in the flurry of newer capabilities. It 
maybe something to add to the wider UX discussions [A].
>
> - git-submodule(1): https://git-scm.com/docs/git-submodule
> - gitsubmodules(7): https://git-scm.com/docs/gitsubmodules
> - gitmodules(5): https://git-scm.com/docs/gitmodules
>
> I hope that helps,
>
> Philippe.
>
> [1] https://git-scm.com/book/en/v2/Git-Tools-Submodules
Philip

[A] 
https://lore.kernel.org/git/CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com/
