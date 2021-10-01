Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EF4C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D753761AAD
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhJAWpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 18:45:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51443 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhJAWpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 18:45:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E86D153FF0;
        Fri,  1 Oct 2021 18:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sG9oNyhQ7V197yR1EZeMCET80EUCDapkMLFGJj
        XGWhg=; b=Z0qLizm8z62oL0XqS7UtJFm1t4HTRE/bmlrGzG6Mbr5uCbUG12zzz7
        duRp28e4bb+hmH5hglhCTSX7exPqN8J6Z0nQ3ip6UNdU3502tW+0FD5iyu/ecOmZ
        yQSxrgjojVrT7QtBLdx0lAf6VMZ0Ayzc2VociPwxXTVHzgBI8RyU4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 239CE153FEF;
        Fri,  1 Oct 2021 18:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1F94153FEE;
        Fri,  1 Oct 2021 18:43:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>
Subject: Re: [PATCH v3 1/2] blame: Describe default output format
References: <20211001113725.13354-1-bagasdotme@gmail.com>
        <20211001113725.13354-2-bagasdotme@gmail.com>
Date:   Fri, 01 Oct 2021 15:43:19 -0700
In-Reply-To: <20211001113725.13354-2-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Fri, 1 Oct 2021 18:37:25 +0700")
Message-ID: <xmqqfstk2woo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA48FD0A-2308-11EC-B762-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> While there is descriptions for porcelain and incremental output
> formats, the default format isn't described. Describe that format for
> the sake of completeness.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/git-blame.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
> index 3bf5d5d8b4..683f8ab0b0 100644
> --- a/Documentation/git-blame.txt
> +++ b/Documentation/git-blame.txt
> @@ -93,6 +93,19 @@ include::blame-options.txt[]
>  	is used for a caret to mark the boundary commit.
>  
>  
> +THE DEFAULT FORMAT
> +------------------
> +
> +When neither `--porcelain` nor `--incremental` option is specified,
> +`git blame` will output annotation for each line with:
> +
> +- abbreviated object name for the commit the line came from;
> +- author ident (by default author name and date unless `-s` or `-e` is
> +specified); and

It probably would become easier to read with a comma before
"unless".

Other than that (and the downcasing of Describe in the title), looks
good to me.

Thanks.

> +- line number
> +
> +before the line contents.
> +
>  THE PORCELAIN FORMAT
>  --------------------
