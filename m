Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E390CC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 18:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350989AbiCKSwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 13:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344613AbiCKSwA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 13:52:00 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2230FB18A6
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 10:50:55 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id e6so9976221lfc.1
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 10:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZzSw+aM7yES8F0MxeRq8f08KYcuwPCuhSbqGTstt9s=;
        b=Z9RWwjQXxJaf3KgMWffQOdBTDbJrZ5crQvqJiPKuj/h+hM+xyGJv5HmbnvXJYm+YTb
         edBTh0bDKGqWfjoPXDDEQvvBXlC0SDTncVrBiA1WvraQY47B7FPSqiZugHnxYywnrrRY
         xJcDtpP7Tib9wu7N9etWBO9a+hIFuyP+ZkYMS1R2sKcs1cVSZFUfiNpkhGOuG0TXq+O6
         S8tWQ9UtwFEq69NmRxHBkLt6nxsWZ3H4JQ/VHzOP8m9BDGtJQvZ/c20p4o4H543qm7yX
         EaR3IlpWiZY9EmshOq+iZxKhlvy6z8rpTbF6QlQw261bxkXdRcbo04nRuSljaJB5PqRj
         t6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZzSw+aM7yES8F0MxeRq8f08KYcuwPCuhSbqGTstt9s=;
        b=CBMheWMzOTW/07iKbBNbu5N2u+CFm71yVHnnTBQhJcBKHsS8AlIcMrgOnGP1GduLPS
         1lARTkdkN3V7mPr2MbmZVyfpmHV/cblOH2S7Cb+ujw1+91kU6wx9Cn9VTmmPr/55ky7d
         PlwN4GfVaQn/XSa4/X8s5Ll4OMFB5n8N8TiLF/uMUe2heuep9GXSoHtlfu34ImSixn1a
         ojqa86BRNy7/PPpqdWhA653+f1MMCewQEcwUlsHPjRKL7NOHenrXRXSa9o745HagBb2A
         yXcaIZLmH0uUFUtWYOvBZ5oxxAw9jgXL4Ga9zsTbn7OB4lqiUqJRRkh3PeZ+zlM5qbBF
         c95A==
X-Gm-Message-State: AOAM530ifmDvezb6zbfQd4UytB8UBhHWMUvMGePJgM6C7vqEB+vhJWcE
        GaQSfrnE2f2jcebiRplnydTzYW8t8UUPaKwzUaI=
X-Google-Smtp-Source: ABdhPJwcdNhgmlZSB6ecEBhHsaFjYjBrXzsGxL0zhsAnKrCxHWWncuEfi4gIrXD0n6OLjHoc5J+/RIEdkWbynvBgJT0=
X-Received: by 2002:a05:6512:2215:b0:448:6c21:3a66 with SMTP id
 h21-20020a056512221500b004486c213a66mr3632288lfu.241.1647024653271; Fri, 11
 Mar 2022 10:50:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
 <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com> <xmqqmthxbcv2.fsf@gitster.g>
 <CANQDOdfX4tXSy_9r8mnXpYD=BoJtEcydAXBTff_ekf=6ryoebQ@mail.gmail.com>
In-Reply-To: <CANQDOdfX4tXSy_9r8mnXpYD=BoJtEcydAXBTff_ekf=6ryoebQ@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 11 Mar 2022 10:50:42 -0800
Message-ID: <CANQDOdcp3gA+Uro9qzfPOtusni2j4tHqT2wCHqyvQHcwtVHQCg@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] A design for future-proofing fsync() configuration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 4:03 PM Neeraj Singh <nksingh85@gmail.com> wrote:
>
> On Thu, Mar 10, 2022 at 3:35 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > After this change, new persistent data files added to the repo will need to
> > > be added to the fsync_component enum and documented in the
> > > Documentation/config/core.txt text.
> > >
> > > V6 changes:
> > >
> > >  * Move only the windows csprng includes into wrapper.c rather than all of
> > >    them. This fixes the specific build issue due to broken Windows headers.
> > >    [6]
> > >  * Split the configuration parsing of core.fsync from the mechanism to focus
> > >    the review.
> > >  * Incorporate Patrick's patch at [7] into the core.fsync mechanism patch.
> > >  * Pick the stricter one of core.fsyncObjectFiles and (fsync_components &
> > >    FSYNC_COMPONENT_LOOSE_OBJECTS), to respect the older setting.
> > >  * Issue a deprecation warning but keep parsing and honoring
> > >    core.fsyncObjectFiles.
> > >  * Change configuration parsing of core.fsync to always start with the
> > >    platform default. none resets to the empty set. The comma separated list
> > >    implies a set without regards to ordering now. This follows Junio's
> > >    suggestion in [8].
> > >  * Change the documentation of the core.fsync option to reflect the way the
> > >    new parsing code works.
> >
> > Hmph, this seems to make one test fail.
> >
> > t5801-remote-helpers.sh (Wstat: 256 Tests: 31 Failed: 4)
> >   Failed tests:  14-16, 31
> >     Non-zero exit status: 1
> > Files=1, Tests=31,  2 wallclock secs ( 0.04 usr  0.00 sys + 1.40 cusr  1.62 csys =  3.06 CPU)
> > Result: FAIL
>
> Thanks for reporting this.  I didn't see a failure in CI, nor when
> running that specific test in mingw.  I also munged my config to
> include core.fsyncObjectFiles and didn't see a failure.
>
> Could you please share some more verbose output of the test, so I can
> look a bit deeper?  In parallel, I'm trying again after merging my
> changes onto seen.
>
> Thanks,
> Neeraj

Hi Junio,
I've also tested v6-on-seen on Linux and I'm still not seeing the
failure. Does the
failure still happen on your end?
Thanks,
Neeraj
