Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B349C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 18:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358691AbiDTSsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 14:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350681AbiDTSss (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 14:48:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBCE43ED3
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 11:46:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23D6E184049;
        Wed, 20 Apr 2022 14:46:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1xsSx2PWNJbA
        BIHNeukgo/LuDoYXi+ZkWKLku9ZPEUU=; b=a4z5WKGb/iQWwJR9ATJqvjCWazG2
        nIS74n3URHG66u/T1dWS91m8NLL67/Q3jLPwWe7H+Ru621bLv9C5Mh4IYewR36dD
        Wz+/Rh0VAbYjMUQFmV54g/PuJPhda7wF9ihHIv3Z4RGVV/pic2UnFZ53cplic43w
        /wQn0LnKh+4d+xg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1A69D184048;
        Wed, 20 Apr 2022 14:46:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B4B29184047;
        Wed, 20 Apr 2022 14:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 30/31] CI: have osx-gcc use gcc, not clang
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
        <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
        <patch-v4-30.31-94abb826627-20220418T132809Z-avarab@gmail.com>
        <55271bbe-7b6e-7c92-7337-2439a2f5be26@talktalk.net>
        <xmqqh76orx3v.fsf@gitster.g>
        <52382f7c-5b6a-63b6-2eb2-26c12f31f529@gmail.com>
Date:   Wed, 20 Apr 2022 11:45:52 -0700
In-Reply-To: <52382f7c-5b6a-63b6-2eb2-26c12f31f529@gmail.com> (Phillip Wood's
        message of "Wed, 20 Apr 2022 11:11:09 +0100")
Message-ID: <xmqqr15rpp9b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1B733490-C0DA-11EC-A932-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... There is a complication though in that Dscho's series
> adds github markup to the build output and this series separates the
> build from the tests which means that is not necessary. I think it
> should be easy enough to change Dscho's series so it only uses github
> markup for the tests which is the main improvement and just wait for
> the build and tests to be separated in this series (ideally they'd be
> a short easy to review series that did just that).

OK, Dscho, =C3=86var, does that sound like a workable plan?  See a reroll
of Dscho's series (which Phillip considers "should be easy enough")
first, get it solid enough and merge down to 'next', and then see
the refactoring by =C3=86var on top, hopefully with a minumum churn that
makes it impossible for people to review?

Thanks, all.
