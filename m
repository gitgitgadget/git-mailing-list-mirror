Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD59C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 17:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355837AbiALRyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 12:54:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50816 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355830AbiALRyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 12:54:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98E49114CBA;
        Wed, 12 Jan 2022 12:54:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5UEokm/Gqn9K
        n3yqz2HHZ2H6FJGCdPHTlsEvSM8vmHk=; b=sQrHO9zbGF0koxyoVQH1Qq1Svgh6
        5YA24NkXUdAWw3MT3epZ7hUYiPANya5QhPyJ1Ijq7+QmBfJ6T+AQPYCCwLAE+Neq
        N3Crvdi3qr4Jm0Rx/E2nTwnuEORFZklKmS3N3i8LRQel8MdpYjiucqfGsjKplfAP
        D5Q2IGO6at1dEys=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91189114CB9;
        Wed, 12 Jan 2022 12:54:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 048E8114CB8;
        Wed, 12 Jan 2022 12:54:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
        <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
        <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
        <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet>
        <xmqq8rvn1nkw.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2201111439190.1081@tvgsbejvaqbjf.bet>
        <220111.86mtk2xb1y.gmgdl@evledraar.gmail.com>
Date:   Wed, 12 Jan 2022 09:54:18 -0800
In-Reply-To: <220111.86mtk2xb1y.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 11 Jan 2022 18:00:51 +0100")
Message-ID: <xmqqy23kx2k5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AAF7F562-73D0-11EC-B1D5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Maybe that was the right thing to do, maybe not, but it went out with
> v2.30.0 and the lack of complaints since then would seem to suggest tha=
t
> I was right that removing it wouldn't be a big deal.
>
> Of course it may have broken someone's script somewhere.
>
> But an important distinction is that they can get it working again by
> just copy/pasting that ~100 line shell library into their own script, o=
r
> calling the underlying commands it was invoking themselves.

Was parse-remote a part of what promised our end-users?  merge-tree
has been since it was written. =20

That distinction is even more important.
