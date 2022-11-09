Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36D2C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 16:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiKIQKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 11:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiKIQKI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 11:10:08 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84C622BEA
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 08:09:51 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id o140-20020a4a2c92000000b0049effb01130so1067332ooo.9
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 08:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEZnb3E1JxnJwDbJ9Cb/awdgjTOqOTeYkGb7s1O2/0c=;
        b=WyfeBVTI687CaPVMtCHH42euyNnlrZz26sBzI6gAtOWEs7I/9UMeqEfW/T2UEtZKy4
         RfDXhVIJpt+JHXEADR3wXJSBukbBgSp/bAOmEVV3qKr6G6iwirptbRhSUtvtSHWd0Ybr
         GAv875uj25zeEAELH3c4uBkPMHCP1dgLhtQ6whjmBYXyPS1aXWm7b26MYEWipP/4L3xM
         zpcJv0F8Z6vbylpR7mXLRQHVJo2OhkHDa56RN9Ey/jq3NNnS1CSnfW+LoyiElfbye7sn
         vW2Wf+6l/jHB9q+fOJtxOb4b1euTEIX1hSdMQ4dl6q14vV/KLon5hIYjkF4E6etwNUyh
         5IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEZnb3E1JxnJwDbJ9Cb/awdgjTOqOTeYkGb7s1O2/0c=;
        b=B9U5R1uXSvO4tDWhjIL0PEbuSCGDhT95rUHAxE6RAcNGI95uKsJFTjxWbkPmOHGouR
         +OD4EcrRbmrw2iMr8/0KxM09TirUs8uQhjT0myY9ZSTBd/u3OUSHN+Aiq/Z2b50rMTv5
         eYn6pPlhk1JJ7MZQo1lHdTtKEWEk9+9ZplHDul7nKZvG/2TvHRA+JFEHmujlkOsb2QY2
         N5HEyOmoqZ6TWBaQEq1kvvgOgRvR5Q5wy+eQs/2Kz2nWuoPaUlAqGJy67yH7Q9kM4Vjb
         /jCJLm1oGF0aOCeBNWAqTjt+93ifiq37TxnrZhE7+0cxiptcY4XY41Xt4esRnhMY/yZl
         DdNA==
X-Gm-Message-State: ACrzQf0SyH929HI5tq61Qi/u3DIpEcYDoeIuFRj0OaNN9BjEE0jIz803
        FZrq3hSGJaAHRr7HHi+yX1AKlTYu6ZbxeocQjsM=
X-Google-Smtp-Source: AMsMyM6vEBmpKt1d1EmA5CZJSwR+pN47+vNZaOtGB23YxdgiBDDYmNFoB3d7oRsGCxUUyQu6ze5Heyotj22i7isdv08=
X-Received: by 2002:a4a:bf16:0:b0:481:1436:49ac with SMTP id
 r22-20020a4abf16000000b00481143649acmr25787108oop.28.1668010190865; Wed, 09
 Nov 2022 08:09:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.1412.git.1667989181611.gitgitgadget@gmail.com> <Y2uoko+ho9c5sfKf@coredump.intra.peff.net>
In-Reply-To: <Y2uoko+ho9c5sfKf@coredump.intra.peff.net>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Wed, 9 Nov 2022 16:09:14 +0000
Message-ID: <CAGJzqsn3-_qM8K8_+5=z7-u-n1Oe-CfgjrSLF84RaFXUDMOChg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: increase example cache timeout to 1 hour
To:     Jeff King <peff@peff.net>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 9 Nov 2022 at 13:18, Jeff King <peff@peff.net> wrote:
>
> > Instead, nudge users to make cache more usable. Currently many users
> > choose store over cache for usability. See
> > https://lore.kernel.org/git/Y2p4rhiOphuOM0VQ@coredump.intra.peff.net/
>
> I don't see how my email argues for this. The only thing I mentioned
> about credential-cache there is that it's not available on all
> platforms.

I'll amend the commit message.

> But if you want my opinion on its usability, the main problem is not
> that the cache timeout. It's that entering the credential at all is a
> pain, either because it's a semi-automated environment that needs to
> operate without user input, or because the credential itself is awkward
> for the user to enter (like a long token). And that's what pushes people
> to "store" over "cache".

I agree. I have some ideas to help human users; I'll share in the other thread.

> The patch itself is obviously correct.

Thanks for the review
