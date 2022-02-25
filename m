Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC591C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 18:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiBYSQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBYSQk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 13:16:40 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBDA1F6352
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:16:04 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12E8F18BBDA;
        Fri, 25 Feb 2022 13:16:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MFhHni86DMTH
        n198CatUl0THM4hfDBExgt3k0hivhBg=; b=E90XYfAWObDU8JV3bgnNWe7V2j4A
        Jsh/+uVJxK24FYq2enpuLatoZsYgUiFS5h4vkltWKlezlTGJonbLzqZiNM3sD3ew
        wbyYddTS2ONQC4svSY4edyq/w0XsLYchy2UQPW18Wowi9trMrUzp9OpqCJ1ywjEt
        UzEMbqHFi4WdfLY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0AA4318BBD9;
        Fri, 25 Feb 2022 13:16:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 718F118BBD7;
        Fri, 25 Feb 2022 13:16:01 -0500 (EST)
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
Date:   Fri, 25 Feb 2022 10:16:00 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 25 Feb 2022 15:10:46 +0100
        (CET)")
Message-ID: <xmqqv8x2dd7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FCDC5946-9666-11EC-A21D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I merged my branch into `seen` and pushed it. The corresponding run =
can
> be seen here:
>
> 	https://github.com/dscho/git/actions/runs/1892982393

I visited this page (while logged in to GItHub---I am saying this
for others who may not know the output is shown differently for
visitors that are logged-in, and and logged-in users).

> On that page, you see the following:
>
> 	Annotations
> 	50 errors and 1 warning
>
> 	=E2=93=A7 win test (3)
> 	  failed: t7527.1 explicit daemon start and stop
> ...
>
> 	=E2=9A=A0 CI: .github#L1
> 	  windows-latest workflows now use windows-2022. For more details, see=
 https://github.com/actions/virtual-environments/issues/4856
>
> In my mind, this is already an improvement. (Even if this is a _lot_ of
> output, and a lot of individual errors, given that all of them are fixe=
d
> with a single, small patch to adjust an option usage string, but that's
> not the fault of my patch series, but of the suggestion to put the chec=
k
> for the option usage string linting into the `parse_options()` machiner=
y
> instead of into the static analysis job.)

It is not obvious what aspect in the new output _you_ found "an
improvement" to your readers, because you didn't spell it out.  That
makes "in my mind, this is already an improvement" a claim that is
unnecessarily weaker than it really is.

Let me tell my experience:

 - Clicking on macos+clang in the map-looking thing, it did show and
   scroll down automatically to show the last failure link ready to
   be clicked after a few seconds, which was nice, but made me
   scroll back to see the first failure, which could have been
   better.

 - Clicking on win+VS test (2), the failed <test> part was
   automatically opened, and a circle spinned for several dozens of
   seconds to make me wait, but after that, nothing happened.  It
   was somewhat hard to know if I were expected to do something to
   view the first error and when the UI is ready to let me do so, or
   if I were just expected to wait a bit longer for it to all happen
   automatically.

Either case, the presentation to fold all the pieces that finished
successfully made it usable, as that saved human time to scan to
where failures are shown.

I personally do not care about the initial latency when viewing the
output from CI run that may have happened a few dozens of minutes
ago (I do not sit in front of GitHub CI UI and wait until it
finishes). As long as it is made clear when I can start interacting
with it, I can just open the page and let it load while I am working
on something else.

Thanks.
