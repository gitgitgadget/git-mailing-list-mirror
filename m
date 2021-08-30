Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF1C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 22:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD86D604AC
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 22:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbhH3WWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 18:22:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56400 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhH3WWP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 18:22:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B7F8E7302;
        Mon, 30 Aug 2021 18:21:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NXx0geCbp0bT2kS5ylY9l0FTrt7ElshRchEc/A
        7deZc=; b=aCKm9M0bwXO1BbeD5tt+g8urYsU9gbhTR/HkYG/u0QIl9PwFZFJ9WV
        1Rl6jBj6edgjYasKARe2wkYIIz/o2Nb/spwMg+djlJBzAG8BPV/hMWe9R3E5Lzn0
        QFIPYqLSOTwl+ebayjJTfBIqRgkNq6C5Q4++SzHqvTVTs8RWaSJQE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32859E7300;
        Mon, 30 Aug 2021 18:21:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD452E72FE;
        Mon, 30 Aug 2021 18:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, levraiphilippeblain@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v3] sequencer: advise if skipping cherry-picked commit
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
        <691c660422676c92180feb1c2a88049afe7536b9.1630359271.git.steadmon@google.com>
Date:   Mon, 30 Aug 2021 15:21:20 -0700
In-Reply-To: <691c660422676c92180feb1c2a88049afe7536b9.1630359271.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 30 Aug 2021 14:46:02 -0700")
Message-ID: <xmqqr1ea1sm7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A463EEA-09E0-11EC-BA17-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Silently skipping commits when rebasing with --no-reapply-cherry-picks
> (currently the default behavior) can cause user confusion. Issue
> warnings when this happens, as well as advice on how to preserve the
> skipped commits.
>
> These warnings and advice are displayed only when using the (default)
> "merge" rebase backend.
>
> Update the git-rebase docs to mention the warnings and advice.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---

Looks sensible.

Will queue.  Let's merge it down to 'next' in a few days and leave
the follow-on work to later.

Thanks.
