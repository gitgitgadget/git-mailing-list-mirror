Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C5CC25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 21:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiHTVWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 17:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTVV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 17:21:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083F40E2F
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 14:21:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6DF21304AF;
        Sat, 20 Aug 2022 17:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JFPQIJXpzlfMMPOKMNF3XMNNn7KDvH3Xodm3SF
        MZtaU=; b=lMFoSkXQ6/uqbWioMSRLwK3HFJp1wWi5APVyP3kTOoFC1EmcFZyLLF
        P52uWJriIpa1KKXcxV3zf9Hci8ddr/yInBRvD0VsnTVMM5j2sBwahBw0kBWjrhQI
        7sfZc6xsT/M/g/1ivxedVSYM1qL8zMaTT+BAiK7zF24p4p+3I8QG0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE5F71304AE;
        Sat, 20 Aug 2022 17:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E05B1304AD;
        Sat, 20 Aug 2022 17:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/11] annotating unused function parameters
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
        <220819.861qtc8gug.gmgdl@evledraar.gmail.com>
        <c22a8317-7d43-d84b-f63f-df2da31b4658@github.com>
        <220819.868rnk54ju.gmgdl@evledraar.gmail.com>
        <YwCtkwjWdJVHHZV0@coredump.intra.peff.net>
Date:   Sat, 20 Aug 2022 14:21:53 -0700
In-Reply-To: <YwCtkwjWdJVHHZV0@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 20 Aug 2022 05:46:59 -0400")
Message-ID: <xmqqzgfyhaq6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D1164A8-20CE-11ED-BDF3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Likewise, one thing I like about the renaming is that it fails
> compilation regardless of -Werror.

Yes, I like that aspect of the macro very much.

> And finally, I actually prefer the parentheses of:
>
>   static int register_ref(const char *refname, const struct object_id *oid,
> 			  int UNUSED(flags), void *UNUSED(cb_data))

That, too.

> So I dunno. These are all matters of opinion, and if it was just my
> patches, I'd say my taste wins. But all of us are going to have to write
> these annotations at some time or another when we add callbacks, etc. So
> we should at the very least pick a syntax the majority prefers. :)

Well, we can teach others a good taste ;-)
