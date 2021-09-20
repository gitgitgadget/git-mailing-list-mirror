Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4D3C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7DF9632A5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 17:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346559AbhITRXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 13:23:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54518 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbhITRVX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 13:21:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AE7AEE0FB;
        Mon, 20 Sep 2021 13:19:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bhYRq7N6L965pv60sP9O2yZgVZjeLp4fD0WFXJ
        AsSjg=; b=x25XpH0GQlpq06y0jgFlGzb214H97wUP16z6ROCMcyfwlHrUKlxeZi
        3Ml3AL0xNwr/BcSFNrNbWfYHNc2qBjmjz0U4iPuXUn4w5D8/aFeBirdR3uMIK4od
        kdyRWvau5Eqzz5hwVkFGDPZqWqcuKnmtE3as2QBl0q9WpeDcJKSF0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32B28EE0FA;
        Mon, 20 Sep 2021 13:19:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96F31EE0F9;
        Mon, 20 Sep 2021 13:19:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v2 8/8] submodule--helper: rename helper functions
References: <20210907115932.36068-1-raykar.ath@gmail.com>
        <20210916103241.62376-1-raykar.ath@gmail.com>
        <20210916103241.62376-9-raykar.ath@gmail.com>
Date:   Mon, 20 Sep 2021 10:19:54 -0700
In-Reply-To: <20210916103241.62376-9-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 16 Sep 2021 16:02:41 +0530")
Message-ID: <xmqqbl4ncgg5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9653FAA-1A36-11EC-ACEF-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> These two functions were prefixed with 'do' before the shell-to-C
> conversion because they were utility functions meant to be called by
> their non-prefixed counterpart.
>
> Since those callers don't exist anymore, and these functions can now be
> used directly, let's rename them to signal this fact.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> ---
>  builtin/submodule--helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Nice.
