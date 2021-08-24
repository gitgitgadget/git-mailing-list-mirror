Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62857C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317276138B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhHXVp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:45:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60005 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhHXVp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:45:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D1CC2151FC1;
        Tue, 24 Aug 2021 17:45:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6xVQJ7XwwIEg
        iwgAjsqR8AJJwgQPn47j4SQl2z2omqw=; b=J9ZZ/udGLUmih1EZOEOn4e4eaUpQ
        a9JZ1tfGCmROjqmsP7M0tYAY+UYU3VB8MAvikLqtQoQHCMWYmgicV2M31ZeLj3v5
        pXc9aezVpVPAnWIN/gK9SyA+MKkZ0owyhQVtwUUodEGmq09cD52qK86FZZog68ZS
        0yX0NNAkTpQe5DI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C933A151FC0;
        Tue, 24 Aug 2021 17:45:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 916C1151FBF;
        Tue, 24 Aug 2021 17:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Ben Goldberg <ben@benaaron.dev>, git@vger.kernel.org
Subject: Re: send-email issue
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
        <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
        <20210813180056.ctzivmakj4bj5apa@nitro.local>
        <xmqq35rbtx84.fsf@gitster.g>
        <20210816131143.6ifcbpxp6ilo2nv5@nitro.local>
        <YRqQJTyBW6j6b2pW@coredump.intra.peff.net>
        <xmqq4kbps58l.fsf@gitster.g>
        <YRqY4Tw4YxbepuFg@coredump.intra.peff.net>
        <xmqqzgthql1h.fsf@gitster.g> <87eeakfc6b.fsf@evledraar.gmail.com>
Date:   Tue, 24 Aug 2021 14:45:06 -0700
In-Reply-To: <87eeakfc6b.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 23 Aug 2021 16:49:08 +0200")
Message-ID: <xmqq8s0qms9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8D1D7C44-0524-11EC-AF19-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think per
> https://lore.kernel.org/git/87o8ejej8m.fsf@evledraar.gmail.com/ that
> this may not be much of an issue in practice, i.e. assuming that most
> modern servers only accept auth over the encrypted channel the user wil=
l
> get an error anyway.

Let's see how it goes.  It may be wishful thinking but it would lead
to the easiest/simplest solution.


