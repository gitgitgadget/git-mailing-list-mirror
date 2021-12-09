Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33173C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 04:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhLIEGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 23:06:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56630 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhLIEGN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 23:06:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 463A9EEB07;
        Wed,  8 Dec 2021 23:02:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5NtujBKU3KSwgyzep54n69+aDIMwWVqfHHM7myUgSKI=; b=R9or
        ++wlpNKvbNOPiAJ37tHdclbeivBZVqPuzuulbnSQEcu+77OMU2G1t8thKp4WVPWA
        PeHf+UYM6gqrDSFIsPfthP7y++X7HNaFGzw0EeFKyYWABtpZ8FQgUxkAEuNo1LTa
        qWXO0BJ77TTkvUdk9lysXGVVN5ty0d6pX+uL1Zw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C93AEEB06;
        Wed,  8 Dec 2021 23:02:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8EA94EEB05;
        Wed,  8 Dec 2021 23:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v9 00/17] Upstreaming the Scalar command
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <211130.86mtlleqhm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111301450030.63@tvgsbejvaqbjf.bet>
        <xmqqtufs1a39.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2112021549330.63@tvgsbejvaqbjf.bet>
        <xmqq1r2vvszo.fsf@gitster.g>
        <CABPp-BGaHHUuQqvvDLBSaRG7C=SzS-ykOLi4HCdDDXQHgHjmJA@mail.gmail.com>
        <xmqq35navofg.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2112081217450.90@tvgsbejvaqbjf.bet>
Date:   Wed, 08 Dec 2021 20:02:37 -0800
Message-ID: <xmqq35n2v31e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D959FC6C-58A4-11EC-961D-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If I remember correctly, you mentioned quite a couple of times that you
> expect, particularly oldtimers on this list, to be mindful when
> contributing patch series, and to delay patches that would interfere with
> other patch series that are already in flight.
>
> I saw with sorrow that this rule was ignored a couple of times recently,
> even with new contributors, and I sincerely hope that we can unignore that
> rule again.

Sorry, but I am not sure what you are complaining about.

In general, I do try to ask more experienced and competent folks to
bear more burden when playing the role of a traffic coordinator, as
they are more capable of doing so to help the process.  

Relative importance and complexity of the topics also play a role,
so it is also possible that a more junior contributor may be asked
to yield for a more urgent or a less complex topic.

I would give strong preference to things that are already in 'next',
of course.  There has to be an extraordinary reason before we kick
something out of 'next', only to yield the way to allow another
topic to graduate first.

So, I am not sure if there is a need to unignore any rule here.

Thanks.

