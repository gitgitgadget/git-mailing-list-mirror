Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365EFC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 19:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbiANTFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:05:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54429 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiANTFF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 14:05:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 092DD16842A;
        Fri, 14 Jan 2022 14:05:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hol0Go32/rAU
        pdTrvrCC0VrVfM1PtbWPUbipUrx9OWE=; b=VYUzfV/WhIfS9GSKAVI/wunIcVhr
        278LGBW7bnh5J0wHfiSYhM73cgXdLF7aBB44qRqtV2BC/Q/D54Dd4R6LMBxkO0CI
        pB9B0Kfrxqh5mQstWmrkmnU7KzPKcN5imfsBsk4k67mJ851fd64T5wIjzhhp9FEl
        TjxovEDHdwV0o3o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0118D168427;
        Fri, 14 Jan 2022 14:05:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3C94168424;
        Fri, 14 Jan 2022 14:05:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 4/6] object-name: show date for ambiguous tag objects
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
        <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
        <patch-v7-4.6-2e5511c9fa5-20220111T130811Z-avarab@gmail.com>
        <xmqq1r1bgso2.fsf@gitster.g>
        <220114.865yqmtt9z.gmgdl@evledraar.gmail.com>
Date:   Fri, 14 Jan 2022 11:04:59 -0800
In-Reply-To: <220114.865yqmtt9z.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 14 Jan 2022 13:05:45 +0100")
Message-ID: <xmqq4k66cf50.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E00D5790-756C-11EC-9B61-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I still think the trade-off of not doing that discussed in the commit
> message is better, i.e. (to quote upthread):
>    =20
>     We could detect that and emit a "%s [bad tag object]" message (to g=
o
>     with the existing generic "%s [bad object]"), but I don't think it'=
s
>     worth the effort. Users are unlikely to ever run into cases where
>     they've got a broken object that's also ambiguous, and in case they=
 do
>     output that's a bit nonsensical beats wasting translator time on th=
is
>     obscure edge case.

Writing the above (and quoting it again to make me respond to it)
have already wasted a lot more time than a better solution that does
not lead to a misleading output, especially given that it was given
for free to you already.
