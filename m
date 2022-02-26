Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0476C433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 18:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiBZSoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 13:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiBZSoO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 13:44:14 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F0614893F
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 10:43:36 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0707C11FAF4;
        Sat, 26 Feb 2022 13:43:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CyYfLeOvCYM2
        pcx0caruLkoNpOD/31P/dsIWO2v7TOY=; b=exY0BPXhyVLUKdpCEqf4EUnMes5E
        MBa/8sYtMBCe45xSMDphKHekG4YesvlzQCHflxpF5zMbZVGoLwh5XDaIF0JnAFuX
        SwXgM47pGNU7pbsV2lucylf0kpaXYWG6YrNZnxoDWBi0pOwklEFgvRk6ICNiqATu
        TvEYi7Rvh9Nn9q0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F257811FAF3;
        Sat, 26 Feb 2022 13:43:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66E2611FAF2;
        Sat, 26 Feb 2022 13:43:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
        <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
        <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
        <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
        <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
        <xmqqv8x2dd7j.fsf@gitster.g>
Date:   Sat, 26 Feb 2022 10:43:33 -0800
In-Reply-To: <xmqqv8x2dd7j.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        25 Feb 2022 10:16:00 -0800")
Message-ID: <xmqqzgmd5uzu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0083BD82-9734-11EC-AD5A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Let me tell my experience:
>
>  - Clicking on macos+clang in the map-looking thing, it did show and
>    scroll down automatically to show the last failure link ready to
>    be clicked after a few seconds, which was nice, but made me
>    scroll back to see the first failure, which could have been
>    better.
>
>  - Clicking on win+VS test (2), the failed <test> part was
>    automatically opened, and a circle spinned for several dozens of
>    seconds to make me wait, but after that, nothing happened.  It
>    was somewhat hard to know if I were expected to do something to
>    view the first error and when the UI is ready to let me do so, or
>    if I were just expected to wait a bit longer for it to all happen
>    automatically.
>
> Either case, the presentation to fold all the pieces that finished
> successfully made it usable, as that saved human time to scan to
> where failures are shown.
>
> I personally do not care about the initial latency when viewing the
> output from CI run that may have happened a few dozens of minutes
> ago (I do not sit in front of GitHub CI UI and wait until it
> finishes). As long as it is made clear when I can start interacting
> with it, I can just open the page and let it load while I am working
> on something else.

FWIW, CI run on "seen" uses this series.

When I highlight a failure at CI, I often give a URL like this:

https://github.com/git/git/runs/5343133021?check_suite_focus=3Dtrue#step:=
4:5520

I notice that this "hide by default" forces the recipient of the URL
to click the line after the line with a red highlight before they
can view the breakage.

For example, an URL to show a similar breakage from the old run
(without this series) looks like this:

https://github.com/git/git/runs/5341052811?check_suite_focus=3Dtrue#step:=
5:3968

This directly jumps to the error and the recipient of the URL does
not have to do anything special, which I have been using as a
convenient way to give developers a starting point.

I haven't compared the implementation of this one and =C3=86var's series
that aims for a different goal, so I do not yet have an opinion on
which one should come first (if we want to achieve both of what each
of them wants to achieve, that is).

Thanks.

