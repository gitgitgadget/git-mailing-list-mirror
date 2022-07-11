Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72611C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 19:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiGKTVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 15:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiGKTVW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 15:21:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953773AB14
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 12:21:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1CC31A6112;
        Mon, 11 Jul 2022 15:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ShC2PlOUiZLG
        6Sb9C7xtjediai4Xel3N/8FSwx8RNCY=; b=k0nv4PATUpmn1WC9Q4F/Yt/1nmSJ
        nesP5gcW834DW0qyfcqpD/UDQBqvQSzuQhywU8+Q5jVhCHKWYuxfeXqTRxggPYGx
        qJJgmt/h1sozfh/Aj71n9TEBVkMZRRqRstqaZ/b4+3m+LOjSKh8/hW3e43ZOGkbo
        pXwQInypBGId0eI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6E7C1A6111;
        Mon, 11 Jul 2022 15:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 49AA81A610D;
        Mon, 11 Jul 2022 15:21:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonas Aschenbrenner <jonas.aschenbrenner@gmail.com>,
        git@vger.kernel.org
Subject: Re: Suggestion to rename "blame" of the "git blame" command to
 something more neutral
References: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
        <220710.86r12t82ea.gmgdl@evledraar.gmail.com>
        <20220710145502.GT17705@kitsune.suse.cz> <xmqq1qutrkm8.fsf@gitster.g>
        <220711.86sfn77sd7.gmgdl@evledraar.gmail.com>
Date:   Mon, 11 Jul 2022 12:21:16 -0700
In-Reply-To: <220711.86sfn77sd7.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 11 Jul 2022 13:47:06 +0200")
Message-ID: <xmqqwncjo3pv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A3102EEE-014E-11ED-8824-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Jul 10 2022, Junio C Hamano wrote:
>
>> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>>
>>>> What do you think about this old patch of mine to add a 'git praise'=
?:
>>>> https://lore.kernel.org/git/20190401101246.21418-1-avarab@gmail.com/
>>>
>>> Since you are asking .. I think it completely misses the point.
>>>
>>> I would consider it effective if users of git-praise(1) needed no
>>> knowledge of existence of git-blame(1).
>>
>> I think you are the one who completely misses the point of him
>> sending the URL (hint: what is the date of the patch?)
>
> I wrote it as a joke, but that was in 2019, and I think at that time th=
e
> idea that we needed to do anything about the "master" nomenclature was
> equally far-fetched, but here we are.

Comparing master/main with blame/anything-else is apples and
oranges, though.

The switch of (not the feature to configure) the default was
palatable only because it benefited even those who did not mind the
continued use of the word 'master', those who found 'main' just as
problematic as 'master', or anybody in between, simply because the
major hosting sites and existing projects were or have already
migrated.  In such an external reality, using 'master' as the
hard-coded default would have forced more people to configure when
they start their project, whether they liked or hated the word
'master' [*1*].

"git blame" is completely different.  Nobody cares if you do not
find a "blame" offensive word [*2*], nobody should care if you typed
"git blame", and nobody should dictate you to stop using "git blame"
nor eradicating "blame" from our source.

Let this thread just stop, please.


[Footnotes]

*1* Admittedly we helped the migration of these people by improving
the auto-detection in "git clone" of what the upstream uses, and
adding the configurability to "git init", so we weren't impartial
bystander who passibly adjusted to the prevailing wind, but we
weren't the only one who were setting the policy and forcing other
folks to adopt it.

*2* After all, if the tool finds an old mistake you made, blaming
the earlier breakage to you, why are you making a big fuss about it?
You already made a mistake in the commit "git blame" found; even if
(figuratively) you are playing the "I must always be right" game,
admitting your past mistake does not make you even more wrong.  It
is what you did in the past, and you can simply acknowledge the fact
and move on, with th easpiration that the next time you would be
more careful.  The world would become a better place and the first
step in that journey is to admit your past mistakes and accept the
blame.
