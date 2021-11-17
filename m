Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E158AC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C145C60F51
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhKQIMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:12:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61903 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbhKQIML (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 03:12:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D8F7F167F4A;
        Wed, 17 Nov 2021 03:09:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=g9lcHVJ7y9bWQGPu3AES960Dz
        nBDetIaXgXeOctsZ0I=; b=pTPT51fOpP+CJFwH3ugh0MHo4NZzTm6dM1VJQPQXU
        aiR77IPtK87wYvh5qsCKwWQavLG+gqiwdmc8SRNVOjKmytdf5Ax1OPXRDSlXons/
        RWNFIg+GK9RvM9g87h6LzqLWMcWLqQ/lwHm5ESTJLsBviopQ4oJbUpFAjlny4RFk
        9U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0B07167F49;
        Wed, 17 Nov 2021 03:09:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26435167F47;
        Wed, 17 Nov 2021 03:09:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/8] fetch: lowercase error messages
References: <20211113033358.2179376-1-andersk@mit.edu>
        <20211113033358.2179376-2-andersk@mit.edu>
        <xmqqczn0d6er.fsf@gitster.g>
        <alpine.DEB.2.21.999.2111160206440.105644@scrubbing-bubbles.mit.edu>
Date:   Wed, 17 Nov 2021 00:09:08 -0800
Message-ID: <xmqqv90r4317.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A4B9620A-477D-11EC-B74B-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Kaseorg <andersk@mit.edu> writes:

> On Tue, 16 Nov 2021, Junio C Hamano wrote:
>> > Documentation/CodingGuidelines says =E2=80=9Cdo not end error messag=
es with a
>> > full stop=E2=80=9D and =E2=80=9Cdo not capitalize the first word=E2=80=
=9D.  Reviewers requested
>> > updating the existing messages to comply with these guidelines prior=
 to
>> > the following patches.
>>=20
>> Thanks.  Whether reviewers requested or you thought of it on your
>> own, separating such a preliminary clean-up into its own patch would
>> be a good idea, especially if the later patches need to update (some
>> of) them.
>
> It was your request; I just mentioned it in case other reviewers wonder=
=20
> why this belongs in this topic.

Sorry, let me try again, as I wasn't clear enough.

Readers of "git log", for whom we write our log messages, are not
interested if reviewers suggested, or you came up on your own.  The
more relevant thing for them to learn from our log messages is the
reason why that solution was chosen (and the fact that the author is
now committed to the chosen solution---not "this does not make much
sense but I am randomly updating as I was told"). E.g.

    ... first word".  This file has many existing messages that
    violate these guidelines.  Clean them up in preparation for
    subsequent patches that touch some of these messages.

or something like that.
