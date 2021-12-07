Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5F3C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 00:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350331AbhLGAJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 19:09:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62579 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhLGAJf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 19:09:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 529E717D67F;
        Mon,  6 Dec 2021 19:06:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8LyJGl0ApfENAbWeQi0MIS4WkGR54RTaGI9h+F
        QZep8=; b=kYJeXO0la48018Uko/q/+ISVhMgNrctzd0yTaAvwBXB3v4lLsm7Kvg
        BIdPy29co8Vzdns6IpHN3I9jEz8lU1xXyhuMPoVm107zWSToaGzMQyGg4GlzDjKG
        n3n5rRgl9kjAMSN3aQL+Lr8ATSsLTgSIe+ODUxnlOCf43TParrBPM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4ACCB17D67E;
        Mon,  6 Dec 2021 19:06:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4333817D67B;
        Mon,  6 Dec 2021 19:06:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Mahdi Hosseinzadeh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
Subject: Re: [PATCH] githubci: add a workflow for creating GitHub release notes
References: <pull.1146.git.git.1637840216877.gitgitgadget@gmail.com>
        <AM0PR04MB60196EFE984652ECCBD591A8A5629@AM0PR04MB6019.eurprd04.prod.outlook.com>
        <nycvar.QRO.7.76.6.2111261455590.63@tvgsbejvaqbjf.bet>
        <AM0PR04MB601972377B5CC2E24B6BA1DFA5639@AM0PR04MB6019.eurprd04.prod.outlook.com>
        <211129.86k0grf7lj.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111301239480.63@tvgsbejvaqbjf.bet>
        <xmqqy252u8t7.fsf@gitster.g> <20211203083334.tziwuhbg2u4lsslt@fs>
        <xmqqo85vonba.fsf@gitster.g> <20211205105441.vsgyef3njcggbzku@fs>
Date:   Mon, 06 Dec 2021 16:05:59 -0800
In-Reply-To: <20211205105441.vsgyef3njcggbzku@fs> (Fabian Stelzer's message of
        "Sun, 5 Dec 2021 11:54:41 +0100")
Message-ID: <xmqqwnkhb7o8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7643795A-56F1-11EC-BBD7-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> Still, if this gets added to git/git I think the risk of users
> considering the github release to be the primary source is quite high
> since lots of tools and CI integrations use them.

That's a bit of downside.  I guess not using this patch then would
make our life simpler, then.
