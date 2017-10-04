Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961B32036B
	for <e@80x24.org>; Wed,  4 Oct 2017 03:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbdJDDAB (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 23:00:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57984 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750797AbdJDDAA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 23:00:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7826E94159;
        Tue,  3 Oct 2017 22:59:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WZmIFU3IyaDjY6ZmfFVBy2feAuM=; b=iBWzeT
        Ae4C6cym2GMczf4isE4P6dc1Jco9rfUWRR5YBxo0ao/AplcagfFLAJ4mEs7FEZqH
        vXeWJhnaRAf0h/wYWnxGB7ldj4+ttGWjyd73UQfHI4OL89uY/6gR2D/c95x7eH72
        txJLMGXJdbL6jyFsgPeACDww5XZ3ZMqz3Cj4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v+VFBj3zM0Xtf7CbYSq3iFD2jStv6WK7
        RJJTWrZu1RYgLfmOd2nzNsqWK4Sl7xR38jYAETs44qJ/zAasZ5AtUxT94nBs2UPv
        LhHUyMC145pLEA9MBUDAMwF2p55ExfsOxooImLPxn/AK77Lc/zHhHETD+XIsxc7Y
        4Vmz5f80cnQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F43794158;
        Tue,  3 Oct 2017 22:59:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D032094157;
        Tue,  3 Oct 2017 22:59:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
References: <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
        <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
        <20171003061515.72l35fpvcf63vsf6@sigill.intra.peff.net>
        <xmqqinfwiu5n.fsf@gitster.mtv.corp.google.com>
        <20171003071622.el6zqibfyrjc2mra@sigill.intra.peff.net>
        <xmqqefqkiq8v.fsf@gitster.mtv.corp.google.com>
        <20171003084506.lwmnrym4oyf66icz@sigill.intra.peff.net>
        <xmqq4lrgip7u.fsf@gitster.mtv.corp.google.com>
        <20171003091049.jb46pyi3obtwkzsa@sigill.intra.peff.net>
        <xmqqpoa4h5y7.fsf@gitster.mtv.corp.google.com>
        <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Date:   Wed, 04 Oct 2017 11:59:57 +0900
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 3 Oct 2017 09:37:13 -0400")
Message-ID: <xmqqr2ujfwia.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B975FBA-A8B0-11E7-8313-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's what I came up with on the "color.ui=always is nonsense that we
> should not offer" front. The number of patches may be a little daunting,
> but most of them are just removing cases of "git -c color.ui=always"
> from the tests.
>
>   [01/12]: test-terminal: set TERM=vt100
>   [02/12]: t4015: prefer --color to -c color.diff=always
>   [03/12]: t4015: use --color with --color-moved
>   [04/12]: t3701: use test-terminal to collect color output
>   [05/12]: t7508: use test_terminal for color output
>   [06/12]: t7502: use diff.noprefix for --verbose test
>   [07/12]: t6006: drop "always" color config tests
>   [08/12]: t3203: drop "always" color test
>   [09/12]: t7301: use test_terminal to check color
>   [10/12]: t3205: use --color instead of color.branch=always
>   [11/12]: provide --color option for all ref-filter users
>   [12/12]: color: make "always" the same as "auto" in config

I'm shuffling these so that everything except 03/12 and 09/12 goes
on top of jk/ref-filter-colors (to be merged later for v2.14.x) to
create jk/ui-color-always-to-auto-maint branch.

Another branch jk/ui-color-always-to-auto would fork from 'master'
and have 03/12 and 09/12 (with a tweak to use vt100 explicitly, as
we lack 01/12 at that point) applied, and then merge the above one.
And then queuing another one that drops "env TERM=vt100" tweak added
to 09/12 would bring us to the same state as applying your 12 patches
directly on top.  That will cook in 'next' down to 'master' to make
sure we do not regress in 2.15.

Thanks.
