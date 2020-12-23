Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D1C433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2D8223E4
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgLWU44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 15:56:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62826 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgLWU44 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 15:56:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6D145118EAD;
        Wed, 23 Dec 2020 15:56:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jgVY5QAeUwiot62e0DAghD0AUkA=; b=BgNCNs
        HXhMH5AZg9KKOdFNP1gejNDtJ84fiabMwN8aF9NiehmVW6ancQ2EUFag1wK/cRNf
        3qxvYOOvReNaaH+U8OY5s2fZyRvxC9L/hAJn+9yfPbbaiHOTzQG5sos8aXOTV9oO
        wHKGbdRrld+pq8KH1mtrLcwahWgxnVx09z/ek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YAkC0eDM/xrPI+kdGUgi7eU3FNJlpOgA
        8mqfGeTrJP5RrYvX1IIbunEk7+IWPldGFs1oClYNVGrguHa15e/Z1VSvGzOxV5Mf
        ae67tVS+IsVvloNIWxDbY7pBxvzAUOuyzHv0Yo5D9V9ihrQT+gvedaQHBiLJZhoP
        Q0wepliSrmE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5512E118EAC;
        Wed, 23 Dec 2020 15:56:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 96F90118EA8;
        Wed, 23 Dec 2020 15:56:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
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
Date:   Wed, 23 Dec 2020 12:56:09 -0800
In-Reply-To: <5fe36790793ae_2354120839@natae.notmuch> (Felipe Contreras's
        message of "Wed, 23 Dec 2020 09:51:44 -0600")
Message-ID: <xmqqpn306y3a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49BF3E5C-4561-11EB-9096-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> You are not THE one making contribution.
>
> When I'm sending a patch, I have the role of "contributor".

Yes, you are a contributor, but there are other contributors to the
change under discussion.

> In your own release notes [1] you say:
>
>   New contributors whose contributions weren't in v2.29.0 are as
>   follows.
>
> Presumably these are the people who contributed patches, not reviews.

If I said "These community members have their name as an author of a
patch for the first time since v2.29", would that mean those who do
not have any commit under their name are not community members?

> I don't know why you feel the need to explain that to me. I have been
> contributing to open source projects for more than 20 years.

Because you are acting as if you don't know and have to always be
the right one no matter what.  You may not mean to do so, but that
is how your behaviour appears to me (note that I did not know say
"to others").

I won't have time to respond to your word games after I send this
message.
