Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046FBC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 23:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF49761006
	for <git@archiver.kernel.org>; Thu, 27 May 2021 23:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhE1AAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 20:00:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56646 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhE1AAE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 20:00:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1178FD4C23;
        Thu, 27 May 2021 19:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sumHhY9yXdJX
        dfxsnsPQWOVjEmI8WFyXROvMLUUf5UM=; b=ZZOI6nJgCIq9iNK7L78bNc4HuDa3
        V/tpJC0TJAIxgIiQbxH4s7NSjrcD8jwxrTShQq1+Buc70M6MdHBFkKloQ+iwYW2b
        ERf8AgREAwZNulsZwTYCMJBsA9kzHthYVIKPHeF+qQrKZzb7m5eglU69n6uukgkm
        ksvvsykcxCuR4yA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06EADD4C22;
        Thu, 27 May 2021 19:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85B51D4C21;
        Thu, 27 May 2021 19:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: CoC, inclusivity etc. (was "Re: [...] systemd timers on Linux")
References: <20210520221359.75615-5-lenaic@lhuard.fr>
        <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
        <44d937a0-e876-e185-f409-a4fd61eae580@gmail.com>
        <nycvar.QRO.7.76.6.2105220856320.57@tvgsbejvaqbjf.bet>
        <60aaa09aebce4_454920811@natae.notmuch>
        <YKrk4dEjEm6+48ji@camp.crustytoothpaste.net>
        <87wnrooa17.fsf@evledraar.gmail.com> <xmqqim38jfja.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2105250327550.57@tvgsbejvaqbjf.bet>
        <87mtshn3vj.fsf@evledraar.gmail.com>
        <YK+rmNWh+jPais9P@coredump.intra.peff.net>
Date:   Fri, 28 May 2021 08:58:27 +0900
In-Reply-To: <YK+rmNWh+jPais9P@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 27 May 2021 10:24:24 -0400")
Message-ID: <xmqqsg2791b0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6EB1E984-BF47-11EB-A239-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not really targeting anybody in particular in this thread (and
> L=C3=A9na=C3=AFc seems to have taken it all in stride in this case). It=
's more
> just a reminder that it's easy to forget to do these kinds of things,
> and keep this kind of perspective. I know I have not always done it
> perfectly at times.

Thanks.
