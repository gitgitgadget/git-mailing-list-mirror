Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFCDC32771
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 18:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIOSnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 14:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIOSnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 14:43:15 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C9895E46
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 11:43:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2B0313FA7D;
        Thu, 15 Sep 2022 14:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/KC3zfJyzs3rgDjiSMttG7ky4bFnXaDJ+Esvj+
        YStt8=; b=MgwH0EZf51VQ54NIHOvHXSTTPYxNAC8w+jG4DY50fHTU+l5TPKWb8z
        XhRkBeUWGPRzrm8ysdKBQRRD3dmYAnI5w/ZfPZyqOnXULsyXlBERC5sbUUAbbsMX
        HejIv/rbn7PYMj4xkyBgJ8u7yAYO51mLIG7bvVVzNea9wTnCopkQg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9EC513FA7C;
        Thu, 15 Sep 2022 14:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5382E13FA79;
        Thu, 15 Sep 2022 14:43:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] diff-merges: clarify log.diffMerges documentation
References: <20220914193102.5275-1-sorganov@gmail.com>
        <20220914193102.5275-4-sorganov@gmail.com>
Date:   Thu, 15 Sep 2022 11:43:11 -0700
In-Reply-To: <20220914193102.5275-4-sorganov@gmail.com> (Sergey Organov's
        message of "Wed, 14 Sep 2022 22:31:02 +0300")
Message-ID: <xmqqr10cmqbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4063242A-3526-11ED-8CE4-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/config/log.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
> index 5250ba45fb4e..cbe34d759221 100644
> --- a/Documentation/config/log.txt
> +++ b/Documentation/config/log.txt
> @@ -30,9 +30,9 @@ log.excludeDecoration::
>  	option.
>  
>  log.diffMerges::
> -	Set default diff format to be used for merge commits. See
> -	`--diff-merges` in linkgit:git-log[1] for details.
> -	Defaults to `separate`.
> +	Set diff format to be used when `--diff-merges=on` is
> +	specified, see `--diff-merges` in linkgit:git-log[1] for
> +	details. Defaults to `separate`.
>  
>  log.follow::
>  	If `true`, `git log` will act as if the `--follow` option was used when

Is the reason why the patch drops "default" because the value given
is used only when --diff-merges=on is given, and does not kick in
when "--diff-merges=<format>" is explicitly given?

The rest of the change does make sense.


