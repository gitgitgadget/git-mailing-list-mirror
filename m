Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFB3C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 03:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhLID4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 22:56:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59713 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhLID4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 22:56:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EA89EE8A9;
        Wed,  8 Dec 2021 22:52:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=yNEHAU2MYZfPOepkAYGekU5ZBTgqJ2VsMdu3H/8eH8s=; b=yf66
        PWhv1iUS9HqNE7B8ZSkug/LBQxe2m7DYijBOrKUOPk5PuUM/ccnsTD9RWkIo9AA0
        OqcGfY6etz8RrC7ul4nFOSfAXYRzQO2CaUjUNKxlQf6vIWcJf5Yxe7YIPC+jIFtH
        D4MnM9I8vMufkpid6KSrTRN00/Ei27pJaGcBgis=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25E25EE8A8;
        Wed,  8 Dec 2021 22:52:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82515EE8A7;
        Wed,  8 Dec 2021 22:52:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2112081207320.90@tvgsbejvaqbjf.bet>
Date:   Wed, 08 Dec 2021 19:52:37 -0800
Message-ID: <xmqq8rwuv3i2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73B0A948-58A3-11EC-9068-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The Scalar Functional Tests were designed with Azure Repos in mind, i.e.
> they specifically verify that the `gvfs-helper` (emulating Partial Clone
> using the predecessor of Partial Clone, the GVFS protocol) manages to
> access the repositories in the intended way.
> ...
> I do realize, though, that clarity of intention has been missing from this
> mail thread all around, so let me ask point blank: Junio, do you want me
> to include upstreaming `gvfs-helper` in the overall Scalar plan?

Sorry, I do not follow.

What I was lamenting about was the lack of CI test coverage of stuff
that is already being considered to go 'next'.  Specifically, since
contrib/scalar/Makefile in 'seen' has a 'test' target, it would be a
shame not to exercise it, when we should be able to do so in the CI
fairly easily.

I fail to see what gvfs-helper has to do with anything in the
context of advancing the js/scalar topic as we have today.  If "The
Scalar Functional Tests" that were designed with Azure Repos in mind
is not a good fit to come into contrib/scalar/, it is fine not to
have it here---lack of it would not make the test target you have in
contrib/scalar/Makefile any less valuable, I would think.

Unless you are saying that "make -C contrib/scalar test" is useless,
that is.  But I do not think that is the case.



