Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558BCC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 06:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiAMGIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 01:08:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53798 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiAMGIG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 01:08:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F4E610290C;
        Thu, 13 Jan 2022 01:08:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=PZjILzGEHGdEeAzfY82owduomdlikXnBD6lkevM4cN8=; b=FEFR
        9B/1lbGmQskRP4pxVbNnUkWgWIGPinVnfd4rZF+FzJn4MUtNLrvCyjkQz376jDFK
        RG7mPIZ+C5hdRQvm+Nv6TegIDxfOS0KDyPooaHhScybBKmixiMuod1QDRQShEsgq
        KnA9MEaK/GxhWqotVIgLZMRqhj/XpAblvhEDd3w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63C4B10290B;
        Thu, 13 Jan 2022 01:08:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A88D2102909;
        Thu, 13 Jan 2022 01:08:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
        <CABPp-BFei07srZBgyKs6HCm+G+hmPR-3_EkKjRK8WwGL1Uf2oA@mail.gmail.com>
        <xmqqk0f4x20a.fsf@gitster.g>
        <CABPp-BHQdkhAEmTrtc+XMgj5A5ASBVRw0_bXH10NSrMsyRK+oA@mail.gmail.com>
Date:   Wed, 12 Jan 2022 22:08:03 -0800
Message-ID: <xmqqk0f4jhh8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BB7A7CC-7437-11EC-934B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> so it may be quite simple to deprecate "merge -s recursive".
>
> Yes...but why deprecate?  I thought the plan was to (eventually) make
> requests for either `recursive` or `ort` be handled by running the
> `ort` backend.  Making that kind of switch is much smaller than the
> one we already made to switch the default backend from `recursive` to
> `ort`, so I'm not sure I see what we gain by doing such a switch in
> stages.  Maybe I'm missing something?

Didn't we "deprecate" but still indefinitely support "annotate"?  I
have been assuming that recursive will be in that category after ort
establishes itself.
