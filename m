Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928D9C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 09:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7767860FDA
	for <git@archiver.kernel.org>; Mon, 24 May 2021 09:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhEXJGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 05:06:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53015 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhEXJGO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 05:06:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B311B3980;
        Mon, 24 May 2021 05:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nZfooJOdVQ4+
        gzwrJ+ierqJ9bLkHNc6yvTTiL+zvuF4=; b=tym3HBE6m5RvtLcOol76kP8nx4y2
        Y1LuxprwUt9kW5FHZCXcvEInJRyVHmhlhvYJ541L/eSr3WzLaUYMiX7J1UsvjP9H
        Log0puIze9ao2Qg4Z40HFz8awVYFPuZgLynBP/o/smfhYYiVYzacszTKCjfZVJrT
        UD/n+ixHVHAl4EM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FB43B397F;
        Mon, 24 May 2021 05:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB45FB397D;
        Mon, 24 May 2021 05:04:44 -0400 (EDT)
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
Subject: Re: [PATCH v4 0/4] add support for systemd timers on Linux
References: <20210520221359.75615-1-lenaic@lhuard.fr>
        <20210524071538.46862-1-lenaic@lhuard.fr>
Date:   Mon, 24 May 2021 18:04:44 +0900
In-Reply-To: <20210524071538.46862-1-lenaic@lhuard.fr> (=?utf-8?B?IkzDqW5h?=
 =?utf-8?B?w69j?= Huard"'s
        message of "Mon, 24 May 2021 09:15:34 +0200")
Message-ID: <xmqqh7ismrir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 15464D02-BC6F-11EB-841B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr> writes:

> Hello,
>
> The main difference between this v4 patchset and the previous v3
> concerns ...

Ehh, before that, please be helpful to those who weren't involved in
the discussion of earlier rounds and haven't seen the paches v3 and
below.  What is this topic about in the bigger picture, why readers
should be interested in reading them, on top of what commit is the
series designed to apply, etc. etc.

Thanks.

> the first patch, the one introducing a new function to use
> $XDG_CONFIG_HOME.
> Instead of re-purposing the existing `xdg_config_home(filename)`
> function, I=E2=80=99ve created a new generic one named
> `xdg_config_home_for(prog, filename)` to address the potential
> conflict issue raised by Danh.
>
> I=E2=80=99ve also reworded the commit message of the last patch to addr=
ess the
> review comments.
> I replaced the =E2=80=9Che=E2=80=9D by a =E2=80=9Cthey=E2=80=9D.
> To be honest, I=E2=80=99m not an English native speaker, so I don=E2=80=
=99t feel
> comfortable debating which usage is common in informal speech or in
> formal writtings.
> So, I would be happy to change it to =E2=80=9Che or she=E2=80=9D if it =
is more
> consensual and looks less =E2=80=9Cartificial=E2=80=9D than =E2=80=9Che=
/she=E2=80=9D.
>
> L=C3=A9na=C3=AFc Huard (4):
>   cache.h: Introduce a generic "xdg_config_home_for(=E2=80=A6)" functio=
n
>   maintenance: introduce ENABLE/DISABLE for code clarity
>   maintenance: `git maintenance run` learned `--scheduler=3D<scheduler>=
`
>   maintenance: add support for systemd timers on Linux
>
>  Documentation/git-maintenance.txt |  60 ++++
>  builtin/gc.c                      | 548 ++++++++++++++++++++++++++----
>  cache.h                           |   7 +
>  path.c                            |  13 +-
>  t/t7900-maintenance.sh            | 110 +++++-
>  5 files changed, 657 insertions(+), 81 deletions(-)
