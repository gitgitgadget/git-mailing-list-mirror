Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4806C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC91611C6
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbhI1RjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:39:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55382 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241527AbhI1RjM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 13:39:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AEF3F15F218;
        Tue, 28 Sep 2021 13:37:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ihh0DgRdCD6L8BnRdmxMOTKbP3dfQXn5txAaGo
        AdqwI=; b=PAnIm6U7e/yrI9EiI/HHd2PBC8ZWw4Vvx/Or8ErGJOpYunotylNOIh
        JlQdl8qF3PI5vP1RxzmM2FFX4IxPHL+DKmhSqe339j5DeovhmR+rwXsNDme1Ah7X
        XKmZ2ja/6Z1GFC6+NU45C7QK83eQgwiEPB5aE2VrFDvjVD8Egg+5k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A74D615F217;
        Tue, 28 Sep 2021 13:37:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 188D615F215;
        Tue, 28 Sep 2021 13:37:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
References: <20210903170232.57646-3-carenas@gmail.com>
        <20210927230438.3759964-1-jonathantanmy@google.com>
        <CAPUEsphk9b0TpUDgW9qkG=ehKx+hPi5GNtqTP2o2MeL1VpHHPQ@mail.gmail.com>
Date:   Tue, 28 Sep 2021 10:37:29 -0700
In-Reply-To: <CAPUEsphk9b0TpUDgW9qkG=ehKx+hPi5GNtqTP2o2MeL1VpHHPQ@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 27 Sep 2021 17:30:34 -0700")
Message-ID: <xmqq35polhye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C138366C-2082-11EC-A20C-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Mon, Sep 27, 2021 at 4:04 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>>
>> > +ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
>> > +DEVELOPER_CFLAGS += -Wno-incompatible-pointer-types
>> > +endif
>>
>> I noticed today that I wasn't warned about some incompatible function
>> pointer signatures (that I expected to be warned about) due to this
>> line - could the condition of adding this compiler flag be further
>> narrowed down? gcc -v says:
>
> Apologies; it is gone already in "seen" (and hopefully soon in "next")
> by merging js/win-lazyload-buildfix[1]

I will mark it not ready for 'next', while waiting for a fix-up.
Thanks for stopping me.
