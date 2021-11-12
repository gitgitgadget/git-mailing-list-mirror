Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEAFC433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D26C60F8F
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhKLQEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:04:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51632 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbhKLQEX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 11:04:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 148B9F8F19;
        Fri, 12 Nov 2021 11:01:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jHShF36QpKb64Zr9E6r2Dam9qwRFUazVj2Yr1B
        NL0AE=; b=EEZYb7n25G5Wi1m9LDu7a+P/GwDcceT4mx01t3nzyqURoZy43odv1o
        dvTOusTWsPooEc6WV3lhRF3qQxWOrCmHZ93wt3rBiFL1HsyFAfpCyeuBgTDq7nHh
        RPiCtKqRFsh3C0DKeIvHAroyc+IobdNnI21AZdbQXD5FnIY1ses/s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AEADF8F18;
        Fri, 12 Nov 2021 11:01:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6824AF8F17;
        Fri, 12 Nov 2021 11:01:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
        <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
        <20211104194619.GA12886@dinwoodie.org>
        <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet>
        <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com>
        <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet>
        <xmqqee7ozyx4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111101324020.21127@tvgsbejvaqbjf.bet>
        <CA+kUOanh1m=dkE-gDikg53zOPXx_7v65ggqxPspuZWDbdOrR=g@mail.gmail.com>
Date:   Fri, 12 Nov 2021 08:01:30 -0800
In-Reply-To: <CA+kUOanh1m=dkE-gDikg53zOPXx_7v65ggqxPspuZWDbdOrR=g@mail.gmail.com>
        (Adam Dinwoodie's message of "Fri, 12 Nov 2021 08:56:42 +0000")
Message-ID: <xmqqtughtlb9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD5FB466-43D1-11EC-B56D-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> I have just run the complete test suite on rc2, both with and without
> this patch, and I can confirm it resolves this problem and doesn't
> cause any other new test failures.

Thanks for a good news.

> But yes, the (lack of) speed of running the Git test suite on Cygwin
> is one of the reasons I run the tests on high-spec Azure VMs rather
> than my own systems. Unfortunately the Cygwin compatibility layer plus
> the overheads of NTFS mean things are unlikely to get significantly
> quicker any time soon, and between WSL and Git for Windows, I expect
> interest in improving Cygwin's performance is going to continue to
> wane.

Out of curiosity, are the use cases and user base of Cygwin waning,
or are there still viable cases where Cygwin is a more preferred
solution over WSL (the question is not limited to use of Git)?


