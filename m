Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AD4C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D62760F02
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhJ2Up2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:45:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60706 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhJ2Up1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:45:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8E7116B1DA;
        Fri, 29 Oct 2021 16:42:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Pf2bORcxPUhe+vZexvZEaPftrJJLZlFelXXVq
        sebyY=; b=NfOXJqhK68ZFDx1F3NIoekdGMSm1aQkwdp6Pb0dRKs5oSP4iLmzz3W
        BqZKaPFq7+9udEvXFXH1n600SNxxg7EdxWRLEWPzAha6krzwrkQmX3tGGtIq3n9I
        Q9QpEWn43t63ByVi8fDGQPnKnKiHKyVykBUih2hPztJdnnjCgm1mo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C21B016B1D9;
        Fri, 29 Oct 2021 16:42:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7F9A316B1D5;
        Fri, 29 Oct 2021 16:42:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: disable fsync everywhere
References: <20211028002102.19384-1-e@80x24.org>
        <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
        <20211028182824.GA1307@dcvr> <xmqqilxhq774.fsf@gitster.g>
        <20211029001552.GA29647@dcvr>
        <YXxa3i3gXsutG4Cx@coredump.intra.peff.net>
Date:   Fri, 29 Oct 2021 13:42:54 -0700
In-Reply-To: <YXxa3i3gXsutG4Cx@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 29 Oct 2021 16:34:38 -0400")
Message-ID: <xmqqo877k1f5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB4B615E-38F8-11EC-9CD5-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Again, not really an objection, but I don't think this replaces the
> "you're better off running the test suite on a RAM disk" wisdom.

Nice summary.  This was sold as "not everybody has ready access to
tmpfs", so those of us who can use either should stick to our tmpfs
as we have done so far.

