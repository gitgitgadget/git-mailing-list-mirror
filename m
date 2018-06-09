Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F441F403
	for <e@80x24.org>; Sat,  9 Jun 2018 14:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753261AbeFIOYc (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 10:24:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41839 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753207AbeFIOYb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 10:24:31 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so9831949plb.8
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BoIEW9yqXg9zQPyYxNyHj1y9GUjRRVUMuBqZpIYa3WQ=;
        b=pq5yL5SFG/Xa3HZH/Ur/PMko/TGV7Y58f8awkLmtgq0XvF4LO5PKJ8HRXpd3yYiBgi
         JKl22SY7xHYrsu+qQihDjnaSqiTuLfjqpNXR4z1UBm+0KYhr9qwQJxQJZgI84NZfrzv5
         PWtBtAysnkSz4lp/ZSBRyHrk6wVkNadUDwDfwA9mJkVZ3eAnh5DpEX+afLpHSN0vFzgH
         yvJIKdbWJsJYUFx3xyqKWPlOOvw54lEA4NynAfD3D4SDe3kUTwY/HcU7lSh68cMUOxFi
         u05UvcbltST1l9RrTrjes+Ojqya4nZY1FYW+jV6j14nL96/3I3QG5VUIIz+36dMapMWA
         7KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BoIEW9yqXg9zQPyYxNyHj1y9GUjRRVUMuBqZpIYa3WQ=;
        b=GWmstGN01q+bxkfCsrxIqDbxrZXLe3FL9gJP4xDn77rNHad3ydu02nUW7jP4NVz8U2
         drWFAMwlMPBn1wDFVf40n4TzJEkVYS1+Pznj78zbSvzcX/v5W4NGnfMvLkA9u/UtnBm4
         iu9IK9ty3/LzefaXamKznJI8AhAgqnpkYkUriuoGlqrRWYeI/8zavu1ezg+QmmVUfrGp
         ktg/ZBW7gPXtLdM4533NcOFmZqtBQD4e6xlMI9tCejaeJWPFoqgqw2G/CJxOCxjzhiDa
         Qv+F8cMveRaScKBzdajdfTpv6vEVOYWdziDK+DhwtHRnUNGkWIkJgrwVgFZmRHPGJkbf
         jM7Q==
X-Gm-Message-State: APt69E1LOZYNFn68Fft1LBfu2k2/qRG9n4mvwK8UcfIo9uGHb+7mtdaA
        szGQ9QEHXf29G9fA80gPbIs0RulrzgisENFhzsM=
X-Google-Smtp-Source: ADUXVKIaTu/JvCwSER2molnmMlwh62/eZzAfbmT7gp7+YLgEG490Bu81c5j3qDbtQw5RMRkzynqH0Dgj3wjNJCZvq5Y=
X-Received: by 2002:a17:902:9a95:: with SMTP id w21-v6mr8686746plp.168.1528554271487;
 Sat, 09 Jun 2018 07:24:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Sat, 9 Jun 2018 07:24:30
 -0700 (PDT)
In-Reply-To: <20180608224136.20220-18-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com> <20180608224136.20220-18-avarab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 9 Jun 2018 16:24:30 +0200
Message-ID: <CAN0heSqrgUw1u8Ykk-9eGosWwFS0NFM7sLBe5Loo4cN=tkrXaA@mail.gmail.com>
Subject: Re: [PATCH 17/20] abbrev: unify the handling of empty values
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 June 2018 at 00:41, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gma=
il.com> wrote:
> For no good reason the --abbrev=3D command-line option was less strict
> than the core.abbrev config option, which came down to the latter
> using git_config_int() which rejects an empty string, but the rest of
> the parsing using strtoul() which will convert it to 0.

It will still be less strict in that it accepts trailing garbage, e.g.,
`--abbrev=3D7a`. Probably ok to leave it at that in this series, but
possibly useful to mention here that this only makes these options "less
differently strict".

I also notice that the documentation of `--abbrev` starts with "Instead
of showing the full 40-byte hexadecimal object name" which doesn't seem
right. I get much shorter IDs and I can't see that I'd have any
configuration causing this. Anyway, that might not be anything this
series needs to do anything about.

> +               if (!strcmp(arg, ""))
> +                       die("--abbrev expects a value, got '%s'", arg);

> +               if (!strcmp(arg, ""))
> +                       return opterror(opt, "expects a value", 0);

> +               if (!strcmp(optarg, ""))
> +                       die("--abbrev expects a value, got '%s'", optarg)=
;

> +       test_must_fail git branch -v --abbrev=3D 2>stderr &&
> +       test_i18ngrep "expects a value" stderr &&

> +       test_must_fail git log --abbrev=3D -1 --pretty=3Dformat:%h 2>stde=
rr &&
> +       test_i18ngrep "expects a value" stderr &&

> +       test_must_fail git diff --raw --abbrev=3D HEAD~ 2>stderr &&
> +       test_i18ngrep "expects a value" stderr &&

Mismatch re i18n-ed or not between implementations and tests?

Martin
