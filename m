Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03251F463
	for <e@80x24.org>; Mon, 23 Sep 2019 22:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391560AbfIWW3n (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 18:29:43 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40883 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391487AbfIWW3n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 18:29:43 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iCWpv-0001Vc-6L; Mon, 23 Sep 2019 23:29:40 +0100
Subject: Re: Git in Outreachy December 2019?
To:     Jeff King <peff@peff.net>, Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20190913205148.GA8799@sigill.intra.peff.net>
 <20190920170448.226942-1-jonathantanmy@google.com>
 <20190921014701.GA191795@google.com>
 <20190923194004.GF21344@sigill.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <dba9791a-ea7a-2e79-0eb3-27fd8504853e@iee.email>
Date:   Mon, 23 Sep 2019 23:29:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190923194004.GF21344@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/09/2019 20:40, Jeff King wrote:
> On Fri, Sep 20, 2019 at 06:47:01PM -0700, Emily Shaffer wrote:
>
>> """
>> "Did You Mean..?"
>>
>> There are some situations where it's fairly clear what a user meant to
>> do, even though they did not do that thing correctly. For example, if a
>> user runs `git commit` with tracked, modified, unstaged files in their
>> worktree, but no staged files at all, it's fairly likely that they
>> simply forgot to add the files they wanted. In this case, the error
>> message is slightly obtuse:
>>
>> $ git commit
>> On branch master
>> Changes not staged for commit:
>> 	modified:   foo.txt
>>
>> no changes added to commit
>>
>>
>> Since we have an idea of what the user _meant_ to do, we can offer
>> something more like:
>>
>> $ git commit
>> On branch master
>> Changes not staged for commit:
>> 	modified:   foo.txt
>>
>> Stage listed changes and continue? [Y/n]
>>
>> While the above case is a good starting place, other similar cases can
>> be added afterwards if time permits. These helper prompts should be
>> enabled/disabled via a config option so that people who are used to
>> their current workflow won't be impacted.
>> """
> This is an interesting idea. At first I thought it might be too small
> for a project, but I think it could be expanded or contracted as much as
> the time allows by just looking for more "did you mean" spots.
>
> I have mixed feelings on making things interactive. For one, it gets
> awkward when Git commands are called as part of a script or other
> program (and a lot of programs like git-commit ride the line of plumbing
> and porcelain). I know this would kick in only when a config option is
> set, but I think that might things even _more_ confusing, as something
> that works for one user (without the config) would start behaving
> weirdly for another.
>
> I also think it might be an opportunity to educate. Instead of giving a
> yes/no prompt, we can actually recommend one (or more!) sets of commands
> to get the desired effect. I _thought_ we already did for this case by
> default (triggered by advice.statusHints, which is true by default). But
> it looks like those don't get printed for git-commit?
>
> -Peff
Also there is a lot of common problems and issues that can be mined from 
StackOverflow for similar "Did You Mean..?"user problems.

Philip

  

