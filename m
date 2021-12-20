Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA32C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 20:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhLTUxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:53:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50643 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLTUxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 15:53:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2A6216FE03;
        Mon, 20 Dec 2021 15:53:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rzZjFU2HNlhe
        osTgRIwCVwjjeIEWc8bL1pCUfZiigjg=; b=DU7CvFIzY6SLcP6ZU4vlg445xfNY
        oGiB0vywfopmlMDL+ZNzz5JupoYdpDv/ApafWiCPkJrfy6JIoWsWtV579eU9btBV
        cQWu5vDesDViDaOHuaze9mObHEDVIaSrwhlP3hgC1ihFLpuYGAuFnG6pTRjbO2Sr
        EDhQcUS+TOsq4Jo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB5DE16FE02;
        Mon, 20 Dec 2021 15:53:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4DBAA16FDFE;
        Mon, 20 Dec 2021 15:53:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Hamza Mahfooz <someguy@effective-light.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Be?= =?utf-8?Q?l=C3=B3n?= 
        <carenas@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] grep/pcre2: factor out literal variable
References: <5fa6962e-3c1c-6dbc-f6d7-589151a9baec@web.de>
        <ba503995-866d-fc80-4e38-b4dfd0e5c5bc@web.de>
        <211219.86o85cwfje.gmgdl@evledraar.gmail.com>
Date:   Mon, 20 Dec 2021 12:53:17 -0800
In-Reply-To: <211219.86o85cwfje.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 19 Dec 2021 20:37:37 +0100")
Message-ID: <xmqqmtkvuhfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DC95D456-61D6-11EC-B326-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Aside: Not needed for this change, but I wonder if we could benefit min=
utely
> from:
>
>     #ifdef PCRE2_LITERAL
>     options |=3D PCRE2_LITERAL;
>     #endif
>
> It'll save PCRE2 the small effort of finding that we've got no metachar=
acters.

After the dust settles, it would be a good addition in a separate
patch.

Thanks.
