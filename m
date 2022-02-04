Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EEDC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiBDTyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 14:54:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61628 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiBDTye (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 14:54:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6F84D17429A;
        Fri,  4 Feb 2022 14:54:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DWGqhc7eL4AY
        RkXqHgEK500OQp8YR3aafSVdoFlVcIs=; b=DQesdA5KZ68q6GarxyWwtuFnJTYx
        wbNu/7zfRPePfjzaw/zqWzEbRoe05jzhIwFZzYl24L4zEouaT/UU9vkFXJpu8sO+
        D58juZITDhrNrnIC5oqo1H00XCTwPefPVUzvlGPu9V8v/lX1AqHd66Y6m0yO9sXG
        zVa515KsEI0E20s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 683FC174299;
        Fri,  4 Feb 2022 14:54:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C2628174293;
        Fri,  4 Feb 2022 14:54:30 -0500 (EST)
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
Date:   Fri, 04 Feb 2022 11:54:29 -0800
In-Reply-To: <CABPp-BGN+rErYFmMbUwxcwSOvCQbJMzB43-VRtim7tXtkuKvCQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 4 Feb 2022 09:55:57 -0800")
Message-ID: <xmqq4k5emmq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 446CA870-85F4-11EC-9F2B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> =C3=86var had a good comment about code coverage on Windows that we mig=
ht
> want to address first[1].  (Namely, splitting one test into two -- one
> that tests a path with backslashes that can be skipped on windows, and
> a separate test that checks paths with spaces, tabs, and non-ascii
> that can be run on all platforms.)

According to the lazy-prereq definition for FUNNYNAMES, we seem to
skip tab-embedded names on windows, so it may not be used on all
platforms, but such a detail aside...

I do not get why funny letters should matter and need to be tested
specially in the first place, to be honest, but because we have with
FUNNYNAMES prereq already, hiding some tests behind it would be a
good idea regardless.

> But other than that, yeah, this should be ready for 'next'.
>
> [1] https://lore.kernel.org/git/220204.86h79f45nf.gmgdl@evledraar.gmail=
.com/

Thanks.
