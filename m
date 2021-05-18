Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A98C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 00:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350FE613AF
	for <git@archiver.kernel.org>; Tue, 18 May 2021 00:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbhERAwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 20:52:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65484 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbhERAwb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 20:52:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF16213FF8A;
        Mon, 17 May 2021 20:51:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qXNezqlUw+c7apQ5GQ7+T6AYZgM/Y6cln1mMoH
        nT5j0=; b=DwqR/Q1UYg47nvvAJeMiM4sswWIjDkVQKMgkVFK4/iAq7a4Fa9Hwk8
        zeC8v503zOfTkt9fkyfaEcCs6vVwn73lfBFra4T7/GqXiuexrxIbu+eI5uOp+R1O
        ZvF2HOZuL5oSqxRCfwHU74GxkY14FAOGDcR+zyoUT4WPX1b7toIMA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B76FA13FF89;
        Mon, 17 May 2021 20:51:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A71E13FF88;
        Mon, 17 May 2021 20:51:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
        <pclouds@gmail.com>, Richard Hansen <rhansen@rhansen.org>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
        <xmqqbl993irp.fsf@gitster.g> <60a245a927c62_126333208ea@natae.notmuch>
        <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
        <xmqqpmxp6u13.fsf@gitster.g> <60a2daa57d8a6_13c370208f3@natae.notmuch>
Date:   Tue, 18 May 2021 09:51:10 +0900
In-Reply-To: <60a2daa57d8a6_13c370208f3@natae.notmuch> (Felipe Contreras's
        message of "Mon, 17 May 2021 16:05:41 -0500")
Message-ID: <xmqq1ra46f0h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2426DCF2-B773-11EB-B487-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > I agree that if the purpose is to be illustrative, using shortcuts like
>> > "an empty endpoint means HEAD" is not helpful. And likewise for "@"; if
>> > you need to have "revision range" defined, there is a good chance that
>> > you don't know about shortcuts like "@" either.
>> >
>> > So I would prefer something more explicit (whether it's "mybranch" or
>> > "end" or "HEAD" or whatever).
>> 
>> Perhaps.  Being illustrative for common use case is also important,
>> so I do not mind teaching "missing endpoint at either side defaults
>> to HEAD" early.
>
> A glossary is not a place to teach (anything other than the definition).
> It's supposed to contain glosses (brief explanations).

Fair enough.  Then let's limit ourselves to the definition, but give
a correct one.  It is not "syntax" that the phrase "revision range"
refers to; it is what is specified by that syntax.

[[def_revision_range]]revision range::
        A set of connected commits to work on, usually specified by
        giving two end points, like `origin..mytopic`.  See the
        'Specifying Ranges' and 'Revision Range Summary' sections of
        linkgit:gitrevisions[7] for details.
