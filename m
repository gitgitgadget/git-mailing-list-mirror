Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10184C4332F
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 02:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348945AbiAYB7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 20:59:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59064 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381569AbiAXUVT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 15:21:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9ED55176806;
        Mon, 24 Jan 2022 15:21:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BQCAs1SfCFRC
        1JSisuCN2eadbgMLXXVsNJbZl3kH940=; b=mlDhRTR7JekKD8id6ED40cGXrlcW
        qs9OlZ8jMcmKmwBDqg0LtLpnID9BoHypee7ySOWC4hup+nKfPwuJPXmCTlfyc61U
        9QuU3pNLujYe6xBX19alRQ6oyMvb0yScHbBmxMlboDsy7jZHpUpOjDRGw+QwMXF3
        KXVeiM8l1xEsEdI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 96E94176804;
        Mon, 24 Jan 2022 15:21:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F23C0176803;
        Mon, 24 Jan 2022 15:21:15 -0500 (EST)
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
Date:   Mon, 24 Jan 2022 12:21:14 -0800
In-Reply-To: <220124.86r18xgcv4.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 24 Jan 2022 20:07:26 +0100")
Message-ID: <xmqqlez43mx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2EA71C4A-7D53-11EC-A016-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Aside: I have not yet found such a compiler, does anyone know of one
> that breaks? In any case doing this for good measure seems fine, just
> wondering if we're cargo-culting a needless workaround or not.

Before I started Git, I had to deal with quite a many variations of
UNIX, all of which looked alike but behaved slightly differently,
and I do recall seeing this exact breakage, so it is a real solution
to a real problem, and I can see OpenSSL folks had seen the same one.

If you find my experience is not Enough, I have no further words for
you on this topic.

If the question is "name a compiler that breaks and is *still* in
active use", then the answer would be fuzzy (it depends on the
definition of "in active use"), but is useful to find out.


