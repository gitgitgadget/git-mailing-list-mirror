Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B379AC433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 23:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbiBAXST (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 18:18:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54148 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiBAXSR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 18:18:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39CC3170D63;
        Tue,  1 Feb 2022 18:18:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7VW/BTEHwF/smRZO9t95XGcQX/apKtcCPlAXZT
        U+S/s=; b=aNstmQoL1geQETjsjRz0LRbi+5IvP/aVQ0poHQ8tcr7XD84l7/F7ek
        sBSjVvkp1vmKtauuWYhQ/qmENYVLW9rKXmTfGYU8VB3saPHeJdUJucC66lEHz/fL
        ANeZcBdGmLAErbgIGsW6kk5BGoOw2XPfjSRO4iEJ3w+edXKG7gviU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3336F170D62;
        Tue,  1 Feb 2022 18:18:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9CA9A170D60;
        Tue,  1 Feb 2022 18:18:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jerry Zhang <jerry@skydio.com>, git@vger.kernel.org
Subject: Re: [PATCH V3 1/2] patch-id: Fix antipatterns in tests
References: <20220131232529.8484-1-jerry@skydio.com>
        <20220131235218.27392-1-jerry@skydio.com>
        <d9275c31-7558-fc9c-9eb3-2a0cb81a8259@kdbg.org>
Date:   Tue, 01 Feb 2022 15:18:13 -0800
In-Reply-To: <d9275c31-7558-fc9c-9eb3-2a0cb81a8259@kdbg.org> (Johannes Sixt's
        message of "Tue, 1 Feb 2022 23:07:31 +0100")
Message-ID: <xmqqtudi9nwq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B2A3E3A-83B5-11EC-A0FF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>> +	calc_patch_id nonl <nonl &&
>> +	calc_patch_id withnl <withnl &&
>
> ... you could in fact just redirect the here-documents into these commands.

That was part of my original suggestion, and then I realized that
nonl and withnl may later be reused and rewrote it before sending my
review comment.


