Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2149BC4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 00:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B5861184
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 00:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhHUAK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 20:10:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63712 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhHUAK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 20:10:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A59EDBD19;
        Fri, 20 Aug 2021 20:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=pF3MbHNYLogVKdwDL7g8MfGbkq1nkfIEUJRxnjE9w90=; b=QJf7
        9JYOKJDFBgVpauAhjVjZW9Xr8w7kVfey4GfMoaw3tqH4tKK12lwPJCqgVswHdAHb
        k0MOHwK4/6aQ8vYiLscZgp/zLRgJ74TZd7M/xWR1+KXO8jLutB6Bh634jDzKIOYw
        a8m2XGJfXpglrsruaRFbXdmuXUeqJUKgPBqG6J0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 913CCDBD18;
        Fri, 20 Aug 2021 20:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11235DBD16;
        Fri, 20 Aug 2021 20:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 0/6] Speed up mirror-fetches with many refs
References: <cover.1629452412.git.ps@pks.im>
Date:   Fri, 20 Aug 2021 17:09:46 -0700
Message-ID: <xmqq1r6nu08l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 183D14C4-0214-11EC-8D8A-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> I've taken another look at fetches in the context of repos with a huge
> amount of refs. This time around, I've taken a look at mirror fetches:
> in our notorious repo with 2.3M refs, these mirror fetches can take up
> to several minutes of time even if there are no changes at all.

I notice that 4/6 (and no other patch) is not signed-off and wonder
if there is a reason (e.g. you are not so comfortable with the idea
behind the step or the implementation) or a simple oversight?

> Note that this series depends on ps/connectivity-optim and thus only
> applies on top of next.

It seems that the dependency of this series is not just 'master'
plus 'ps/connectivity-optim' but some more stuff from 'next'.  I
expact that topics that have been cooking in 'next' during the
previous cycle will graduate to 'master' early next week, so perhaps
it is easier to handle this kind of "depends on some stuff in
'next'" topics after that happens.

Thanks.
