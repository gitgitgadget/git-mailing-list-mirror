Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBD8C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 19:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E671B601FE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 19:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhHQTgn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:36:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55658 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhHQTgn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 15:36:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CE74DF98C;
        Tue, 17 Aug 2021 15:36:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LqRpH1oUKIFx
        iZA9vtun1yrlZ7BkzPw1epvWx/DgodQ=; b=VP7zMe5mvx+hHH8Ys6SPSpSM1Dil
        r2OlR1vB4OilNI6K5rP8OY6dZYJadEdP70mzgQiXgK9lwcVQag6Civ8xiWZG+NX5
        EQUK4lw4STtCbw2nZGfvyW+Goev/5ZrN5Ayd5XhsQKdu+yrhakK2tGbQj70Ezfn9
        O9LKP/OfxZkReZU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64278DF98B;
        Tue, 17 Aug 2021 15:36:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E3B52DF98A;
        Tue, 17 Aug 2021 15:36:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: add job for gcc-4.8 to GitHub Actions
References: <20210816045750.36499-1-carenas@gmail.com>
        <444e7410-c9c9-1b90-da5f-d6862a35c1fc@gmail.com>
        <YRqP7J7Gu0VmB6q2@coredump.intra.peff.net>
        <20210817111512.GA2257957@szeder.dev>
Date:   Tue, 17 Aug 2021 12:36:08 -0700
In-Reply-To: <20210817111512.GA2257957@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Tue, 17 Aug 2021 13:15:12 +0200")
Message-ID: <xmqqbl5v50ev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5F061218-FF92-11EB-8BDC-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> IMHO it may be more trouble than it's worth. If we can't find a compil=
er
>> that complains on this construct, then maybe it is not a construct wor=
th
>> worrying too much about.

Absolutely.  Of course, there are vendor compilers that are not GNU
or clang that may throw us surprises ;-)

> I for one like for loop initial declarations, because they allow us to
> limit the scope of the loop variable to the loop, and would love to
> see it used in more places (well, wherever possible, actually, but
> that'd be a lot of churn).  So I would prefer to just drop this job
> sooner rather than later, update CodingGuidelines, and, if deemed
> necessary, launch a weather balloon.

I'd agree in general, but it must be done in a bit different order,
i.e. weather balloon first.
