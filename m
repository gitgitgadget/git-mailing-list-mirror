Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927E81FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 23:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbcFUXoU (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 19:44:20 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33458 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbcFUXoS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 19:44:18 -0400
Received: by mail-io0-f173.google.com with SMTP id t74so30504561ioi.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 16:42:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c+70kZ7XXgcGY7822xp63iEXE5Jsd7XUZd2ZgetL1OU=;
        b=D+RB6MamiXzl3C4/JdNOWCXr0Dip+hPS9nTx26Yw6rH0NtLmH76JfJ14snL85VVhEw
         xKnrGZwpqhKyTFnq8gQEa7trO+/D2rGgUjjUmMPB3+j+bjVsKtgHkJFR/BkapT9omZMz
         8wCBEdM9WL7F/12tpUI7z3/lrgfX6IcqLN/80FxI6adxP4bSjlzz7gc7yNliF0Kz7FbU
         mkNRZ90xw+9nNd9fl9+xut2960fBGPwltbGQXSoIPK6fR/pD3y5bJIpgy1bQZMZgaMFw
         f7f+MLQahx+RcfWtjgp9gcVk+vLfQCd/5J+u8hvaG9wtudq0gHFgx1A60E4FFFI7pBnr
         p/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c+70kZ7XXgcGY7822xp63iEXE5Jsd7XUZd2ZgetL1OU=;
        b=NQHD4J0krWg9AnnORp2eD54a4DFDQDJlX6dxmxr700f5Lcg6jyAOTtOO04TLrB1fdM
         PDDcqhv1dDLIpdFUNOQL7c1DGyO4emYgFWFR0Br5t9qBCxDZvVlkS1L1H+I7mATNlCw8
         d6PyXLmPWH45hkIwu0E3sdkwD41tKAffWrGeGNqo/Wp+/T+ICyEFBM4E9UEB+4tk+W07
         ZvrGL6ZRH2F10WzmQBKXnTdYA+idZcF/7mGkWM+6x4lGmNh/KATf1U0lm7iJDCh9UH3D
         bVk0tl1zKMduQsPZ4vp2p3de0QwXaeg52DqVbIIl+F3YgqsSoEY+KO/Hx8yJk6+/QwaI
         i/nA==
X-Gm-Message-State: ALyK8tLjE0NEr5lunSbL4S49T3mIfCV+P2hJVHKXbTzz63ctEaQZ2JFPSGf8Stw35lewg3n9hAkOFyQVp8eHlcXV
X-Received: by 10.107.178.4 with SMTP id b4mr35721925iof.83.1466552215414;
 Tue, 21 Jun 2016 16:36:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Tue, 21 Jun 2016 16:36:55 -0700 (PDT)
In-Reply-To: <5769C883.3060103@eagerm.com>
References: <5765D752.4000404@eagerm.com> <CAGZ79kYqtLGHjEirP=6ssiUf2fuHirtKDXr117bjwomho2uf3A@mail.gmail.com>
 <5769C883.3060103@eagerm.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 21 Jun 2016 16:36:55 -0700
Message-ID: <CAGZ79kYaUH5gqiVqjVwG9QYyLvh2FAVdYMU+MiyWmbL2YabphQ@mail.gmail.com>
Subject: Re: Managing sub-projects
To:	Michael Eager <eager@eagerm.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Michael,

On Tue, Jun 21, 2016 at 4:06 PM, Michael Eager <eager@eagerm.com> wrote:
> Hi Stephan!
>
> On 06/19/2016 07:01 PM, Stefan Beller wrote:
>>
>> On Sat, Jun 18, 2016 at 4:20 PM, Michael Eager <eager@eagerm.com> wrote:
>>>
>>>
>>> Any other ways to do what I want without creating a separate forked
>>> repo for each of the sub-projects?  Or have I misunderstood one of
>>> these schemes?
>>
>>
>> I think forking is the way to go here, as you want to have new code
>> and maintain that.
>
>
> This was my conclusion.
>
> What I originally wanted was a repo with two origins, the upstream for
> the master and public branches, and my repo for my branches.  Git may
> be able to do all kinds of magic, but this two-origin scheme sounded
> strange after I thought about it for a while.

Well, 2 origins sound strange indeed, but "origin" is just a name to point at
a remote place. You could have ["origin" , "private"].

Once upon a time, I used ["mainline", "origin", "<other peoples name>", ...],
which I confused myself with, so now I am down to
["origin", "private", "<other peoples name">].

The difference for my work flow is that I have read permissions only
on all but one remote.

>
>> Personally I would try out submodules.
>
>
> I've used submodules on another project.  There are some odd quirks,
> and lots of web pages which say to avoid submodules like the plague, but I
> didn't have lots of trouble.  (After an initial bit of confusion while
> getting familiar with submodules, which is what I can say about every
> feature in Git.)
>
>>> Git submodule:  Branches created in the sub-projects are pushed to the
>>> upstream repo, not to my repo.  I tried to change origin and created an
>>> upstream reference, but was not able to get changes pushed to my repo.
>>
>>
>> Beware that there are 2 areas you need to look at. First the submodule
>> repo
>> needs to have a remote that points away from the projects origin (to your
>> private fork).
>
>
> I'll create an "upstream" remote to the project repo, so I can pull/rebase
> from the upstream into my forked repo.  The "origin" will point to my repo.

