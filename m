Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD5C433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 19:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B367360FD7
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 19:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347347AbhIBTUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:20:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57412 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhIBTUU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 15:20:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EFD04158609;
        Thu,  2 Sep 2021 15:19:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WBoTHE6mYHq3
        ZfUXN3jBqDq/YIFOl8wglcbadXx2o2M=; b=X7ebX/2FKEPQryjJWtA4i9UtH4pL
        +I9yPZkP2pYRz+71Ym6jJuU/hGeVs33vtxw3hoEICFB+k21ugtW54CsiK+H16LP0
        7MdWM93IjvlU4eT3P7AkoCl4TYXfXjsWij33616vpCZcAWy0GpuLK5Lppf0/9UjD
        BwZrKUwmZyNR4ns=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8CFD158608;
        Thu,  2 Sep 2021 15:19:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 972C3158605;
        Thu,  2 Sep 2021 15:19:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk,
        mackyle@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH] gettext: remove optional non-standard parens in N_()
 definition
References: <YS9RieTeJSFmd6M7@coredump.intra.peff.net>
        <patch-1.1-d24f1df5d49-20210901T112248Z-avarab@gmail.com>
Date:   Thu, 02 Sep 2021 12:19:16 -0700
In-Reply-To: <patch-1.1-d24f1df5d49-20210901T112248Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 1 Sep
 2021 13:25:52 +0200")
Message-ID: <xmqqilzikcp7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AB707EDA-0C22-11EC-8B3B-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove the USE_PARENS_AROUND_GETTEXT_N compile-time option which was
> meant to catch an inadvertent mistakes which is too obscure to
> maintain this facility.
> ...
> I don't care how this lands exactly, but thin (eye of the beholder and
> all that) that the commit message above is better. Carlo: Feel free to
> steal it partially or entirely, I also made this a "PATCH" instead of
> "RFC PATCH" in case Junio feels like queuing this, then you could
> build your DEVOPTS=3Dpedantic by default here on top.

FWIW, I think this goes in the right direction, and I'd rather not
to have to handle too many multi-patch topics in which one step
takes hostage the other steps.

Thanks, all.
