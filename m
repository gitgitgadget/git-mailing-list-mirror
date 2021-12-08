Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56F0C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 22:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhLHW3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 17:29:30 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52628 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLHW33 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 17:29:29 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C76A9F390B;
        Wed,  8 Dec 2021 17:25:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wIA6jZSiccYkF8QnFOgVZR/HVfrTA+KKVJEIUh
        /fus0=; b=H12iHDDLsSwkdAkBfcgxqt4mVXHlKS6rLZ8y3wpHn5duUwo2HVeXvB
        t+Hb9/l7ecCAdTEZ7urLgB7PSda5vuaaTJ70N7X0WDEMzXYJpLrQyS0MNSI1quQf
        nBSNoTUxXsI/cGmShAeV6v6HEIRA6bFh2RKnIT+L7BV2x2orpmU28=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B973FF390A;
        Wed,  8 Dec 2021 17:25:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0494DF3909;
        Wed,  8 Dec 2021 17:25:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
        <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
        <YbEpE7UI+ovnNQyj@coredump.intra.peff.net>
Date:   Wed, 08 Dec 2021 14:25:54 -0800
In-Reply-To: <YbEpE7UI+ovnNQyj@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Dec 2021 16:52:19 -0500")
Message-ID: <xmqqczm6ybrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFAF94A8-5875-11EC-8F50-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For diff-highlight in particular, you need to have a working perl, so
> you'd probably want to at least wrap it with a NO_PERL ifndef. For
> mw-to-git, you need to have MediaWiki::API installed, though I think the
> tests at least notice this and skip everything if you don't.

I know I locally lack MediaWiki::API and saw the test skipped
everything.  I do not know that would be true on a box without any
perl, though.
