Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19E2C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C0C61076
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhHKRVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 13:21:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52827 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhHKRVG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 13:21:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE1D014235B;
        Wed, 11 Aug 2021 13:20:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EyRAC6+NNpKw
        smsRU4x4CoFt9tP7NGOzOWVe3CPTNiA=; b=jaw78KfYvJZ0Cv3uYm177m/t6NA5
        pRYovf1V0aRCRYYPPwgR6CP52llx46SM/wS1EGopiu/YWwjuTugH8A5q80Qg4AuL
        PCzYatNY7x52kRR+vR0IcyQcM0ABkwpHUA6lT2gaueaE+dIK/6CNhvTU5mJO/pak
        MWBAWYTNIgKdlts=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B682214235A;
        Wed, 11 Aug 2021 13:20:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 111B4142359;
        Wed, 11 Aug 2021 13:20:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org, e@80x24.org,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH/RFC 0/3] pedantic errors in next
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
        <20210809013833.58110-1-carenas@gmail.com>
        <xmqqtujyftzx.fsf@gitster.g> <YRIZsOaguDW0HaeI@carlos-mbp.lan>
        <0b973579-748e-ce2f-20aa-a967765cce83@web.de>
        <CAPUEspiWdGRQoBnpn_uwjkqV7ffMm+MkzbNVU1rZ6yCwkpmNaA@mail.gmail.com>
        <1a18a701-7d14-d6c5-6929-30636e688006@web.de>
Date:   Wed, 11 Aug 2021 10:20:37 -0700
In-Reply-To: <1a18a701-7d14-d6c5-6929-30636e688006@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 11 Aug 2021 16:57:52 +0200")
Message-ID: <xmqq5ywbaoey.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 72C50F80-FAC8-11EB-AD84-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> would at least the two included in the chunks above be safe enough for
>> RC2 as I hope?, is the one with the additional int too hacky to be
>> considered for release?;
>
> I think your -pedantic fixes 1 and 2 should go into the next possible
> release candidate because they fix regressions.

I agree.  They are at the bottom of 'seen' just above 'master' in
last night's pushout for this exact reason.

> Same for my signed-left-shift fix in
> http://public-inbox.org/git/bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de=
/
> (or some improved version if it's lacking in some way) and the yet to b=
e
> published fix for the alignment issue.  I assume Andrzej as the reporte=
r
> or Eric as the original author would like to have a shot at the latter.

Thanks.  It was missed as it was buried in the discussion exchange.
Will queue together with cb/many-alternate-optim-fixup topic.

