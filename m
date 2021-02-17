Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B8AC433E6
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D18364E6C
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhBQVXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:23:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65507 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhBQVXA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:23:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 935F2A81E2;
        Wed, 17 Feb 2021 16:22:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UdQgRnbR5tZY
        z8YMW4527YGrhJk=; b=cupnAXNgHM0QQKCl/aZk+OfeM/NB8k9/eBKLqdw1EK2d
        kAmXdHVZNBfmn6irruucJZqgPflCitFRpAh0+y6KWqJMzFTYAwVd33s3SPuI6BYz
        yDi/4IGuf6psOIe81A0W1ByuxjNkpBhZPmMKBx+t5WbBUdVrHU1R/fR0JxysFBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CE+xfc
        SHexhPz3v6+Myzm4Am6/aTyw/dKiJY3S1C5nWMeQB72W/zh15CMKrjSAS6QYjGb5
        AhGaIxRvE/15ia7Ewbe/zmAtkZEhZhvH5PtXoAYXQtrTOWOCYLSaYB387sphARDg
        CNWv6IEN8WOrNyNDrHEti1cSZmevHEDgVgfck=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B3E0A81E1;
        Wed, 17 Feb 2021 16:22:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18714A81E0;
        Wed, 17 Feb 2021 16:22:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/3] fix some doc rendering issues since v2.30.0
References: <cover.1613590761.git.martin.agren@gmail.com>
Date:   Wed, 17 Feb 2021 13:22:10 -0800
In-Reply-To: <cover.1613590761.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Wed, 17 Feb 2021 20:56:03 +0100")
Message-ID: <xmqqeehejsot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3267FDB2-7166-11EB-9E43-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> These three patches fix some rendering issues I came across in the
> output of
>
>   ./doc-diff v2.30.0 master
>
> The original topics are so/log-diff-merge, ps/config-env-pairs and
> ab/mailmap.
>
> Martin =C3=85gren (3):
>   rev-list-options.txt: fix rendering of bonus paragraph
>   git.txt: fix monospace rendering
>   gitmailmap.txt: fix rendering of e-mail addresses
>
>  Documentation/git.txt              | 2 +-
>  Documentation/gitmailmap.txt       | 8 ++++----
>  Documentation/rev-list-options.txt | 6 +++---
>  3 files changed, 8 insertions(+), 8 deletions(-)

All of them look "obviously correct".  Thanks.
