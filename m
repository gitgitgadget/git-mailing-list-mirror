Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02855C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 19:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345343AbhLVTxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 14:53:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61328 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhLVTxo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 14:53:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6CDE10DA86;
        Wed, 22 Dec 2021 14:53:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cvChaZx92DRhb7OZQVF0Eh6CGKgSL9zGnd2sWQ
        RHDEo=; b=hYJqsyBA6D0GPAaskSj8UnoahsGjMrSIxjBF0cZiWg/fMT/BQJ42+T
        UJa77QzknRLWNgVme9X9icWrdRBPgdp8wGnAWXD/D56K1nPolqaNnSPhDs7Iaqkj
        Y1J7Y3FWn32mIgsMMj64XmoRMM/6ekKi1R8xjt17cKQVzWC8FrXN8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDE9310DA85;
        Wed, 22 Dec 2021 14:53:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3CDD710DA84;
        Wed, 22 Dec 2021 14:53:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Erik Cervin Edin <erik@cervined.in>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
        <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>
        <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
        <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net>
        <xmqqa6guub9n.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2112221717440.347@tvgsbejvaqbjf.bet>
Date:   Wed, 22 Dec 2021 11:53:41 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2112221717440.347@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 22 Dec 2021 17:19:58 +0100 (CET)")
Message-ID: <xmqqczloju0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDE8DBD8-6360-11EC-AB22-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 20 Dec 2021, Junio C Hamano wrote:
>
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>
>> > I should point out that in most cases on Unix, it _is_ expected that you
>> > install your manual pages into the same place as everyone else, so in
>> > this case, installing the HTML documentation alongside Git's may be the
>> > best solution.
>>
>> Yup, that sounds like the most sensible way to do things.
>
> So what about `~/bin/git-my-reply-to-junio`? Do we expect people to write
> a manual page and install it into `~/man/man1` and for `man` to pick that
> up?

Yes, if they write one, and then tell man that you have extra
manpages there via MANPATH.

I expect people *not* to write a manual page in practice for such a
thing, though ;-)
