Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25119C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 21:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiAGVCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 16:02:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59301 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiAGVCW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 16:02:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A99616DFBC;
        Fri,  7 Jan 2022 16:02:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vvj72Gdmqnj5+Oh8eu+pI7Tr33CvQVDkjGQ02I
        Mj5MA=; b=PE6r4mZXnM3afLeGHfCjR8c4LO2mwf0dVDTZZBl8eNwZLOLQEPGvVj
        1s9BEbhvTL/NS0Ygw4lLb889GPgne5b3Qwx0dogHXwWg1tw9XbNkMWSaXPgUxyaH
        /eRU+kJTQNTiRHre7B0sdNC8OW3XId/aohsuCj0YT19C5w+QwaKhQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 73ABE16DFBB;
        Fri,  7 Jan 2022 16:02:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E1B5716DFBA;
        Fri,  7 Jan 2022 16:02:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH V3] git-rev-list: add --first-parent-not flag
References: <20220105232755.23523-1-jerry@skydio.com>
        <xmqqpmp4bjni.fsf@gitster.g>
        <CAMKO5CsGJdDYvBsb8_-AkpAeeoVGY0Qhv4sX8TimJ4eqR=sLvA@mail.gmail.com>
Date:   Fri, 07 Jan 2022 13:02:18 -0800
In-Reply-To: <CAMKO5CsGJdDYvBsb8_-AkpAeeoVGY0Qhv4sX8TimJ4eqR=sLvA@mail.gmail.com>
        (Jerry Zhang's message of "Thu, 6 Jan 2022 19:51:48 -0800")
Message-ID: <xmqqiluv8dk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A3F0F0A-6FFD-11EC-86E0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

>> Assuming that propagating the UNINTERESTING bit only along the first
>> parent chain is a way to achieve some meaningful result (which, as I
>> said, I am not convinced about), I probably would call this option
>> "--exclude-first-parent-only" and explain it perhaps like so
>>
>>         Follow only the first-parent chain from commits given with a
>>         {caret} in front of them, to find commits to exclude.
>>
>>         This prevents commits merged from the side branches from
>>         becoming uninteresting and instead be shown if they are
>>         reachable from the positive end of the range.
>>
>> I am debating myself if the second paragraph is necessary, though.
>> I suspect that the first two-line paragraph may be sufficient.
> Sure, I'll update the patch and commit text with these changes.

OK.  Also the log message for the commit needs to be updated so that
those who read "git log" and find the commit for this change will
not have to ask the same question as I asked.

Thanks.
