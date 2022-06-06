Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37C8C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiFFRmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiFFRmB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:42:01 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787852FA609
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:41:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A791412E85F;
        Mon,  6 Jun 2022 13:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AhqmuHArjcUPixsirCgD3DT3nAeKN/9HOSeWBm
        Hnftg=; b=rABfjGm6C77RRN63ljprPbd4K9gXjw+pgO5jbM4qZpOl6hzK/xGWVz
        c/dC9NTACnUfc5qyxLF6yrOnpGcqnKD6St+Tm/QE1egKExSoj2aUuIbP+0F+QuZD
        J+B4HYeTu+AQ9j1C8dibNB+OEZ0BztltPEHhczn8gMhkPxoqLWNGg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DC2012E85E;
        Mon,  6 Jun 2022 13:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05C3C12E85D;
        Mon,  6 Jun 2022 13:41:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v5] git-prompt: make colourization consistent
References: <20220604161333.54627-1-joak-pet@online.no>
        <20220604192606.176023-1-joak-pet@online.no>
        <xmqqzgipah7n.fsf@gitster.g>
        <592c0133-d6f3-3376-0fe7-3633f3a91377@online.no>
Date:   Mon, 06 Jun 2022 10:41:56 -0700
In-Reply-To: <592c0133-d6f3-3376-0fe7-3633f3a91377@online.no> (Joakim
        Petersen's message of "Mon, 6 Jun 2022 19:31:31 +0200")
Message-ID: <xmqqleu98za3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F699EBF4-E5BF-11EC-AB8D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joakim Petersen <joak-pet@online.no> writes:

> On 06/06/2022 18:29, Junio C Hamano wrote:
>> Joakim Petersen <joak-pet@online.no> writes:
>>>   * If the local tree has new, untracked files and there is nothing in
>>>     the stash, both the '%' and the    short upstream state indicator
>> looong space?
>> 
>
> That is quite the long space indeed, I'll get that fixed.
>
>>> If the user is in a sparse checkout, the sparsity state indicator
>>> follows a similar pattern to the short upstream state indicator.
>>> However, clearing colour of the colourized indicators changes how the
>>> sparsity state indicator is colourized , as it currently inherits (and
>>> before the change referenced also inherited) the colour of the last
>>> short state indicator before it. Reading the commit message of the
>>> change that introduced the sparsity state indicator, afda36dbf3b
>>> (git-prompt: include sparsity state as well, 2020-06-21), it appears
>>> this colourization also was unintended, so clearing the colour for said
>>> indicator further increases consistency.
>> Here, after explaining how bad the current situation is, like the
>> above, is a good place to say what we do, i.e. "teach indicators to
>> clear after themselves".
>
> I'll add a clear statement of what this patch does as well.

I think you already have "Make the coloring of these ... consistent
by making ..." much earlier, and moving it here would be sufficient.

>> Nicely written.
>> Will queue.
>> Thanks.
>> 
> Alright, great!
