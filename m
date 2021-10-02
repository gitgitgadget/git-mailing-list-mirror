Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609C7C433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2169661B3B
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 20:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhJBUNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 16:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBUNw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 16:13:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C12C061714
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 13:12:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v10so48267717edj.10
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nS6Ys0LZgHnuaXSKi1qt3EQLeCDAunULZKJRjAZ2DzU=;
        b=PKj/h4svJDv97kGdHiJ/dHLkh9XjFCRf5mkDW+IMNqALy8pXwJv7HEu8Foz+UUaEN6
         tTSw+JbcZI/0exyyaF2z38oHMVNlI0RlvGbB4UfP1wdwlt7vw9Ncl8NhDJ0ZBDe+fEoT
         9nbSnGnSABhVCK/Cm9YSVwsIgc97cJOnSE6O27xLBhjx6H3FlUfaMrewbUhLu0IKZ+Nv
         ImZkzhf2fNWi5viqfQ7sUuMA+Gfk/QLVwuUo5GDPK1tyKh/Bnoz4w7Kpz3fWHstwZcYZ
         PCiD3a7vcztI6S7yzb1phL2y0og58h7g9auYM/v0CnoJBDvdyyR2CLazx2MMYCLOxUlj
         AaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nS6Ys0LZgHnuaXSKi1qt3EQLeCDAunULZKJRjAZ2DzU=;
        b=AOVejqSKpn2Q0E+SPRhfCw3pQhNEyF8A+8Yzx0f0iW4EbsBtbFXvhgcsYmAQi2pkiq
         PGd+loTCbh4qSOTJ7wkI38ozSOePhXjuHmmV02q1K3gKFn5qjTHGQRzoKBJPWgxmrSfS
         CvexrfFUr13pYO2RpYV+4GhXAWvmPBFXsZMDjAou6xq56Ha1tmoNkHNDPph8frGaAfO4
         c9VkyftLFtsdPCz+ykur+LPAydTRavL2zbolvOJm32uoj7JbDOW7Vu471v9/FbuC3gOi
         2xMeLoXIJr1Fx4UB3qWMf5PwQdNzNxPQsbj9Acdr1Ihua++U1ezKhdb0d4gWCpNoYiQ7
         I9hw==
X-Gm-Message-State: AOAM533qrYAK2neXowdbI533X3rwpv1zBxiuvWWogJdqF6Gn4K2br86f
        WNmP/ixzBkYsFAQZtZeuzke+YnwiFOJCFg==
X-Google-Smtp-Source: ABdhPJzEfhTIr9MK+g/0uRWWojo26eQ/HVcqGCUVCDlMJfQvXOJiUtDwm7aJ9nm8ZE2IkPcUZkbXfg==
X-Received: by 2002:a05:6402:424a:: with SMTP id g10mr4829752edb.26.1633205524354;
        Sat, 02 Oct 2021 13:12:04 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b3sm4458370ejb.7.2021.10.02.13.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 13:12:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 1/3] *: spell Latin abbreviations correctly
Date:   Sat, 02 Oct 2021 22:08:56 +0200
References: <20211002184407.117282-1-rybak.a.v@gmail.com>
 <20211002184407.117282-2-rybak.a.v@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20211002184407.117282-2-rybak.a.v@gmail.com>
Message-ID: <871r53p4oc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 02 2021, Andrei Rybak wrote:

>  On the other hand, if you are fetching because you would want a
> diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
> index d1bc09e49b..fcf7b2daf6 100644
> --- a/compat/regex/regcomp.c
> +++ b/compat/regex/regcomp.c
> @@ -2370,7 +2370,7 @@ parse_expression (re_string_t *regexp, regex_t *preg, re_token_t *token,
>  	}
>        /* We must return here, since ANCHORs can't be followed
>  	 by repetition operators.
> -	 eg. RE"^*" is invalid or "<ANCHOR(^)><CHAR(*)>",
> +	 e.g. RE"^*" is invalid or "<ANCHOR(^)><CHAR(*)>",
>  	     it must not be "<ANCHOR(^)><REPEAT(*)>".  */
>        fetch_token (token, regexp, syntax);
>        return tree;

Let's leave externally imported code out of these sorts of changes
please.

The last time I tried (unsuccessfully) to send a series to update
compat/regex/ one of the frustrating things was the three-way diff
between base/ours/advanced upstream being cluttered by these sorts of
tree-wide typo/spelling etc. fixes.
