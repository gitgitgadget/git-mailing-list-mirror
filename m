Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF1AC35240
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF4F206A2
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 01:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="ViPaI4w9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgAXBvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:51:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43006 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgAXBvo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 20:51:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so588769ljj.9
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 17:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8sF9NnZRjSF5NUkGO9YTwUc8s3aKmWVdotQa5E7guQ4=;
        b=ViPaI4w9JvVk5zfuIN6ueUxW5NPGwqRgq3zDuZj6Ya+dEgecrlhI0oLP/jnUi6C5mC
         KjhzBf1APCVe5mml3yiQqSYGk3qwQe5KcwyBbQwsKEn4EkjVaKx3/yo9Gvh3bSjfX8Ap
         TyDOXDQO64e+mv+mLBYlPBDnWkkEpYjnZKKAmSuQ8e/qJt/fCfnrDcMFcvGuESUQOaWc
         2YDYt+a9MgMC+5zT/ENWIBmHiPB/aXLzAUzfe3EmtOGSC27anbXYLPf8JuqsNJBWGU2V
         NSkzUUuWN9xDUxGXY5GIq4KXgvsPgK2dWesPITAkcLFLBrqpWQADgC6M/rTrXJdWNjKT
         XWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8sF9NnZRjSF5NUkGO9YTwUc8s3aKmWVdotQa5E7guQ4=;
        b=bECyt/Jv+BUBAKzZ/YU3CS7PlclwUri+b+Y+LGNGdWzHOX8xcKolRSXI7b2SoSct/C
         FnzF1c7DkuhGX1Lmga4kTx/QM/gbX3ESgIQbWix1zZbVOFwP3Y6dfvU52MKhf7DCXfM0
         sIQk9dMb32aukSnGSEo0osMNJyxzQVJvOvXJO5U3RTVAb34Vm+YbN3sby2/lzdINHwyy
         UTIIGvTXtfUoXpOMwDhraZrxmx8I607fp6rm8cJ5GdVDbQw2C8vsa34/6ngUW+yc+BTx
         lImPwE89gqoICNhQhFKG/VyuyXXXxD95ProPT4EJmwflyhysrub9aCH11sNbiD3a3IYj
         mHvg==
X-Gm-Message-State: APjAAAXZPUqLdSK8qhtRuki17oeuatnQuteJQcWwapCjjV8GYl/pkQRG
        cmZ+3Se+sbmenIenNvQ/8W+vAv7NpE8sIt7zXeNjrg==
X-Google-Smtp-Source: APXvYqxsX8ec4tJzKgnZbKQxwqv/n/oEerLTKIZWSwsEikz5JkEO9rAFTSFvVF46DvAMI+5bb1/xeuGX3Cge987rMQk=
X-Received: by 2002:a2e:884d:: with SMTP id z13mr764640ljj.116.1579830700153;
 Thu, 23 Jan 2020 17:51:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579805218.git.matheus.bernardino@usp.br>
 <6ec39af930871496dd7694ea27eeca69d5d60c96.1579805218.git.matheus.bernardino@usp.br>
 <CAN0heSq3gvZeUXnqzbjFY-1axmFXEJDO4oRp9abRO8TuxJQuDw@mail.gmail.com>
In-Reply-To: <CAN0heSq3gvZeUXnqzbjFY-1axmFXEJDO4oRp9abRO8TuxJQuDw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 23 Jan 2020 22:51:29 -0300
Message-ID: <CAHd-oW4NM_ZdCeW_HBZxcZrd47v3uMn96t+nHLZt3Pe3R6vfWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: sparse-checkout: mention --cone option
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Martin

On Thu, Jan 23, 2020 at 5:28 PM Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>
> Hi Matheus,
>
> On Thu, 23 Jan 2020 at 20:02, Matheus Tavares <matheus.bernardino@usp.br>=
 wrote:
> > In af09ce2 ("sparse-checkout: init and set in cone mode", 2019-11-21),
> > the '--cone' option was added to 'git sparse-checkout init'. Add this
> > option to the respective doc file.
>
> Nit: s/respective/corresponding/
>
> "Respective" sounds -- to me at least -- like you're tweaking two
> different files. Maybe that's just me.
>
> >  To avoid interfering with other worktrees, it first enables the
> >  `extensions.worktreeConfig` setting and makes sure to set the
> >  `core.sparseCheckout` setting in the worktree-specific config file.
> > ++
> > +When `--cone` is provided the `core.sparseCheckoutCone` setting is als=
o
>
> Nit: maybe add a comma after "provided". Without it, I could see someone
> false-starting the parsing as "provided with the" or even "provided to
> the". Those readings obviously don't work out in the end, but with an
> extra comma, I think it's easier to just naturally read this the way
> it's intended.
>
> > +set, allowing for better performance with a limited set of patterns
> > +(see 'CONE PATTERN SET' bellow).
>
> s/bellow/below/

Thanks for the comments. Junio has already addressed them[1] when
picking up the patch :)

[1]: https://github.com/gitster/git/commit/a402723e488c66bd12cf674c332f185f=
ee1d2347
