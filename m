Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE169C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA24E6103B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhINRao (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:30:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58061 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhINRam (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:30:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 825B215C73E;
        Tue, 14 Sep 2021 13:29:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HPYMKHgp4LM8
        DpUItx6JkZMkVXqMDjMiW+XC8mMEjjI=; b=XaKRoCJR2N5Bl/0D0i0xAmh/QugD
        sSV6nVh7kW2Vk5y2W0zTKctZ0VSCi9/UrQxF4CgG9vdskhFNjnwqB7owCzDvFR5S
        PSxgO4ASFHrDHoxVAfv3pWYqoVYBWLy5GqeySXz7oX/sjZ0Nl9kK+xoiJis2Z+zm
        eZf7TEuDySvR0w4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A84E15C73D;
        Tue, 14 Sep 2021 13:29:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E8E7715C73C;
        Tue, 14 Sep 2021 13:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Train station analogy, was Re: [PATCH v3 00/15] [RFC]
 Upstreaming the Scalar command
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <87r1dydp4m.fsf@evledraar.gmail.com>
        <87ilz44kdk.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
        <87mtofnzv1.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet>
Date:   Tue, 14 Sep 2021 10:29:20 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 14 Sep 2021 16:24:53 +0200 (CEST)")
Message-ID: <xmqqilz32hhr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4C7AA140-1581-11EC-BD4B-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, let's try an analogy.
>
> Imagine that a person is asking for directions to the train station. An=
d
> the other person is replying by asking "did you know that this train
> station was built in 1878? It is actually quite interesting a story...
> [and then goes on to describe the history and what excites them about
> it]". Now, the first person tries again to ask for directions, again do=
es
> not get an answer to that question, and is slowly starting to look at
> their watch. The second person, being completely oblivious to all of th=
is,
> goes on with their wonderful story about the train station and its
> cultural heritage. So the first person walks a bit further to ask a thi=
rd
> person, but the second person is not done yet and says "but you haven't
> heard me out! That's disrespectful!".
>
> Just imagine for a minute how you would feel if you were the first pers=
on.
>
> And that is how I feel asking for reviews about the Scalar patch series
> and then being forcefully dragged into that tangent about the build
> process.

At least to me, how this Makefile for Scalar should interact with
the overall build process does not mesh well with the story about
hwo direction to and history of the station are unrelated.  If we
plan to start from contrib/ and eventually want to make it a part
of the core Git (i.e. "git scalar <subcmd> ..." becomes just like
"git bisect <subcmd> ..."), we would eventually need to see the
recipe needed for including "bisect" and "scalar" work the same
way, no?

I am getting the impression that such a unified build process is
=C3=86var wants to see at the end, I am not even sure if you do from
the above "analogy".  Cool down a bit, perhaps?

The following assumes that you share the goal of making "git
scalar" just like "git bisect"---another first class citizen of
Git toolbox, the user can choose to use it or the user may not
have a need to interact with it, but it exists there by default
and is not an opt-in add-on component.

I would understand it if your plan is to convert to a unified
build procedure at the very end of the upstreaming process, and
not while you populate contrib/ with more and more scalar stuff,
because the Makefile bits for the entire scalar, while not yet
upstreamed, has already been written as a separate procedure and
having to convert the whole thing upfront before you can start
trickle parts would mean you need to (re)start the process.  And
I would even be sympathetic if you felt it like a distraction.

But at least I view it as a step that needs to happen sometime
between now and at the end.  I do not yet have an opinion on
which one is more pleasant, between (1) having to deal with a
single Makefile that needs to be aware of two different locations
*.[ch] lives in, and (2) having to deal with two Makefiles that
duplicates definitions and risks them needlessly diverging.

I also would understand it if the reason why you want to keep the
top-level Makefile as intact as possible because you sense a high
probability that scalar will stay in contrib/ and even turn out
to be a failure.  Keeping the build procedure separated certainly
will keep it easier to yank it out later.  But I do not think
such a case is quite likely.

Thanks.
