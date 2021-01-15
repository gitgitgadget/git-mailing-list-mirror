Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DBCC433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 05:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541BB22BEA
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 05:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbhAOFye (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 00:54:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64429 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbhAOFyS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 00:54:18 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 732881133BF;
        Fri, 15 Jan 2021 00:53:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MQ02cZqzRAhQoisfRF6JqRvJcW4=; b=R5/qSc
        rsLF46HpJL9p7zSnggkX7URx0upavZIXalUJ4lAzGb4dv7M6HQneywFWF3//ANej
        KfkY89elTWtZqpSZ7WY/3LpwxyaVd4kQYT2Tshs3FWDcOm/1jglFc863qbfR7gH1
        +w7G8wiXW4n2NOc9i4U09SztCQVRWBSEctDuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rhTDtgbUrRsTa+92QUf91VP2I26pefHi
        P9cRgqvoWboNq6zgA+pSRRv7GWxXEp3u+mDdK7DeoeOIcBedIvIXYmVLHqqWfO+1
        2n6emPgrFs9uWNboIdzqtyH0kVM9kIIJ2YE9g8+DBkVEWdGWaNY6wzRJA1y/kKPO
        R766TuCC0lU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B9C81133BE;
        Fri, 15 Jan 2021 00:53:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ACBA41133BD;
        Fri, 15 Jan 2021 00:53:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 01/22] mailmap doc: create a new "gitmailmap(5)" man page
References: <20210105130359.21139-1-avarab@gmail.com>
        <20210112201806.13284-2-avarab@gmail.com>
        <a71860ee-6810-8766-b9c7-4c03ea7e6e01@gmail.com>
        <xmqqk0sfxpd4.fsf@gitster.c.googlers.com>
        <6612514d-051a-1e58-7ea1-c00428882f2d@gmail.com>
        <xmqqft32vqe4.fsf@gitster.c.googlers.com>
        <4c9123c0-ee35-11aa-04dc-8ffe79781507@gmail.com>
Date:   Thu, 14 Jan 2021 21:53:31 -0800
In-Reply-To: <4c9123c0-ee35-11aa-04dc-8ffe79781507@gmail.com> (Philippe
        Blain's message of "Thu, 14 Jan 2021 22:36:46 -0500")
Message-ID: <xmqq5z3yvj8k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0005C320-56F6-11EB-9BFF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> I'm still not sure I have should have sent it as a reply to the commit it's
> fixing (as I did), or to the last commit of the series, or to the cover letter,
> or as a new thread to the list... what's the etiquette around this ?

I can deal with any of the above, but with the goal of keeping the
list archive most useful for later readers, I would imagine that it
would be best if such a follow-up fix were made against the specific
step (if there is such a single step) that introduced an issue (in
other words, where you would have squashed your fix into, if it were
under your control to redo the series).  If there is no such single
step and the fix applies to the whole series in general, a response
to its cover letter would also do, I would think.

Thanks.
