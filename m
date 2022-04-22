Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169D7C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 23:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiDWAB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 20:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiDWABY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 20:01:24 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B859A1E3DE4
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 16:58:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D09A109942;
        Fri, 22 Apr 2022 19:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jXfAcP/a8k0C
        tNbxZLO2jyNiUXVD2wRPRiO/JqVecfg=; b=jx88I5iUnuHLebisLqWAmfDTrg32
        fFCRv2UkSo32l50AwURNv2sLL2qeZmXg0n1/uwdKaLGJIGc+i3byZPth5gPyixPB
        7Lcmq7IDsH5yMS/ltN6Z+L2BKgLy7S0KeviqGwdHlMTFkJwP3OIxUupf95nKvmbN
        OGphzDmn+yjN0TA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 149DD109941;
        Fri, 22 Apr 2022 19:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 197BA10993F;
        Fri, 22 Apr 2022 19:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/2] ci: make failure to find perforce more user
 friendly
References: <20220421225515.6316-1-carenas@gmail.com>
        <20220422013911.7646-1-carenas@gmail.com>
        <20220422013911.7646-2-carenas@gmail.com> <xmqqo80td5wj.fsf@gitster.g>
        <xmqq5yn069lq.fsf@gitster.g>
        <CAPUEspjGX4L-4T-93a2729SkB92TP500JYmEbKyrRFbv7moTXw@mail.gmail.com>
Date:   Fri, 22 Apr 2022 16:58:27 -0700
In-Reply-To: <CAPUEspjGX4L-4T-93a2729SkB92TP500JYmEbKyrRFbv7moTXw@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 22 Apr 2022 16:13:15 -0700")
Message-ID: <xmqqo80s4qn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1ABF7134-C298-11EC-A050-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Fri, Apr 22, 2022 at 3:23 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
>>
>> So, how about replacing it with something like this?
>
> Agree 100%.
>
> It would theoretically make the issue raised by =C3=86var of not knowin=
g
> when perforce was skipped slightly worse
> but getting that fixed would seem like something that could be done in
> a follow up.
>
> I have to also admit, with all the on the fly changes to these same
> files, it might be wiser to wait until later anyway.

Actually, I was thinking about taking these two (possibly with
=C3=86var's "download with https://, we are in 21st century" change to
make them 3-patch series) and fast-tracking.

The homebrew specific "packagers can take a bit of time to catch up
and we may see hash mismatch" and other tweaks =C3=86var has can come on
top once we see the basic "any parts of tests can fail and the rest
can still be tested, why does it have to be world-stopping if we
fail to install p4?" working.

Thanks.
