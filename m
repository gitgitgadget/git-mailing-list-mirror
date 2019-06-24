Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D375B1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 19:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfFXTXF (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 15:23:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63002 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfFXTXE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 15:23:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B04367C91C;
        Mon, 24 Jun 2019 15:23:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vs6lgIegiF1ZwXiS49CDFp2UETo=; b=pshtDt
        M34SF05wlbhAdkk67Idv8amYuuD5nyq6BJ0BbzdRwUUYaTcYtQanyqpZh05KWEVd
        cwDEKX766uh5gPIFM6pdvXe0w4x3gWxbfTiwS5WMl5ijW7Vj18pneG+xeJepdoD4
        JEo1nYVxLyfSEg38zcRPM1CVjY3tRKoXUZEYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=negB5Qiz6k65wPrGW26c8eTR6W9SZ0WS
        mPxbeVYhlS0RHiSydqho9n4Yrw+9IIAJIHUMl7PJJWvZAxaDh0QB9EptIR9JPHQi
        i0vriMmzz/MC1YzW63BUnb3bAq3CzWFUIhPxNO8MdLQiz+g6nLOdKi8SGQFM0JK2
        DDJL/odrXfM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8C5F7C91B;
        Mon, 24 Jun 2019 15:23:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D87AE7C918;
        Mon, 24 Jun 2019 15:22:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/1] t0001: fix on case-insensitive filesystems
References: <pull.151.git.gitgitgadget@gmail.com>
        <pull.151.v2.git.gitgitgadget@gmail.com>
        <c2fdcf28e725c91a1a48c34226223866ad14bc0a.1560978437.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1906211632570.44@tvgsbejvaqbjf.bet>
        <xmqqh88ikfpb.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906241212220.44@tvgsbejvaqbjf.bet>
        <xmqqimsuj4ft.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1906241937010.44@tvgsbejvaqbjf.bet>
Date:   Mon, 24 Jun 2019 12:22:57 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906241937010.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 24 Jun 2019 19:38:18 +0200 (CEST)")
Message-ID: <xmqqblymhjou.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A719C68-96B5-11E9-A308-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The other path category is the paths in the index, which _are_
> case-sensitive, no matter what core.ignoreCase says.
>
> So I'd rather keep the `fs`.

Sensible.  Thanks.
