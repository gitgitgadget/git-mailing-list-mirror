Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EB8C4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7D023B7D
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 06:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgLIGzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 01:55:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50895 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbgLIGzo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 01:55:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB999FB339;
        Wed,  9 Dec 2020 01:55:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=42dzKifjNmMScfiklfOJ28WdbSU=; b=hSk6lg
        01ztXME9zCxBstf1UmZZms0LJ97U6igxygzo6T17LGPELKT1KehZABj9wXsYFqW0
        eleffwa6UOXiZE0zMxuwmFkFvFzml8u4WrFINjMN0ppZHODy9Q2yV+Z8o7QgDFR6
        7/MsGZqSm30qzP10hD2Ut1+O21+rzKgQn62Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XhAWgFTZaKvuxmzs2raRGsdEuM6uYmjj
        4sZk7j1l5tWQLvdD+6jtbYWRJyHA6q/Jjf2MBEc5/v+uzC3Orx0fIE2fWtVk9zdJ
        a9/gPD2WIq5f+IgIJgwVkUdoq8tpAiS0fRWvppFUQcnRYKDuIqN/qzNgwvAj4ptd
        n9rj3PxO6sI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C3E15FB338;
        Wed,  9 Dec 2020 01:55:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 159E1FB334;
        Wed,  9 Dec 2020 01:55:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
References: <20201209002619.25468-1-felipe.contreras@gmail.com>
        <X9A1On3v35nEjL7i@camp.crustytoothpaste.net>
        <CAMP44s0W3En0ZuNfBOOZhfeFUeFRvEFs7khAFRraocuDaFpbNA@mail.gmail.com>
Date:   Tue, 08 Dec 2020 22:54:58 -0800
In-Reply-To: <CAMP44s0W3En0ZuNfBOOZhfeFUeFRvEFs7khAFRraocuDaFpbNA@mail.gmail.com>
        (Felipe Contreras's message of "Wed, 9 Dec 2020 00:36:16 -0600")
Message-ID: <xmqqlfe731vh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74965614-39EB-11EB-9EB1-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> We have an .editorconfig file[0], which is a cross-editor file that can be
>> used to specify these settings.  It is supported by many editors out of
> ...
> Also, we don't have to support configurations for every editor under
> the sun, that's a slippery slope fallacy.
>
> We can stop at 1 editor: the most widely used editor by developers by far [1].
>
> Cheers.
>
> [1] https://pkgstats.archlinux.de/packages#query=vim

It shows 71% (for vim-runtime), that is a lot higher than ~20% for
emacs.

Amusingly, https://pkgstats.archlinux.de/packages#query=nano tells
us that nano clicks at 80%, which makes it the editor with the
largest number with your yardstick ;-) [*2*].

In any case, I think it is a worthy goal to ship a sample set of
"vimrc" entries that people can readily accept for their use.  It
also is a reasonable "feature request" to consider doing something
similar to "editorconfig" to give other editors similar convenience.


[Footnote]

*2* In other words, I doubt these graphs are depicting "how widely
is an editor used by developers".  It is just showing how often it
is installed, and I know the primary workstation I use daily has vim
and nano installed without me choosing to have them, as opposed to
emacs I had to manually install, and I only use vim once every month
and nano once every quarter.

Note that I do not doubt vim is popular.  It is popular and it makes
sense to include it in the set of "first class" editors that deserve
priority treatment when we allocate engineering effort to support.

I just do not think these graphs are the best supporting material
for the claim you made "the most widely used editor by developers".
