Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D9FC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 19:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EB260FDA
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 19:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbhIAT7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 15:59:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50140 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241380AbhIAT70 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 15:59:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B0F2150259;
        Wed,  1 Sep 2021 15:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5RgVO6a6tWlU1H5wdZdOy55174D7Qpy8VKEEYf
        dz3mo=; b=xhPJIXsjb6QWNmu/Sb3cm6z4Avqpak1WV/168Dfk7hpSm31OTqu+2A
        hWDF/pfbi3nH+Jck6wt7eWP4aW3KdmFRjnlJJkGmjz/MPMn+32oo1E8VZ+OgWmEg
        Fx4k6Q5LdEiuNivTRSnLpRS2cAdvNEcu7ZoJ9Fu+oWRz1SWJcFRFs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 53AA2150258;
        Wed,  1 Sep 2021 15:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 95F3C150257;
        Wed,  1 Sep 2021 15:58:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 0/7] Speed up mirror-fetches with many refs
References: <cover.1629452412.git.ps@pks.im> <cover.1630501732.git.ps@pks.im>
Date:   Wed, 01 Sep 2021 12:58:19 -0700
In-Reply-To: <cover.1630501732.git.ps@pks.im> (Patrick Steinhardt's message of
        "Wed, 1 Sep 2021 15:09:36 +0200")
Message-ID: <xmqqwno0oyp0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F58F8DF4-0B5E-11EC-981E-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> There's only some smallish changes based on Stolee's feedback (thanks
> for that!):
>
>     - A small typo in 1/7.
>
>     - A confict fix in 4/7 required now because it's based on master
>       instead of directly on my merged topic.
>
>     - I've adjusted patch 5/7 such that I don't have to re-touch the
>       logic in 6/7.

OK, as a sanity check on my end, I've tried to apply this on master
and then to merge the result with 'ps/connectivity-optim' topic
(i.e. expected endgame for this and the other topic if both of them
graduated today without any other topics), and then tried a merge on
master to the previous round (i.e. has the other topic already in),
and did not see any difference in the end result.

Will replace.
