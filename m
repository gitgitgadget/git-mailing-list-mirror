Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C5EC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 353856120C
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 18:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhJDSTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 14:19:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64928 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhJDSTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 14:19:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E798CEBCC9;
        Mon,  4 Oct 2021 14:17:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ihtua6Dzrr9cBsq5Rdmw7cOykdc7ZwvGKrE7Ht
        0gCq0=; b=Y7Yu5lRl/n9a57zPVEosX7doon7XaGUg4m8qTCJ3yLmzfmw8aa/62R
        rEAdEY5Bx99ted5Wo4TKEUBEZ0tEj+qZ2F6aH3YdD4ReRcsW6y88MOQgqAa34Pk1
        nHr6i4D+nCd5m9796NZS/1pKGeVjCqulcLnJ1wHHQ39Ik+4Rn7KRY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7393EBCC8;
        Mon,  4 Oct 2021 14:17:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C785EBCC7;
        Mon,  4 Oct 2021 14:17:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFC PATCH v4 00/10] Fix various issues around removal of
 untracked files/directories
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
        <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
        <CABPp-BEaJAG=pqyjCR93YUoqj06WwSqjiPENDHjgSTWwzd_C2A@mail.gmail.com>
Date:   Mon, 04 Oct 2021 11:17:25 -0700
In-Reply-To: <CABPp-BEaJAG=pqyjCR93YUoqj06WwSqjiPENDHjgSTWwzd_C2A@mail.gmail.com>
        (Elijah Newren's message of "Mon, 4 Oct 2021 07:38:17 -0700")
Message-ID: <xmqqh7dwwt6y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53EA6F32-253F-11EC-85E1-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> So, I guess trying to distill what bugs me, I'd say: it seems to me
> that you have ignored what Junio said about taking my series, and then
> you rebased my series on top of unrelated stylistic churn, with that
> churn containing three issues that trigger ongoing misgivings I have
> about the care being put behind these refactorings, especially
> considering their value compared to the features and bugfixes we are
> getting, and you seem to fail to try to understand my changes and
> misrepresent them in the process.  I hope I'm not overreacting but
> something feels wrong to me here.

Just one thing.  It is fairly easy to rebase and merge and generally
muck with somebody else's changes without fully understanding it.  I
do that all the time ;-)

I would prefer to see us assume misunderstanding by incompetence,
rather than misrepresentation by malice to further one's own agenda.
