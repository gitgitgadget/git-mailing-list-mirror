Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0105C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 20:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbiBTU1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 15:27:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244677AbiBTU1A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 15:27:00 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60475DD6
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 12:26:36 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B0E3916C691;
        Sun, 20 Feb 2022 15:26:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7eMcVVQMm3PAbdtmH2dt/VrBYDtf7hRW11l6Em
        C+jv4=; b=Pqtyp+wfbyPD7qhPY/nfP3oPeVcCsJztRipfxcUzjRF+9hlBCK/xOr
        KEPu3IzgklMVVa04W09GT03At4FtXW7Nc0Os2KF2hr5Sm389NpiQGIf3K5O71CZG
        G67g7iBbw64f6twbBkhPJdAbPjaDkMIYWSbQJgZNp761gaR6tE+Ag=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A99CB16C68E;
        Sun, 20 Feb 2022 15:26:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F30D16C65A;
        Sun, 20 Feb 2022 15:26:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 02/11] worktree: extract copy_filtered_worktree_config()
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <f8aa87112a85ee2aa263cb2096232f462e76d06c.1645379667.git.gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 12:26:32 -0800
In-Reply-To: <f8aa87112a85ee2aa263cb2096232f462e76d06c.1645379667.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Sun, 20 Feb 2022
        17:54:18 +0000")
Message-ID: <xmqqh78tuvwn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64D53A16-928B-11EC-9C66-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> This logic was introduced by 5325591 (worktree: copy sparse-checkout
> patterns and config on add, 2022-02-07), but some feedback came in that
> the add_worktree() method was already too complex. It is better to
> extract this logic into a helper method to reduce this complexity.
>
> Reported-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/worktree.c | 81 ++++++++++++++++++++++++----------------------
>  1 file changed, 42 insertions(+), 39 deletions(-)

Quite straight-forward.  Looking good.

Thanks.
