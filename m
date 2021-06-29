Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0097C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 00:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A4C61CDA
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 00:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhF2AfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 20:35:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59008 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbhF2AfI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 20:35:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74AAC155718;
        Mon, 28 Jun 2021 20:32:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=O7lCn5bFOf5ZZqLaav3umsU+M
        n1PqIU/tKeUGOOGVBM=; b=o2R0ZnJk8sE6LESWzWhbt8ZVusaq/VKM+5w+TQ3TR
        TjICBqoT7yfb08WKB6mHyQ9KKiLuBoQjDrm43zz+PDFfNrhQ25cGBYfZboS2DWeh
        d/o3Kt84tx1i5BDmCIIA0O7AVjaJyvJdrBohYfSlA2cnSXhKisOfnwjZRugClTvG
        6Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C27F155717;
        Mon, 28 Jun 2021 20:32:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD25E155716;
        Mon, 28 Jun 2021 20:32:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] hook-list.h: add a generated list of hooks, like
 config-list.h
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
        <patch-3.3-f343fc7ae6-20210617T100239Z-avarab@gmail.com>
        <20210618170550.GE6312@szeder.dev>
        <648321ed-bda9-d7fc-73e1-7ccf48addf9c@web.de>
        <nycvar.QRO.7.76.6.2106221642560.57@tvgsbejvaqbjf.bet>
Date:   Mon, 28 Jun 2021 17:32:38 -0700
Message-ID: <xmqqv95x4ijd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82803176-D871-11EB-AF51-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 20 Jun 2021, Ren=C3=A9 Scharfe wrote:
>
>> How about something like this?
>>
>> 	sed -n '/^~~~~*$/ {x; p;}; x' Documentation/githooks.txt |
>> 	sort |
>> 	sed 's/^.*$/	"&",/'
>>
>> sed is already used by generate-configlist.sh.
>
> I do like me a good sed script.
>
> Thanks,
> Dscho

Yup. =20

This is buried below the 27-patch series, so the whole thing cannot
advance until this gets sorted out.

Thanks.
