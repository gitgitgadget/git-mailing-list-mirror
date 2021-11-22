Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC04C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbhKVWNZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:13:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52188 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhKVWNY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:13:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 921791559A8;
        Mon, 22 Nov 2021 17:10:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vxSd8gWs1QxjguKtQr2crc//gmZYDoC6/T0S/V
        BeraM=; b=T1seuu2/HM9ipyqSOWEA/umRIkRwAYdHzmQo36GSn1gMR0TFmzJg4F
        xcWZyn2gikvEzIqj42p6mREnpSvmwaFWLLMIJ+veRpiwTPVXPXwSLeErMaNU8/u8
        q1wLXhpJ0yY0nlZHTbrWbRSxcEs48z4T8I4JQ+0Q8tULi5ZDM/n4U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A55A1559A7;
        Mon, 22 Nov 2021 17:10:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E402D1559A6;
        Mon, 22 Nov 2021 17:10:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 supporty
References: <20211114211622.1465981-1-sandals@crustytoothpaste.net>
        <20211114211622.1465981-2-sandals@crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2111161129120.21127@tvgsbejvaqbjf.bet>
        <xmqqk0h7423v.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111221242320.63@tvgsbejvaqbjf.bet>
        <xmqq1r38hzi9.fsf@gitster.g>
        <CAPUEspibE6AMyoxwJGno9R=21JU5MpFVGBxCQYBCbCBwx-y25A@mail.gmail.com>
        <xmqq8rxgf254.fsf@gitster.g> <xmqqv90jewwa.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111222300580.63@tvgsbejvaqbjf.bet>
Date:   Mon, 22 Nov 2021 14:10:13 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111222300580.63@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 22 Nov 2021 23:03:14 +0100 (CET)")
Message-ID: <xmqqwnkzdepm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F823F89E-4BE0-11EC-8E71-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> But if we were to do so, perhaps we'd want something like what I
>> gave at https://lore.kernel.org/git/xmqqy25lwa86.fsf@gitster.g/ in
>> its place to avoid confusing people.
>
> That sounds like a good course of action to me.
>
> Please note that the MSVC-related adjustment of the `FLEX_ARRAY` block is
> still needed, I think.

The "something like what I gave ... to avoid confusing people" patch
is following up on the direction to drop the patch with -std=gnu99
change.  IIRC, your MSVC adjustment was to tweak that patch we were
discussing of dropping, so even if it is still needed, it won't be
part of what I was doing.

