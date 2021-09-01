Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B882C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A4861075
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbhIAV42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 17:56:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57169 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhIAV42 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 17:56:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D11F914AA32;
        Wed,  1 Sep 2021 17:55:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FbFQRHy4EO/wESq8bJrrsdxpBPUD8OTXfZpVmq
        m0cSg=; b=Yf1jzvagNA7CQM1zLYuGXzSTR6rjn9ByfTbeSgW4KDbS1zp+tVuTAa
        pvxPi3vF0xmmNEB7lO9NaHENtvq1TNhEsbTxKPRE5DtGs8Dd7kAq4alUW3yLEKpL
        Byj0spyHEPKJ2D7qk+pxAffYKCRLZ4tQi28LK0Fn6SVb7XXt8aYnA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BB5DC14AA30;
        Wed,  1 Sep 2021 17:55:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11CB814AA2D;
        Wed,  1 Sep 2021 17:55:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 0/7] Add a new --remerge-diff capability to show & log
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
        <xmqqy28gngwj.fsf@gitster.g>
        <CABPp-BENXw11v3KxkFL+NsF5Qo7Pff1QdyxG2YxQB+SV6Or-Hg@mail.gmail.com>
Date:   Wed, 01 Sep 2021 14:55:25 -0700
In-Reply-To: <CABPp-BENXw11v3KxkFL+NsF5Qo7Pff1QdyxG2YxQB+SV6Or-Hg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 1 Sep 2021 14:42:16 -0700")
Message-ID: <xmqqtuj4nepe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 511011D4-0B6F-11EC-8936-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> We do have `git diff AUTO_MERGE`, though.  It's not quite the same as
> it doesn't include all the "CONFLICT" messages shown in the terminal
> like --remerge-diff does with log/show, but otherwise it's the same.

Ah, forgot about that one, so we are good.

> Perhaps we could even alias `git diff --remerge-diff` to `git diff
> AUTO_MERGE`?

I do not think it is a good idea to hide AUTO_MERGE behind an
option.  It is a feature that deserves more user awareness by
itself.

Thanks.
