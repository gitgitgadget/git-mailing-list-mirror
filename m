Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261D31F42D
	for <e@80x24.org>; Wed, 21 Mar 2018 11:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbeCULZm (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 07:25:42 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:41435 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbeCULZl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 07:25:41 -0400
Received: by mail-wr0-f182.google.com with SMTP id f14so4803725wre.8
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EoYQBHagJcgCVcTFgxtqgraQFCxTR3tc8BQtGsPESio=;
        b=MErh208RQcuc6aa90nI2EFRrwMmlqUQO8vKiIKxW5l8pR3TCU0kjBO7joxrX6XksYz
         8ERnwoCyR+zrrTHlNQJlqk6WuoPGPiDtWbZx2BjyyfeaVoWfsV9n5p2RED7WkJYpg1V9
         nsGSzMl3n+UgCjUfYzcvbvMuViBhVSOBMvsHAHYVsDsWhe7E2Z3x/9D9JRA0tuAHu1LR
         z5Xk7OQoXolYI0PjILVcRUFp8u1pD7WhdXo/zZZCpu3PkOoqB4IY9ENfp/sCEn45EhHi
         ZeWKLt6r8si3yVo7FZd16ZED0CGtm+Iwx1dMoxukgIoWbIVGujQa6mut5VGYiEz7JK3o
         03Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=EoYQBHagJcgCVcTFgxtqgraQFCxTR3tc8BQtGsPESio=;
        b=kxVVC2TJoPWPaUshxNXsL+Y1IV3oTrNnLPQ4/XN8G3vHKYa92cLCw9HN1dx2hXwATp
         M+tFFIZTzeXdN1lFBmAqJPTuoUObpptoX7VCEQaWum8O5a5aWhbDXIcqdUFS8LYpBdaA
         p9e6/lHMOhXC6/ov5VAEZlDcJCN7O5MWqgzZCxcrcdjlrQkDPtwhEiwzhCKdHbskJ3jt
         +lQieAwWbUzOeEsN7zhDmxbPKdSbKSz2MypYsJMw+17+AtQ1f7zT4zW4KVPQwYT7VSkX
         HU+UQBF4782QY+4TIZotDFRyA8dxd4Dh5/uCl08F79WbP148UBhHeWV3/4JmCzKwjP27
         HO/A==
X-Gm-Message-State: AElRT7Gugw8qxnQzpeHnJrEUtKBWl1ouod8rpr8nBXWI1p9L7Btxy7YD
        qAQYe8ipYoJTUp2dujxUE3M=
X-Google-Smtp-Source: AG47ELvs1hGCrHv6zaLgX83AbqC9qQVC52YmqzPYVT1sl54YcCONzpVBAnvbjLcCe5Fu1ddPXizlmw==
X-Received: by 10.223.139.68 with SMTP id v4mr16721148wra.23.1521631540535;
        Wed, 21 Mar 2018 04:25:40 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id o2sm3713127wro.31.2018.03.21.04.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 04:25:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: [PATCH] doc: clarify non-recursion for ignore paths like `foo/`
References: <CAHnyXxSqtB=bSbA83V6HC6-aPCxw60h1iKQaa6ChwsmcUUCd0w@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CAHnyXxSqtB=bSbA83V6HC6-aPCxw60h1iKQaa6ChwsmcUUCd0w@mail.gmail.com>
Date:   Wed, 21 Mar 2018 12:25:38 +0100
Message-ID: <87muz1brgt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 21 2018, Dakota Hawkins jotted:

>>> At any rate, would it at least be a good idea to make the "trailing
>>> slash halts recursion, won't consider nested .gitignore files"
>>> explicit in the `.gitignore` doc? Unless I'm missing it, I don't think
>>> that behavior is called out (or at least not called out concisely/in
>>> one place). It looks like this is all there is:
>>
>> Yeah, it's definitely come up multiple times over the years. I don't
>> know what all is in gitignore(5), but if it's not mentioned it probably
>> should be.
>>
>>>     "If the pattern ends with a slash, it is removed for the purpose
>>> of the following description, but it would only find a match with a
>>> directory. In other words, foo/ will match a directory foo and paths
>>> underneath it, but will not match a regular file or a symbolic link
>>> foo (this is consistent with the way how pathspec works in general in
>>> Git)."
>>>
>>> Also, I'm not sure what the "following description" is in "it is
>>> removed for the purpose of the following description". Is that trying
>>> to imply "excluded from the rest of the doc"?
>>
>> I think it means "for the rest of the description of how the patterns
>> work". I.e., "foo/" matches as "foo" when the rest of the matching rules
>> are applied. I agree it's a bit awkward. Patches welcome. :)
>
> I hope this is correct. I tried to follow the instructions. Please let
> me know if I need to fix something with how I'm sending this!
>
> -- >8 --
> Subject: [PATCH] doc: clarify non-recursion for ignore paths like `foo/`
>
> The behavior of .gitignore patterns ending with trailing slashes is
> unclear. The user may expect subsequent matching patterns to matter, while
> they do not. For example:
>
>   foo/       # Ignores `foo` directories and everything inside of them
>   !foo/*.txt # Does nothing
>
> Explain this behavior (and its implications) more explicitly.
>
> Signed-off-by: Dakota Hawkins <daktoahawkins@gmail.com>
> ---
>  Documentation/gitignore.txt | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index ff5d7f9ed..e9c34c1d5 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -89,12 +89,17 @@ PATTERN FORMAT
>     Put a backslash ("`\`") in front of the first "`!`" for patterns
>     that begin with a literal "`!`", for example, "`\!important!.txt`".
>
> - - If the pattern ends with a slash, it is removed for the
> -   purpose of the following description, but it would only find
> -   a match with a directory.  In other words, `foo/` will match a
> -   directory `foo` and paths underneath it, but will not match a
> -   regular file or a symbolic link `foo` (this is consistent
> -   with the way how pathspec works in general in Git).
> + - If the pattern ends with a slash it will match directories but prevent
> +   further recursion into subdirectories. In other words, `foo/` will match a
> +   directory `foo`, excluding files and paths underneath it, but will not match
> +   a regular file or a symbolic link `foo` (this is consistent with the way
> +   that pathspec works in general in Git). Consequently, `foo/` will prevent
> +   consideration of subsequent matches, including exclusions (for example,
> +   `!foo/*.noignore`). In order to match `foo/` directories while allowing for
> +   possible later exclusions, consider using a trailing wildcard (`foo/*`).
> +   Note that matching directories with a trailing wildcard incurs some
> +   additional performance cost, since it requires recursion into
> +   subdirectories.
>
>   - If the pattern does not contain a slash '/', Git treats it as
>     a shell glob pattern and checks for a match against the

Just before the context your patch quotes, we have this in gitignore(5)
already:

    [...]It is not possible to re-include a file if a parent directory
    of that file is excluded. Git doesn’t list excluded directories for
    performance reasons, so any patterns on contained files have no
    effect, no matter where they are defined.[...]

I can't see how your change to the documentation doesn't just re-state
what we already have documented, which is not to say the docs can't be
improved, but then we should clearly state this in one place, not
re-state it within the span of a few paragraphs.
