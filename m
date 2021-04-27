Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806EEC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 06:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4672761078
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 06:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhD0Gwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 02:52:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50990 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhD0Gww (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 02:52:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B083811EB25;
        Tue, 27 Apr 2021 02:52:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RlR5Ep9MUqzkPL94+av7CcCrnJ3XcyjdSOvB3M
        0RU1M=; b=AYm/5ipC6J4+ECOdP1aQTYns40lNxxuvfiJzpR+hAX2GpfjqZSzSHp
        D6JG87W2SYIWH2VSisfhdx3Ejxc9+x9t0lrOj2EZ2ue8fJ8WJYY3rBPRgNCKruP1
        GGl/H/JYPUk4AqyG0+CgE3eXmOywB0oKDp49STYnz47TYnTe/l4Kg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D83F11EB24;
        Tue, 27 Apr 2021 02:52:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CFBCB11EB23;
        Tue, 27 Apr 2021 02:52:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: reflog existence & reftable
References: <CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com>
        <87im4f3l62.fsf@evledraar.gmail.com> <xmqqim4fzier.fsf@gitster.g>
        <CAFQ2z_OGv3qNp9jaeuMij5gqv1MoOeb73zH9mOvikLs8dWvmmg@mail.gmail.com>
        <YILUs3T4oM78ZcW2@coredump.intra.peff.net>
        <CAFQ2z_OEB_jnL-G=GfypMiLLjE3gwp07ZMo3uF5aGkp3o6Yb9A@mail.gmail.com>
Date:   Tue, 27 Apr 2021 15:52:05 +0900
In-Reply-To: <CAFQ2z_OEB_jnL-G=GfypMiLLjE3gwp07ZMo3uF5aGkp3o6Yb9A@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 26 Apr 2021 19:33:14 +0200")
Message-ID: <xmqqy2d4dxt6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14BEF23A-A725-11EB-A743-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> Thanks. Does that count as consensus? Junio?

Sounds like it, even though I have been absent for most of the
period ;-)
