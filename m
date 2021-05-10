Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D9C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 19:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75969613C2
	for <git@archiver.kernel.org>; Mon, 10 May 2021 19:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhEJTi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 15:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhEJTi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 15:38:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18DC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 12:37:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s25so22257777lji.0
        for <git@vger.kernel.org>; Mon, 10 May 2021 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMCt/nnyiUtNlhwkg/luSEikWnRjufiF/ubo5G17e30=;
        b=bu3K1VHoongreH2G9jvC1Cx4YvB+EXJwmRlJCasAlVJJ4kW5Fbth8n8BaAU6MUOFva
         CZn394RHkxweb8j34q3NYTUQmH7od3Wd0wJPGBZafLE0KgSKC+J8ee2Kvn6FcZsM21V1
         5OZ0EX3FPdCcw6JPQ882MmBq74zvFUiLn9wWJVeiqYOKw2y+ebs8OZ4cCH7OgouoHoGZ
         Kdn4eBCzQMTwnVdQf4ExBarLhcoiU1x93q/7u0XOfZdA2a4vioCNsVORWZkH4u8ds6k3
         7GxUPOE1aIWrvtzsyfzOJzFvDlBIszM8S6fkkyMwumX1dskg0JkCo3Aodl6a8pZEn9R8
         cG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMCt/nnyiUtNlhwkg/luSEikWnRjufiF/ubo5G17e30=;
        b=Ugd4ZIQf57OYG0L64A4BzHqsoK9xAeki8SqTOw7vn14Oea1LVV0Yke9HUcePDH4WW8
         eXHeswU5HvJasoSBQJKClAcFxpobFz2lcw2NBFW/M4+ZRoZPxWtgeaPRd6mNUxAXT54Z
         ymN7a748Se8rbc7ri1NV5nXpq2aNplLPKmM60cLpxbYsbnfdWCMXI+GNGvY3F9X1PdyK
         tOXcYxBcNXl0pUkqSJflQDzas8nZrBE3t5rSHs/3FmDr9BwM73dX0x+tC2fP6BdRW/Bx
         NM3Fhu3VzAOo5Pm4sbFMU6Uta3kdAzV/ImI9RKYgQqjFdgu81eEkF+36CvPTq26AM0pJ
         ZaVQ==
X-Gm-Message-State: AOAM531HuVJNkshJDou+KFJsDtMj5HGh+uuqc0id4r41AePcGg7HW659
        1rL2vowh8HxCHxIzM1sFeFliLIlLQhu8CJRk2XykR27OxKs=
X-Google-Smtp-Source: ABdhPJyGcUWFKawwAKmNlPBw1E2Bo1GtccVcF+cuYwnQRv6xMHgRpfZ4IB1rQEh5lBwUKJXURGGrQuaQeFLJwj9Avgo=
X-Received: by 2002:a2e:87cb:: with SMTP id v11mr3317213ljj.113.1620675470409;
 Mon, 10 May 2021 12:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <e4c3d482-03b4-141c-e47b-cb3e175da3ab@iee.email>
 <789bcc9cd074cb94f706b9d432e29b52bf6a33c3.1620134775.git.matheus.bernardino@usp.br>
 <CABPp-BFpeoENLADH-e6dCc0PyEVQyHueY6PV8AZYbD+a3iceXA@mail.gmail.com>
In-Reply-To: <CABPp-BFpeoENLADH-e6dCc0PyEVQyHueY6PV8AZYbD+a3iceXA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 10 May 2021 16:37:39 -0300
Message-ID: <CAHd-oW7veyN+qetv-Mf-qPa+bcah=JCz6mSRAzunVgaFRxdbnA@mail.gmail.com>
Subject: Re: gitignore + commit with excludes = bug
To:     Elijah Newren <newren@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>,
        mailnew4ster@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 10, 2021 at 4:27 PM Elijah Newren <newren@gmail.com> wrote:
>
> Thanks for tracking this down.  Your analysis and patch look correct
> to me, but perhaps we could simplify the code a bit.  Instead of
> looping twice, perhaps insert the following code above the if-checks:
>
> +               /*
> +                * We can have a bunch of exclusion rules:
> +                *    .gitignore
> +                *    *.log
> +                *    !settings.log
> +                * and we're trying to see if the path matches one of these,
> +                * but note that the last one is a "negated exclusion rule",
> +                * for the excludes to match this pathspec, it needs to not
> +                * match the negated exclusion.
> +                */
> +               int retval = (item->magic & PATHSPEC_EXCLUDE) ? 0 : 1;
>
> and then change all the "return 1" statements to "return retval".

Hmm, but then wouldn't something like `git add ignored :^ignored` also
trigger the warning, as we see 'ignored' first, and return 1 before
seeing ':^ignored'?
