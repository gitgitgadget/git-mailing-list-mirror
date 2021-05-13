Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D1FC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E82C61452
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhEMUYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 16:24:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56703 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbhEMUYX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 16:24:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5997D11D3F6;
        Thu, 13 May 2021 16:23:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+stsvTh+ZiiZ
        d3hhRIXKXa2ligGvBX7W2XhXP5p//6Q=; b=KLpIl9pTzGyHpHYe3mx4qQGDZttR
        nkZY3uVjpPQ6KvCKji5YgqczJgRu5Ex0OVZQdv57iaqNhAvbmpl9w0doQRDBI/Xr
        T4uC125o/aslZIA5/0IF5QXM3Pkt/tEc4RU6sJMQ+JG3DEQ3tz1zpa/5eMYwk+SH
        S++LSs8FQkYvYZY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44E9B11D3F5;
        Thu, 13 May 2021 16:23:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 707D111D3F4;
        Thu, 13 May 2021 16:23:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] INSTALL: note about make man with Asciidoctor backend
References: <20210512064128.15411-1-bagasdotme@gmail.com>
        <xmqqtun8fncl.fsf@gitster.g> <609b8e214e1b6_6e4e92087e@natae.notmuch>
        <CAN0heSrNzxSpq=trPvOHAYx_yT1W=WuN1XstzTRjHdZko-i+DA@mail.gmail.com>
Date:   Fri, 14 May 2021 05:23:07 +0900
In-Reply-To: <CAN0heSrNzxSpq=trPvOHAYx_yT1W=WuN1XstzTRjHdZko-i+DA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 13 May 2021 15:41:11
 +0200")
Message-ID: <xmqqwns29ydw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0888C160-B429-11EB-AD41-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
>> >
>> > > +   You can also do "make man" using Asciidoctor's manpage backend=
 in
>> > > +   place of xmlto by passing USE_ASCIIDOCTOR_MANPAGE=3DYesPlease.=
 Version
>> > > +   2.0 or later is highly recommended, as these version properly =
handle
>> > > +   apostrophes.
>> ...
>
> Even early 2.0.x had some issues [1]. It's always debatable whether the=
y're
> significant or not, i.e., is a significant speed-up worth it if the
> result is just-as-informative-but-a-bit-ugly-here-and-there? We should
> provide some rough background here to help people and distros decide.

What does "properly handle apostrophes" refer to exactly?  I got an
impression that it was the pretty-quoting that breaks cut-and-paste,
which is a usability issue for manpages.

> Maybe something like
>
>   "This can be quite a bit faster and requires fewer dependencies, but
>    please note that this is early work: there are some typographical
>    issues we know of, and there might be others."
>
> but hopefully phrased better than that.

That looks like a good starting point.

