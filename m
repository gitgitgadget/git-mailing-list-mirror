Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52DDC07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C257A61CB3
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhGFV6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:58:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64281 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhGFV6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:58:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 827B3C2542;
        Tue,  6 Jul 2021 17:55:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PPnbMzq3kJFrgaBkhDqv2KLNDzbQqv42e4p1x2
        df61U=; b=XLKXsyhAGus2lpfe9m3wrSkueyFe9M4/6BWOfFk2oFci27MwpbFVjy
        JuRU+rOq6IWasw9QQNRmPGyEdeJwz/7L8vaVURSlcsnRUr3qqXov624bZN2viYZ3
        gtbX6Lje0UWzl3F9PAUCaxX3kU2cGo/zKegclumEcI29jIpCPmRtU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79617C2540;
        Tue,  6 Jul 2021 17:55:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7A0BC253F;
        Tue,  6 Jul 2021 17:55:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrew Berry <andrew@furrypaws.ca>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH] docs: .gitignore parsing is to the top of the repo
References: <xmqqczrvl8kl.fsf@gitster.g>
        <20210706205439.75015-1-andrew@furrypaws.ca>
Date:   Tue, 06 Jul 2021 14:55:28 -0700
In-Reply-To: <20210706205439.75015-1-andrew@furrypaws.ca> (Andrew Berry's
        message of "Tue, 6 Jul 2021 16:54:39 -0400")
Message-ID: <xmqqo8bfgl9r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0A25F20-DEA4-11EB-8C54-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrew Berry <andrew@furrypaws.ca> writes:

> The current documentation reads as if .gitignore files will be parsed in
> every parent directory, and not until they reach a repository boundary.
> This clarifies the current behaviour.
>
> As well, this corrects 'toplevel' to 'top-level', matching usage for
> 'top-level domain'.
>
> Signed-off-by: Andrew Berry <andrew@furrypaws.ca>
> ---
>  Documentation/gitignore.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 53e7d5c914..534cda5747 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -27,10 +27,10 @@ precedence, the last matching pattern decides the outcome):
>     them.
>  
>   * Patterns read from a `.gitignore` file in the same directory
> -   as the path, or in any parent directory, with patterns in the
> -   higher level files (up to the toplevel of the work tree) being overridden
> -   by those in lower level files down to the directory containing the file.
> -   These patterns match relative to the location of the
> +   as the path, or in any parent directory in the same repository, with
> +   patterns in the higher level files (up to the toplevel of the work tree)
> +   being overridden by those in lower level files down to the directory
> +   containing the file. These patterns match relative to the location of the
>     `.gitignore` file.  A project normally includes such
>     `.gitignore` files in its repository, containing patterns for
>     files generated as part of the project build.

Sent a wrong/stale patch?

