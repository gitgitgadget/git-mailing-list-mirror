Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB590208C4
	for <e@80x24.org>; Fri, 11 Aug 2017 18:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbdHKSVH (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 14:21:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50016 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752850AbdHKSVG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 14:21:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 303EEA117C;
        Fri, 11 Aug 2017 14:20:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5HeyO/3Xa1zg
        fB7qOU1tPfLRLvU=; b=b87vLw/JdPKEWhgaD2SGeQAn3PRLHDc7sy80nwD1ux2D
        2uB6tdwbB+IUrDDnECSBHgaNIk77PfjfB/j/xxg78lSmLbEjDmda1P/dj+1pghRp
        5VJZ4oFOTpyYxbQXkmTWWHzfhLdg9r6zfIO4ibVxTkc2hVyH2K80/XgfAcAGZfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=trwUn8
        Yb9Y9kxqsa/GOvvzi3RNMMX4tQDHAAW1O2ovY8h282trEExJtguYZR/3ER4ZTxLz
        9s20Gz5veGyGo0m1HztOTQHO4oKOI94JEAfq17tSlZHaqGWwA1t4BoufHnTSPBkO
        aBOA60pMkmzbRKwQ876cb5bN0oRjVDDJumOyU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2742EA117B;
        Fri, 11 Aug 2017 14:20:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 835C4A117A;
        Fri, 11 Aug 2017 14:20:55 -0400 (EDT)
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
        <xmqqwp6c63bm.fsf@gitster.mtv.corp.google.com>
        <faa74d6d-90b5-2de1-6478-854d3d52d30e@web.de>
Date:   Fri, 11 Aug 2017 11:20:54 -0700
In-Reply-To: <faa74d6d-90b5-2de1-6478-854d3d52d30e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 10 Aug 2017 08:08:20 +0200")
Message-ID: <xmqq7eya0xvd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0D5FAA8-7EC1-11E7-B663-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 09.08.2017 um 19:47 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>=20
>>> There could be any characters except NUL and LF between the 4096 zero=
s
>>> and "0$" for the latter to match wrongly, no?  So there are 4095
>>> opportunities for the misleading pattern in a page, with probabilitie=
s
>>> like this:
>>>
>>>    0$                          1/256 * 2/256
>>>    .0$         254/256       * 1/256 * 2/256
>>>    ..0$       (254/256)^2    * 1/256 * 2/256
>>>    .{3}0$     (254/256)^3    * 1/256 * 2/256
>>>
>>>    .{4094}0$  (254/256)^4094 * 1/256 * 2/256
>>>
>>> That sums up to ca. 1/256 (did that numerically).  Does that make
>>> sense?
>>=20
>> Yes, thanks.  I think the number would be different for "^0*$" (the
>> above is for "0$") and moves it down to ~1/30000, but as I said,
>> allowing additional false success rate is unnecessary (even if it is
>> miniscule enough to be acceptable), so let's take the 64*64 patch.
>
> Ah, right, now I get your calculation in the email I replied to above.
> "^0*$" has a probability of 2/255 to produce false positives.

Yes, and that is larger than 2/256 we would have to accept with the
original "^0{4096}$" or the updated "^(0{64}){64}$" by ~1/30000,
which is unnecessary additional false rate of success.

Thanks.




