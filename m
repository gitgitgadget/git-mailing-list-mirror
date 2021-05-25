Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368C5C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DE06113E
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhEYGxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 02:53:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56551 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhEYGxI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 02:53:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98382129F2F;
        Tue, 25 May 2021 02:51:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=q5MZvD2glX6B
        TnxDtWt2CrVPUMkMiSit/BzJSgC9I4c=; b=SM18yTDIU7Q9RuK672cAN9TD8Ufj
        +Faw3H6oFMcs07eKIlUCfrw6/RR5+2AmFYqDvKoHsDjf8n/KgWH1XNNqGUgzS4CZ
        lnCtXn8yiFC+CiOKYvu5XrkdqBG4hTWBxQmIvZzfm/yiPIqK3pjvrx4hWQD6Kjd9
        JwUdlJ85SVep9x4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90283129F2E;
        Tue, 25 May 2021 02:51:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7186129F2C;
        Tue, 25 May 2021 02:51:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Subject: Re: Renaming "non-contrib" things out of contrib/* (was "Re: [Bug]
 git-credential-netrc.perl[...]")
References: <87k0nt3f8i.fsf@gmail.com>
        <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
        <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
        <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
        <YKqzj/DZU8m9AaI/@coredump.intra.peff.net>
        <60ab17018efee_1691c20832@natae.notmuch>
        <87o8d0o2or.fsf@evledraar.gmail.com>
Date:   Tue, 25 May 2021 15:51:34 +0900
In-Reply-To: <87o8d0o2or.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 24 May 2021 12:05:34 +0200")
Message-ID: <xmqqtumrfgqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A5DB74D0-BD25-11EB-A41D-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I wonder if just a top-level completion/* wouldn't be best, or if we
> want to group them all together something like
> optional/{completion,credential}/ or other name suggesting that these
> are meant to interact with not-always-present 3rd party software. Maybe
> integrations/* ?

Add-ons?

I think dispelling the conception by distro people must begin with
an update to contrib/README where it clearly says these are
"contributed software" that are not part of "Git".  They are not
something we stand behind like what we have in the rest of the
source tree.

Also, the description there is rather stale.  For example, the last
paragraph must go as its entirety.  The ecosystem has expanded
thousand-fold since the document was written, and we no longer
encourage people to add new things to contrib/ directory at all.  We
instead encourage them to write and sell their ware on their own
merit alone, without planning to "borrow" authority and gain undue
advantage over its competitors by being in the contrib/ area in our
tree.
.
