Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C37AC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhLQA6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:58:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50111 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhLQA6B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:58:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EA62FC914;
        Thu, 16 Dec 2021 19:58:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+dx9ItaRC91c9q4gKhuQex7TL4h6QW1m6JZTSC
        Ema8U=; b=Rq26ShKPYdwQH5Q4pe8zQBilEb2Q12oJR0neVIu65Sv+Pefv8nrm/E
        tdNqjCSx9sxMgWfU41QOpYXtJ351f+c2BN2J5nSNR+hfA07+C3mTx623qZlCZEux
        VSeRqg/v4oxLxbjLSQwQ0FHz+Do7y4n6DOijtV1RfJ16/5j0Zp30Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42BFAFC912;
        Thu, 16 Dec 2021 19:58:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86F93FC911;
        Thu, 16 Dec 2021 19:57:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jasdeep Khalsa <jasdeepkhalsa1@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Adding new/create & del/delete aliases into git
References: <CALtRjJ3bu1ub=407kt-aemfV6BU8CfPZJxLRG5WgTZBYWbaXCQ@mail.gmail.com>
Date:   Thu, 16 Dec 2021 16:57:58 -0800
In-Reply-To: <CALtRjJ3bu1ub=407kt-aemfV6BU8CfPZJxLRG5WgTZBYWbaXCQ@mail.gmail.com>
        (Jasdeep Khalsa's message of "Thu, 16 Dec 2021 13:29:15 +0000")
Message-ID: <xmqqmtl059pl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6109031C-5ED4-11EC-AD13-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jasdeep Khalsa <jasdeepkhalsa1@gmail.com> writes:

> I've been using the following aliases for a long time:
>
> del or delete = branch -D
> new or create = checkout -b
>
> And I feel these are good candidates as an addition into the core git
> API as they provide an easy way for new starters to understand the
> creating and deleting of branches - which is arguably one of the most
> common git operations.

He wants to see his "create" to create and "delete" to delete a
worktree, not a branch.  And she wants to see her "create" to create
and "delete" to delete a repository, not a branch.

Not everybody shares your "feel that these are common".

Aliases and synonyms are so personal and it is better to make sure
that we do not define more than necessary at the public level.
Otherwise we will end up squatting on more good names that people
may want to use for their own aliases.

