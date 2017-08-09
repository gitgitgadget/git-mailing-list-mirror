Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7C01F991
	for <e@80x24.org>; Wed,  9 Aug 2017 17:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbdHIRrh (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 13:47:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60494 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751443AbdHIRrg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 13:47:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BCC686F3C;
        Wed,  9 Aug 2017 13:47:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eyZvz2a59PuR
        xvWcBf4QTixQ724=; b=qipMBXUMPhF4kEDHV84wDfkIyhPaXmMZQ5D89F5Y5kxv
        vPwKsuYLqnpJkXu1AcauziX7ntU8pJ3o8dQLUlLk71YECm8jr/xQG8Ma17BWO5RO
        dNxh8uSB6dwvTFs2AWl+bEV7xyLxcZDpEwQigW8vzy5u/StyzBhw4qwqPgqzQIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iGXCk3
        jyyvSKx5iAfanIwIkP/jkBCwTVui/7mjBtJfpTMTuqSBCxblSFzwpdfE0ZtYVT7X
        lkPe+tcpA1fF8ZAGq36OHqrU9HAipivXtLgsVuOLiYuZFo4Idhaf4YaalanCDURw
        JA5Y5rROaBni6jHHe+REvpU/fq9PENxYuwoe0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13BCD86F3B;
        Wed,  9 Aug 2017 13:47:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6763E86F38;
        Wed,  9 Aug 2017 13:47:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        David Coppa <dcoppa@openbsd.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] t4062: stop using repetition in regex
References: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
        <alpine.DEB.2.21.1.1708081648130.11175@virtualbox>
        <1e7ed028-77fe-195a-4acf-6c80d1704463@web.de>
        <xmqqinhxaf0i.fsf@gitster.mtv.corp.google.com>
        <xmqq7eydae7r.fsf@gitster.mtv.corp.google.com>
        <cd60d779-fe38-4f0e-4d36-2c40b2afec7d@web.de>
        <xmqqtw1h8g1u.fsf@gitster.mtv.corp.google.com>
        <50c2eaab-d1d8-3376-6e7a-1c898d978d12@web.de>
        <e3e65635-2dc8-de58-5662-3eab619aedb3@web.de>
        <xmqqh8xg7mhy.fsf@gitster.mtv.corp.google.com>
        <13394372-1494-6650-05ec-0122e02664d3@web.de>
Date:   Wed, 09 Aug 2017 10:47:25 -0700
In-Reply-To: <13394372-1494-6650-05ec-0122e02664d3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 9 Aug 2017 19:20:43 +0200")
Message-ID: <xmqqwp6c63bm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CE7B78B6-7D2A-11E7-8AC1-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> There could be any characters except NUL and LF between the 4096 zeros
> and "0$" for the latter to match wrongly, no?  So there are 4095
> opportunities for the misleading pattern in a page, with probabilities
> like this:
>
>   0$                          1/256 * 2/256
>   .0$         254/256       * 1/256 * 2/256
>   ..0$       (254/256)^2    * 1/256 * 2/256
>   .{3}0$     (254/256)^3    * 1/256 * 2/256
>
>   .{4094}0$  (254/256)^4094 * 1/256 * 2/256
>
> That sums up to ca. 1/256 (did that numerically).  Does that make
> sense?

Yes, thanks.  I think the number would be different for "^0*$" (the
above is for "0$") and moves it down to ~1/30000, but as I said,
allowing additional false success rate is unnecessary (even if it is
miniscule enough to be acceptable), so let's take the 64*64 patch.

>> So we are saying that we accept ~1/100 false success rate, but
>> additional ~1/30000 is unacceptable.
>>=20
>> I do not know if I buy that argument, but I do think that additional
>> false success rate, even if it is miniscule, is unnecessary.  So as
>> long as everybody's regexp library is happy with "^0{64}{64}$",
>> let's use that.
>
> The parentheses are necessary ("^(0{64}){64}$"), at least on OpenBSD.

Sorry, what I wrote was merely a typo; the one from you I applied
did have the parens so we are good.

Thanks.
