Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8872520248
	for <e@80x24.org>; Sat,  2 Mar 2019 03:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfCBDaH (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 22:30:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36760 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCBDaH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 22:30:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id v10so22195818lji.3
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 19:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p25szKsO8VHru+fqK+JegHBp+kHv4fWvg+IM17EAj8w=;
        b=WKBYyd7IHe+ypoluTqev8CY9X8VqmGuR7EwnnylT8G4mZJzvD2aYVPQIrjE+lJbZNi
         2IoA6LOb5vguAaXouf7hqL7yv/NwJHNaeLWRclKIFw0aSAHRv2TD2DZbf87thxW67q8B
         a+hGJBG2gp8ugfxQgOQVFGBU+5sSmaDd1Dx/ca6MXoR6uGAhvq/0bud7Eh45WqtOZak7
         OuW1Z/lJhImHWwdU1XSFCosm3M3XMheARnjj0fj4CJbPCXQsydz9WqRHZPxAXEc1f2Ry
         BRKKBH/nBRM6Y6RaHLk7rS3Tu+3ft7LCt5BrzAUGCtzvD92IdVHM5p019XXWJx7F7e4Y
         ZiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p25szKsO8VHru+fqK+JegHBp+kHv4fWvg+IM17EAj8w=;
        b=bAcKB9lX+PaJehi+VXDXIy3WeNFdVNor1rg5Cj7OoGus5E/Qk/fyXe0CqlF/Q0fT0/
         vEu2DgQ3JoPl1s8FCRnnNcKZeaMjphmkwYKvU96mlqePHBmoUvEYsbFeY4Q2d/ICDSFr
         bidamR7hiCZ8uz8skgUcXAlh5pjxUAsRs5covtjHSxzNCufZn1B69HanKDWnQEcfFHSN
         kplFYb9kub5RCwKVPXUaZ7jnq80TiZK+/fNPy0D/8BUulfg5G1cJ5cFU1+TjuM+YeBhl
         GHf2hIeWlM2DlcqHg10VUbDaGG2CCxUhKFKZy21EssoduVSYyE9kkScpAyTqLMy5jIK7
         W6Ww==
X-Gm-Message-State: APjAAAWvG0nru3uqpAnbii0Y0d1u7RZLTZ4v8Gxi4sVbKN6yWjID3wWK
        uz5vxaq5EJxxs7WuvuLQ+0WSckXINVepCHaPaWg=
X-Google-Smtp-Source: APXvYqykSlCzOhcGKWwqoJlUgGjwmPrKA9u9YrsHEvlsdU2bZ1GsVZcZOMesroQFryPCGs9YxCpmHwE19MTcr2YFGbE=
X-Received: by 2002:a2e:88d0:: with SMTP id a16mr2093920ljk.77.1551497404742;
 Fri, 01 Mar 2019 19:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20190301171304.2267-1-brandon1024.br@gmail.com> <20190301190954.GG30847@sigill.intra.peff.net>
In-Reply-To: <20190301190954.GG30847@sigill.intra.peff.net>
From:   Brandon Richardson <brandon1024.br@gmail.com>
Date:   Fri, 1 Mar 2019 22:29:38 -0500
Message-ID: <CAETBDP6oX=NtiOux=5_5t3cj8Vb2QFyfTPmj1h4dOW2oa-hurA@mail.gmail.com>
Subject: Re: [PATCH v2] commit-tree: utilize parse-options api
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 1, 2019 at 2:09 PM Jeff King <peff@peff.net> wrote:
> I think you want an "OR". Or even separate conditions, since really this
> is just implying OPT_NEG(). In fact, you could implement and explain it
> like this:
>
> diff --git a/parse-options.h b/parse-options.h
> index 14fe32428e..d46f89305c 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -202,6 +202,18 @@ const char *optname(const struct option *opt, int flags);
>                 BUG("option callback does not expect an argument"); \
>  } while (0)
>
> +/*
> + * Similar to the assertions above, but checks that "arg" is always non-NULL.
> + * I.e., that we expect the NOARG and OPTARG flags _not_ to be set. Since
> + * negation is the other common cause of a NULL arg, this also implies
> + * BUG_ON_OPT_NEG(), letting you declare both assertions in a single line.
> + */
> +#define BUG_ON_OPT_NOARG(unset, arg) do { \
> +       BUG_ON_OPT_NEG(unset); \
> +       if (!(arg)) \
> +               BUG("option callback require an argument"); \
> +} while (0)
> +
>  /*----- incremental advanced APIs -----*/

Ahh yes. I had originally used ((!unset) || (!arg)), and second guessed myself
before I submitted v2. However, I much prefer your solution which reuses
BUG_ON_OPT_NEG(). I'll switch to that :-)

Brandon
