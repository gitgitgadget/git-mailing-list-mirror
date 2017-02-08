Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B731FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 19:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdBHTfr (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 14:35:47 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:34968 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdBHTeE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 14:34:04 -0500
Received: by mail-it0-f45.google.com with SMTP id 203so108049555ith.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 11:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eTX50RFcDdsMR/XOEYuISnAmJjTY9LzFyJRRWNaSu04=;
        b=fZ1oTShHnSAM5U6WsBqYi/cpQKgALFaAU0NxDb1W4HRmvMHfR1kH27dpofImTpBhyz
         1gQLn44EPxF3+MpawL9XH0ezIpSy1ayuLKg+ILelnAiwBnO2oYLWMjkYQn2RthWTrYnO
         y9ThBcPmwz5ct+QODNkKBXcry7fS+cnsHn1fWR/iv74OUUumCKMzHgheD5ux+qUUklT9
         oxY2p1/v1rVIKY471oji1ZEiEhKJBttt6+5233nLwYQ3Yx7B9XZl4qwJ5crxX0skLGCI
         csYjQHezrvgDpiPRQn7vqABkRBUv1mykhcLrmBL3laFCxyWd8YPSFTYdkOzCAdS4jpSo
         26Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eTX50RFcDdsMR/XOEYuISnAmJjTY9LzFyJRRWNaSu04=;
        b=az9H6Im3sNEpaqV7YJTMghXJDbEc7VPQ4ki82nmDQwJKEycSpcUcnvQ5IISFtyYZC1
         /bB1l29q8krVvOJ9P9pADU5U34bSisfsGDr1HggdwS8t9kXDljfj45OCKbzeSlYNBePE
         DYRBDOB1F9F1kRn7HA3OlUXk9sOaIayx6i/6QoVkA71blCXsi23aYU9w0oQrDdVekv1V
         9EkprOr2IeqsGTx+0yl7npHEr5JURYo55K6HX9xhuF6SlgFX/7n5vLtpEaJ48dTzKWmr
         pIorMLWmplpUFYNe1DQ5JHdZEXg/RL/kxYV3wvUpQGSV+yRlPPuGmkrC+6+pSsupjS+V
         iMnA==
X-Gm-Message-State: AIkVDXL2bG0Oa8aExOGMt8lNKoBqmCD2mit4Zy4usZGIoq75VyI1JtBq/GLxSsoKKc0uMjGRDXWXZPCUZY2Zfxl+
X-Received: by 10.36.4.2 with SMTP id 2mr17231643itb.116.1486580825679; Wed,
 08 Feb 2017 11:07:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 8 Feb 2017 11:07:05 -0800 (PST)
In-Reply-To: <7e54658a-dcb2-64a7-3c67-0c4fa221b2fb@gmail.com>
References: <0f14df64-1aa2-e671-9785-4e5e0a076ae6@gmail.com>
 <CAGZ79kaZUOO4qusCDF9=VJ-6QPjAvc5eSaazjWWEocRMHuTSug@mail.gmail.com> <7e54658a-dcb2-64a7-3c67-0c4fa221b2fb@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Feb 2017 11:07:05 -0800
Message-ID: <CAGZ79kYr3pmo_+fP8O++TvcW6pohRsVmapSpoJ18_ouVg8tRiw@mail.gmail.com>
Subject: Re: gitconfig get out of sync with submodule entries on branch switch
To:     Benjamin Schindler <beschindler@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2017 at 4:17 AM, Benjamin Schindler
<beschindler@gmail.com> wrote:
>
>
> On 06.02.2017 11:35, Stefan Beller wrote:
>>
>> Answering the original email, as I feel we're going down the wrong rabbit
>> hole in the existing thread.
>>
>> On Mon, Jan 30, 2017 at 8:21 AM, Benjamin Schindler
>> <beschindler@gmail.com> wrote:
>>>
>>> Hi
>>>
>>> Consider the following usecase: I have the master branch where I have a
>>> submodule A. I create a branch where I rename the submodule to be in the
>>> directory B. After doing all of this, everything looks good.
>>> Now, I switch back to master. The first oddity is, that it fails to
>>> remove
>>> the folder B because there are still files in there:
>>>
>>> bschindler@metis ~/Projects/submodule_test (testbranch) $ git checkout
>>> master
>>> warning: unable to rmdir other_submodule: Directory not empty
>>> Switched to branch 'master'
>>
>>
>> checkout currently doesn't support submodules, so it should neither
>> try to delete B nor try to repopulate A when switching back to master.
>> checkout ought to not even touch the existing submodule B.
>
>
> Well, it tried to remove the folder (the rmdir warning) but it failed so in
> some sense you are right. Is there a technical reason for this default
> though? Here, I frequently have to point out to people that they need to
> initialize/update the submodule on e.g. clone.

The reasoning is more based on historical momentum.
Back then when gitlinks/submodules were invented (git repositories
inside other git repositories! How frickin' cool is that?) nobody quite knew
how they were going to be used eventually.  So the safe play at the time was
to not touch them at all. (Also easy to implement, but that was not the point
as I learned).

And now we have a lot of people expecting just that. So we cannot change
the behavior overnight. So we'd first implement the alternative (e.g. the
--recurse-submodules flag for checkout) and then once we do a major
release we may want to flip the default.

>
>>
>>>
>>> Git submodule deinit on B fails because the submodule is not known to git
>>> anymore (after all, the folder B exists only in the other branch). I can
>>> easily just remove the folder B from disk and initialize the submodule A
>>> again, so all seems good.
>>
>>
>> by initializing you mean populating(?), i.e.
>>
>>     git submodule update
>>
>> would work without the --init flag or preceding "git submodule init A".
>> That ought to not redownload A, but just put files back in the working
>> tree
>> from the submodule git directory inside the superprojects git dir.
>>
>>>
>>> However, what is not good is that the submodule b is still known in
>>> .git/config.
>>
>>
>> Oh, I see. You did not just rename the path, but also the name
>> in the .gitmodules?
>
>
> I wasn't even aware that the submodule name was something different from the
> path because the name is by default set to be the path to it. So yes, I
> didn't just relocate it, it had a different name.

Yeah the path/name is tricky and usually only differs when you move the
submodule inside the working tree. (As the name stays constant we know
where the git directory is expected: .git/modules<name> so we can check there
instead of re-cloning to the "new" submodule-path.)

>
>>
>>> This is in particular a problem for us, because I know a number
>>> of tools which use git config to retrieve the submodule list. Is it
>>> therefore a bug that upon branch switch, the submodule gets deregistered,
>>> but its entry in .git/config remains?
>>
>>
>> The config remains as it indicates that you express(ed) interest in
>> submodule A, such that when switching branches
>>
>>   master->renamedToB->master
>>
>> then we'd still care about A. As for the tools, I'd rather see them use
>>
>>     git submodule status/summary
>>
>> instead of directly looking at the config, because the config may
>> change in the future.
>
>
> That was my feeling but its good to know to have more solid reasons why that
> would be.

The reasons here are backward/forward compatibility.
When trying to change the behavior of submodule related things, there is no
clear distinction of plumbing/porcelain as we have in the rest of Git.
So even in gits own test suite we sometimes rely on things that may change
later on, and that makes it very hard to move forward, which is why I try to
have an opinion on how to do things properly.

Thanks,
Stefan
