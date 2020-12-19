Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6436C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 01:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E5523BDC
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 01:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgLSBlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 20:41:52 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58939 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgLSBlw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 20:41:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D15B49A9DA;
        Fri, 18 Dec 2020 20:41:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o+qM6LlWlB79oq98JAoowaLlk8Y=; b=j6mjD4
        VfpepWuRrRQxxtmvBrBEkAWIJzFKIB79qz++H6kSiztqegCgtImymURxHefzdB1T
        Iwf7fodBbIeBAROZoIllmEH88wh8m6bG7FvvPZEtYV9fhJJIdibwtewFZ0jI8Evx
        WUDleGroPHpUNZYtU6/nkS8GG18gwwMMDyMao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ezM1ir7O+Kx8PXiw7cRyd8ICeb8krfYZ
        5YeDDI8nbFdGPLjv7Y0BO+4SS00AcoNYJQxmVNuweyw9gTyD4GbhbApA+29IViMj
        OGulJjTsB/MFTOt6vClVmRzIYV4xZqTk61uuoyHtj/EmN1tQywID5Ti5o6sCHqx4
        2HZSXqq89H8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C85BE9A9D9;
        Fri, 18 Dec 2020 20:41:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32AAD9A9D8;
        Fri, 18 Dec 2020 20:41:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 23/33] diff-merges: fix style of functions definitions
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-24-sorganov@gmail.com>
        <CABPp-BEf2nbahjzR6aLLNy0YsHYcHqCozCe6veoZOH3LAM892g@mail.gmail.com>
        <87blercju2.fsf@osv.gnss.ru>
Date:   Fri, 18 Dec 2020 17:41:07 -0800
In-Reply-To: <87blercju2.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        18 Dec 2020 16:41:41 +0300")
Message-ID: <xmqqft42shcc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 440B78C8-419B-11EB-8298-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> When Junio noticed and pointed to this deficiency, I asked him if I
> should fix all the series from the start, or it'd be OK to use fixup
> commit. As he didn't answer and nobody else commented either, I opted
> for the latter.

Sorry if it slipped through the cracks---I get too many discussion
threads to pay attention to.

Yes, we strongly prefer *not* to keep the honest history that
records all the mistakes we made along the way.  Rather, we take the
time a topic is still in flight and not yet cast in stone by merged
to 'next' as an opportunity to pretend that the topic came to
existence in the perfect shape, thanks to collective brain effort.

It is our basic courtesy to future developers who has to read our
code (i.e. "log -p") to understand what we've been thinking, when
they want to fix some stupid bugs we will inevitably leave in our
codebase.  It is distracting to read from the beginning of a topic,
notice something funny going on and keep moveing to later patches,
while harboring puzzlement in our minds, then later discover that
the funny thing we noticed earlier was a simple mistake that gets
fixed, not some clever trick the reader needs to think deeply to
understand.

Thanks.


