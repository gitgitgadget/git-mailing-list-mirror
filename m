Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DEF71F404
	for <e@80x24.org>; Wed, 14 Mar 2018 00:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932710AbeCNAiV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 20:38:21 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34802 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932590AbeCNAiU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 20:38:20 -0400
Received: by mail-pg0-f66.google.com with SMTP id m15so646925pgc.1
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 17:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hebtFnyxmjZI1+POSrnf+8NdyUBo6ku1AFkRKJbIulU=;
        b=qKTGUBrJrtAlPx5/6LXURQGEge4ujFZivt0mFz1FHfPLpyR7Qe5wwxrdjqBY3wkjWq
         65O1Ny834BSGYo8wJn22QTWmLkO5cq6GP1wjno7kVRWEyiHS/bGAG1P5w9RS/HLwKtfB
         t7sLhN6TOqy5MpONDEiQQ3sq/J72ktryb7MDbxgCIHu/71irvZmdF4xFf9aqJBZKX8Yn
         Mvn80tNLOIptIB0ksTmbbc4lS3IcCJbXLxVCBrP6+cXCQJQmeP7LE5R+Fe+770e5m9yl
         Jk4TiU7M0MDJw9zFJZm8fRchGBIw2Qa5IH1KT5xLdkCQs2EdiTRXY0TTcfL/8ALaWXc5
         jBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hebtFnyxmjZI1+POSrnf+8NdyUBo6ku1AFkRKJbIulU=;
        b=N9kQvX7LZZ6Vc1qCceehnVstpNELqwRLFuQpKgtTd8nYag2uHemV04w+Y1iIg1O6Vk
         5+Ee3sJu4EQceKmQ88AjdqLmNBuD6uL8cFqhyNYG4pG2ahi7wCHQQz6WJeAfLz1wA178
         ce5YNttXgyWYNaLLc3XdeKdOa06oblkSfxWXe6EkFPYzhZYW+mHo9BrGF8pY5JLP0zM6
         lronR4Fp7qoE8eilXES/7HNEyDltirsCj6+lrwBeX5MP+mGtLy1jOaN7YWFx4uan1eDS
         SlZyDJxsvErDM8Ik+QzBU2G9sRB+Qz2cpMRgZQa7m5nmquQ8kqStX8i48Vh2SGnL7mKp
         f6yg==
X-Gm-Message-State: AElRT7Fa8b52Nr/hm8rSOTWgz7pjXIBfAQQWTXfl1bn4THMOpnt93ia9
        B6H8SmrXUKV6M6ZtTkU+1LOMV0Sf
X-Google-Smtp-Source: AG47ELs3iG/l6Z8PHO43mioWSdYI5Iu4o1M4rkBuCFpWZXe4gTdyj2L/cuYq9zGP3aCSAr9iFXOObA==
X-Received: by 10.101.67.137 with SMTP id m9mr1957508pgp.301.1520987899338;
        Tue, 13 Mar 2018 17:38:19 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i127sm2148957pgc.12.2018.03.13.17.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 17:38:18 -0700 (PDT)
Date:   Tue, 13 Mar 2018 17:38:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Magne Land <magne.land@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/githooks: Clarify the behavior of
 post-checkout hook
Message-ID: <20180314003816.GE147135@aiede.svl.corp.google.com>
References: <0102016220f23987-d4661c81-cf6e-4c96-8487-acce6bb365c8-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0102016220f23987-d4661c81-cf6e-4c96-8487-acce6bb365c8-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Magne Land wrote:

> From: Magne Land <magne.land@appfolio.com>
>
> This can happen when using 'git rebase -i’:
> could not detach HEAD
>
> Based on discovering this Stack Overflow discussion:
> https://stackoverflow.com/questions/25561485/git-rebase-i-with-squash-cannot-detach-head
> ---
>  Documentation/githooks.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks for investigating and writing this.

May we forge your sign-off?  See Documentation/SubmittingPatches
section [[sign-off] 'Certify your work' for more about what this
means.

The above leaves one question unanswered: is this the *right* behavior
for "git checkout" to have?  I.e. is it useful for "git checkout" to
fail when the post-checkout hook fails, or would it be better for it
to e.g. simply print a message and exit with status 0?

Not a rhetorical question: I'm asking because I don't know the answer.
What do you think?

Thanks,
Jonathan

> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -166,7 +166,9 @@ worktree.  The hook is given three parameters: the ref of the previous HEAD,
>  the ref of the new HEAD (which may or may not have changed), and a flag
>  indicating whether the checkout was a branch checkout (changing branches,
>  flag=1) or a file checkout (retrieving a file from the index, flag=0).
> -This hook cannot affect the outcome of 'git checkout'.
> +
> +If this hook exits with a non-zero status, 'git checkout' will exit with the
> +same status.
>  
>  It is also run after 'git clone', unless the --no-checkout (-n) option is
>  used. The first parameter given to the hook is the null-ref, the second the
