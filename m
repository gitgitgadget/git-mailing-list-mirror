Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA52C433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 02:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiKLCWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 21:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKLCWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 21:22:03 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4D0391E4
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 18:22:02 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 94-20020a9d0067000000b0066c8d13a33dso3746466ota.12
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 18:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVP4XGip15z0mZgaXvBAIFBFHOX8gTaXXzT7KX30CbM=;
        b=RGFyg3PF3fZbN0H3R6g3tC5o2YAg3bbw9F6hT4Wl/WUpAD+le9+bL5u8sXdgffSHBI
         v+1yZqDj8okjENURpNHMs1R7OujjJzSMbPzWcC/ZdpltMs8hVj3jjGdVX8qGNcaO7nWN
         siL+XyHcI+0GvW8ume2FCki3T4fX9a9oPvnYEoS6pG/VhFeI+Liy+UYHHpJXtFZDECk2
         tcWsai0do/P05T3JWVh0JGhSaMTptWd44BYBVOYTCneiK/oSTQyoZlNlV++VKWZyOu4v
         XVuFqZb2Ehdm33WNkjfjgzOn7NarmaeKObBhWfyazi5WKZ4nEjgt4qIQAVneggf6bJM4
         mRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVP4XGip15z0mZgaXvBAIFBFHOX8gTaXXzT7KX30CbM=;
        b=iNRmuutllAxx35zQkxGEEdEqhW/LtIlH2zMGXqYJBTKuuL9pw0xbWNe20CWQaZk6bW
         hR+jNQB2K5e1LXTWIHmjBh7F3B6anZQzTE/fltoT0B0noSU/cEwbT6Q+CbKUaAdsdlzx
         TUJkSAHdeI7W4ftcIt9qjfA7fQDKxMXSEcntC8oiF+vHAKBmrILjYH/g0vjVCaGiA+Hy
         AyeH70EgcsmnauZBz7HmJnmODQ8iosdn95R3hhcuXqdRBQ665fF3CI9x83ee5HUYlwre
         bW78/Bz1Qca10ocm3Xz5HtPSiyltfa+42HWnxHlud8phoULCrgQdOTEyx03cL/8Ciqfe
         IlOg==
X-Gm-Message-State: ANoB5pnOdqTXdC0TgcJd1wWdI843vEHMDBw4qI+P4jddKokP794sH2tR
        l+H8CWo4oH39WhYNOE9X/s8AR3J291mlTj/Na3g=
X-Google-Smtp-Source: AA0mqf7N44fV1rJbymeL0iwHXp/soxoXR/9nyhxkVWakOuueGsgF1DxSnhaI/mY3QR6UPS73qZ5ml99NKAKjEonkvHg=
X-Received: by 2002:a05:6830:161a:b0:66c:37a2:d876 with SMTP id
 g26-20020a056830161a00b0066c37a2d876mr2634800otr.249.1668219721437; Fri, 11
 Nov 2022 18:22:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1393.git.1666598268697.gitgitgadget@gmail.com> <Y1cm2a3qy9aowwNh@coredump.intra.peff.net>
In-Reply-To: <Y1cm2a3qy9aowwNh@coredump.intra.peff.net>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Sat, 12 Nov 2022 02:21:24 +0000
Message-ID: <CAGJzqsmH0DpEZDVZYU=6XpBO_vPfbirrK7KaWm2RmKG3aAk0oA@mail.gmail.com>
Subject: Re: [PATCH] docs: clarify that credential discards unrecognised attributes
To:     Jeff King <peff@peff.net>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 25 Oct 2022 at 00:59, Jeff King <peff@peff.net> wrote:
>
> On Mon, Oct 24, 2022 at 07:57:48AM +0000, M Hickford via GitGitGadget wrote:
>
> > It was previously unclear how unrecognised attributes are handled.
>
> Yeah, this was always part of the intended behavior, but I agree we did
> not say it very explicitly (aside from an in-code comment!). Both the
> intent and content of your patch look good to me.

Thanks. What happens next? I should look for this change in the seen
branch? https://git-scm.com/docs/MyFirstContribution#after-approval

> We did discuss patches a long time ago that would let Git carry
> arbitrary keys between helpers, even if Git itself didn't understand it.
> One of the intended uses was to let helpers talk to each other about
> TTLs. So if you had say:
>
>   [credential]
>   helper = generate-some-token
>   helper = cache
>
> where the first helper generates a token, and the second caches it, the
> first one could shove a "ttl" or "expiration" key into the protocol,
> which the cache could then learn to respect.

Composing helpers like this is how I encourage users to configure
git-credential-oauth [1][2]. Note that the storage helper should come
*before* the generator, so that `credential fill` finds a stored
credential before it generates a fresh credential.

> the first one could shove a "ttl" or "expiration" key into the protocol,
> which the cache could then learn to respect.
>
> But we never merged such a thing, and in practice I think people would
> just implement both parts as a single helper for simplicity.

Composing helpers has the advantage that the user can choose their
preferred storage. Generated credentials aren't necessarily short
lived. GitHub OAuth tokens, for example, are good for at least one
year [3].

[1] https://lore.kernel.org/git/CAGJzqs=+fCQzkDX53H8Mz-DjXicVVgRmmzPjkatSiOpYO7wGGA@mail.gmail.com/
[2] https://github.com/hickford/git-credential-oauth
[3] https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/token-expiration-and-revocation#token-expired-due-to-lack-of-use
