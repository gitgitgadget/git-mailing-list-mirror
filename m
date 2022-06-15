Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4193C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 18:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349926AbiFOSsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244809AbiFOSsA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 14:48:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9596D377E3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 11:47:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C111D124BAC;
        Wed, 15 Jun 2022 14:47:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+3fbNObWhB1JgUbYuumMwnjrzq7CejDgom4L9U
        pauX4=; b=o+5lvIuOanSpGgOSBwZMchb1TViu+RNxngp6kZUYnM/axmAeMduV7m
        CLfN53lRY3uT26eZDNQQUNr7G19A+CQyYE2yN1T4ZR7tMVV6OEJR0PYLv66gKLmX
        9KaO8s+aaEIM8BbjODXohA0/88KFr0l6jNavaO66dVxHJzaHc2bMM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8F43124BAA;
        Wed, 15 Jun 2022 14:47:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28C4B124BA9;
        Wed, 15 Jun 2022 14:47:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fangyi Zhou <me@fangyi.io>
Subject: Re: [PATCH] push: fix capitalisation of the option name autoSetupMerge
References: <pull.1276.git.git.1655307345132.gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 11:47:57 -0700
In-Reply-To: <pull.1276.git.git.1655307345132.gitgitgadget@gmail.com> (Fangyi
        Zhou via GitGitGadget's message of "Wed, 15 Jun 2022 15:35:44 +0000")
Message-ID: <xmqqtu8lzrtu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACBECCDE-ECDB-11EC-BF24-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fangyi Zhou <me@fangyi.io>
>
> This was found during l10n process by Jiang Xin.
> ...
> @@ -171,7 +171,7 @@ static NORETURN void die_push_simple(struct branch *branch,
>  				 "To avoid automatically configuring "
>  				 "upstream branches when their name\n"
>  				 "doesn't match the local branch, see option "
> -				 "'simple' of branch.autosetupmerge\n"
> +				 "'simple' of branch.autoSetupMerge\n"
>  				 "in 'git help config'.\n");
>  	die(_("The upstream branch of your current branch does not match\n"
>  	      "the name of your current branch.  To push to the upstream branch\n"

As this affects translation, I'll fast-track and apply the patch
directly on 'master', as the underlying topic that brought in this
string is a new feature that will never be merged down to 
maintenance tracks.

Thanks.
