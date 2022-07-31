Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A499BC00140
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 18:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbiGaS4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jul 2022 14:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiGaS4d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jul 2022 14:56:33 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A8E9FF4
        for <git@vger.kernel.org>; Sun, 31 Jul 2022 11:56:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A718149456;
        Sun, 31 Jul 2022 14:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Vn9wuW+TVP1g
        7Fcp3UzmnFOST7UugAIBSRblQCPc6pY=; b=MAuIY13gPXeMw5P7MRxUMFClwRu6
        iWn2d/O8rCXl6wHR4xv/vWZCLi/jtW0pI3UFvn0a25TkJS6/y03MW4VD0y/ucSzM
        i5hWx5lQY8w2sM1tCm02WX9AaLPfpoLtnZc5uCgL7SDgfE1zqcyGw97PgsT9nil0
        WMsjLVM/8fhRbX4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 619B8149455;
        Sun, 31 Jul 2022 14:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4D4B14944F;
        Sun, 31 Jul 2022 14:56:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eugen Konkov <kes-kes@yandex.ru>
Subject: Re: [PATCH] format-patch: clarify --creation-factor=<factor>
References: <xmqqo7x9ch7n.fsf_-_@gitster.g>
        <20220728174953.66964-1-sunshine@sunshineco.com>
        <220728.867d3xj6s0.gmgdl@evledraar.gmail.com>
        <xmqqv8rh9co5.fsf@gitster.g>
        <CAPig+cTxM2vr11XRU-zrNAJRwveP0W9d0x8Euvr6HKmQicKgPQ@mail.gmail.com>
        <CAPig+cQ94oC-6wftkP_=RSEsOVPKeuBWuMshDkwV+Xu_FjrKeg@mail.gmail.com>
Date:   Sun, 31 Jul 2022 11:56:28 -0700
In-Reply-To: <CAPig+cQ94oC-6wftkP_=RSEsOVPKeuBWuMshDkwV+Xu_FjrKeg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 29 Jul 2022 20:25:26 -0400")
Message-ID: <xmqqa68p157n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7CB5AF80-1102-11ED-A774-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Jul 28, 2022 at 5:09 PM Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
>> On Thu, Jul 28, 2022 at 4:59 PM Junio C Hamano <gitster@pobox.com> wro=
te:
>> > >> -               [--range-diff=3D<previous> [--creation-factor=3D<=
percent>]]
>> > >> +               [--range-diff=3D<previous> [--creation-factor=3D<=
factor>]]
>> >
>> > Eric, I am not sure if the other patch for the range-diff command as
>> > a standalone patch is worth it.  Perhaps you can help me by
>> > submitting a single combined patch to cover the above as well as
>> > what we wrote in the two patches, with you marked as the primary
>> > author and with Helped-by: that credits =C3=86var?
>>
>> Will do.
>
> Given Dscho's response in [1] which states that "percent" is more
> accurate than "factor", perhaps these two patches are unwanted after
> all, and instead the documentation of "creation factor" in
> Documentation/git-range-diff.txt ought to be expanded with a better
> explanation, as hinted in [2].

Yup, I do not mind "percent" at all.  As long as it is clear that we
use it to avoid fractions by multiplying by 100.  Something along
the lines of "This number is expressed by 'percent', but its range
is not constrained to 0-100%.  It is a weight given to X relative to
Y, and default is 60% (i.e. 0.6).  You give it larger value when you
want to do Z and smaller value when you want to do W" would be what
our readers need to see, I would think.

Thanks.
