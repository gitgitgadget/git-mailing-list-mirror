Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F13F1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 16:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbdHIQID (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 12:08:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62088 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752725AbdHIQIC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 12:08:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27E62912D8;
        Wed,  9 Aug 2017 12:07:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/FKMK4zei8dz
        z4TML2N89RtykCY=; b=NrV2oBMbYLLfycROf+QXy36qKNnMFu6Kb4SGWK4yN3UI
        j7ddaP9ctg4Z/Jiv0L7g7PbbRClsf3RBWWKhEZZuvAGLsiMg5ahFygh6phifeRTA
        pZhFo/viC3COqA5WUA7XCTnwbxFyT2WYsfOtO8QUu5j9wPRnhGxLFOvKIigkvEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=P7QCAb
        tpCYirnEMSceEasnVkI1hub8XVfzuxuE+Py8fkjr7zPLwt7zmB7Fl4zVu8fvXWPg
        o5/QUhaCeE10vgra9tylSZ81+oKFb8np1dY9x0ncuPDGRVHETRIsH/3kMZlm7mil
        rXyUpm5axgXLxCUW9TkvlX8n7BXjrgcvQtWfQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19777912D7;
        Wed,  9 Aug 2017 12:07:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 731E6912D2;
        Wed,  9 Aug 2017 12:07:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        David Coppa <dcoppa@openbsd.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] t4062: stop using repetition in regex
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
        <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
        <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de>
        <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com>
        <xmqq7eydae7r.fsf@gitster.mtv.corp.google.com>
        <cd60d779-fe38-4f0e-4d36-2c40b2afec7d@web.de>
        <xmqqtw1h8g1u.fsf@gitster.mtv.corp.google.com>
        <50c2eaab-d1d8-3376-6e7a-1c898d978d12@web.de>
        <e3e65635-2dc8-de58-5662-3eab619aedb3@web.de>
Date:   Wed, 09 Aug 2017 09:07:53 -0700
In-Reply-To: <e3e65635-2dc8-de58-5662-3eab619aedb3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 9 Aug 2017 16:15:10 +0200")
Message-ID: <xmqqh8xg7mhy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E6EC442E-7D1C-11E7-A646-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> In the face of unreliable segfaults we need to reverse our strategy,
>> I think.  Searching for something not in the buffer (e.g. "1") and
>> considering matches and segfaults as confirmation that the bug is
>> still present should avoid any false positives.  Right?
>
> And that's not it either. *sigh*
>
> If the 4097th byte is NUL or LF then we can only hope its access
> triggers a segfault -- there is no other way to distinguish the
> result from a legitimate match when limiting with REG_STARTEND.  So
> we have to accept this flakiness.

> We can check the value of that byte with [^0] and interpret a
> match as failure, but that adds negation and makes the test more
> complex.
>
> ^0*$ would falsely match if the 4097th byte (and possibly later
> ones) is 0.  We need to make sure we check for end-of-line after
> the 4096th byte, not later.

I do not have a strong objection against "^0{64}{64}$", but let me
make sure that I understand your rationale correctly.

We assume that we do not have an unmapped guard page to reliably
trap us.  So "^0{64}{64}$" will report a false success when that
4097th byte is either NUL or LF.  There is 2/256 probability of that
happening but we accept it.

A pattern "0$" will give us a false success in the same case, but
the reason why it is worse is because in addition, we get a false
success if that second page begins with "0\0" or "0\n".  The chance
of that happening is additional 2/256 * 1/256.  Worse yet, the page
could start with "00\0" or "00\n", which is additional 2/256 *
1/65536.  We could have yet another "0" at the beginning of that
second page, which only increases the chance of us getting a false
sucess.

We consider that 2/256 * (1/256 + 1/256^2 + 1/256^3 + ...) is too
big an additional chance of getting false success to be acceptable,
even though 2/256 which is the chance of false success that we have
to and are willing to accept.

Now I am not good at doing math on the keyboard and text terminal,
but

    X    =3D (1/256 + 1/256^2 + ...)
    256X =3D 1 + X
    X    =3D 1/255

so that additional rate of false success is 2/256 * 1/255.

So we are saying that we accept ~1/100 false success rate, but
additional ~1/30000 is unacceptable.

I do not know if I buy that argument, but I do think that additional
false success rate, even if it is miniscule, is unnecessary.  So as
long as everybody's regexp library is happy with "^0{64}{64}$",
let's use that.

Thanks.
