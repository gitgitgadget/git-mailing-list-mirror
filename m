Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF6720951
	for <e@80x24.org>; Thu, 16 Mar 2017 10:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbdCPKR1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 06:17:27 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33329 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbdCPKR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 06:17:26 -0400
Received: by mail-lf0-f52.google.com with SMTP id a6so18050384lfa.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=91OriAg7lmQxauMSie+vcOltQ/QF/9Lt8UMxNdVOQZ8=;
        b=eG5zr/D6Wo1fMnBBUic6AiRqxWawm9KDmUig0JDkXyy0/Bw43qtSM3/aq54zs8KdhZ
         RIHdCyt/gaIsJZEBka4UZZkFpP7naccqknnHISooEBlPDgmErpM0i45AogZIdag4gE35
         FX7ULbgPwm/Y+Rmw4DdhAAVrf2dBk+Orq97nVvIzi5Se+nHfscVhCqMYufaclyECG8d8
         spNa+R3hDbb8TKD5ZsqPShAdrj8Q55yuM6PJbgKCVLsm7cJPSWezifveREsnjKNyH7o8
         8T48L2pwNgLRooH9Nq3FTMGDkaNnxaqFwXGw64Ld12ePADg+ml9FgS7+qxao4vfKSNaA
         cHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=91OriAg7lmQxauMSie+vcOltQ/QF/9Lt8UMxNdVOQZ8=;
        b=t7Vh4cIMrdDHKzuf/nWf1XHOdgWfCzPO6qlhbA5FKjwgXXGH70bnzDkWQkm9MIzMvj
         hO/2deKYowX8GhjEQLc30mobn/ce88reEaoqnC56I/MWjT4goEm7VDK3bzYyhsbq2K7j
         nGqn7Bl0d10xtkbV/PSrqjSo9hMazR3OeGnt2BBMtBj5bjFj9A8Fuuswt/pXw0nAPL4e
         XDvgik0KIpoL80K3+C1L9WyAi5386mpYwRTc8rS5yajD3bLmUAt1fVt3xFwAHzCI2f4f
         dF6GsTpaKkGSvmDIuFIE9mj0bAxXpFcYe3Lz+FD4YxZbAE0KM2UzdsPwbb5Kv7iJZWE3
         /OrA==
X-Gm-Message-State: AFeK/H1st2RXNZmSQBYBKvNymV7XPCu6yK/5LVsmdTVxpkTAUHeRSODlMGIQECgz3WJDCcITaxX0XFEw+eqetg==
X-Received: by 10.46.22.79 with SMTP id 15mr2522690ljw.119.1489659443667; Thu,
 16 Mar 2017 03:17:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Thu, 16 Mar 2017 03:17:03 -0700 (PDT)
In-Reply-To: <CAGZ79ka56DtHeAMVK7T-voXm3aRrGvUPNYW9MC1YR+kcGriWJw@mail.gmail.com>
References: <CAHd499CfJnPtLmi8qzr=_jrfCgMw85MOUv-wPKmAHFUyDFXhRA@mail.gmail.com>
 <CAGZ79ka56DtHeAMVK7T-voXm3aRrGvUPNYW9MC1YR+kcGriWJw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Mar 2017 03:17:03 -0700
Message-ID: <CA+P7+xoU3AA1FGRZno2mi+K4vhGy9EN3d4YDv_vqKOPqp7vboA@mail.gmail.com>
Subject: Re: Finding a tag that introduced a submodule change
To:     Stefan Beller <sbeller@google.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 10:10 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Mar 3, 2017 at 7:40 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> I have a repository with a single submodule in it. Since the parent
>> repository represents the code base for an actual product, I tag
>> release versions in the parent repository. I do not put tags in the
>> submodule since multiple other products may be using it there and I
>> wanted to avoid ambiguous tags.
>>
>> Sometimes I run into a situation where I need to find out which
>> release of the product a submodule change was introduced in. This is
>> nontrivial, since there are no tags in the submodule itself. This is
>> one thing I tried:
>>
>> 1. Do a `git log` in the submodule to find the SHA1 representing the
>> change I want to check for
>> 2. In the parent repository, do a git log with pickaxe to determine
>> when the submodule itself changed to the value of that SHA1.
>> 3. Based on the result of #2, do a `git tag --contains` to see the
>> lowest-version tag that contains the SHA1, which will identify the
>> first release that introduced that change
>>
>> However, I was not able to get past #2 because apparently there are
>> cases where when we move the submodule "forward", we skip over
>> commits, so the value of the submodule itself never was set to that
>> SHA1.
>>
>> I'm at a loss here on how to easily do this. Can someone recommend a
>> way to do this? Obviously the easier the better, as I have to somehow
>> train my team how to do this on their own.
>>
>> Thanks in advance.
>
> I cannot offer an easy way. However I can come up with a proposal
> how to make this easy in the future. ;)
>
> "git-{branch,tag} --contains" currently only takes a commit id as that is
> easy to check for. (Just a revwalk from all commits, as we walk over the
> commits in the graph)
>
> We should extend the possible arguments to --contains, such that you can
> do
>
>     # check that a given path had this exact tree/blob id
>     git tag --contains <path>:<tree/blob-id>
>     # check if the given tree/blob was at any path
>     git tag --contains <tree/blob id>
>     # generalizing from above:
>     git tag --contains [<pathspec>:]<blob/tree id>
>
> With this designed API you could ask for
>
>     git tag --contains submodule:<sha1 from step 2>
>
> For the implementation of this feature the revwalk would also need
> to walk the object graph (as restricted by the pathspec) and
> see if there is the given object for each tag.
>
> Thanks,
> Stefan

This sounds useful, but has a limitation in regards to submodules.
Lets say that parent project points submodule commit 1.

In the submodule, you create commit 2, commit 3, and commit 4.

Then, in the parent project, you new move the submodule forward to commit 4

I think the general goal for submodules is to say "which parent commit
included this submodule commit" but the parent never ACTUALLY included
commit 3, it only included commit 4 which happens to contain commit 3.

I'm wondering if it might be worth adding an (optional) mode for
submodules which would disallow adding a submodule pointer if the
current submodule pointer is not an ancestor of the new value. This
seems like a valuable protection for many uses cases (and preserves
the behavior of a bisect to find which commit added something). It
obviously shouldn't be mandatory since people often re-wind the
submodule pointer. If you have this enabled the only way to rewind the
submodule pointer would be to rewmind the parent history itself.

You could make the --contains logic above smart enough to try and
detect "ancestor of" like now, but I think that wouldn't necessarily
buy us too much and seems pretty submodule specific.

Thanks,
Jake
