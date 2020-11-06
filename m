Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E677C388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 02:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B9820782
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 02:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YSTCICqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbgKFCA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:00:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56794 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgKFCA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 21:00:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 670FA931BB;
        Thu,  5 Nov 2020 21:00:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lS0M9yuEdEINhHdc8U5zTgMA880=; b=YSTCIC
        qQCtiZ8sS8U0Wp5s71UuVC5xjHvkHWZFH0REdIIqGfQYVixEs3WNh0iVwH+vmYfo
        CbdQroDfyXtD+PT2B+fyb9Pe+6xxYC+dSUicwmt0CSPbVGDtA3mhDYk57EBC0Thn
        AUkHzpVDfFTyuXdv/5zcO6Uh18Vl9USkZthbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aF27xACEr+Z3FZVk08+eu3vg+MZCyJck
        lkz+45MeB7DLlanFKnRCTUowSl6PPTLJcBuZl0Rw1Xq22qcv1BI0nXd78m53Kq6n
        iOWsDNwHeup6Hnf2zY0q73d7O1wSYLet6s14Pf+wkIbBVZB+xHjEIX8Iv6EGzY6k
        7TyT54EJ16Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E569931BA;
        Thu,  5 Nov 2020 21:00:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2F4D931B9;
        Thu,  5 Nov 2020 21:00:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 00/15] Add struct strmap and associated utility
 functions
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 18:00:56 -0800
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Fri, 06 Nov 2020 00:24:43
        +0000")
Message-ID: <xmqq5z6jgs6f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8D087AC-1FD3-11EB-BCBB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v4:
> ...
>  * Add a patch which updates shortlog to use the new strset API.

This makes my life so much simpler ;-)

Would the implementation be very different from Peff's that you can
take the authorship?  Thanks.
