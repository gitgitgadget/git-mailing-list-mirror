Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD71C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD9F61212
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbhIPPoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 11:44:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54139 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhIPPoX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 11:44:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1504CEDB7C;
        Thu, 16 Sep 2021 11:43:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gJGwpciJplrhes9Zm1Ms7mf+YJNpgmbf0QZ8V1
        dFtF4=; b=JpONY/+QHvrn2Nsm8E2Hzwez+2qXts6vRNNmFHHZLIhMFjKCXrFeZx
        XteNaShkewOcuSrmXFaukOdKTAgdLxxrqtZdudMPqSwX35Opnk3Vpz+2r4e1Vtg0
        W+ZTzpqkVTLmnVGMr977cpbJWxRkrNsptn5bWS8PTlI6OokLOnb/c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B853EDB7B;
        Thu, 16 Sep 2021 11:43:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F6BAEDB7A;
        Thu, 16 Sep 2021 11:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     wesley@schwengle.net
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH] Document `rebase.forkpoint` in rebase man page
References: <c7949156-a7e5-085f-4779-82d0538a4d72@schwengle.net>
        <20210916124709.2824551-1-wesley@schwengle.net>
        <20210916124709.2824551-2-wesley@schwengle.net>
Date:   Thu, 16 Sep 2021 08:43:00 -0700
In-Reply-To: <20210916124709.2824551-2-wesley@schwengle.net>
        (wesley@schwengle.net's message of "Thu, 16 Sep 2021 08:47:09 -0400")
Message-ID: <xmqqv930ttkr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C63BA2A2-1704-11EC-9D82-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

wesley@schwengle.net writes:

> From: Wesley Schwengle <wesley@opperschaap.net>
>
> The option exists and the rebase behaviour tricked me into thinking
> there was a bug with git. This will tell people how they can tweak the
> default behavior.

This tells readers about almost nothing but your frustration.

We, or anybody who will be reading "git log" in 6 months to improve
the system, will not need to hear it.  Instead we need to understand
what the real problem is, what was wrong in the behaviour, or what
the expected behaviour was and why the use of the feature was
inappropriate in the particular case, without which it is impossible
to understand why this sentence was added when a future developer
and documenter tries to improve upon this text.

> Signed-off-by: Wesley Schwengle <wesley@opperschaap.net>
> ---
>  Documentation/git-rebase.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 506345cb0e..8d2bee3365 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -446,7 +446,8 @@ When --fork-point is active, 'fork_point' will be used instead of
>  ends up being empty, the <upstream> will be used as a fallback.
>  +
>  If <upstream> is given on the command line, then the default is
> -`--no-fork-point`, otherwise the default is `--fork-point`.
> +`--no-fork-point`, otherwise the default is `--fork-point`. You can override
> +this default by setting the configuration option `rebase.forkpoint` to false.

We often do:

  "See also `rebase.forkpoint` in linkgit:git-config[1]."

(for example, there is a reference to linkgit:githooks[5] in the
same page).

Thanks.


