Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C413C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE0C60720
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 23:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhI0Xyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:54:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62635 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbhI0Xym (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 19:54:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB669EBCE2;
        Mon, 27 Sep 2021 19:53:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mIJJiuBq+kWFtppjfLkRj4J7GT1nzBiw6eXV9X
        aTTZE=; b=vsX0zL1ChZ09uaqCIh8dRA5IjSeRDDuSwLlHyv1q3ry5KpZe+EMuTn
        MtJAlBK7+9A2pThHNq92J9kmCgFZSdSac9tXbgqt4Dg6Kg4sC3sUKqLP8mUlvL0J
        F7FDkqdDcKZAhaNor8GC3BswwIUOgtStGSguo4OJ4w/GXan177LxM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC5DCEBCE1;
        Mon, 27 Sep 2021 19:53:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15BEEEBCE0;
        Mon, 27 Sep 2021 19:53:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v6 4/8] core.fsyncobjectfiles: add windows support for
 batch mode
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
        <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
        <bdb99822f8c45a8b2855ee2ab38c4460e4b5e22e.1632527609.git.gitgitgadget@gmail.com>
        <xmqq1r59rde8.fsf@gitster.g>
        <CANQDOdfxZP1GSb29LfcLQ2U84hRsgSq4kfzshPHFU8=o9+BSjg@mail.gmail.com>
        <CANQDOdd5T=6HR5hr1VOom0b+x0ps0yrQOeo8XD5QkSv2BuUNGA@mail.gmail.com>
Date:   Mon, 27 Sep 2021 16:53:01 -0700
In-Reply-To: <CANQDOdd5T=6HR5hr1VOom0b+x0ps0yrQOeo8XD5QkSv2BuUNGA@mail.gmail.com>
        (Neeraj Singh's message of "Mon, 27 Sep 2021 14:03:09 -0700")
Message-ID: <xmqqzgrxmv8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D8422A0-1FEE-11EC-BF5C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> ....  The current ifdeffery is unpleasant to read but not too long
> and also pretty direct.
> Win32 has an extra level of indirection, but the unix platforms
> syscalls are directly written
> in one place.

Yes, that is exactly why I concluded that reducing just one instance
would not make that much difference ;-)

Thanks.
