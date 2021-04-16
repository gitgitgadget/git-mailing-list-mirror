Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53451C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19811613B0
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhDPTEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 15:04:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59346 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbhDPTEV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 15:04:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43DAFC844B;
        Fri, 16 Apr 2021 15:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nVGcZXBRYmY6
        dKZA1lv2IqaR7Ng=; b=aceM1Zu5KZkAzv6IptiR+m8ssFtiC8fCQ8KDUWZsRQXQ
        /x1A3jLbe+9iYcdvByE9YXu6tI4JGjR1xeq8N0dCSZ+LLLcLMQo/IZb1j1hJLwFU
        PaLtQdUuRrgqCiJXHNyOTH4p9u+j0m4xGd6a+pVP7dW9f9HP4nBpLVHhNY4lnfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ot8zJ3
        DHIW+gnFgoxO0clEbt0vyNCq1uBr0c4BqYyete/Sr7FQSVnMr/M8mYW99M78wQnS
        FjOX2/G5ooEDzE4TcEnhxAamxPs1pnhWLBsAUCMvzhSTnqCIQ3zuabKRH82zBQmw
        FTzk8+bDZQ4eyuoqj7cmE3ZCA3OGtB0yDoNCA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CFCEC844A;
        Fri, 16 Apr 2021 15:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B33AC8449;
        Fri, 16 Apr 2021 15:03:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] Makefile: add missing dependencies of 'config-list.h'
References: <20200416211807.60811-2-emilyshaffer@google.com>
        <20210408212915.3060286-1-szeder.dev@gmail.com>
        <87pmz4ig4o.fsf@evledraar.gmail.com>
        <YG+UeQRwdBsVeRNV@coredump.intra.peff.net>
        <20210409212044.GD2947267@szeder.dev>
Date:   Fri, 16 Apr 2021 12:03:54 -0700
In-Reply-To: <20210409212044.GD2947267@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Fri, 9 Apr 2021 23:20:44 +0200")
Message-ID: <xmqqblaem4px.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7DCD6762-9EE6-11EB-84A3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Thu, Apr 08, 2021 at 07:40:41PM -0400, Jeff King wrote:
>> On Fri, Apr 09, 2021 at 12:08:23AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>>=20
>> > > -config-list.h:
>> > > +config-list.h: Documentation/*config.txt Documentation/config/*.t=
xt
>> > >  	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
>> > >  		>$@+ && mv $@+ $@
>> > > =20
>> > >  command-list.h: generate-cmdlist.sh command-list.txt
>> > > =20
>> > > -command-list.h: $(wildcard Documentation/git*.txt) Documentation/=
*config.txt Documentation/config/*.txt
>> > > +command-list.h: $(wildcard Documentation/git*.txt)
>> > >  	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
>> > >  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
>> > >  		command-list.txt >$@+ && mv $@+ $@
>> >=20
>> > This change makes sense.
>>=20
>> I agree it looks like it's moving in the right direction, but I am
>> slightly puzzled by the existing code. Why do we need to use $(wildcar=
d)
>> for git*.txt, but not for the others?
>
> We don't need $(wildcard) for git*.txt either, because 'make' expands
> wildcards in prerequisites, see e.g.:
>
>   https://www.gnu.org/software/make/manual/html_node/Wildcard-Examples.=
html
>
>
> On a related note: all config variables are now listed in
> Documentation/config/*.txt; Documentation/*config.txt doesn't contain
> any, so that could be removed.

Is it OK for me to keep expecting an update to the patch happen soon?

Thanks.
