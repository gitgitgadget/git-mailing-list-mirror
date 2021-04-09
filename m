Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD95C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A314B61165
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 22:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhDIWpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 18:45:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63049 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhDIWpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 18:45:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE193AF23A;
        Fri,  9 Apr 2021 18:45:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EsF4RzAmqh76miSbKCjGvWNQkY4=; b=CJQMOY
        s71KjbuBfxD44vGz8i1Oa/bY/c7K+lBsyilX1VXZBlkOsUItoQ1h471YOicjQYV0
        vOBHx8jbk+gJWGVymrYThtLwEOyoHmV1i+gc1+PVefuwrtGwv+164yHCqVgi+edl
        yd1kHWwtAiPPdhxCGjgnrwnPkYqTagOUpglzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z0FPTLxUSOSh8wyAi8BUAlbWZT+t5Mip
        pE6Y2d8cMcU3iEC0uBhl3M69bX3cxlNM0tIrcMYU2/UGGglSNGWR27AMydLRiq8d
        9dLs8N8LQkxO9bKzy3nWOyI3Dnu0Fnjvi9G225r09PLxysjFrYO0TUkVkHttQzP2
        CXjJwyigKRA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3CB3AF239;
        Fri,  9 Apr 2021 18:45:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53085AF238;
        Fri,  9 Apr 2021 18:45:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     scottworley@scottworley.com
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] doc: update advice about other implementations' v4
 index support
References: <20210409202206.29990-1-scottworley@scottworley.com>
Date:   Fri, 09 Apr 2021 15:45:08 -0700
In-Reply-To: <20210409202206.29990-1-scottworley@scottworley.com>
        (scottworley@scottworley.com's message of "Fri, 9 Apr 2021 13:22:06
        -0700")
Message-ID: <xmqq1rbjm617.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CBC2436-9985-11EB-80D0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

scottworley@scottworley.com writes:

> From: Scott Worley <scottworley@scottworley.com>
>
> Signed-off-by: Scott Worley <scottworley@scottworley.com>
> ---
>  Documentation/git-update-index.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 2853f168d9..e8eca5dadf 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -166,9 +166,10 @@ you will need to handle the situation manually.
>  +
>  Version 4 performs a simple pathname compression that reduces index
>  size by 30%-50% on large repositories, which results in faster load
> -time. Version 4 is relatively young (first released in 1.8.0 in
> -October 2012). Other Git implementations such as JGit and libgit2
> -may not support it yet.
> +time. Version 4 is relatively young (first released in git 1.8.0 in
> +October 2012, supported in libgit2 0.24.4 from December 2016, go-git
> +4.0.0 from January 2018, and jgit 5.9.0 from September 2020). Other
> +Git implementations such as Dulwich may not support it yet.

Thanks for these dates.  Time flies---I didn't realize it has been
almost 9 years---the feature was merged in May 2012, in v1.7.11
(yes, I am hinting that the original lists a wrong date and we
should correct it while at it).

I wonder if we should lose "relatively young" from the description
here, though.

