Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050C2C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F5622519
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 22:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgLXW6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 17:58:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57524 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgLXW6K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 17:58:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AFDCA2507;
        Thu, 24 Dec 2020 17:57:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4gLKfHO3+F3aUO5YwZ5+Ii9uN2g=; b=jTY/9+
        m9iVjJ+gths3eD5oeuz7eVJFseValtxM2PfCt+RRoBA+ScdXhxwjtuEsD6TJ6jkM
        /szGm4U9eoape88gLAvyKs7Pk20d6Lzd1xR2FJPXqZdVMRuVp4wx/iP9Egjekbkd
        G3IARxH4WODXpqrIkXUtJe7kTir1nIRER46Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m2tr0XS+1eSWw1FOmzaurE4/0tfgOR3k
        XWpHZbsCNiiRG8/bKGOr3rhLJfizCIV5Tl2g+M2SO2jsX1VPSAAzTvJUn7IHRCZy
        hc9MYf5xXnDxol8ijsLUlSG7autagG75as/qopbD5KMemjAOLrLkhUpJfjKetSfa
        rMWo5nJ6vus=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11B79A2506;
        Thu, 24 Dec 2020 17:57:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8FB13A2505;
        Thu, 24 Dec 2020 17:57:26 -0500 (EST)
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
        <20201218054947.GA123376@ellen>
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
Date:   Thu, 24 Dec 2020 14:57:25 -0800
In-Reply-To: <5fe4b33dbc028_19c920834@natae.notmuch> (Felipe Contreras's
        message of "Thu, 24 Dec 2020 09:26:53 -0600")
Message-ID: <xmqqtusa24oa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64616624-463B-11EB-8BC4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Not "I signed off on my subjective approval of this patch & what it's
>> for etc.", which seems to be closer to your interpretation.
>
> Why does it have to be only one meaning?
>
> Junio doesn't sign off on a patch that he doesn't think is good.
> Same happens with all the lieutenants of Linux.

I know some people try to indicate that a patch is not ready for
inclusion as-is by omitting sign-off.  That way, it would not be
enough for the maintainer to pick it up and add his or her own
sign-off---the maintainer has to go back to the author and ask it to
be signed off (which happens).

But I try not to use the lack of sign-off on my patches to mean
anything, because the technique does not work for me.  A patch I
sent without my sign-off may later turn out to be worth keeping, and
when I run "git am -s" on it, I'd have a full sign-off chain anyway.
There is no "going back to the author and ask" necessary.

In any case, I am not sure what you are trying to achieve by
mentioning the cases where patches are not signed-off.

The reason why some patches do not carry sign-off might be because
the sender does not wish to certify and that's OK.  But if you are
arguing that when you write "Signed-off-by:" your sign-off can mean
something other than what DCO says it means, what those people who
sometimes do not sign-off their work do would not be useful at all
to support your claim, I would have to say.  You need to find other
people's signed-off patch when they did not mean to certify them
under DCO, if "it does not have to be only one meaning" is what you
want to support.
