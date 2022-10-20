Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD87C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJTURX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJTURW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:17:22 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627201AE286
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:17:18 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id 8so550409ilj.4
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iz4OltoDTjwckLdR6coXQCXpfKzqEJJuISHijszrSvk=;
        b=kd9w7Hv6CoK35EaSfP0BXYHZ/a9QkIL19kOQWXJylVMNMZLExibpqK9iRdP4A1xkl/
         SEiwYuAZfZI97XFLu8vkuJCYY8NmTQujpiEKeExSBXfcDrCvFR+wbp74cwKf/Iciu7xs
         1B/go9gMeDVUx7HFk0JwCRUn7gQoWl+eCJ0FPTY9r8dlzid9eLQIYhMypsyHX4HGvtK9
         A0GO95SumEpYdObEs443+W3SZnMDSzwNqcc80yWfPsn5uo0UCJp3uZE+v/kMAkNoSPh8
         IlUVeYrnhEIjMvrtgp9CQhIRy6hHjZgzmJC6OgX3yUxmLuKVMGd/nhOXOs/BWzaLIBEb
         gchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iz4OltoDTjwckLdR6coXQCXpfKzqEJJuISHijszrSvk=;
        b=ggCJqv2M39ki/hGzqSd+2wD75Mmp1YL8f3IvanRvW1CcYb0+o6T3n7c6f1Sa9CNv8F
         OEDg55zo2J108n5n2MSuLHs5Q4sR4LeqMQ19mAfgJ5HUdum+tDMfI2yAGNX2HaFiVZY5
         +jCzbMlHsbIuBWyHK4k4bxKVLxCiM31qTp4ste/SK5V0n53CReTvPAGHfG48Vx4EAIU5
         OqX2NIQ0XWeS1YPTH82HQL1Rzr2FU2bBIaKaAHRpgeAY011fBciLPTi+318tJYLrDSFH
         wYWRZVm9D0fHtn0BVb1aRP52/D9a0bmrgoOdxi6VGYiWjf89B9geC3mAfqgHtpiQft0n
         KXJw==
X-Gm-Message-State: ACrzQf38Tfq5qh4keRFRrhoy3ex25WaatDBwAnImFeskb0em6KqBo5Kn
        4VbEZL1hK6KAcDlnUzNKd68knNDlB7HmLRKyu6c=
X-Google-Smtp-Source: AMsMyM4PJoA2Tw2UaFeGzq2Qs3DxrWV6D1dSRibi6p07mYIlypcOrgXtJuoKecdSwpplh4Ywbviwec3/5qyIsdu0pUA=
X-Received: by 2002:a05:6e02:1909:b0:2fc:7bd1:25c0 with SMTP id
 w9-20020a056e02190900b002fc7bd125c0mr11797624ilu.147.1666297037566; Thu, 20
 Oct 2022 13:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1384.git.1665839050813.gitgitgadget@gmail.com>
 <087d3fca-d01e-f36a-85f5-7e861e4d11ca@jeffhostetler.com> <CANaDLWKcF07=FQgT7ZTKmcgworH45YdNy8hy2faMBg3CGYEf+w@mail.gmail.com>
 <d696b07f-cfa9-be45-b6d2-adb72811a205@jeffhostetler.com>
In-Reply-To: <d696b07f-cfa9-be45-b6d2-adb72811a205@jeffhostetler.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Thu, 20 Oct 2022 15:17:06 -0500
Message-ID: <CANaDLWJrBHAD4gu-h1sRgHXPbhf6YneJDF_+rhcRVDueKZfpLA@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: long status advice adapted to the fsmonitor
 use case
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oooh, I definitely like where your mind is with this. I think it makes a
lot of sense, there used to be one way to act upon a slow status, now there
are a few, so I can see how any in-depth explanation here would add to the
confusion for a user in a terminal who is just trying to get things done.
And I see how the current messaging already kinda infringes on that.

Alright, I can write the first draft of the documentation changes you were
mentioning. Heads up though: I'm going to need your tight review of it,
because I'm not as completely comfortable with what each option does as I
wish I was, so I worry I may write something accidentally inaccurate. I'll
take the time to read up on it though, and then I'll try my hand at it and
update it here, and let's take it from there if that sounds good.

With that, I'm thinking the "slow status" advice could be turned into
something as simple as:

> Your git status run was slow, here are some ways to optimize it.
> https://git-scm.com/docs/git-status#_performance_optimizations

(To be clear, I'm very un-opinionated about phrasing.)

There's one thing I'm still worried about though, which is what you
mentioned earlier, and which brought me here: the fact that git-status
feels like a read-only command, but secretly isn't. I'm thinking the
confusing use case is when the repository was in fact set in a way that
things are cached, and yet git-status is still slow because it was
generating that cache, and the user doesn't have a way to know that.

Adding to the murkiness, it might not have been the reason, so I understand
we can't say things in such a confident manner as "it will be faster now",
because of course it depends.

So I'm thinking, after the message above when git-status was slow, in the
specific case where the untracked cache is on (whether FSMonitor is on or
not, since that sounds more like under-the-hood detail), we could display
something like the additional line here:

> Your git status run was slow, here are some ways to optimize it.
> https://git-scm.com/docs/git-status#_performance_optimizations
>
> Your git status run was cached.

If the untracked cache is on, I'm assuming that would be always accurate
information, is that correct?

If you're concerned that users may not understand what it means for them,
we could also make it more obvious without over-committing about it:

> Your git status run was slow, here are some ways to optimize it.
> https://git-scm.com/docs/git-status#_performance_optimizations
>
> Your git status run was cached, it may be faster on your next runs.

What do you think?

To summarize, next steps for me:
- Make the first draft for the doc updates.
- Change the advice messaging based on our discussion above and what you
think of it.
- I still need to look into your test-related advice from last time, I
haven't yet. I really would like to give tests to all this.

Thanks a lot for all this, it helps tremendously!
