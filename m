Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923B5C43600
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70472613F7
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhELXZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:25:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51310 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349121AbhELWrX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:47:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73004CF168;
        Wed, 12 May 2021 18:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Mu/xXxHNHBVm
        Y8CW1sZJwHEyHgYrXwnlrLz8iliaLvI=; b=fRc4Al6QHP/hIOX+Mg0Y4H1Qejsz
        t0Hc1jKyUYTFP+tP+TmU6H9NGnbuIKg0BWTwGRc605tdlCxM/18QABZis7s6Ze6s
        k8uv5Ujxxgp5NblfdmY18kvaYgypRbd8sUzrlak7krXudB9yuXnCdkRg4vwt7D6q
        6QuW/HymuE7t0lU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BAC5CF167;
        Wed, 12 May 2021 18:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E72DBCF166;
        Wed, 12 May 2021 18:45:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Makefile: make PERL_DEFINES recursively expanded
References: <xmqqr1idn41e.fsf@gitster.g>
        <patch-1.1-92571a8cf7-20210512T094803Z-avarab@gmail.com>
        <YJwyJKxXJ5Oe+EYD@coredump.intra.peff.net>
Date:   Thu, 13 May 2021 07:45:55 +0900
In-Reply-To: <YJwyJKxXJ5Oe+EYD@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 12 May 2021 15:53:08 -0400")
Message-ID: <xmqqzgwzefks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D0253DE0-B373-11EB-A263-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, May 12, 2021 at 11:49:44AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> Since 07d90eadb50 (Makefile: add Perl runtime prefix support,
>> 2018-04-10) PERL_DEFINES has been a simply-expanded variable, let's
>> make it recursively expanded instead.
>>=20
>> This change doesn't matter for the correctness of the logic. Whether
>> we used simply-expanded or recursively expanded didn't change what we
>> wrote out in GIT-PERL-DEFINES, but being consistent with other rules
>> makes this easier to understand.
>
> Thanks for following up on this. I think it's worth doing.
>
> -Peff

Yup, thanks, both.
