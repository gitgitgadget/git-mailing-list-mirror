Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFCBC47082
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D74861352
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 00:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFIAXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:23:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50721 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFIAXE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 20:23:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86D21BA108;
        Tue,  8 Jun 2021 20:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZgEgRQvgqlLd
        F/cFrxUeZx2f6ifZxmzG/0E2AKnME5c=; b=d3NuoAE+/+PU03060Nhg9KfM636a
        J3W1kX5ctQDKafrJLmApnnxu0hdIPuSuRmYwcLrgDpy+Jokgx3FZ46UAm8lEnyRV
        VK69LxVweNa5w7s55beccn6R0vjiLKZNxWnBtsPCmau1y3I1irtLfC/sEm/1Zb+f
        hV4Hvfm4tqdl+D0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E551BA107;
        Tue,  8 Jun 2021 20:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10644BA106;
        Tue,  8 Jun 2021 20:21:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/3] add support for systemd timers on Linux
References: <20210524071538.46862-1-lenaic@lhuard.fr>
        <20210608134000.663398-1-lenaic@lhuard.fr>
Date:   Wed, 09 Jun 2021 09:21:09 +0900
In-Reply-To: <20210608134000.663398-1-lenaic@lhuard.fr> (=?utf-8?B?Ikw=?=
 =?utf-8?B?w6luYcOvYw==?= Huard"'s
        message of "Tue, 8 Jun 2021 15:39:57 +0200")
Message-ID: <xmqqh7i7nb0q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 972E3578-C8B8-11EB-A95B-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr> writes:

> Hello,
>
> I=E2=80=99ve reworked this submission based on the valuable feedback I=E2=
=80=99ve received.
> Thanks again for it!
>
> The patchset contains now the following patches:
> ...

A summary very well written.  I wish all the cover letters were
written like this one.

> I hope I=E2=80=99ve addressed all your valuable feedback. Do not hesita=
te to
> let me know if I=E2=80=99ve forgotten anything.
>
> L=C3=A9na=C3=AFc Huard (3):
>   cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" functio=
n
>   maintenance: `git maintenance run` learned `--scheduler=3D<scheduler>=
`
>   maintenance: add support for systemd timers on Linux

Thanks.
