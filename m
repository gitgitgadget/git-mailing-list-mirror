Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410CEC433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 01:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E65C464E86
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 01:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhB0BxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 20:53:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58584 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhB0BxF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 20:53:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 918EBBBBB7;
        Fri, 26 Feb 2021 20:52:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MmVWg8SByTbtXNw4jEhlNIN/dYg=; b=hosGEG
        EQe8/FMREjk/VmXg9nhOyYCEhYJ0DCOcOuDNQNCuqBJFxTXTSx8B5XS2Mm1jXglL
        qfPm79YwPdR6E7wrlB1YE6DyYs636hruL6fIKGg77A521BIY4a60oMpA7K8oLDLD
        tSqHH9RwC1gCR8t1B4Np9MLpGYiWi0QVPQgJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d6vhe8Xt1A0ZwELxPVbyASZd9dWNxtp4
        pPBudo/Z+HBRuV3ksQYn+FJCQ+/zRnpAIQy5v3iai41nDjjLx1RiEDWl5tesMiyf
        iP/VjiC5gkEwoCB3SFZwEqLN9R1/nSc1cI4iftNpLRs00+nSJa5haid3asFk8xkQ
        x3XsBCd48GQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87E80BBBB5;
        Fri, 26 Feb 2021 20:52:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FD2DBBBB4;
        Fri, 26 Feb 2021 20:52:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, pudinha <rogi@skylittlesystem.org>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 0/1] mergetools/vimdiff: add vimdiff1 merge tool variant
References: <20210214022840.849312-1-seth@eseth.com>
        <b3467a47-dffd-154f-76f9-e09b8145a5e5@gmail.com>
        <YDhBAPbU/T8BldrS@ellen.lan> <xmqqh7lzshx6.fsf@gitster.g>
        <YDmFrd/zB4G93oHz@ellen.lan>
Date:   Fri, 26 Feb 2021 17:52:22 -0800
In-Reply-To: <YDmFrd/zB4G93oHz@ellen.lan> (Seth House's message of "Fri, 26
        Feb 2021 16:35:09 -0700")
Message-ID: <xmqqblc6qnu1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F34D794-789E-11EB-B4C6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> On Thu, Feb 25, 2021 at 06:04:53PM -0800, Junio C Hamano wrote:
>> Seth House <seth@eseth.com> writes:
>> > I'll roll those into this patch.
>> 
>> I'd rather see it as a completely separate patch.
>
> Ok, will do.
>
> Should I roll a v2 of this patch set to include David's tested-by tag
> even though there's no code changes?

I think that is exactly what we have on sh/mergetools-vimdiff1 topic
branch in 'next'.

    $ git fetch
    $ git show 'origin/next^{/^mergetools/vimdiff:}'

Thanks.