That is similar to the "mainline" I mention above. :)

In your work flow is there such a thing of an upstream of the
superpoject containing
all these subprojects? I thought that was a collection you are
ultimately creating,
such that the superproject has only one remote (your authoritative copy), while
each submodule has 2 remotes "upstream" (that I assume to be read only for you)
and an "origin" (your maintained version, which then contains stuff that is
referenced by your superproject).

>
>
>> Then you have to look at the superproject that
>> 1) records the sha1 for the submodules internally
>> 2) all other information except the tracking sha1s must be user provided,
>>      where the .gitmodules file contains recommendations (i.e. the url
>> where to
>>      obtain the submodule from, whether to clone it shallowly,
>>      if we have a specific branch in mind). The contents of that file
>>      are not binding, e.g. if the url provided in the .gitmodules file
>> becomes
>>      outdated later, it is still possible to setup the
>> submodule/superproject correctly.
>>
>> However for your business purpose, you would put the url of the private
>> forks
>> in the recommended URL of the submodules.
>>
>> As the superproject only tracks the sha1, and has this recommended pointer
>> where to get the submodule repository from, you need to take special care
>> in a rebase workflow, because the old rebased commits fall out of the
>> reachability
>> of the graph of objects, e.g.:
>>
>> Say you have a version `abc` in a submodule that is one commit on top of
>> canonical projects history, and `abc` is recorded as the sha1 in the
>> superproject.
>>
>> Then you rebase the commit in the submodule to a newer version of the
>> upstream,
>> which then becomes a new commit `def` and `abc` is not referenced any
>> more,
>> so it can be garbage collected.
>>
>> This is bad for the history of the superproject as it then points to
>> an unreachable
>> commit in its history.
>>
>> To preserve the historic non-rebased `abc` commit, you could have a
>> set of branches
>> (or tags) that maintain all the old non rebased versions.
>
>
> Sounds like every time I rebase, I should tag the repo to annotate this,
> and (as a side effect) retain the history.
>
>> This problem comes up with submodules with any workflow that requires
>> non fast forward changes (forced pushes), I think.
>>
>> So maybe you need to have an alias in the submodule for rebasing, that
>> is roughly:
>>
>> rebase:
>>      if rebased history is published
>>          create a tag, e.g.: "$(date -I)-${sha1}"
>>          (and push that tag here or later?)
>>      rebase as normal
>>      carry on with life
>
>
> What do you mean "if rebased history is published".

bad wording.

    "If the commits that you are going to rebase are published:"



>
> Generally I'd apply a tag after the rebase was completed successfully,
> then push both the updated branch and tags to my repo.

Sure, you can also tag after rebasing.

You only need to make sure that the history that is lost during rebase is not
pointed at from the superproject, which is the case in either version. When
first rebasing and then tagging, the tag is preserving the history for the next
rebase though, which is why I did not think of it first.

>
>> To get back to your complaint:
>>
>>>   I tried to change origin and created an
>>> upstream reference, but was not able to get changes pushed to my repo.
>>
>>
>> I would imagine this to be
>>
>>       (cd submodule && git remote set-url origin <your fork> && git push
>> origin)
>>
>> for plain pushing in the submodule and then
>>
>>      $EDIT .gitmodules
>>      # edit submodule.<name>.url to point at <your fork>
>>
>> to get the superproject correct.
>
>
> Thanks.
>

Thanks,
Stefan
