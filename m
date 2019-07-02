Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4571C1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 16:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfGBQ73 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 12:59:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52638 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfGBQ73 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 12:59:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 096D17384D;
        Tue,  2 Jul 2019 12:59:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y8Qc7fdPBZH04wYk5TyMJ0QirV8=; b=SNsrx2
        pijYAIa15ZL5Ba8rScL2jvcsB4hAUTr1z+UUema99S4QAA4c9v7wSfCW1r7KmI4W
        dSrn7apncMBMsMtl6EhCU4/veMmopfv9K7xNTjLZ+7WWfgToJ0z7Eknd5V4EvTC5
        4hmMXfJduy8MrN3wcCBIpRWFCXVdX2vELuQWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WsItKi4FzhBmHvxq8DfaghqPw6Gb3rMX
        Xk1em8udOFb87iXtO5+17KQiYjUdlOxrME+wPHoBvz09l46DF8izwqVaU0rNbU3r
        91M2Uz1FYVxfHkbDZDBZ60F6jxPOBU68xZWrWWncbtZXzMPI+zk9X0pHjR7oDkCI
        5x8RgKJortk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 256AE7384C;
        Tue,  2 Jul 2019 12:59:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4924D7384A;
        Tue,  2 Jul 2019 12:59:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/3] repo-settings: create core.featureAdoptionRate setting
References: <pull.254.git.gitgitgadget@gmail.com>
        <pull.254.v2.git.gitgitgadget@gmail.com>
        <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
        <87sgro7lxo.fsf@evledraar.gmail.com>
        <CACsJy8Aqdb_-5ituTQMNjacHiJbw4abV=HsH9s6PoAGKyuwdJg@mail.gmail.com>
Date:   Tue, 02 Jul 2019 09:59:20 -0700
In-Reply-To: <CACsJy8Aqdb_-5ituTQMNjacHiJbw4abV=HsH9s6PoAGKyuwdJg@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 2 Jul 2019 18:09:41 +0700")
Message-ID: <xmqqv9wk4bkn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDDCF58E-9CEA-11E9-8036-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> So I'm all for a facility to have a setting to collectively opt-in to
>> new things early. But I think for such a thing we really should a) at
>> least in principle commit to making those things the default eventually
>
> Some features may be best enabled for certain setups. This is why I
> set configuration variables repo size, worktree size.. instead of just
> one number.

Yeah, I think the concept of core.fetureAdoptionRate is faulty at
multiple counts, and I admit I am guilty of making at least one
aspect worse by giving the topic branch to queue these patches a
mistaken name of "early-adoption".

Some tweaks, like the use of index version 4, may be something we
strive to make it eventually suitable for _all_ users.  

The effort may involve multiple iterations of things like "gee, the
prefix-compression works very well for really big tree, but sucks
for a project of medium size; lets tweak to automatically
enable/disable it based on the size of the tree", but the main point
is that we want to eventually make it good for projects of all sizes
and different access patterns.  While we do the treaking, the user
experience may be rocky, and "early adoption" model is perfectly
suitable for a thing like this.

But some other tweaks, like the ahead-behind thing, are what we
would never make it the default for everybody.  They are "Git is
never designed to be used like this, but if we disable small things
like this and that, the end user experience for those who used to
have them might suffer, but other aspect of the system becomes
usable" tradeoffs.  When we are done experimenting and know what
kind of system castration may give acceptable trade off, we know the
subset of users to whom these tweaks give benefit (and others to whom
these are not improvements).  Opting into these things is not about
"early adoption".

Also as raised in another message in this thread, I do agree that
the configuration does not belong to the "core." hierarchy.  It is
more like a macro, that flips individual configuration based on a
higher level "grouping" (e.g. my project falls into "large but
infrequently updated" category) to suit the access pattern.

> I see this more like gcc =O options. And for those options, the
> developers decide what to include. If you know what you want already,
> you can just turn specific keys on. Otherwise you count on devs to do
> the right things.

Yup.  Sorry for backing a wrong model.  And I kind of like the word
"bundled" you mention below, not as in "bundled with Git", but more
as in "these configuration settings are bundled together to serve
users of this kind of project".

> Which makes me think about a slightly different implementation detail
> (which I ignored because I didn't think further about per-release
> stuff): since these are basically meta config to change defaults, we
> can just implement them as a (builtin, or bundled) config file. The
> user can see what are included much easier we have several different
> config "profiles" (deep history, large worktree, bleeding-edge...) and
> the user can include one or all [1].
>
> [1] it also opens up the opportunity to have a standard (but optional)
> set of aliases. But that's a touchy topic.
