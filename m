Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDFD20C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbdLADhr (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:37:47 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:39119 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdLADhq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:37:46 -0500
Received: by mail-wm0-f44.google.com with SMTP id i11so1151528wmf.4
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bWbcxVXLGA7o6jrtmNu1Uc8wkBVg6Tu2Rz5ZYuT/n6c=;
        b=xwmvuIh69MPE33FvTQj6Zi6XPT6m40/6QOIIRDYLBpmO8hhSVNJj/2RaGmpnstKgmX
         VoIPr4AGAs83DDL7LnnlmwFQ7V6XeNoEeXiGdO++tXrbHd4IIkc19wIUn3VJyC+UdpTn
         LVDGNx8o8r42/XWXmYrXQbYmFXzxCv1ADRXFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bWbcxVXLGA7o6jrtmNu1Uc8wkBVg6Tu2Rz5ZYuT/n6c=;
        b=j/UqVhpgRV47P6OoV1IpAm5WdBPQArisDZFcHboq/GENJUehqrhLG3S52j7nvqYU2o
         k/Amrqm8e5KoC10XyF1ZmaRArHI9tTihpjjwevQBK+SYO3t4+SgvdPAjz5Crr3XqtX3W
         czOVpdT50DriNoI6cw/Jmob9COp862MffyX6Pytav4jwM51fxretoWg4qhTu5QzQPlMd
         Brbz51xg/lYPpx3MsMHH07s0Q2VOyD6aeCMDhUncZA8LmAWm1vPYvGJbyV4fNBTj7IRG
         BYoeYKaA3yIJeCDIWNWdXLGg3bQ1iG6nCQL78buCpuITgcRnI1Ia7ZRipzIrwdOkDxfs
         tJQg==
X-Gm-Message-State: AJaThX7piHiIn7nrYlzIQyq4ONhDBkDQKz6BGgpDGrPew7wkM5lt4upI
        hIePOyW1OLcFJweomkwQ7GcFsRa1ZHYBSWeROb5p
X-Google-Smtp-Source: AGs4zMa4k7G7Tr1lCPhHBBH9BQT1HBHWcCJYAuBQ/53TWYM3UBckz0PFJmdAbZHKX/lWogkqkmtxWl7Zx+y78cijZU8=
X-Received: by 10.28.16.78 with SMTP id 75mr65402wmq.16.1512099465429; Thu, 30
 Nov 2017 19:37:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.213.12 with HTTP; Thu, 30 Nov 2017 19:37:24 -0800 (PST)
In-Reply-To: <20171201025106.GD20640@aiede.mtv.corp.google.com>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com> <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
 <C89EEDA4D8F84C6290111C04ADAE6872@PhilipOakley> <CANxXvsM-q-MH3y94=tW8GmbWNjvrskPoGEhOkyAzsbZd8RrRbg@mail.gmail.com>
 <CANxXvsNuEmo+uaRY8t44csqzXAk3rS+D9E=LMvaLcZeg-aLvRw@mail.gmail.com> <20171201025106.GD20640@aiede.mtv.corp.google.com>
From:   Vitaly Arbuzov <vit@uber.com>
Date:   Thu, 30 Nov 2017 19:37:24 -0800
Message-ID: <CANxXvsM4MNuXAgy51ke09u1HZqwZfmhS4-yM1bvAKc+ZniRadg@mail.gmail.com>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Makes sense, I think this perfectly aligns with our needs too.
Let me dive deeper into those patches and previous discussions, that
you've kindly shared above, so I better understand details.

I'm very excited about what you guys already did, it's a big deal for
the community!


On Thu, Nov 30, 2017 at 6:51 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Vitaly,
>
> Vitaly Arbuzov wrote:
>
>> I think it would be great if we high level agree on desired user
>> experience, so let me put a few possible use cases here.
>
> I think one thing this thread is pointing to is a lack of overview
> documentation about how the 'partial clone' series currently works.
> The basic components are:
>
>  1. extending git protocol to (1) allow fetching only a subset of the
>     objects reachable from the commits being fetched and (2) later,
>     going back and fetching the objects that were left out.
>
>     We've also discussed some other protocol changes, e.g. to allow
>     obtaining the sizes of un-fetched objects without fetching the
>     objects themselves
>
>  2. extending git's on-disk format to allow having some objects not be
>     present but only be "promised" to be obtainable from a remote
>     repository.  When running a command that requires those objects,
>     the user can choose to have it either (a) error out ("airplane
>     mode") or (b) fetch the required objects.
>
>     It is still possible to work fully locally in such a repo, make
>     changes, get useful results out of "git fsck", etc.  It is kind of
>     similar to the existing "shallow clone" feature, except that there
>     is a more straightforward way to obtain objects that are outside
>     the "shallow" clone when needed on demand.
>
>  3. improving everyday commands to require fewer objects.  For
>     example, if I run "git log -p", then I way to see the history of
>     most files but I don't necessarily want to download large binary
>     files just to print 'Binary files differ' for them.
>
>     And by the same token, we might want to have a mode for commands
>     like "git log -p" to default to restricting to a particular
>     directory, instead of downloading files outside that directory.
>
>     There are some fundamental changes to make in this category ---
>     e.g. modifying the index format to not require entries for files
>     outside the sparse checkout, to avoid having to download the
>     trees for them.
>
> The overall goal is to make git scale better.
>
> The existing patches do (1) and (2), though it is possible to do more
> in those categories. :)  We have plans to work on (3) as well.
>
> These are overall changes that happen at a fairly low level in git.
> They mostly don't require changes command-by-command.
>
> Thanks,
> Jonathan
