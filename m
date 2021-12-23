Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B4CC433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 20:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhLWU2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 15:28:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54396 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350248AbhLWU2C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 15:28:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E27316A5A3;
        Thu, 23 Dec 2021 15:28:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n6DQC1SNuzsASZbutMS73UvOVKWpFOoDTu/oG5
        Noyl0=; b=eaJP3Pa33Tf8GvJz5CjSSBBufy4Vi+rBTNC24gmvaL83A/HOoN8LBt
        MS7EOsSWL7ypacybKRSfxQreWqframw5DNag9jdHTkLoXpqXzW288TtNmaiMI0uj
        3Ib79GHKj70y2rXko7d29t5iTpbRjLYn2j8NUUKN2WBQOfN7BZ4EE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66B3716A5A2;
        Thu, 23 Dec 2021 15:28:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 639C516A5A0;
        Thu, 23 Dec 2021 15:27:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 0/3] preliminary fixes for reftable support
References: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
Date:   Thu, 23 Dec 2021 12:27:55 -0800
In-Reply-To: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Thu, 23 Dec 2021 19:29:47
        +0000")
Message-ID: <xmqqk0fv83sk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0B179B0-642E-11EC-B64A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> these two commits to the reftable library prepare for making 2 tests in the
> test suite pass in my pending changes for reftable support.

Welcome again to our "we cannot count to three" club.

> This series was built against 'master'. It also has a fix for a fd leak (>=
> 0 vs > 0), which is part of my reftable-coverity fixes topic.

What is going on here?  We have the same fix in two series?  Are
these two series meant to be applied, or is this a beginning of
splitting and resubmitting the other larger series into smaller
chunks?

I am not opposed to having two identical fixes to a high priority
problem, one in a long series that may take longer to graduate and
the other one in a short series that is trivial to verify.  I am not
opposed to retract a longer series and trickle a number of series'
that replace it, either.  I just wanted to know what is happening
here.

Thanks.

> Han-Wen Nienhuys (3):
>   reftable: fix typo in header
>   reftable: signal overflow
>   reftable: support preset file mode for writing
>
>  reftable/block.h           |  2 +-
>  reftable/error.c           |  2 ++
>  reftable/readwrite_test.c  | 35 +++++++++++++++++++++++++++++++++++
>  reftable/reftable-error.h  |  4 ++++
>  reftable/reftable-writer.h |  3 +++
>  reftable/stack.c           | 30 ++++++++++++++++++++++++------
>  reftable/stack_test.c      | 33 +++++++++++++++++++++++++++++----
>  reftable/writer.c          |  3 +++
>  8 files changed, 101 insertions(+), 11 deletions(-)
>
>
> base-commit: fae76fe5da3df25d752f2251b7ccda3f62813aa9
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1164%2Fhanwen%2Freftable-features-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1164/hanwen/reftable-features-v1
> Pull-Request: https://github.com/git/git/pull/1164
