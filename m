Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06227C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3596109E
	for <git@archiver.kernel.org>; Mon, 17 May 2021 19:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhEQT2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 15:28:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54741 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbhEQT2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 15:28:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0DCE313342F;
        Mon, 17 May 2021 15:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ui38oCEMTd/9W0wwiuWbPQdP7Kr+ZiqhFdRGri
        Zi/Ag=; b=J7PzS4BP3MS+IlCCI+qJPObljGC4NSkqQqsLX+SZAVaKY3oBKLl/b6
        raJ6LSo7ojk6hy5dum3MzJtTiJYKGbswYPZ+2RXs+jIFzOSSbTm4X2nRbIAcWU97
        0zTNhjgUcFRuqnUZngHXdAp2Dfxi6tIKqJyBRKkfL1yEyqz4sSA8g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 06D4013342E;
        Mon, 17 May 2021 15:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DFF7E13342D;
        Mon, 17 May 2021 15:26:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
        <xmqqbl993irp.fsf@gitster.g> <60a245a927c62_126333208ea@natae.notmuch>
        <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
Date:   Tue, 18 May 2021 04:26:48 +0900
In-Reply-To: <YKJZt4vFECoLZhc2@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 17 May 2021 07:55:35 -0400")
Message-ID: <xmqqpmxp6u13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3D270D6-B745-11EB-8E6D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree that if the purpose is to be illustrative, using shortcuts like
> "an empty endpoint means HEAD" is not helpful. And likewise for "@"; if
> you need to have "revision range" defined, there is a good chance that
> you don't know about shortcuts like "@" either.
>
> So I would prefer something more explicit (whether it's "mybranch" or
> "end" or "HEAD" or whatever).

Perhaps.  Being illustrative for common use case is also important,
so I do not mind teaching "missing endpoint at either side defaults
to HEAD" early.

If "missing" endpoint is disturbing, the description can be fixed to
stress that they are "often but not always" given.

>> > Especially since most people are downstream consumers, I'd
>> > suggest using `origin..` or `@{u}..` here.
>> 
>> Nobody uses "origin" (what does that even mean?), [...]
>
> I guess I'm "nobody" then, because I use it all the time.

Oh, I'm nobody, too, and so are many others ;-)

> The example in Documentation/rev-list-description.txt (which feeds into
> the git-log and git-rev-list manpages) uses "origin..HEAD", as well.
>
> IMHO it is a pretty reasonable example, but the examples in
> gitrevisions(7) use made up "r1..r2", and that seems perfectly readable,
> as well.
>
> -Peff
