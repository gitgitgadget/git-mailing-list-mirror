Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C7C4332F
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 23:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCA8610CB
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 23:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhJ0X6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 19:58:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55912 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhJ0X6h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 19:58:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9951EEC71D;
        Wed, 27 Oct 2021 19:56:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/GxOjWemagzB
        63kQENOMfVQ5gff4peZKwJ8QoKaE8vI=; b=iXHdBZTEiiT75qtzGkHFjoz+6d2A
        7I1dlbLTy9auwW0Ppzmqsgfvzx5xvwJXn4OjlTs5nahkPjAZgSekeHpymGS66oJb
        ltSsq0R8yHMt3yV+Y1npElz9XBEZkU5lSyS+Hm9S/3zJJpxvrWnDZsgSjEVgPw/R
        poYeFwldsZVER5U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 901C7EC71B;
        Wed, 27 Oct 2021 19:56:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0ADCEC71A;
        Wed, 27 Oct 2021 19:56:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: js/scalar, was Re: What's cooking in git.git (Oct 2021, #05;
 Mon, 18)
References: <xmqq1r4hv7bv.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2110191436250.56@tvgsbejvaqbjf.bet>
        <211020.86zgr3n698.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2110210947590.56@tvgsbejvaqbjf.bet>
        <211022.868rylkuw7.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2110221734530.62@tvgsbejvaqbjf.bet>
        <211026.86lf2gym9u.gmgdl@evledraar.gmail.com>
Date:   Wed, 27 Oct 2021 16:56:08 -0700
In-Reply-To: <211026.86lf2gym9u.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 26 Oct 2021 14:20:55 +0200")
Message-ID: <xmqqr1c6t42v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 75447854-3781-11EC-882E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It's not that libgit.a isn't rebuilt, that part isn't broken, it's buil=
t
> by the top-level Makefile. It's that if you:
>
>     make -C contrib/scalar
>
> And then change anything it depends on, short of the top-level
> rebuilding libgit.a it won't be re-built, so for anyone hacking on it
> that Makefile is rather useless.

Is this merely an example, or is this the only thing you cared about
the build procedure?

>> I would still like to invite you to think along more productive lines.
>> It's not about where Scalar's build mechanics are right now. It's wher=
e we
>> can take _Git_ to do what Scalar already does.
>
> That's also interesting, but right now we're not discussing that
> subsequent set of patches, but your integration of scalar in-tree. Let'=
s
> fix those issues first.

