Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB416C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA265611EF
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhHYAKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:10:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62110 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbhHYAKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 20:10:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCA6DD492D;
        Tue, 24 Aug 2021 20:09:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sYpJV29kKdkM
        5EfvKsA+6LhO8fi0fsGEsliPGWBanaM=; b=m5e1OgrRTU4bIh7YDVW50eH4MyOE
        0jFwg8UwtZ4VIfhWlkrRB7akQnv0QvsJchfo76d1b7CN0fvb75yxH1tDM8cXVlBD
        XKVyv1EwDkw3mxq21k7HBUFCpLkPFgzvTfZJRNkRQsyDgvtLnW4o7Uwx7PMo8UMy
        IlnaPR/FkG+t9nM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3852D492C;
        Tue, 24 Aug 2021 20:09:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46D7ED492B;
        Tue, 24 Aug 2021 20:09:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "Ben Boeckel" <mathstuf@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #08; Mon, 23)
References: <xmqqo89nq1sa.fsf@gitster.g> <878s0rf8i0.fsf@evledraar.gmail.com>
Date:   Tue, 24 Aug 2021 17:09:21 -0700
In-Reply-To: <878s0rf8i0.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 24 Aug 2021 12:08:02 +0200")
Message-ID: <xmqqbl5ml70u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B3B78714-0538-11EC-B034-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Our E-Mails crossed, but on the "update on my topics" front everything =
I
> noted in the reply to the last What's Cooking is stil current, except a=
s
> noted below:
> https://lore.kernel.org/git/87v93wflm0.fsf@evledraar.gmail.com/

I probably have to push any message that forces me to go outside MUA
and visit an external URL down the workqueue, as there seem to be
quite a lot of backlog on the list.  Please be patient for a while;
also the backlog will likely not be processed in the FIFO order.
I prefer to queue and merge down smaller topics quickly before
getting to any multi-patch series.

> Per discussion at
> https://lore.kernel.org/git/877dgch4rn.fsf@evledraar.gmail.com/ and
> https://lore.kernel.org/git/87y28sfokk.fsf@evledraar.gmail.com/ I think

Only one person talking is usually not called a discussion but a
monologue ;-)

The topics that are actively rerolled are all gathered near the tip
of 'seen' right now so that I can easily ignore them and make _some_
progress in integrating other topics and pushing them down without
getting stuck with endless conflict resolutions.  It would go
smoothly if those who are involved in the topics can work together
to come up with an already-agreed-upon version of the patches before
I get to the chance to look at them again.

Thanks.
