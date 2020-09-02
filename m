Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A2FC433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB212083B
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xh8osMlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgIBUuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:50:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51343 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBUuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 16:50:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C712F6B3C9;
        Wed,  2 Sep 2020 16:50:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UNJda4l2CxW/GWP98ihBDFT8Vbg=; b=Xh8osM
        lg4h4uo/FhWEA5Xsa+51lDH6AUIaboRWn12g63CzH8XdfStatqftsiSN0G+G2kso
        RGBJd7pSQtv+RgJhlbCUsiid2s799oBYKDuKQa/7gqAKQWmm4V+DLTZT+IHaPifq
        FMPuSTmYqo9AK2P5+HkPhTieb7B0by6kZ+FSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wu99geA+J3j2Tv63P9zxDEQsEqr1v9oc
        hPHijiH1B3nnJvCFBAxycLpgTJW5/m8oG+F+QuA6BfX7qD3Z28g0uSY4CQ61x1DZ
        CO0mxOpuR/rhJ0E57seU2YBC3/Qfh2l+FThLq3JX7hvqYbEElXVFr+5SxIMmnvia
        D3rDsZIcIdY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABB0D6B3C8;
        Wed,  2 Sep 2020 16:50:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CAE256B3C0;
        Wed,  2 Sep 2020 16:50:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ci: stop linking built-ins to the dashed versions
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>
        <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com>
        <20200825134714.GC25052@szeder.dev>
        <xmqq364a3f6r.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2008260615280.56@tvgsbejvaqbjf.bet>
        <xmqq5z95xu5f.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009020902080.56@tvgsbejvaqbjf.bet>
Date:   Wed, 02 Sep 2020 13:50:00 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009020902080.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 2 Sep 2020 09:06:10 +0200 (CEST)")
Message-ID: <xmqqwo1baop3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFAB5E84-ED5D-11EA-8B71-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> What this patch does is simply to complete the mission of e4597aae6590
> (run test suite without dashed git-commands in PATH, 2009-12-02): to make
> sure that our very own scripts do not use dashed invocations of built-in
> commands.

OK, then I totally misread the proposed log message, or the proposed
log message didn't adequately describe what it was trying to solve.

With e4597aae (run test suite without dashed git-commands in PATH,
2009-12-02), we should not need git-foo in bin-wrappers/ for most of
git subcommands, as long as our tests and scripted porcelains the
test invokes never use the dashed form.  And with this step, we come
closer to that goal?

"git checkout next && make test" does not seem to populate anything
extra in bin-wrappers but bare minimum that needs due to the protocol
requirements, though, without this patch, so the above may not be
the whole story.

Apparently, the patch does not achieve this goal.

    For that reason, we just introduced a Makefile knob to skip linking
    them. TO make sure that this keeps working, teach the CI
    (and PR) builds to skip generating those hard-links.

because what matters to tests, when run without with-dash, which is
the sensible modern default, is what is in bin-wrappers/ and we do
not populate it with builtin git-add... at all even before this
step.  In other words, this change has no way to make sure "skip
linking them" will keep working more than what we already have.

Rather,

    Since e4597aae6590, we stopped running our tests with "git-foo"
    binaries found at the top-level of a freshly built source tree;
    instead we have placed only "git" and selected "git-foo"
    commands that must be on $PATH in bin-wrappers/ and they were
    what used by the tests.  This is to catch the tests and scripted
    Porcelains that are tested will get caught if they try to use
    the dashed form.

    Since CI jobs will not install the built Git to anywhere, and
    the links we make at the top-level of the source tree for
    "git-add" and friends are not even used during tests, they are
    pure waste of resources these days.

    Thanks to the newly invented SKIP_DASHED_BUILT_INS knob, we can
    now skip creating these links in the source tree.  Do so.

or something along the line, perhaps.

Thanks.
