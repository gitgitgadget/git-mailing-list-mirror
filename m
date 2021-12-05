Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534BAC433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 01:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhLEB2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 20:28:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57894 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhLEB2m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 20:28:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D4F2FD519;
        Sat,  4 Dec 2021 20:25:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tbv6j9PsyEktZmN0lA+5+iCbB5iEbLe8KF6L18
        I3uuw=; b=Ca90FF5PO2uOjcWwA4AhZXAGUIKyt/ZmFvn0Zc5YMFDr7e8Zq06mri
        OM4mJvX0KaWzQgnWaqNGA3y7ldXJ9pr/rSjyna7kGZCtBIm6wLnMIPgxWIHF+lqw
        871FewDQ+PJmBRKnhpN7NvUlry76et/o7SFt3kRi2Y6DZN56+Iits=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2134FFD518;
        Sat,  4 Dec 2021 20:25:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F749FD517;
        Sat,  4 Dec 2021 20:25:14 -0500 (EST)
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
Date:   Sat, 04 Dec 2021 17:25:13 -0800
In-Reply-To: <20211203083334.tziwuhbg2u4lsslt@fs> (Fabian Stelzer's message of
        "Fri, 3 Dec 2021 09:33:34 +0100")
Message-ID: <xmqqo85vonba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3298CC60-556A-11EC-AABF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> One benefit that I see is that github offers APIs & Notifications
> around releases and lots of CI integration already exist for it. If my
> (non github) CI includes building the git source then i can easily
> trigger when upstream releases a new version. Just pulling the repo
> and watching for the tag works just as well of course.

Ahh, thanks.

If some sort of "push" notification is available only for "there is
a new release" but not for "there is a new tag", then I can sort of
see why having a "release" would be nice.  Listening to notifications
and acting on them is more pleasant than having to poll.

Do I understand what you said correctly?

