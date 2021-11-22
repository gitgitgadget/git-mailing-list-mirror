Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F2FC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 07:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhKVHJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 02:09:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63568 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhKVHJX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 02:09:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7B93EF631;
        Mon, 22 Nov 2021 02:06:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=ijTw9jrNt8/RPh5wezOALLzhd
        DVwuvVFbHJNnV6PzDI=; b=miN2P0B+NTfjs8HsqNJdt7ggoTdBeK517PlXR7dm0
        GYQw1KGs86h1WhFs8OI1Y4Yt4qHdbfgAiM8XP0/6gI3Q9zgv+vKOfn8bOOAXgGQb
        UBTiGuXM9gCziGNydNf92Ohzh8W7RB//zZkMonpSpZ/lebjAxcsujsF8OhNJ8sGJ
        NQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91516EF62F;
        Mon, 22 Nov 2021 02:06:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF1C4EF62E;
        Mon, 22 Nov 2021 02:06:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v8 2/2] am: support --empty=<option> to handle empty
 patches
References: <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
        <pull.1076.v8.git.1637563611.gitgitgadget@gmail.com>
        <3ff18e16a7a24fdd8c57b40960e0d6b95c2490e6.1637563611.git.gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 23:06:14 -0800
Message-ID: <xmqqbl2ck6u1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AF341390-4B62-11EC-BD9B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Aleen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Aleen <aleen42@vip.qq.com>
>
> Since that the command 'git-format-patch' can include patches of
> commits that emit no changes, the 'git-am' command should also
> support an option, named as '--empty', to specify how to handle
> those empty patches. In this commit, we have implemented three
> valid options ('die', 'drop' and 'keep').
>
> Signed-off-by: Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <aleen42@vip.qq.com>

Perhaps this line should imitate what Hans Krentel did in
https://lore.kernel.org/git/pull.1143.git.git.1637347813367.gitgitgadget@=
gmail.com/,
i.e. real name first, and then (nickname) in parentheses.

Also, the in-body "From:" line should match the sign off.

I corrected what has been queued in 'seen' manually when I applied
the previous round.

> +--empty=3D(die|drop|keep)::

This is the only change relative to what is queued (we had
"--empty-commit", which is remnant from an earlier iteration), and
it makes the documentation consistent with what the code does.

Good.
