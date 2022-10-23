Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D204ECDFA1
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 21:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJWVsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Oct 2022 17:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJWVsO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2022 17:48:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F086386B
        for <git@vger.kernel.org>; Sun, 23 Oct 2022 14:48:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6015E1C3C64;
        Sun, 23 Oct 2022 17:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Lmng7INw1taigUgiwHBKUPn9wnNXazEuybVbBv
        qLyHQ=; b=KaoDknVCq1+yPYPPKoTA+ABoeiD5g6bER20b1LPs7YVc+an2kFdEJF
        OzgGK3sgqg1oMWwMaUE7js0GIZ0mTHp97A1Cza7FzTK7FIHajRCjFDFQvLVAUfcm
        scpYkJE0kuT4ZFmxurpU4v/yZghvEARSJdW2AFcrEHa9RnO938lDc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56ED51C3C63;
        Sun, 23 Oct 2022 17:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D9A41C3C62;
        Sun, 23 Oct 2022 17:48:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/5] repack: use tempfiles for signal cleanup
References: <Y1M3fVnixJHvKiSg@coredump.intra.peff.net>
        <Y1M3oie5dPrRaOni@coredump.intra.peff.net>
        <Y1RUI8ny2mexxwKm@coredump.intra.peff.net>
        <xmqqtu3vflau.fsf@gitster.g>
        <Y1VzPY4zQyZbVAsm@coredump.intra.peff.net>
        <xmqqlep6fm5h.fsf@gitster.g>
        <Y1WqX7YRrSpkmyxH@coredump.intra.peff.net>
Date:   Sun, 23 Oct 2022 14:48:05 -0700
In-Reply-To: <Y1WqX7YRrSpkmyxH@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 23 Oct 2022 16:55:59 -0400")
Message-ID: <xmqqh6zufbze.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 607D402E-531C-11ED-92F3-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I did try the same exact patch before going to bed last night but
>> t7700 somehow failed some other steps in my local tests and I gave
>> up digging further X-<.  One step at a time...
>
> Hopefully not my bits. :) FWIW, the tips of "master", "next", and "seen"
> all pass just fine for me (minus this race on seen).

Not your bits.  What I am pushing out on 'seen' now has a few topics
excluded to avoid CI breakages, reproducible or flaky.

Thanks.
