Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6232EEB64DD
	for <git@archiver.kernel.org>; Sun, 13 Aug 2023 22:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjHMWVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Aug 2023 18:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjHMWVT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2023 18:21:19 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705ED11D
        for <git@vger.kernel.org>; Sun, 13 Aug 2023 15:21:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CC5F1A960E;
        Sun, 13 Aug 2023 18:21:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=37j/AuqvZbNyt9teB1R2DorHRAIWBiSnSuB3V1
        cMAw8=; b=iWBFWru0fqq1d/9QUt1rmxcUdzWuU0NV9N1n35hqGws5Qi51cblYeG
        0NSxN7YyYMWiLdqj91Z+WYik7HVSvz7JVvrqcWgTCE/bRwK9yov7diFJMfrCZ8n9
        +GNwD1hOxQMpPtFqhc/CFAjHUENpiyV9506BlwXFemYZUZr1JoHwA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44CA51A960D;
        Sun, 13 Aug 2023 18:21:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AEBC41A960C;
        Sun, 13 Aug 2023 18:21:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH] builtin/worktree.c: Fix typo in "forgot fetch" msg
References: <20230811233940.30264-1-jacobabel@nullpo.dev>
Date:   Sun, 13 Aug 2023 15:21:13 -0700
In-Reply-To: <20230811233940.30264-1-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Fri, 11 Aug 2023 23:39:51 +0000")
Message-ID: <xmqqttt2mvmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B73B2F3C-3A27-11EE-9FCF-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> Replace misspelled word "overide" with correctly spelled "override".
>
> Reported-By: Teng Long <dyroneteng@gmail.com>
> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
> This patch fixes a typo identified in [1]. 
>
> Luckily the text that contained this typo didn't interact with any other
> behavior and the change didn't require any modifications to the test
> code so it was a very quick, easy fix.

True, but l10n folks need to be given sufficient time to react, so
let's postpone it til immediately after the upcoming release.

Thanks.

> 1. https://lore.kernel.org/git/20230809064724.13032-1-tenglong.tl@alibaba-inc.com/
>
>  builtin/worktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 4cd01842de..10db70b7ec 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -696,7 +696,7 @@ static int can_use_remote_refs(const struct add_opts *opts)
>  		return 1;
>  	} else if (!opts->force && remote_get(NULL)) {
>  		die(_("No local or remote refs exist despite at least one remote\n"
> -		      "present, stopping; use 'add -f' to overide or fetch a remote first"));
> +		      "present, stopping; use 'add -f' to override or fetch a remote first"));
>  	}
>  	return 0;
>  }
>
> base-commit: fac96dfbb1c24369ba7d37a5affd8adfe6c650fd
