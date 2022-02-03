Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F28FC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 19:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiBCTNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353676AbiBCTNe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 14:13:34 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AE1C06173B
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 11:13:33 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so10919470pjt.5
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 11:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=o4s8kS/PWf8erqH+PQ6wgJWWsII+FH1AJ+p5J5uLWR8=;
        b=dc6XcbUIno4g0OG6ONs661xLcj81glQyxynY4RZyV8V20T4CiqP504lfQRexdf91yR
         T6yyMB9zHtIwgLiqHYm6DDW9ICbDhMrfE6g2UOsPjcCm275pLgVs4u9QFcnxCizG6NR7
         OEmPWKkJoLcBbZqp4/roCKB2dSYVx7u8I//j6ZSSg484sFXRQFAU8gfTNlroCFYn3FGh
         z+CAdCd4Utp9rsbosmIE4UdL+hd3GPlNvp4xdWeQ+vI5m+vuKZJmzopWvJ/DVjkaEftk
         nzyuwLZ0FSTp3BUJANmO6gVUBbpU10c5D8KeVBUFgE71gWTw7RI/LE3zUwTC1di8skSX
         xB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=o4s8kS/PWf8erqH+PQ6wgJWWsII+FH1AJ+p5J5uLWR8=;
        b=Oww32aE34rcil7WFfndJQbCDoD4vHxLubzOXCNEcCmnm3ujqde+i65N9Zn7j94zqKb
         YsLFSrkqY0ZcdFr+08U8PxNw1sxTHpNScYq1WDlLtfiTN64Z5ctVcR5ZHAzDgVBvui43
         Fahzz1Kz9Iqxq7tM8srqQ8lCxNB3vMa7kOGdgKwdD90oVMMPCdSBIgsc0vhnLfVPVGkO
         9sVTJs6C/mQj+50ch3N/ssOjTRDEgphu9PHnLl/W+9E2EqWtj8aO4e6SI7Pe1N8B0W26
         5oUDjFM0WSX+HARK5PaG4NJGpTQwjGQvaR4jYaoJMxjTilpgPHhZ+iMROFXZEJixZZ1j
         kSEg==
X-Gm-Message-State: AOAM532FjRY9PvBAW7z8lry5PMyc6+7khhuxrSRHFpaNIyHnNpxyVdwM
        e8S07AGGkU51AaPAGDe3OzA=
X-Google-Smtp-Source: ABdhPJwQKDqrGnvDvay429lK+FF74tQNrh+Q0yOLT+JilYb7KFQr6cMRd0LQEVpBBEr/3CHfqorShA==
X-Received: by 2002:a17:902:b48d:: with SMTP id y13mr11209040plr.75.1643915608282;
        Thu, 03 Feb 2022 11:13:28 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id y41sm30674279pfa.213.2022.02.03.11.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 11:13:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: check-ignore: code-quote an exclamation mark
References: <20220203101643.1987-1-philipoakley@iee.email>
Date:   Thu, 03 Feb 2022 11:13:27 -0800
In-Reply-To: <20220203101643.1987-1-philipoakley@iee.email> (Philip Oakley's
        message of "Thu, 3 Feb 2022 10:16:43 +0000")
Message-ID: <xmqqy22ru5k8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> The plain quoted exclamation mark renders as italics in the
> Windows pdf help manual.

HTML rendered version shows <em>!</em> and depending on the
stylesheet it would become italic, too.  It can be seen in the
pre-rendered versions I ship at [1].

> Fix this with back-tick quoting and surrounding double quotes
> as exemplified by the gitignore.txt guide.

This becomes "<code>!</code>" (with surrounding double-quotes) [2],
and making these two pages consistent makes sense.

> While at it, fix  the surrounding double quotes for the other
> special characters usages.

This changes also sounds good, too.

Will apply.  Thanks.


[References]

*1* https://github.com/gitster/git-htmldocs/blob/master/git-check-ignore.html
*2* https://github.com/gitster/git-htmldocs/blob/master/gitignore.html


>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>
> Since V1:
> Corrected finger trouble with special character when copy-pasting.
>
>  Documentation/git-check-ignore.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> index 0c3924a63d..2892799e32 100644
> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -33,7 +33,7 @@ OPTIONS
>  	Instead of printing the paths that are excluded, for each path
>  	that matches an exclude pattern, print the exclude pattern
>  	together with the path.  (Matching an exclude pattern usually
> -	means the path is excluded, but if the pattern begins with '!'
> +	means the path is excluded, but if the pattern begins with "`!`"
>  	then it is a negated pattern and matching it means the path is
>  	NOT excluded.)
>  +
> @@ -77,7 +77,7 @@ If `--verbose` is specified, the output is a series of lines of the form:
>  <pathname> is the path of a file being queried, <pattern> is the
>  matching pattern, <source> is the pattern's source file, and <linenum>
>  is the line number of the pattern within that source.  If the pattern
> -contained a `!` prefix or `/` suffix, it will be preserved in the
> +contained a "`!`" prefix or "`/`" suffix, it will be preserved in the
>  output.  <source> will be an absolute path when referring to the file
>  configured by `core.excludesFile`, or relative to the repository root
>  when referring to `.git/info/exclude` or a per-directory exclude file.
