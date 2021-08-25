Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04BCC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 17:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95EC8610E5
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 17:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhHYRlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhHYRlu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 13:41:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D279CC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 10:41:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j4so567366lfg.9
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NX76AUPfEO2a1l2zmU5IjT1ElAO65i+0HPNrA4wIKNk=;
        b=FDYlbGlH7UwxV2Q+9qzlajo7vXqkKdu2lhza80d9WABXLjd9CJQTBJ/0czn9mqEblJ
         SUx38DKnpKQU/hJHLFjAu2Sf3rm1zknGpNkwUnZEgVSFUgrC48HNOFZFikYzmpx/iJyj
         hQzaqks4EbKOnryZBkYtD55a8HFkufl6Ye44/TyVp8Y1v9yfsHX0gI40t3p/JIog2VwF
         XZfY5Xyv79nkI1jPJQiCNBhF0lihR7qOYp6ujbZfODxoPsl8z6qJ/GCeE5OCgDTRhfe3
         sftfmB32okw4RhHAbIxNCAhnQFPy7HSVnIspheUSDgHAU8VU1SZlTjGOQIDntHhmSlOx
         DJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NX76AUPfEO2a1l2zmU5IjT1ElAO65i+0HPNrA4wIKNk=;
        b=jN0pD+xmaGvcEC8rtAIa5p6FchvFkJO3jqM+JjrHNqh9erOy71wWVGBVnuIHYU9EhT
         e7UqMElu4Owmj5D7ifl3rSipkcBy+COTce4kdo4DHbn6oH6t52yBZ7DXOOkWjuEdROyu
         98hlYwMUhIEXreb4qa2KmlHaRNw4Y1fpSdFrRKm49LI4Z+Fziu+5PlOfti21k818jDXw
         xAKHESBbJyAjlwU9WEPXlQKZOSvDJgbPtnnzhZvst8ymn1h9MWyIiioV6IOm8gmTVQzT
         LtyWyKwv0ebcqtcPcpA8vHegcNGMNS2SH26ZdQvv3xL1ZK+FpWDxz6QAApagbM82I2nv
         JmJw==
X-Gm-Message-State: AOAM532u/LOfMyZOt9L/bn52bo53HbCGwFzYhLtAkErn3zMij6YL+M9z
        vlx9Y4BNxZKi4FNnAIeyG85NhIDaU8vRKB9tdqc=
X-Google-Smtp-Source: ABdhPJxXyKjkop5L5kdSosP9g9Eq0qKw3dAcEm43RRbf0UyodgTO+KCj6n1cq/mOdyrAuL1rqTws7c2+03QbhUQgncs=
X-Received: by 2002:a05:6512:2342:: with SMTP id p2mr33099831lfu.516.1629913262441;
 Wed, 25 Aug 2021 10:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
 <20210825053839.GA27037@lst.de>
In-Reply-To: <20210825053839.GA27037@lst.de>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 25 Aug 2021 10:40:53 -0700
Message-ID: <CANQDOdf7rMyT4Swriw9=Ei7KN1iLv_dGDWSSck22Zu6AztOyjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
To:     Christoph Hellwig <hch@lst.de>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 10:38 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 25, 2021 at 01:51:32AM +0000, Neeraj Singh via GitGitGadget wrote:
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > When adding many objects to a repo with core.fsyncObjectFiles set to
> > true, the cost of fsync'ing each object file can become prohibitive.
> >
> > One major source of the cost of fsync is the implied flush of the
> > hardware writeback cache within the disk drive. Fortunately, Windows,
> > MacOS, and Linux each offer mechanisms to write data from the filesystem
> > page cache without initiating a hardware flush.
> >
> > This patch introduces a new 'core.fsyncObjectFiles = 2' option that
> > takes advantage of the bulk-checkin infrastructure to batch up hardware
> > flushes.
>
> Another interesting way to flush on linux would be the syncfs call,
> which syncs all files on a file system.  Once you write more than
> handful or two of files that tends to win out over a batch of fsync
> calls.

I'd expect syncfs to suffer from the noisy-neighbor problem that Linus
alluded to on the big
thread you kicked off.  The equivalent call on Windows currently
requires administrative
privileges (I'm really not sure exactly why, perhaps we should change that).

If someone adds a more targeted bulk sync interface to the Linux
kernel, I'm sure Git could be
changed to use it. Maybe an fcntl(2) interface that initiates
writeback and registers completion with an
eventfd.
