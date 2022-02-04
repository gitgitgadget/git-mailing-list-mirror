Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A108C433FE
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiBDVrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:47:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55744 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbiBDVrs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:47:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2C08FBC71;
        Fri,  4 Feb 2022 16:47:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FCFje4TVxivVR8Fvqc9We9FU8ddY6jsDvwkQuv
        IWuFA=; b=AGzLVuxS4fy0MuMvZBcAZ4ucTnJhZ3n9qvJfjtkZRaryTX7YD/knU0
        PFJOLRWc56vpv/51wj2roXVsq682qLHrpNHzlwtyhCSMexgG7WjOj7QrDBCfUkBj
        zXvWUuHgrH2D38harJc+tn3/qLjfgxs2PSF8sx50XeVSfODCQjdME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A6C51FBC70;
        Fri,  4 Feb 2022 16:47:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1AC1EFBC6F;
        Fri,  4 Feb 2022 16:47:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 0/3] completion: sparse-checkout updates
References: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
        <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
        <CABPp-BGM0xu=Hgd_uKevAbpCtxR9ZY5NX=PWNn2Bqw8SaOJvLQ@mail.gmail.com>
        <xmqq1r0io95u.fsf@gitster.g>
        <CABPp-BGN+rErYFmMbUwxcwSOvCQbJMzB43-VRtim7tXtkuKvCQ@mail.gmail.com>
        <xmqq4k5emmq2.fsf@gitster.g>
        <CABPp-BHgU3-VVt+OYfY77_ymPdFHbs8x1SMN_V9jfawDZ570Ng@mail.gmail.com>
Date:   Fri, 04 Feb 2022 13:47:45 -0800
In-Reply-To: <CABPp-BHgU3-VVt+OYfY77_ymPdFHbs8x1SMN_V9jfawDZ570Ng@mail.gmail.com>
        (Elijah Newren's message of "Fri, 4 Feb 2022 12:01:22 -0800")
Message-ID: <xmqq5ypul2wu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1758DC40-8604-11EC-9F2B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Handling them was specifically the job of the third patch in the
> series, and thus it made sense to add some kind of test for them.

Ah, yeah, reading from ls-tree via process substitution to avoid a
pipe that makes the loop a subshell and using "read -d$'\0'" with
IFS disabled to grok the -z output.  Full of bash-isms of the good
kind ;-).

Nicely done, and it deserves to be showed off in tests.


