Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23440211B5
	for <e@80x24.org>; Thu,  7 Feb 2019 19:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfBGT3M (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 14:29:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38567 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBGT3M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 14:29:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so1087168wmh.3
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3wTBpHhgedJic4XDPJ05moWFw8lYfgrl8HJ9cI3WLJg=;
        b=SX9ypC3Vyu3PK8Ubn3vNuc7c5rY5tqTt8GoqxOiohlz6k+sAMnTn9EgZBtgEzbuy5H
         U8Ob34sQkCGnV6L17ZoBKI6p4M0LcfB243LgnwOBIsBc8hQGfV66PXnplDg2lYpZMBa4
         rDPOAfYQPavBNDlQylhMDqB88/emSdSUyoV46tcId/Bw59q9qx2waSpUArcliWL74mhm
         CaT9KFx2GaypyQfYZFOjD+1R7OOpwIx0ZDQ84wiVgdh8Ckh/3NnZ2oqYIH65VPM2w2rU
         tE4dOqDKgTLND5dEeCAluXPf/z+rqGzExM2fzfzomziqedXllIwbY1pAsmR/RhtCbFLN
         HCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3wTBpHhgedJic4XDPJ05moWFw8lYfgrl8HJ9cI3WLJg=;
        b=j5LTrIQ9p3F2sTyahxy1/SZPNd/MCBRu0EaktkMyoFGP628H742lKk+wyBmaz11WSr
         Rnl6xmz3cS4ll/ZL0KrXrY7KIEu4+jh/fBgVsbwDiWC6RcvRjThS+lOCJWqGgr0EgV5F
         VuFqPAUx8A1LDc2iMhu7vCA0SfPn268pMqVe2omC0wUYv2CEYU6X8ByQ+q0qznZIr5L6
         z00s0YoDfjKW2yBjqLXvuyV5gDL1wQSi14AM0oK5SfyLF7LKSe4bQUNVm4VkY0DElmc9
         qw1k5qzeatfLez+HqGYxPZDPqXDN21pJcA/is2fymQcHDSpVnrcztJ3eSE9pXKZKKVWZ
         hK/Q==
X-Gm-Message-State: AHQUAuaL3pBFDLhW0RYPrCbxauXWcPgfgPNQ81Y9e0WDVqx9CXsI2oRD
        ryRbc1JBViyBbzP5QhzhVpk=
X-Google-Smtp-Source: AHgI3IaQB94tonPaqHwsuv/GycuWQf2AyCZ5533hgHhcoEglaGI0ruanHBvcwEtcj6uxXrJcFegVuA==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr8524412wmf.111.1549567749701;
        Thu, 07 Feb 2019 11:29:09 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v4sm325426wme.6.2019.02.07.11.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 11:29:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Katrin Leinweber <katrin.leinweber@uni-konstanz.de>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] doc: prevent overflowing <code> tag in rendered HTML
References: <14b8a047-9e88-5ed9-300a-c8df1e953f07@uni-konstanz.de>
Date:   Thu, 07 Feb 2019 11:29:08 -0800
In-Reply-To: <14b8a047-9e88-5ed9-300a-c8df1e953f07@uni-konstanz.de> (Katrin
        Leinweber's message of "Thu, 7 Feb 2019 20:16:37 +0100")
Message-ID: <xmqqwombo0sb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Katrin Leinweber <katrin.leinweber@uni-konstanz.de> writes:

> Add an apparently missing back-tick to fix a multi-line <code> section
> on https://git-scm.com/docs/git-log which seems to have been caused by
> commit 18fb7ffc ("pretty: respect color settings [...]", 2017-07-13).
>
> Signed-off-by: Katrin Leinweber <katrin.leinweber@uni-konstanz.de>
> ---

Thanks for spotting and fixing.  Will apply.

>  Documentation/pretty-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-formats.txt
> b/Documentation/pretty-formats.txt
> index 417b638cd..ee08d0906 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -181,7 +181,7 @@ endif::git-rev-list[]
>    `color.diff`, `color.ui`, or `--color`, and respecting the `auto`
>    settings of the former if we are going to a terminal). `%C(auto,...)`
>    is accepted as a historical synonym for the default (e.g.,
> -  `%C(auto,red)`). Specifying `%C(always,...) will show the colors
> +  `%C(auto,red)`). Specifying `%C(always,...)` will show the colors
>    even when color is not otherwise enabled (though consider
>    just using `--color=always` to enable color for the whole output,
>    including this format and anything else git might color).  `auto`
