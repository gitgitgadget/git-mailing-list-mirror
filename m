Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C7EC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 17:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhLASCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:02:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59890 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352104AbhLASBa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 13:01:30 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90E711719B4;
        Wed,  1 Dec 2021 12:58:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EDrjw3aNkPiQjBbLlKh6xkvxagO4AmoEpfnEui
        aDdpM=; b=u6PuDdBNXz9HLmOjTF1nZGesFQaedzwCfpB+0NudFCDZauqoxZdwOw
        7VyQQmlc6tOubLr5QIrdhFcJ1AfIHeE+txh6Qu4Gsh5N37nysRAm+e3+R1sqsYS7
        0gFbhh3OqKlyAuUPMuuVguAr3RA1fWHp52xgFLlsP54AUDzuVmFoY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8837B1719B3;
        Wed,  1 Dec 2021 12:58:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2B21A1719B1;
        Wed,  1 Dec 2021 12:58:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v9 00/17] Upstreaming the Scalar command
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <211130.86mtlleqhm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111301450030.63@tvgsbejvaqbjf.bet>
Date:   Wed, 01 Dec 2021 09:58:02 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2111301450030.63@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 30 Nov 2021 15:11:19 +0100 (CET)")
Message-ID: <xmqqtufs1a39.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B399B16-52D0-11EC-ADB8-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This patch series' focus is entirely on Scalar, on choosing sensible
> defaults and offering a delightful user experience around working with
> monorepos, and not about changing any existing paradigms for contrib/.

Sorry, but I am confused.

The change to add "make &&" before testing scalar is a good change
that allows CI to work with "existing paradigm for contrib/" that is
"you need to build the top before doing anything in contrib/".

But none of the contrib/ stuff is tested in the pedantic job, but if
I understand correctly, we start some (namely, scalar) stuff in it
tested there, deviating from existing practice.  Is that intended?
