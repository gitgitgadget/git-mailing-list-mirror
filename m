Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D208CC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF07061164
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 21:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbhIPVW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 17:22:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51262 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhIPVWv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 17:22:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FFBE150447;
        Thu, 16 Sep 2021 17:21:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4GAB7zZ1IsSpsfG7xUq5SsvQpyU6gWcrd7d6nB
        WmWKA=; b=I9rTenoeoGwkKkwikB9x1UAaEyaGH2d8eaJ5QDsyDINV7gg2EOW6eS
        n6QHnHvrk9M3UFwfY6f8S44y7fahvED4cy4IKiix1iWOideSheGluB58/1lqCmsw
        XUixvgA0Q80itVMkDAT+wMfahT6QBDPDYVdeglaUJLdkYK9M/Y1aU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2793B150446;
        Thu, 16 Sep 2021 17:21:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6092C150445;
        Thu, 16 Sep 2021 17:21:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     wesley@schwengle.net
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH] Document `rebase.forkpoint` in rebase man page
References: <c7949156-a7e5-085f-4779-82d0538a4d72@schwengle.net>
        <20210916124709.2824551-1-wesley@schwengle.net>
        <20210916124709.2824551-2-wesley@schwengle.net>
        <xmqqv930ttkr.fsf@gitster.g>
Date:   Thu, 16 Sep 2021 14:21:25 -0700
In-Reply-To: <xmqqv930ttkr.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        16 Sep 2021 08:43:00 -0700")
Message-ID: <xmqqtuikrzca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D8391F4-1734-11EC-ADD7-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> wesley@schwengle.net writes:
>
>> From: Wesley Schwengle <wesley@opperschaap.net>
>>
>> The option exists and the rebase behaviour tricked me into thinking
>> there was a bug with git. This will tell people how they can tweak the
>> default behavior.
>
> This tells readers about almost nothing but your frustration.
>
> We, or anybody who will be reading "git log" in 6 months to improve
> the system, will not need to hear it.  Instead we need to understand
>
> what the real problem is, what was wrong in the behaviour, or what
> the expected behaviour was and why the use of the feature was
> inappropriate in the particular case, without which it is impossible
> to understand why this sentence was added when a future developer
> and documenter tries to improve upon this text.

I misspke a bit here.  While hearing only your frustration and
nothing else won't help us much, we do need to understand what
caused your frustration, to avoid frustrating the next user the same
way.  All of the "Instead we need to understand ..." are about that.

> We often do:
>
>   "See also `rebase.forkpoint` in linkgit:git-config[1]."
>
> (for example, there is a reference to linkgit:githooks[5] in the
> same page).

One reason why you didn't find how to tweak the forkpoint feature,
other than giving a command line option to countermand it, is
because this link pointing at the list of configurations, where the
variable is already described, was missing in the doucmentation for
the "rebase" command.

Thanks.
