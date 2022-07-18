Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7B3C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 15:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiGRP22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 11:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiGRP20 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 11:28:26 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D3B2983A
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:28:23 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o26so8977836qkl.6
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xyplpVcjk912bkie/HURunN2k34oxUobs7yNHx4c3FU=;
        b=Of2RyR4aXXwvs9SvYjdCQ6dJPP4cKkPOUL8DeFhwJqNP4l9zoFXrj4lYaKvLlpwpeJ
         1j/f91w0genfX1h3OF+E/R+6dJJpDXa5HpMeMQ5SdqVyy4uwG/zZA8J7AntF5hHg3ow8
         svn8wEPRD1Iskfm94cco2rsED10rjqT0xavDxgIq9SaemmkYFOnU46dAEA9pIbpaOTUe
         6i6gTFpChDpvq/ICOS+e0An7pSTnO0Olv2fDPcyvl1o1s62u9eLFE+4OToH1GK6D/qc6
         we0WL9b3zMD0DZAixpqsmoKySCo4/0mFgPYFNZIecjzHHRMkjBTE2emWu1lCPHqDD8Ml
         p0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xyplpVcjk912bkie/HURunN2k34oxUobs7yNHx4c3FU=;
        b=UePhIpFIlpZWkuqPd3PGtAoridtzVPnMY6oLtzyOQUxasw+xP91EsLvsh/IGTDB14I
         dspb1jjuXFTJeMRwgIosi9DrA29BYD7+XcCuApQf2RnrsxzNRIP3J75liOYga0YNdeIb
         3O2BWosW+nufqyjtqFBr7Ckg0EixLxo22VgJN3etv+iGFo0wyG4ClGHXAVepDCN/dgA0
         tdThX1KlrhlngzaG48UVQI/3yte6XrGjCSC9sP3+t5fjX5VS4E9sCEmz2oheTazClcbC
         dDCWnR/CiIG/yvEDjaZNNaCwpRAeongRamXC8pRs5J6ulOh+piI+rbFR11MzDxSpzT6u
         CR5w==
X-Gm-Message-State: AJIora9Gp0Sv3ptckv5Ar4sV/n8YgaH7Pvs9eqGKPYG/DlqzTwNbQcao
        vhjE13Xvo9e4uGwn1RsqYLUvthjiHoJxtlLl+fs=
X-Google-Smtp-Source: AGRyM1t6ImsKueLwkDMmnbI7hgD2b01JVIrFN9E+sBotYubop5zCFbSYqO7oSqSm8W2FQia963h6b/4tQshSvQ8u0Ek=
X-Received: by 2002:a05:620a:754:b0:6b5:eb92:42e5 with SMTP id
 i20-20020a05620a075400b006b5eb9242e5mr3176797qki.183.1658158102063; Mon, 18
 Jul 2022 08:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220718100530.2068354-1-martin.agren@gmail.com>
In-Reply-To: <20220718100530.2068354-1-martin.agren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Jul 2022 08:28:11 -0700
Message-ID: <CABPp-BFGPbNNpoYRUogxQP7YvbEKJXyHcS13DEpG-tTr8RCzhA@mail.gmail.com>
Subject: Re: [PATCH] config/core.txt: fix minor issues for `core.sparseCheckoutCone`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 3:05 AM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> The sparse checkout feature can be used in "cone mode" or "non-cone
> mode". In this one instance in the documentation, we refer to the latter
> as "non cone mode" with whitespace rather than a hyphen. Align this with
> the rest of our documentation.
>
> A few words later in the same paragraph, there's mention of "a more
> flexible patterns". Drop that leading "a" to fix the grammar.

Ooh, sounds like a good catch.

> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  BTW, Elijah, it seems like you've recently started using different
>  e-mail addresses, even within the same series [1]. Not sure if that's
>  intentional or not? I decided to cc the one you've used by far the most
>  rather than spamming all of your accounts.

Not intentional.  Looks like it has already merged to next, though, or
I'd reroll and correct.  Maybe I should submit an entry for .mailmap.

(Hard drive in my work computer died somewhat recently.  There, I use
my work email for most things; almost everything other than git.git.
When recloning git.git on my replacement computer, I forgot to set
user.email in my git.git clone to override the value found in the
global ~/.gitconfig.)

>  [1] https://lore.kernel.org/git/pull.1268.v4.git.1656984823.gitgitgadget=
@gmail.com/
>
>  Documentation/config/core.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.tx=
t
> index 3ea3124f7f..37afbaf5a4 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -722,8 +722,8 @@ core.sparseCheckout::
>  core.sparseCheckoutCone::
>         Enables the "cone mode" of the sparse checkout feature. When the
>         sparse-checkout file contains a limited set of patterns, this
> -       mode provides significant performance advantages. The "non
> -       cone mode" can be requested to allow specifying a more flexible
> +       mode provides significant performance advantages. The "non-cone
> +       mode" can be requested to allow specifying more flexible
>         patterns by setting this variable to 'false'. See
>         linkgit:git-sparse-checkout[1] for more information.
>
> --
> 2.37.1.373.g4dd4a117ec

This looks good, thanks.

Reviewed-by: Elijah Newren <newren@gmail.com>
