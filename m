Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B725C4332F
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378506AbhK2SeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:34:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57867 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350754AbhK2ScA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:32:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01C2FEF444;
        Mon, 29 Nov 2021 13:28:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Tnk5AEuAi7Q/
        UFUYkwrHD84q97CDeWrWvkn/Lu8NYtw=; b=HwnzHefaQ/4S2X91x3NCa7geW+83
        zBvezAOywDJHp1dG7Hsu+RHggcpNjYueBSKGXbsT6apitoG6LqKHyx05J9KgXgLS
        VqiJHJqtRsh+/v0LyFEg54vFUyFd263UtmOY6VUJQ2WoMmIshcpB63da/JzGJCn+
        KPXgD/zjaqmSCp0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECBCFEF443;
        Mon, 29 Nov 2021 13:28:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 595E5EF442;
        Mon, 29 Nov 2021 13:28:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] test-lib.sh: set GIT_TRACE2_EVENT_NESTING
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
        <3d1bbc91aa3a465ecec2de130456b9ccc08f3032.1638193666.git.gitgitgadget@gmail.com>
        <211129.86fsrff36j.gmgdl@evledraar.gmail.com>
Date:   Mon, 29 Nov 2021 10:28:39 -0800
In-Reply-To: <211129.86fsrff36j.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 29 Nov 2021 15:12:20 +0100")
Message-ID: <xmqqk0gq3jfs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2CDAD196-5142-11EC-A6B6-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Thanks for following up on this.
>
> Rather than hardcoding 100 wouldn't it make sense to have something lik=
e
> the below (which I barely checked for whether it compiled or not, just
> to check how hard it was to change), so that we can just set this to a
> "false" value to disable the nesting guard entirely?

I agree that could be a better endgame if it works.

That is where our agreement ends.  I strongly prefer to have a
small and focused fix for immediate problem at hand, and then a
fundamental "(could be) better" change separately, so that we can
cool the latter longer.

This difference between us is not limited to this topic.  I often
get irritated to see an attempt to jump to the endgame with too big
a change in a single step.  Please don't.

Thanks.
