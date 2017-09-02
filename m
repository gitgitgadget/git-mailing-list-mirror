Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6811B1F4DD
	for <e@80x24.org>; Sat,  2 Sep 2017 02:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbdIBCDX (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 22:03:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54247 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750930AbdIBCDW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 22:03:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2AF0A1722;
        Fri,  1 Sep 2017 22:03:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=2c2htyyaic5R16gupPo0TwsyNRE=; b=FyLAOjyAeQDAO1duPOdx
        EKAqz6w47ujTyWKfjtR5ce720e6QKJPoPRQ4QOb90AJkydMEtdzPi4mD6gZ66iLk
        lvlUJQzRwk7eBvjcSGQBzmsFqLybj8jI2eh0NuP38GKfD6JH4+HdTjPG5PXaPwM7
        pxjcEXYOw/IaJJd47Fzu/qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=G3+PngUyzw/RMYpPEkTnEw2RaqvJh2YY/PY46WIX8lbW7v
        Zo/YMaSacaQMDYBL9nGJDLCo7L69uF8OtJtAUuFTd/ff8wCc7vB8W6rWKPmcUfR1
        UDTRQl+zrLGTS9UEYJbAiK/nKHOh8Yr4lGHJ+TW2Q7dO404GmZUgqrWqYWDU8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9208A1721;
        Fri,  1 Sep 2017 22:03:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37D3CA1720;
        Fri,  1 Sep 2017 22:03:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/for-each-ref: explicitly specify option names
References: <20170901144931.26114-1-me@ikke.info>
Date:   Sat, 02 Sep 2017 11:03:19 +0900
Message-ID: <xmqqk21hj1qw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E53A4C52-8F82-11E7-AE60-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> For count, sort and format, only the argument names were listed under
> OPTIONS, not the option names.
>
> Add the option names to make it clear the options exist
>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---
>  Documentation/git-for-each-ref.txt | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Sounds sensible.  First I thought this was done deliberately because
these placeholder can apply to more than one option and we wanted to
explain each thing only once (e.g. "<object>" appears in 5 places,
and having to repeat something like "you can spell <object> by the
unique prefix of the object name, or the name of a ref that points
at it, or ..." in each option would be awkward), but that is not the
case here.

While we are at it, I just noticed that the SYNOPSIS section makes
it look as if <pattern>... must come before points-at, merged, and
their friends, but I do not think that should be the case.  I also
notice that unlike --sort/--format/... the last four/five options
are spelled with "--option <value>" syntax; we should consistently
use "--option=<value>" instead there.

But these two are separate issues that can be fixed in a patch
separate from this one I am responding to.

p.s.  I am still mostly offline and won't be doing any reviews or
queuing that requires me to look at anything beyond the patch
context.  Please do not get disappointed if you do not see your
patch in my tree until later next week.
