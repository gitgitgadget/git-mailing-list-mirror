Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA8AC433DB
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 18:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7317522582
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 18:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgL0Sbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 13:31:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50268 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgL0Sbb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 13:31:31 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5584A109D0D;
        Sun, 27 Dec 2020 13:30:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pmd+xyXdpZ1zsFJDPiVy272qj7U=; b=Nrx39B
        +Rs09/UXM6bswPQDs1nxSNdydjjLkmU23KusdCj3/SwtDA6wSC4dPsRbMzLPwb4Z
        Bw/4BGZ8408QEAmQg0JPV1nduDMKHqDIi+dATjvk9+iP9KW60kXwj+BBS63j8oeH
        57OFZRRmva0Mnvd555M26Q+tFr9jV09W6rCz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qV96TYZNymDtCbNtJ3OR5iF56GjvbLT6
        ScX2MgflC7fKGAkWW4Qp/YP2tOSTCvMcKTqsEFNzkbyoCHU3YPx1WGRzGe8o+vnS
        x8lUdPbE4Kw8PbG+r3bvYT3iZArejuW4x31BbZ5nPXjWN4mXfcmqnQfcsfUyrZNC
        Fc+ikwTS3cI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C25A109D0C;
        Sun, 27 Dec 2020 13:30:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 94CC9109D0B;
        Sun, 27 Dec 2020 13:30:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Subject: Re: Nobody is THE one making contribution
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
        <5fdc7a7d3a933_f4673208d0@natae.notmuch>
        <20201219001358.GA153461@ellen>
        <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
        <20201221042501.GA146725@ellen>
        <5fe033e0ec278_96932089d@natae.notmuch>
        <20201221073633.GA157132@ellen>
        <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
        <5fe134eeaec71_11498208f9@natae.notmuch>
        <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
        <5fe2c64bd3790_17f6720897@natae.notmuch>
        <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
        <5fe2d89c212e8_18dc12083e@natae.notmuch>
        <xmqqzh248sy0.fsf@gitster.c.googlers.com>
        <5fe36790793ae_2354120839@natae.notmuch>
        <87r1ngufmf.fsf@evledraar.gmail.com>
        <5fe424d0528a2_7855a208d3@natae.notmuch>
        <87o8ijv124.fsf@evledraar.gmail.com>
        <5fe4b33dbc028_19c920834@natae.notmuch>
        <xmqqtusa24oa.fsf@gitster.c.googlers.com>
        <5fe8c464bc190_e22d2086a@natae.notmuch>
Date:   Sun, 27 Dec 2020 10:30:46 -0800
In-Reply-To: <5fe8c464bc190_e22d2086a@natae.notmuch> (Felipe Contreras's
        message of "Sun, 27 Dec 2020 11:29:08 -0600")
Message-ID: <xmqq5z4nqey1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4149F24-4871-11EB-AA66-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> But if you are arguing that when you write "Signed-off-by:" your
>> sign-off can mean something other than what DCO says it means,
>
> The DCO has clause (d), which clearly states the developer must agree
> that a record of his/her contribution is maintained indefinitely (and
> that includes his/her sign off).

Yes.  Are you saying that you are OK with (a)-(c) but not (d)?

> So there's at least two meanings in the DCO itself.

I am not sure what you mean.  DCO itself has a to d (four) clauses,
so that is not where your two comes from (unless you are hedging by
saying "at least two").  What are you counting to reach two?

Still puzzled.
