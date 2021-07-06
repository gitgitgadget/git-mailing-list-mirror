Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F5AC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDD861C69
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhGFT6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:58:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50139 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhGFT6j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:58:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E9B38148FE7;
        Tue,  6 Jul 2021 15:56:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GjByk+PvD3gDJQM47XJ+KOh/PXhkBsoBrmfmBj
        mN2vg=; b=OzbeqjWgfJITBPkh1nSZhBZaYCzAD7ONIxXP39pUpIuWSHO3Ug8689
        O1wUNPDn5U16Gm47HG1gpiEtpyU35q9iNzzxgU7bD6mZTGBWgfPubwZJVI64O+D8
        XNI4x6L8AtnHbEGEvqleUO9Rv+lAHgFIW1LIkiUBvpfLgnEbZ53Pc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E387E148FE6;
        Tue,  6 Jul 2021 15:56:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 613A1148FE4;
        Tue,  6 Jul 2021 15:55:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 0/2] fix 2 more test files that were accessing file
 system directly.
References: <pull.1042.git.git.1625597277.gitgitgadget@gmail.com>
Date:   Tue, 06 Jul 2021 12:55:56 -0700
In-Reply-To: <pull.1042.git.git.1625597277.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Tue, 06 Jul 2021 18:47:55
        +0000")
Message-ID: <xmqqk0m3i5df.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EA6E0B2-DE94-11EB-9E85-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This reduced the number of test failures in the reftable series by a bit.
>
> Han-Wen Nienhuys (2):
>   t1415: avoid direct filesystem access for writing refs
>   t7509: avoid direct file access for writing CHERRY_PICK_HEAD

Thanks.  Both look quite sensible.

Will queue.


>
>  t/t1415-worktree-refs.sh     | 10 ++++------
>  t/t7509-commit-authorship.sh |  4 ++--
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
>
> base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1042%2Fhanwen%2Freftable-tests2-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1042/hanwen/reftable-tests2-v1
> Pull-Request: https://github.com/git/git/pull/1042
