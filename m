Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC9C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2828A6113E
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345036AbhIIUEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:04:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56894 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhIIUEB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 16:04:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E1ADDF3CB;
        Thu,  9 Sep 2021 16:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=jGiOXfhL/oX/EmUP2HAHvhL23
        DXfOgczjChsLmJ9zCs=; b=Ag/ZidXTPz2pFWuiOWbJE6BL6p0yWl1+/rottgW4N
        /5DHRJ4XD7rSllfOzDcbyDPFdlXpVphxY8y/l1GkaY4gTItnvsF//kAn4VWlityF
        XZbbOsiuJablQb0KI5sNx+xZB/unPAttYX5mKjt+kQ077wtvEJnYTDs23f9NyeCg
        TA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54FA8DF3CA;
        Thu,  9 Sep 2021 16:02:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8CA6DF3C9;
        Thu,  9 Sep 2021 16:02:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v4 0/2] progress.c API users: fix bogus counting
References: <cover-v3-0.2-00000000000-20210823T102722Z-avarab@gmail.com>
        <cover-v4-0.2-00000000000-20210909T010722Z-avarab@gmail.com>
Date:   Thu, 09 Sep 2021 13:02:50 -0700
Message-ID: <xmqqee9xy0t1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E95D6830-11A8-11EC-A2FD-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix bad uses of the progress.c API. See
> https://lore.kernel.org/git/cover-v3-0.2-00000000000-20210823T102722Z-a=
varab@gmail.com
> for the v3.
>
> This re-roll is on top of a merge conflict in v3 with 7a132c628e5
> (checkout: make delayed checkout respect --quiet and --no-progress,
> 2021-08-26), i.e. the mt/quiet-with-delayed-checkout topic.

Thanks, as that commit makes the call to progress code conditional,
with a new variable involved in the decision, it is understandable
that this needs to be adjusted for that newer codebase.

Very much appreciated.
