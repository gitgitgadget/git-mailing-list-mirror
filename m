Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291DEC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 07:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiAZHXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 02:23:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60357 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiAZHX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 02:23:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 168A0185387;
        Wed, 26 Jan 2022 02:23:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=xy2AM5+kxv6ajB2gw+Wqc7NTY
        Hw2kF7TRfAvJprgM3c=; b=oJPWRelVJaLzxV0nfcdBr1HBZaleEgvsEhzqThJdG
        hXZSQxyJJIbxdE3MJapY1wO3AhHpH/KAboWI1OPahhIaGlKYpvJFVKwR9lm+X6Er
        RH7aTf+wPgVKIbUxQ8xq18/LCrFnDfLHwPuGS293psv2+688mgpokl4wdod70kb5
        s0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E7EB185386;
        Wed, 26 Jan 2022 02:23:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7C59E185385;
        Wed, 26 Jan 2022 02:23:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
        David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3?= =?utf-8?Q?n?= 
        <carenas@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v5] compat: auto-detect if zlib has uncompress2()
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>
        <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com>
        <xmqqr190ekrh.fsf@gitster.g>
        <74d35354-20a6-9cc1-3452-573460c694bd@drbeat.li>
        <xmqqtudu9s7k.fsf@gitster.g> <xmqqh79t7sj4.fsf_-_@gitster.g>
        <xmqqr18x3s5s.fsf@gitster.g>
        <220124.86r18xgcv4.gmgdl@evledraar.gmail.com>
        <xmqqlez43mx1.fsf@gitster.g>
        <220125.86wninfwyc.gmgdl@evledraar.gmail.com>
Date:   Tue, 25 Jan 2022 23:23:25 -0800
Message-ID: <xmqq7dant0ya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DA4C87C6-7E78-11EC-B451-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> That will compile cleanly on GCC and Clang with DEVELOPER=3D1, which of
> course may leave some other strictly ISO C compiler unsatisfied.

I agree with you that, compared to the solution we borrow from
OpenSSL, it would be of limited utility.  Let's not go there.

