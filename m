Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BA1C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D0360F4B
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbhIVUZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:25:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63683 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhIVUZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:25:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A42E11585E3;
        Wed, 22 Sep 2021 16:23:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jLx+5sfPSA1m
        Qqi0fnF8+3PdMyfJ5844gk3yrCqG4iE=; b=SZQ/i2i77ACzTpXD86jRfZRQVecA
        LAi9pXAtiziiduAOGtWKk3jlLet84wGCVFrA4e2dONKkC9fpVA/BrVhbyWC3SKuM
        o/jY4QJTVdkqU0CYVZBxnUID32eQii/wKobCYpgVQn8fd5v4sCz6VLN1wJkDhAW0
        000gQzt3FgghHWw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E9791585E2;
        Wed, 22 Sep 2021 16:23:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F4581585E1;
        Wed, 22 Sep 2021 16:23:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/5] repo-settings.c: refactor for clarity, get rid
 of hacks etc.
In-Reply-To: <YUpEubyYwD+Qe+oE@nand.local> (Taylor Blau's message of "Tue, 21
        Sep 2021 16:46:49 -0400")
References: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
        <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
        <d852d412-4d6a-505f-2c4c-52e81ab4e3f4@gmail.com>
        <YUpEubyYwD+Qe+oE@nand.local>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 22 Sep 2021 13:23:52 -0700
Message-ID: <xmqqtuic5pgn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0152ED68-1BE3-11EC-A18E-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Sep 21, 2021 at 11:58:34AM -0400, Derrick Stolee wrote:
>> On 9/21/2021 9:12 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> > A hopefully final re-roll addressing Taylor's v3 review, except for
>> > the suggestion (that I read as) perhaps retaining the test-only code=
,
>> > which I've decided not to do per
>> > http://lore.kernel.org/git/87tuieakms.fsf@evledraar.gmail.com
>> >
>> > [...]
>>
>> This version looks good to me.
>
> Likewise. Thanks =C3=86var for addressing my review.

Yeah, I think this one is good enough for 'next'.

Thanks, all.
