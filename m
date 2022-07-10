Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F15C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 19:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiGJTaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJTaX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 15:30:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC25FDFDF
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 12:30:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB3EC12CBCD;
        Sun, 10 Jul 2022 15:30:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=SMqGyFOzMZRNISVhbJUyHzOId
        5n2i+joMVNjE6k+Xno=; b=QwtDry6GpWQTey219PcTkOPErvzvYlrLlJj7sxS3r
        03qgga3RTCGmcioxR95g9Q1Z0V/UggOan/fwyBqYu1B9UDlxAgfapR4oK+dQBchL
        oz68fxAuoNsR884errf++QEFasRlKNboDaboNJ0qtu1HvskYotpiVAcB9cP92Azd
        qQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1A8A12CBCC;
        Sun, 10 Jul 2022 15:30:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4CFD412CBCB;
        Sun, 10 Jul 2022 15:30:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH] cocci: avoid normalization rules for memcpy
References: <xmqq8rp54r4l.fsf@gitster.g>
        <220707.86y1x585wy.gmgdl@evledraar.gmail.com>
        <xmqq1quw23r8.fsf@gitster.g>
        <cb866b8c-dcc6-557f-da23-1c1972619a8a@web.de>
        <95432eb4-e66a-5c04-9267-f71391fbe277@web.de>
        <xmqqmtdhsf1z.fsf@gitster.g>
        <ded153d4-4aea-d4da-11cb-ec66d181e4c9@web.de>
        <220710.86ilo580mb.gmgdl@evledraar.gmail.com>
Date:   Sun, 10 Jul 2022 12:30:19 -0700
Message-ID: <xmqqr12srcj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BC503BD8-0086-11ED-B1B6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Since ab/cocci-unused is marked for "next" it would be really nice to
> have this based on top so we can add tests for these transformations
> (the topic adds a way to do that).

Please do not follow this mantra in general.

What is already in 'next' cannot be avoided.  What is not yet in
'next' can yield just fine if needed.
