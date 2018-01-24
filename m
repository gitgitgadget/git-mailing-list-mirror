Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CD941FADF
	for <e@80x24.org>; Wed, 24 Jan 2018 13:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933803AbeAXNpV (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 08:45:21 -0500
Received: from mail-ua0-f170.google.com ([209.85.217.170]:39985 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeAXNpU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 08:45:20 -0500
Received: by mail-ua0-f170.google.com with SMTP id t6so2711777ual.7
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 05:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zfJStl+SAax6cNMmxNbo/7aG8iAPwrrkrF8juR/pPhY=;
        b=RXeTf4xxBm1FeWAKffbGh7OmIvlzNOfhSFIejMLW6arPV7ewLQEM54UF68zUtz8GCf
         4PKXRNNkUrkZqTUSZsyl5P97SRktruZJsz7hM4lD9tqsxpOiNDy9izinGqZ+sc+vvGVL
         jQr0UmYzxAwS+Ir9Ko/MuSvuf1TEeQd8JNbjM+L/PD4U6JQcCeCNdDlweIyViyo5vWgb
         KnskKxPef1aIU5+6G/m9TdS5GzaERLgy25Q6jOOAHLJLWuq4NInj612ZxJf54cO9bCPo
         IM07Nbz3pP7i85t/FbrGLUh9imHq8+nA5Pt4Kxv1MT02eSiO4C3OzeEV0GAQO/U0EUkc
         TeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zfJStl+SAax6cNMmxNbo/7aG8iAPwrrkrF8juR/pPhY=;
        b=AivxiZkzplJTWfiuMDsVezXS5iMKsyGo4aIrh7ZB1ZvgCfemVS9E5V0v+UUMe8tCpS
         xJ/krovOcU+p9X+Cnz/YuPXyaqOVm4Jx9UnH8bM2Q+5v5UA7wmwFvQeRGtjEUKOHkkPP
         v3YDrD8EuL/YJ89FMxz3R00pWdjx0B84eHTElIu4yRBIxOOr4OfnLTZurFMM/KfevXwu
         f/DRI9umWf1AKvo4rRb9kF56hDxTOhZdIb4TZ4VbkQuF4nqnqBhWFwg49Mu6eBwGjUUv
         osuNLDC8xE/onpEOQraidevN3zNEUTzW1Kzc7ukbAkvjkMqxn3dvRO78zhFDD7uAmeCg
         NHgw==
X-Gm-Message-State: AKwxyte/XmolMSwK9WfTe69Fp5DaKbTvI73cY0CvXeNuboLvI0JtmltI
        RFFVELVLsmaijwEgfSeRz6QeHaeYMotpoKtwESI=
X-Google-Smtp-Source: AH8x227ro+m1fEowE7dyhUG5DHr7CCOCatHnc2XVg8fTkeR69LmgSgnf4BvjdUsNs35+tKkt0fd1ucGKe44rg7zJzSQ=
X-Received: by 10.176.11.138 with SMTP id c10mr4903199uak.94.1516801519553;
 Wed, 24 Jan 2018 05:45:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Wed, 24 Jan 2018 05:45:18 -0800 (PST)
In-Reply-To: <20180123164340.GG13068@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com> <20180122133220.18587-5-szeder.dev@gmail.com>
 <20180123164340.GG13068@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 24 Jan 2018 14:45:18 +0100
Message-ID: <CAM0VKjkRGxAjjibHbJPmC6KZDFL67WEhN1VFqEjbsQAZbgCB8A@mail.gmail.com>
Subject: Re: [PATCH 4/5] travis-ci: don't run the test suite as root in the 32
 bit Linux build
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 5:43 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jan 22, 2018 at 02:32:19PM +0100, SZEDER G=C3=A1bor wrote:
>
>> Travis CI runs the 32 bit Linux build job in a Docker container, where
>> all commands are executed as root by default.  Therefore, ever since
>> we added this build job in 88dedd5e7 (Travis: also test on 32-bit
>> Linux, 2017-03-05), we have a bit of code to create a user in the
>> container matching the ID of the host user and then to run the test
>> suite as this user.  Matching the host user ID is important, because
>> otherwise the host user would have no access to any files written by
>> processes running in the container, notably the logs of failed tests
>> couldn't be included in the build job's trace log.
>>
>> Alas, this piece of code never worked, because it sets the variable
>> holding the user name ($CI_USER) in a subshell, meaning it doesn't
>> have any effect by the time we get to the point to actually use the
>> variable to switch users with 'su'.  So all this time we were running
>> the test suite as root.
>
> This all makes sense to me, and the patch looks sane.
>
>> Reorganize that piece of code in 'ci/run-linux32-build.sh' a bit to
>> avoid that problematic subshell and to ensure that we switch to the
>> right user.  Furthermore, make the script's optional host user ID
>> option mandatory, so running the build accidentally as root will
>> become harder when debugging locally.  If someone really wants to run
>> the test suite as root, whatever the reasons might be, it'll still be
>> possible to do so by explicitly passing '0' as host user ID.
>
> Coincidentally, we recently set up a docker test build for our local fork
> of Git. We found the whole "mount the existing git source tree" strategy
> slightly annoying, exactly because of these mismatches between the host
> and docker uids.
>
> Instead, we ended up with something more like:
>
>   git archive HEAD | docker run ...
>
> and the in-container script starts with:
>
>   tar -x
>
> to extract the to-be-tested source, and ends with a dump of the failures
> to stdout.
>
> I don't know if it's worth switching strategies now, but just some food
> for thought. It may be less interesting with Travis, too, because you're
> also trying to carry the prove cache across runs, which does require
> some filesystem interaction.

The prove state in itself doesn't need matching user IDs in the host and
the container, because it's only accessed in the container[1].

I think the key is the handling of verbose logs of failed test(s).  The
original motivation for matching the user IDs was, I suppose, that we
wanted to dump the verbose log of the failed test(s) to the trace log on
the host, because this way it's fairly consistent with how other build
job do the same: it uses the same 'after_failure' script to dump the
verbose logs, it relies on Travis CI to automatically run that script if
something goes wrong, and those logs end up in the 'after_failure'
fold.

[1] - I ignored saving and restoring the cache here: while it's done on
      the host, but it's done by Travis CI, presumably as root, so the
      owner of the file doesn't matter.

> (As an aside, I'm not sure the prove cache is doing much. Running in
> slow-to-fast order helps if you are trying to run massively in parallel,
> but we only use -j3 for our Travis builds).

It saves about a minute / 10% of runtime; it's mentioned in 7e72cfcee
(travis-ci: save prove state for the 32 bit Linux build, 2017-12-27).
