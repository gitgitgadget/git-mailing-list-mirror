Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98244C2BA12
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 21:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjIPVtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIPVtY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 17:49:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73F51B2
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 14:49:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D790F35AD3;
        Sat, 16 Sep 2023 17:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=OzB6G0KuK5UppOWCtG/qlYn7CjkEwZl3EkyIz1
        e7UiQ=; b=fsuKYTrrL/HPLpH4G1LVOBEjJ4wx3gYZtyH6bm/HzFsM3jJcprMtKi
        FS80wtNONoTKBScMNmlqJPmg0vaycMKK87jah7MLx09KVmLYwmoHZL2wOOzDj8Jc
        l1h+MWGe9+7HDI6lh52MYwORg1BD4rJJbNdQpCqvgDcYgp45k+VVg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CFD6635AD1;
        Sat, 16 Sep 2023 17:49:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E13035AD0;
        Sat, 16 Sep 2023 17:49:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/4] merge-ort: lowercase a few error messages
In-Reply-To: <20230916072909.GA992098@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 16 Sep 2023 03:29:09 -0400")
References: <20230914093409.GA2254811@coredump.intra.peff.net>
        <20230916060059.GA498798@coredump.intra.peff.net>
        <20230916072909.GA992098@coredump.intra.peff.net>
Date:   Sat, 16 Sep 2023 14:49:12 -0700
Message-ID: <xmqq34zdbxgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E08DB044-54DA-11EE-812F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Sep 16, 2023 at 02:01:00AM -0400, Jeff King wrote:
>
>> Here's one more clean-up on top. I hesitated on this for the initial
>> send just because I didn't know if we might want to switch these error
>> messages to path_msg(), which does capitalize sometimes. But Elijah's
>> response convinced me that we should just leave them in place, in which
>> case it makes sense to do a minimal style fixup.
>> 
>> Junio, this is on top of what you've queued in
>> jk/ort-unused-parameter-cleanups.
>> 
>> -- >8 --
>> Subject: [PATCH] merge-ort: lowercase a few error messages
>> 
>> As noted in CodingGuidelines, error messages should not be capitalized.
>> Fix up a few of these that were copied verbatim from merge-recursive to
>> match our modern style.
>
> <sigh> This fails CI because with GIT_TEST_MERGE_ALGORITHM=recursive, we
> run the old merge-recursive code, which uses the capitalized version.
>
> I'm inclined to just drop this minor cleanup for now, and we can worry
> about it later once merge-recursive goes the way of the dodo.

I wonder if it is just the matter of making matching changes to the
original error messages in merge-recursive that share the
capitalized version?
