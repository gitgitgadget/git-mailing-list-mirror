Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81723C433E0
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B83764E11
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhAaUvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:51:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51579 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhAaUvR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 15:51:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABBADB1D5F;
        Sun, 31 Jan 2021 15:50:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zwy2KOH1tG8KnIXwuRhLOH7kW2w=; b=JHpAmA
        2JOvT13hq9L43OA/Ld5lBjLGJluxD2GvACW4923w4FFK0xzU8UmEfLcqlTOYCv7r
        Mtc+CurIzKVw/VDHnRKl+SimO5ST17FgjDQnJPL4Xijo+2jZ7u9gdiLz4mstV72S
        lPb33SNFFVCCLfKG3c4R6YMOvtz+yUFEyT6q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rjDuH0DatEVbr+nVV3xKCVGjzXyOzUzk
        xF8gKtZJv7/ZiYgolqx9bjxw5ycfAWl5r1PMV/tbiZxW7YtAywIu/JIN6fNvheGP
        BTx0CO4XrVUbJNRjAR7fJ0Mh+QriKVtrA2VqPfKzeEtQ59k2zuGwo0eslKKfzDkv
        J5aqcRMpQBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4BA7B1D5D;
        Sun, 31 Jan 2021 15:50:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E1F6B1D5C;
        Sun, 31 Jan 2021 15:50:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
        <YBYK/B9G30ro+mF+@nand.local>
Date:   Sun, 31 Jan 2021 12:50:33 -0800
In-Reply-To: <YBYK/B9G30ro+mF+@nand.local> (Taylor Blau's message of "Sat, 30
        Jan 2021 20:42:20 -0500")
Message-ID: <xmqqbld4omp2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6C5A268-6405-11EB-B285-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Sat, Jan 30, 2021 at 04:00:56PM -0800, Junio C Hamano wrote:
>> * tb/geometric-repack (2021-01-20) 10 commits
>>
>>  Expecting further work.
>
> I think [1, 2] provide a good update of the alternatives considered.
> I.e., that concatting the packs together is easy but likely produces
> poor results, but reachability traversals are hard if you want to stop
> early.
>
> I'll work on both and see which ends up cleaner and send that to the
> list, probably this next week.
>
> [1]: https://lore.kernel.org/git/YBSSBviXOL8rM3Ao@nand.local/
> [2]: https://lore.kernel.org/git/YBSaHHKV5ncjjJum@nand.local/
>
>> * tb/pack-revindex-on-disk (2021-01-28) 10 commits
>>
>>  Looking good.
>
> Just double checking that you aren't expecting a re-roll of this (and if
> you are, that's fine, too). Peff reviewed v3 in depth and left a few
> comments, the result of which is a replacement for the final patch [3].
>
> FWIW, he said that v3 (with the replacement for 10/10) looked good.
>
> [3]: https://lore.kernel.org/git/YBNlkvrxvAYrLeMc@nand.local/

I was planning to give the series a quick re-read myself before
marking the topic as mergeable as-is, but I was also not planning to
merge too hastily just in case some updates came in the meantime.
