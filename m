Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DF61F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 15:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbeGKPjI (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 11:39:08 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45580 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbeGKPjI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 11:39:08 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so24451209oic.12
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fY1GRAX5C+4+BaW1ZFudOyN8PRjQiqWd41LwDlnRQB8=;
        b=ZunkrVnCJmhrXUV1fYN9HDpS1vkjyt3qmtOL18EiavqQ5H7NidM0ej00zGSxfdRSx0
         fV06JAqksXKsuVHK4epktRieaxKOUYIhiToQ3KSDQwXpfJGAbGRmPq6mTbUT59+xycv9
         uHg5vQqRdnZh6JOuHyupz/hD6whayaRz6oFdGs2aqYAISHt5SO7oaowAODSpn/W4/I4i
         4duyhzatRDTq60SRu0dbUX1LzCcWDB3yST0R22BaN1J7MwfrDS0+Or7cYrrqyMyCaFM3
         ADiuGm4Gkpm3wnpSZ2T+XUmQ+SBYlsy7OL7Igjunuu/shTytn+iT6aA+wYVQeGAnKPQ0
         bSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fY1GRAX5C+4+BaW1ZFudOyN8PRjQiqWd41LwDlnRQB8=;
        b=sma2NF91AjcWZRe3B/Zx0K8hNDYvg8/NXdJWLceaaQoIg1Ote8sZHEnqAxbjgZZfQj
         G4Wa+IFu8NIcTyBwpr80h5PvdoyTb4oa60i2aEysOtPdiffRvfJ/taZiSVbZEXLswwmi
         w6ZhXBsLpZt5/FD9ZpaeWpQkOWpimx73Aovdh7BIpWy3lxK6BGBhw0NuaueFNpdtJqdt
         0soEdfP+Fs/d6xyXPGe5/UGQmxnxBh5kAp384QAWJNsWSKeGYRfWL53Xc2RLDhk4/edo
         dzZg8KC0D9bzz+HN1WhDZvJnQZ0tAzWqpf74iQUVcCQhzkeQLgXjeBURtsGTs0ah7G5B
         NU8Q==
X-Gm-Message-State: APt69E3gN1jY3idQNqNoLVb3WVNRTzKe7iFeHHMxXncotRAsGbqQMeE/
        eQfY8QR/zuD10O/QzNtVZxNKFAaPHywM5JcJzUI=
X-Google-Smtp-Source: AAOMgpdfjnDg8eWRQ0CBghCPdRMzhizIrg2MJ69memGZ9ia/XeesYlwIl25RVhcDJWRe+Ek8BYewp4xYikvL82g/eJ8=
X-Received: by 2002:aca:f516:: with SMTP id t22-v6mr34926166oih.56.1531323254802;
 Wed, 11 Jul 2018 08:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180630133822.4580-1-kgybels@infogroep.be> <20180630145849.GA9416@duynguyen.home>
 <xmqqpo00mi7q.fsf@gitster-ct.c.googlers.com> <CAM0VKj=u0OVad3QDRFOc+NWZ9TfwqAwmZ47s=5e5jGZaPQRH6g@mail.gmail.com>
 <20180707231651.GB6152@infogroep.be> <CACsJy8C=Xs1QY_cMu+H4DR9XovBd5bO-ZC=ie-1x9yZepgUMdA@mail.gmail.com>
 <xmqqwou4azev.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwou4azev.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 11 Jul 2018 17:33:47 +0200
Message-ID: <CACsJy8Agm7qQqed4yoWWRXcZmRFuny5dPSue8NhkNo1tk58zbQ@mail.gmail.com>
Subject: Re: [PATCH] gc --auto: release pack files before auto packing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kim Gybels <kgybels@infogroep.be>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 9, 2018 at 11:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Sun, Jul 8, 2018 at 1:16 AM Kim Gybels <kgybels@infogroep.be> wrote:
> >> Should I post a v3 that goes back to the original fix, but uses
> >> test_i18ngrep instead of grep?
> >
> > Yes please. In my comment I did write we didn't need the repo anymore
> > (or something along that line) which turns out to be wrong.
> >
> >> In addition to not breaking any tests, close_all_packs is already used
> >> in a similar way in am and fetch just before running "gc --auto".
> >>
> >> -Kim
>
> Sound good.
>
> I recall that "clear repo should treat the_repository special" was
> discussed when we saw the patch that became 74373b5f ("repository:
> fix free problem with repo_clear(the_repository)", 2018-05-10),
> instead of treating only the index portion specially.  Perhaps it
> was a more correct approach after all?

I think it's good that we have a way to "shut down the repo" when we
run an external command. But what we lack is "reinitialize the repo"
after the external command is done. We could treat the_repository
special in this case so shutting down does not require
reinitialization. Then repo_clear() should work well here. We could
also add a flag in repo_clear() to say "release all the resources you
are holding, but keep the repo settings/location..., we're not done
with this repo yet" then we don't need to re-initialize the repo
afterwards and still don't make the_repository so special.
-- 
Duy
