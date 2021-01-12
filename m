Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C707C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC24206C3
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436645AbhALTvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 14:51:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61926 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436627AbhALTvi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 14:51:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79DD5FFAA9;
        Tue, 12 Jan 2021 14:50:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t9cc4KVyoZrL6TYrj3jTbDcXKc0=; b=Qh1MFo
        mPeiKgBdcD2JdIfg/aJ/AS3TiM3GGi2BS14vISdsGvF5gXzRh+0Ow1ZAFEH0Hgh/
        djMsz+VB+eDP0PWVh7eG4A59iEvYrXNZAEKi+R/xdVHr00VEYjjgBs+gPVVdNSCz
        R+m8vVZsAnDDUZY/L1mlQZU9sL938EOaEclXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ha187k02GxkBGn77QCqPbj5jirFy3ezh
        WgwjG6AhPV+zG2eSpvnJgnK7itkb/X5HshuE2Xy5zey5MSDqp46Po5blvqeX9PA4
        KVQvGxYUGC/gpI7001X60KM1kZFlWIv7R3wLhmQNFsO8SkzY43ZthdN7K5VcTm5H
        Xio7qS2W71E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72556FFAA8;
        Tue, 12 Jan 2021 14:50:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BAD13FFAA5;
        Tue, 12 Jan 2021 14:50:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/11] [RFH] Introduce support for GETTEXT_POISON=rot13
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
        <X/2JTsoUj3nAQcMi@coredump.intra.peff.net>
Date:   Tue, 12 Jan 2021 11:50:52 -0800
In-Reply-To: <X/2JTsoUj3nAQcMi@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 12 Jan 2021 06:34:38 -0500")
Message-ID: <xmqqa6te3per.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AC93DD2-550F-11EB-8816-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Likewise, I'm not sure that one can reliably rot13 an output for
> test_i18ncmp. It could contain mixed translated and untranslated bits
> from different messages.

As long as <rot13>...</rot13> marking can be trusted (and it cannot
be, but if we declare it is OK to punt, then by definition we can),
I think the messages can be compared.

> So I dunno. You did find two spots where translations could be used.
> But if nobody actually saw them to care that they got translated, were
> they important? I may be a bit biased as somebody who would not use the
> translations in the first place, of course.

I viewed the series with interest, mostly (i.e. 80%+) for its "fun
value"; I tend to agree with you that I doubt its usefulness.
