Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64284C4708A
	for <git@archiver.kernel.org>; Fri, 28 May 2021 00:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433FA61184
	for <git@archiver.kernel.org>; Fri, 28 May 2021 00:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbhE1ADl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 20:03:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64254 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbhE1ADi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 20:03:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A618AC5293;
        Thu, 27 May 2021 20:02:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MQ9yj0N3xOH1LmKTLqVJsATqxUktxVgqshIA79
        +dGNA=; b=tQoJVgE6snakVlqwcfqTxsj0v5PPmXtWMRQ/K1CL05Zl2mEd+dM3t8
        rc2n8NoqBgb8I2D4gHO1RerT12h3AeTHdsV3M1nOKP9HV27WaSr23cPCZWSUkWKQ
        umSD4KzDNm/84aOkdh7ikY1xaWy9cW9YXDha6ob7+48f3DQ6kbJOY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 875B1C5292;
        Thu, 27 May 2021 20:02:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAD04C5290;
        Thu, 27 May 2021 20:02:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/5] doc: asciidoc cleanups
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
        <xmqq7djoj9z9.fsf@gitster.g>
        <YK+texFSW6UurDui@coredump.intra.peff.net>
Date:   Fri, 28 May 2021 09:02:02 +0900
In-Reply-To: <YK+texFSW6UurDui@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 27 May 2021 10:32:27 -0400")
Message-ID: <xmqqmtsf9151.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE748A14-BF47-11EB-BE70-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, May 25, 2021 at 02:51:54AM +0900, Junio C Hamano wrote:
>
>> >  Documentation/Makefile | 77 ++++++++++++++++--------------------------
>> >  1 file changed, 29 insertions(+), 48 deletions(-)
>> 
>> Is this satisfactory to everybody (I haven't taken a look beyond
>> comparing the end results)?
>
> Yes, all five patches look good to me.

The issue that it interacts in a funny way with what brian already
has in 'seen' aside, the patches look good to me, too, so let's
start merging it down.

> The "comments-by" sub-thread looked unproductive to me, so I mostly
> skipped it. ;) But as the person whose name was in the trailer, I will
> say that I do not care either way if it is included. It did not seem to
> add anything to me. Some trailers are good for pointing later readers to
> folks who may be able to help understand or debug an old commit. Some
> are good for just giving credit to people who helped. "Comments-by"
> didn't really seem to do either to me (and I don't feel like I
> contributed much worthy of credit anyway).

Exactly the same feeling.  It didn't add any value that was why I
saw no point in using something almost nobody uses (instead of the
more commonly used Helped-by, for example).

Thanks.
