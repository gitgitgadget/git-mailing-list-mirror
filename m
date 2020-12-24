Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9603CC433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7F62225E
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgLXWlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 17:41:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50611 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgLXWlP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 17:41:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67C29A243E;
        Thu, 24 Dec 2020 17:40:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+p+sAxrg2CN797nLPQmm6F0AwB8=; b=owMKnC
        q5xnREzRn81tyuACDwhAmQ6chA6+68lm9A/W/RBPxdcLAJawV656e0IEKtXV4o9V
        NU3bJBzMP/YpWSn7izTslgQqM3sOW4tWHpFG8jV5tUe/knpA7islaLv+LS//CBiR
        AxeizvMvUxFZnx1H+ictvIUMhZnCxyEmiPUI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KBwWqErCyKbw3Zcvc3jSKxv0zpRJkx0G
        YNbBDWRKR0C7o9DBejT38gFCxE8Vx/Pf9oyEmpknry8yeJpFAgh/WsEKIMqbuyzt
        ry8hOnAdzRdU0uriDkZUYhiZ2tbvxDgTCuI/Q1GkmJ0REEE5QLl0Fkfn14gdJ+jJ
        L9fDicZp8qo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E14BA243C;
        Thu, 24 Dec 2020 17:40:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD67BA243B;
        Thu, 24 Dec 2020 17:40:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        =?utf-8?B?J8OGdmFyIEFy?= =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason' 
        <avarab@gmail.com>, 'Pratyush Yadav' <me@yadavpratyush.com>,
        'David Aguilar' <davvid@gmail.com>,
        'Seth House' <seth@eseth.com>,
        'Git Mailing List' <git@vger.kernel.org>,
        'Christian Couder' <christian.couder@gmail.com>,
        git@sfconservancy.org
Subject: Re: Nobody is THE one making contribution
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
        <20201218054947.GA123376@ellen>
        <5fdc7a7d3a933_f4673208d0@natae.notmuch>
        <20201219001358.GA153461@ellen>
        <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
        <20201221042501.GA146725@ellen>
        <5fe033e0ec278_96932089d@natae.notmuch>
        <20201221073633.GA157132@ellen>
        <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
        <5fe134eeaec71_11498208f9@natae.notmuch>
        <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
        <5fe2c64bd3790_17f6720897@natae.notmuch>
        <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
        <5fe2d89c212e8_18dc12083e@natae.notmuch>
        <xmqqzh248sy0.fsf@gitster.c.googlers.com>
        <5fe36790793ae_2354120839@natae.notmuch>
        <87r1ngufmf.fsf@evledraar.gmail.com>
        <5fe424d0528a2_7855a208d3@natae.notmuch>
        <00f401d6da06$be415560$3ac40020$@nexbridge.com>
        <5fe4b5cbacf0d_19c92087f@natae.notmuch>
Date:   Thu, 24 Dec 2020 14:40:30 -0800
In-Reply-To: <5fe4b5cbacf0d_19c92087f@natae.notmuch> (Felipe Contreras's
        message of "Thu, 24 Dec 2020 09:37:47 -0600")
Message-ID: <xmqqy2hm25gh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06FD3E74-4639-11EB-926B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Randall S. Becker wrote:
>> On December 24, 2020 12:19 AM, Felipe Contreras wrote:
>> > We can narrow down the part I'm talking about:
>> > 
>> >   d. I *agree* that a record of the contribution is maintained
>> >      indefinitely.
>> > 
>> > I don't agree with that.
>> 
>> Clause d is important to maintain compatibility with GRPD[1] rules
>> about maintaining identifying information. This clause is more than
>> about the contribution. It is about consent to maintain your name and
>> email on record indefinitely, as part of the contribution, in the git
>> repository, without the ability to rescind the permission at some
>> point in the future.
>
> I didn't mean I don't agree that clause (d) should be there.
>
> I mean if in a particular contribution I don't agree that a record of
> the contribution is maintained indefinitely with my name, then clause
> (d) is not met. And it is not actually my true contribution, but a
> bastardization of it made by somebody else.
>
> You shouldn't assign to my name changes I don't agree with in
> perpetuity.

The way I read our DCO, especially its part (b), is that it is very
much designed to allow editing, tweaking and improving on others'
patches with editor's sign-off while passing a patch around.


