Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D4CC433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9FF61360
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhKHULO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:11:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57773 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbhKHULO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:11:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C50E168F3C;
        Mon,  8 Nov 2021 15:08:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NHF1vWBRsgXq
        POoh8rqlbPUoKkLE9YY4ACmKosA0B8c=; b=iGtwNYDRn+BY2F2Zj8RC0P4obH6G
        Ad/ruVoLAg8RaHWmflSpOtGaH/cIxjW1Nq0gV8/O2CggkKzrzCpvaePzq8x62pid
        qmqdIoVyFBEevV/bbOuDjMFL++QXI5/wtGDpgn73u8WpXgrNh+jZBI5AOujlvDTd
        Q30GonfzibLzuOc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84BB7168F3B;
        Mon,  8 Nov 2021 15:08:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8F97168F3A;
        Mon,  8 Nov 2021 15:08:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] ci: disallow directional formatting
References: <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com>
        <pull.1071.v3.git.1636031609982.gitgitgadget@gmail.com>
        <211104.86ee7whvoz.gmgdl@evledraar.gmail.com>
        <xmqqpmrf3kjz.fsf@gitster.g>
        <211108.86cznafpke.gmgdl@evledraar.gmail.com>
Date:   Mon, 08 Nov 2021 12:08:25 -0800
In-Reply-To: <211108.86cznafpke.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 08 Nov 2021 19:49:28 +0100")
Message-ID: <xmqqo86utnpi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A257FE2C-40CF-11EC-8ED4-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> So you are comparing
>>
>>  * requiring bash and C.UTF-8 locale to be available
>>
>> vs
>>
>>  * requiring git built with PCRE
>>
>> assuming that "Dscho says doesn't work with PCRE and you say it
>> works with PCRE" is resolved?  They seem roughly the same
>> difficulty to me.
>
> We can hard depend on a git built with PCRE, since the point of this
> thing is to run in GitHub CI, Ubuntu builds git with PCRE, and that's
> unlikely to ever change.

Yes, so is the availability of bash and C.UTF-8 for the same reason:
we are talking about controlled environment.  That is what I meant
by "roughly the same difficulty to me".

FWIW, I am OK with either approach, as I find the patch in question
is just as readable as any rewrite that would use "grep -P", so...
