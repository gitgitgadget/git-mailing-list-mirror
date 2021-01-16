Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A09C433E6
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 06:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFBB23AC0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 06:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbhAPGjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 01:39:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50772 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAPGi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 01:38:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AA691086B6;
        Sat, 16 Jan 2021 01:38:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Apl2emLYu86mDzFL2JUaaZ9Ge0I=; b=KP3+Ur
        ZL0QHU2a+AUhK0dxUNsoVRCTdcHJhwLLQ3yAvZnQvH5Q9LQDMIphSPR3wb3NScLQ
        6p+Rnyq1chfSXDkHLYsNUsRFBT6SMt/fKmMfSt/Y8ZyWTnJt/huAsvX5akVj/R3K
        9gj7iMLXMo7Pj95VC12OdwQQAJUHayu1qD5HI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Mk0XNzHCqQJ8+y0Z4tvTvXH6dZTeZGeu
        pN9lTOdZ88yatvZ5rTcCJihPGy8UzohSlCYVfbnP5Ge5SiS69pOrgZCmYEmU6X+L
        o7ToePM+9tovOCpCszUZcFGQMexBxlXzvxTR0QWyFEiTLEQD7vyFJXVFHSW1yCNF
        6v925TK7ed0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 560AC1086B4;
        Sat, 16 Jan 2021 01:38:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8DBE61086B3;
        Sat, 16 Jan 2021 01:38:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/11] [RFH] Introduce support for GETTEXT_POISON=rot13
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
        <X/2JTsoUj3nAQcMi@coredump.intra.peff.net>
        <xmqqa6te3per.fsf@gitster.c.googlers.com>
Date:   Fri, 15 Jan 2021 22:38:12 -0800
In-Reply-To: <xmqqa6te3per.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 12 Jan 2021 11:50:52 -0800")
Message-ID: <xmqqv9bxpesr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68F4210E-57C5-11EB-B744-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
> ...
>> So I dunno. You did find two spots where translations could be used.
>> But if nobody actually saw them to care that they got translated, were
>> they important? I may be a bit biased as somebody who would not use the
>> translations in the first place, of course.
>
> I viewed the series with interest, mostly (i.e. 80%+) for its "fun
> value"; I tend to agree with you that I doubt its usefulness.

Actually, "I doubt its usefulness" is way too strong than what I
really wanted to say.  I was just skeptical, and I still somewhat
am.  I'd just need a bit more convincing ;-)

