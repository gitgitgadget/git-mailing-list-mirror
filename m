Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD83C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC86661157
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 16:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348657AbhIHQfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 12:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241837AbhIHQfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 12:35:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F7BC061757
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 09:34:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z2so6100525lft.1
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 09:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jCE6zpKcPf9lHDQp7fVUyDcvAsJuo0kC3xYIYgurKr8=;
        b=YiU852KXAAQ5GX7LK5iI4srTiRTVDN6lcxfFESHLpnf/mrB6CHPMRtEYABZxue3ESe
         yUBXHbW9erczwwWS4frHd3zQfWqBISs5s2s5kaoa996ioTrzVyyA3R+kycKwOpyXDIHI
         otIqBulgZDTWszfaDz/k5tfuiefqDmjPMqlP40Pbhsl2Zb3kWPVpuaXy+G6Ts5Vi+llB
         YBmaYmw7rqpfZ5eaFtc9FowQYpMT5x4cZVlV0oOfAWwd21lRuQitkmZCE+KGLTG0fF2G
         T6zQyXOCy6QMIMjyBjaqAHdzS2eLZrQs2ps1pD4IR2zy4fIURRxNxpS1wHUWFAiTaB36
         7Y7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCE6zpKcPf9lHDQp7fVUyDcvAsJuo0kC3xYIYgurKr8=;
        b=l1HNqQ/Hvre3iQDmYIVqtbs7KWwPeXAXWn9mnCseXSdg2dIr08JY14QzUHqSFn4ZaN
         6BkuRyc4qy1PXMfG82waD8MIgQmHCjTCBHNlAag7oF8GtyqM+16nuvsEfMh9Ubn6dhxX
         IQ5UWcYqdhZO6E4ku680lBuRDWanN94RWooz/Ze6d9frYFceVIi+Fco3EoDaCqN8Ouhj
         8B72cWJxGSLgzDEKIMLRkgjEKuL2ELLTAYZhkH25FXrmRJndTl4iayA8POxEzTAehmDo
         1+Ej3TXr1OHMFjBQBfDq6pTPQYrgE+tCfM0g2TAnPAgx/bWu2wXclk+heUbegvQapnBF
         zySA==
X-Gm-Message-State: AOAM530yzQV5HieJeCnLP2QQqTqM6Ippg0uLeR2Ci5pycWbISprDjKdO
        aHMQLwcH9zgMU7pr7+JRwW8oyE1e/Ec5MveQ1v1Bf2oduBI=
X-Google-Smtp-Source: ABdhPJz3qf7PKCex6VoKobk19zHcWC0hoZVmOBnVtNutvr+J6XYmYlkr/WOkVyJKgRHGIVCMODGQJKOX6n4gxJP6WkU=
X-Received: by 2002:ac2:46c4:: with SMTP id p4mr3342112lfo.668.1631118853552;
 Wed, 08 Sep 2021 09:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com> <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
 <CANQDOdeX-SoWnh5DJ9ZdNLfPdAW-wtp_fo99r0Rwe1DQqx4W5Q@mail.gmail.com> <xmqqmton7ehn.fsf@gitster.g>
In-Reply-To: <xmqqmton7ehn.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 8 Sep 2021 09:34:04 -0700
Message-ID: <CANQDOddQsf4Jj+634mdnJXaPG=2idCbCHd1iXO2qm1EMGcDmXg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 7, 2021 at 11:44 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > BTW, I updated the github PR to enable batch mode everywhere, and all
> > the tests passed, which is good news to me.
>
> I doubt that fsyncObjectFiles is something we can reliably test in
> CI, either with the new batched thing or with the original "when we
> close one, make sure the changes hit the disk platter" approach.  So
> I am not sure what conclusion we should draw from such an experiment,
> other than "ok, it compiles cleanly."  After all, unless we cause
> system crashes, what we thought we have written and close(2) would
> be seen by another process that we spawn after that, with or without
> sync, no?

The main failure mode I was worried about is that some test or other part
of Git is relying on a loose object being immediately available after it is
added to the ODB. With batch mode, the loose objects aren't actually
available until the bulk checkin is unplugged.

I agree that it is not easy to test whether the data is actually going
to durable
storage at the expected time.  FWIW, I did take a disk IO trace on Windows to
verify that we are issuing disk writes and flushes at the right time.
But that's a
one-time test that would be hard to make automated.
