Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00A5C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbhK3VTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:19:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56935 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343966AbhK3VTC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:19:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 426F1F0B04;
        Tue, 30 Nov 2021 16:15:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yxB5DifSYHFS
        2gS4mPTo+dPZq75kgqXm5l0hscsczAU=; b=L2C6ow4C3XAqpW4z8u1t3Ztnj2/U
        PCDAgWkibmLeYsRnQP5r7XouOXoiqCRrtpNtGM/dc4DWcDKjzwZdBVKOGaufIRGS
        X+xGnabqZfOaZ5HETWiUmCwNG8Rst0A74ai1038lP1AU2oH/wAcOY2pVNzirK0TX
        llwuvVhiKDcUdAI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 399F3F0B03;
        Tue, 30 Nov 2021 16:15:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82E6DF0B01;
        Tue, 30 Nov 2021 16:15:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Slavica =?utf-8?B?xJB1a2nEhw==?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Use the built-in implementation of the interactive
 add command by default
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 13:15:40 -0800
In-Reply-To: <pull.1087.git.1638281655.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 30 Nov 2021 14:14:13
        +0000")
Message-ID: <xmqqy2551h1f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC598260-5222-11EC-880F-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Over two years ago, Slavica =C4=90uki=C4=87 participated in the Outreac=
hy project,
> starting to implement a built-in version of the interactive git add com=
mand.
> A little over a year ago, Git turned on that mode whenever users were
> running with feature.experimental =3D true.
>
> It is time to declare this implementation robust, to use it by default,=
 and
> to start deprecating the scripted implementation.

Yes, it is time to use it by default to expose any remaining bugs
that those with feature.experimental set failed to catch.
Unfortunately, we do not catch issues real users would encounter in
any "opt-in" feature, until it becomes "opt-out" and unconfigured
users are exposed to it.  This is true even in the presense of large
corporations that expose their internal users to versions based on
'next' regularly.
