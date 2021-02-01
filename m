Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A95C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 01:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B017564DCC
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 01:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhBABto (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 20:49:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51950 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhBABte (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 20:49:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B916B3B27;
        Sun, 31 Jan 2021 20:48:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2Wo0uY7vBvie
        2pCZkpTD8bZDhbo=; b=Rr0eGQQSmQKm7k0bG55RxC5xEQzIuNXXe/QQ2++cuDVF
        usTPWfavGm6xqxjtPhedJky2+S8DPYsc7T9UH9qpt4BASxfgKaWlo38tWRmZH4vJ
        YtQ1e04Wa/AKCagR8EVV5Ntt7+FfkxOlbOghaF1I8h9pJuxVHxtz2BHaHnpLggo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YiLunG
        wq2D5/XoSTg1Id3Y7RLxY/nkcibxHtBeaKrrWamSpl2FZBjnRrDn8DCreqvh4GtF
        x0S1pIGy4m6uPqY+qGcRcX1ax9G9wG46LY0QXSF9w81a8pFl/TxafaTuMvDmncDZ
        jhvErYuFPZTmCUVUJzRBYWqdUA2xpqAMWJLnA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DC36B3B26;
        Sun, 31 Jan 2021 20:48:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 948C9B3B25;
        Sun, 31 Jan 2021 20:48:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
        <87lfc8ocmt.fsf@evledraar.gmail.com>
Date:   Sun, 31 Jan 2021 17:48:50 -0800
In-Reply-To: <87lfc8ocmt.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 01 Feb 2021 01:27:54 +0100")
Message-ID: <xmqqy2g8mubh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A26DEA02-642F-11EB-ADF9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Jan 31 2021, Junio C Hamano wrote:
>
>
>> * ab/detox-gettext-tests (2021-01-21) 3 commits
>>  - tests: remove uses of GIT_TEST_GETTEXT_POISON=3Dfalse
>>  - tests: remove support for GIT_TEST_GETTEXT_POISON
>>  - ci: remove GETTEXT_POISON jobs
>>
>>  Get rid of "GETTEXT_POISON" support altogether, which may or may
>>  not be controversial.
>
> I'm waiting on SZEDER'S feedback on [1], ditto the last What's
> Cooking[2]. Also as noted in [2] the "do we keep GETTEXT_POISON at all"
> question.
>
> How about we just remove it and see if people who love it will come out
> of the woodworks, the patches aren't going to be hard to revert...

Yeah, why not ;-)

