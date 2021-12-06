Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05359C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 19:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347759AbhLFTW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:22:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60260 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhLFTW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 14:22:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DD2D101ECD;
        Mon,  6 Dec 2021 14:18:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=r1DYCm7EIyS4
        BT/v6dBM05zyU0hhFguinm5+d+hgjbc=; b=i4PbRRE7CG3owha/SYmOIPWSPU+h
        pRWNbm8i/+x7fEc+dPh/MsWkAeJIWXtUn35YXplb5btXPrkTOlftu5dvrDEmRlJ6
        Xphw66g9XOqj26+1RRyrkxUmfWc3nXKw5KUfJS/7jCbQLCPNO3YI6HmYDft3TU5V
        upRq0stdRNcpW5M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 335D4101ECC;
        Mon,  6 Dec 2021 14:18:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8D300101ECB;
        Mon,  6 Dec 2021 14:18:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/10] Factorization of messages with similar meaning
In-Reply-To: <96b2d1c2-895d-6196-df8d-ee1e9b6107ce@kdbg.org> (Johannes Sixt's
        message of "Sun, 5 Dec 2021 20:50:13 +0100")
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <d687f69b-efdc-6b1c-c63c-8544ff37d1c2@kdbg.org>
        <xmqqfsr7mrs5.fsf@gitster.g> <8718669.4XknugNGDb@cayenne>
        <96b2d1c2-895d-6196-df8d-ee1e9b6107ce@kdbg.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Mon, 06 Dec 2021 11:18:56 -0800
Message-ID: <xmqqo85tfsnz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5C24D762-56C9-11EC-B8C1-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 05.12.21 um 18:25 schrieb Jean-No=C3=ABl AVILA:
>> If needed, "%s and %s are mutually exclusive" could be turned into
>> "options %s and %s are mutually exclusive" to make it clear that the
>> placeholders can only hold option names.
>
> IMO, being less terse helps not only translators, but also users.
>
> Regarding this particular message, personally, I am not a fan of
> "mutually exclusive" (sounds like it's been taken from a law text). How
> about "options ... are incompatible" or "... cannot be used together"?

Sounds good.  Or perhaps "X cannot be used with Y", which may be
even shorter and is still clear what it wants to say.

    X and Y are incompatible.
    X and Y cannot be used together.
    X cannot be used with Y.

