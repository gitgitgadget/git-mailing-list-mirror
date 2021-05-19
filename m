Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A55C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E216861369
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhESBNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 21:13:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53014 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhESBNf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 21:13:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 395A2CA5C9;
        Tue, 18 May 2021 21:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TwFByJEob3FB47gr8lA0n4ytrBn0+RJj7mEsHk
        Rjv5g=; b=erz9spXKbULUNEqc1TCrAj5QCe/nIJ8Bx/+f3qU95syl5SKcphClvW
        HcQOZ3HY9SV4NeWohn0+jOp1kq72b5SJG94gJF1vL/B/7Kt9K6MfwWMe/PTv4gx5
        +1ggNhor6x/SBHXxQClR1ADFi/IfS82nwDrNxXGzaFK+PEftjGwwI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 317A2CA5C8;
        Tue, 18 May 2021 21:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABA6ECA5C7;
        Tue, 18 May 2021 21:12:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ben Humphreys <behumphreys@atlassian.com>,
        Christopher Schenk <christopher@cschenk.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] fix v2.32.0-rc0 bug with Negotiate / HTTP_NOAUTH
References: <YKMvePOPqjwiXeQ+@C02WD045HTDG>
        <YKNVop80H8xSTCjz@coredump.intra.peff.net>
        <YKNeJ+NKUbD5ixA9@coredump.intra.peff.net>
Date:   Wed, 19 May 2021 10:12:15 +0900
In-Reply-To: <YKNeJ+NKUbD5ixA9@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 18 May 2021 02:26:47 -0400")
Message-ID: <xmqqbl971q8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FC40918-B83F-11EB-9C88-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here are some patches. The first one adds the tests, and I think is an
> obvious improvement.
>
> The second one does the revert. I'd be quite happy if somebody wants to
> figure out how to fix it in a way that addresses the original problem,
> and then we can replace that. But in the meantime, I think it makes
> sense to prepare the revert, as we wouldn't want to release v2.32.0 with
> the bug.

I'll queue these directly on top of the original topic, so that even
a merge of the branch by mistake down to maint won't break.

I saw brian has already floated an idea to solve the original issue,
and I'd encourage people to help finding a proper solution, but
let's leave the actual application of such a change for the next
cycle.

Thanks.

