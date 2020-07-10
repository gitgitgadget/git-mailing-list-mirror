Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D57C433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B686F2068F
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 20:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XLCgGXcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgGJU5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:57:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53488 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJU5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 16:57:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3ADB17E0B4;
        Fri, 10 Jul 2020 16:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=osp29/XFgYB4RA2Ek8WPKSrFjpo=; b=XLCgGX
        cdAsZIn4sMM449t3EdjAQ3zRrmJOxSz+me7T5HTNan14jCUm7G8qjOJ3aU80RwS/
        6pDapjxT8Amqt4J32ZsrSiz6qNhbc5wa2DW7Y7aCIbtbQuFiIa9Zhzxvzu+PL+Lu
        pUk6+nvgfqqVWULEC6ii3e6tw4mAu1FFQAcEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IhS93EcCcB1KBMhtpm1zCvaVx5tLG6kJ
        HHTlsiNE4YVl/H5C7ylxxWCGNGmeZDETlwoK9n8noQoH0tw3clMWTUe3WNed4I7O
        R++S80lo0Oe/esI7DRMY6sekWlFNrZoiXwmDmj2+nJOpW/t6w6ZAzyVGkLEH0ESd
        VsP/CFOQip0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 328BD7E0B3;
        Fri, 10 Jul 2020 16:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A6D837E0B0;
        Fri, 10 Jul 2020 16:57:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 0/4] Preliminary fixes for reftable support
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
        <pull.669.v2.git.1594401593.gitgitgadget@gmail.com>
Date:   Fri, 10 Jul 2020 13:57:09 -0700
In-Reply-To: <pull.669.v2.git.1594401593.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Fri, 10 Jul 2020 17:19:49
        +0000")
Message-ID: <xmqqy2nrrsuy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC618254-C2EF-11EA-9F04-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> These are assorted small fixes split out from the reftable topic.

Will replace.  I'll retitle the 3/4 and 4/4 to

    bisect: treat BISECT_HEAD as a pseudo ref
    reflgo: cleanse messages in the refs.c layer

while queuing.

Thanks.

> Han-Wen Nienhuys (3):
>   lib-t6000.sh: write tag using git-update-ref
>   t3432: use git-reflog to inspect the reflog for HEAD
>   Treat BISECT_HEAD as a pseudo ref
>
> Junio C Hamano (1):
>   Cleanse reflog messages in the refs.c layer
>
>  builtin/bisect--helper.c       |  3 +-
>  git-bisect.sh                  |  4 +--
>  refs.c                         | 50 ++++++++++++++++++++++++++++------
>  refs/files-backend.c           |  2 +-
>  refs/refs-internal.h           |  6 ----
>  t/lib-t6000.sh                 |  5 ++--
>  t/t3432-rebase-fast-forward.sh |  7 +++--
>  7 files changed, 51 insertions(+), 26 deletions(-)
>
>
> base-commit: bd42bbe1a46c0fe486fc33e82969275e27e4dc19
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-669%2Fhanwen%2Fpreliminaries-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-669/hanwen/preliminaries-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/669
>
> Range-diff vs v1:
>
>  1:  b7b2ad8e79 = 1:  0f244ed6cb lib-t6000.sh: write tag using git-update-ref
>  2:  f238d1d7f8 ! 2:  123d246edf t3432: use git-reflog to inspect the reflog for HEAD
>      @@ t/t3432-rebase-fast-forward.sh: test_rebase_same_head_ () {
>        		oldhead=\$(git rev-parse HEAD) &&
>        		test_when_finished 'git reset --hard \$oldhead' &&
>       -		cp .git/logs/HEAD expect &&
>      -+		git reflog HEAD > expect &&
>      ++		git reflog HEAD >expect &&
>        		git rebase$flag $* >stdout &&
>      -+		git reflog HEAD > actual &&
>      ++		git reflog HEAD >actual &&
>        		if test $what = work
>        		then
>        			old=\$(wc -l <expect) &&
>  3:  8a62cc2668 < -:  ---------- checkout: add '\n' to reflog message
>  4:  2b7eb58c15 = 3:  d4007c2a5b Treat BISECT_HEAD as a pseudo ref
>  -:  ---------- > 4:  6ca5b99c8d Cleanse reflog messages in the refs.c layer
