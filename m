Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA893C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 01:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbiC2BBw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 21:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiC2BBu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 21:01:50 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C074F23F3D8
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 18:00:08 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4355111404;
        Mon, 28 Mar 2022 21:00:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cJs5HOnCIZmrOdKK1/RGY7YKRIihu3aLzW7XPJ
        z5UZY=; b=hyLjI5mKM9HjbfWmDb8XGGa7pCIthN2Jlx0q8eKJFpWn068FzdAvg8
        CjgHceGtv5YaJdJY5PKw8ks7iwRi9Z25zWmwvD9Vz4tYa1plCWn3HLBIl4SLioZ6
        SUW3J600wiZ3Bwat4weIDb85MBph/7zDZZyEO7Y+dBjx4XAQ0qThE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 438E7111402;
        Mon, 28 Mar 2022 21:00:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A108D1113EE;
        Mon, 28 Mar 2022 21:00:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Des Preston via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Des Preston <despreston@gmail.com>
Subject: Re: [PATCH v2 2/2] worktree: accept multiple paths
References: <pull.1188.git.1648231504463.gitgitgadget@gmail.com>
        <pull.1188.v2.git.1648500426.gitgitgadget@gmail.com>
        <1df005a4ef1e387c7f7f5486a7a8800b9cd204a8.1648500426.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 18:00:00 -0700
In-Reply-To: <1df005a4ef1e387c7f7f5486a7a8800b9cd204a8.1648500426.git.gitgitgadget@gmail.com>
        (Des Preston via GitGitGadget's message of "Mon, 28 Mar 2022 20:47:06
        +0000")
Message-ID: <xmqq35j1zi7j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9125886E-AEFB-11EC-BBF1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Des Preston via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Des Preston <despreston@gmail.com>
>
> Update the worktree usage to show that the repair command can take
> multiple paths.
>
> Signed-off-by: Des Preston <despreston@gmail.com>
> ---
>  builtin/worktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 8682ff4c417..498975c1fd9 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -22,7 +22,7 @@ static const char * const worktree_usage[] = {
>  	N_("git worktree move <worktree> <new-path>"),
>  	N_("git worktree prune [<options>]"),
>  	N_("git worktree remove [<options>] <worktree>"),
> -	N_("git worktree repair [<path>]"),
> +	N_("git worktree repair [<path>...]"),

The fact that this line was introduced in [PATCH 1/2] and then
needed to immediately be corrected with this patch means the
previous patch was suboptimal and this patch is "oops, the last one
was bad and here is a band-aid fix-up".

Let's not do so.  Instead, you are encouraged to pretend to be a
more perfect developer who does not make unnecessary mistake ;-)

