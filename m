Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1C61F97F
	for <e@80x24.org>; Sun, 18 Nov 2018 19:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbeKSGTl (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 01:19:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45115 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeKSGTl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 01:19:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so20358640edb.12
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 11:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GRztdJ01iYovdrNZ04fZDxQfc9rWnVYpzdhMj38e+Ko=;
        b=DSDu7wKhcFUy8cnSdeEL1eUx4g5KWxybk2ZIVfQGE7D7V3RzXRJKDgRHnw4zk1BW+6
         D8mxsUxBh3JZipj8nqiHRKR/nLnKHfamtuDTIfb8nMvBQM5VRnwJgRB0QUKBBlkaLPjq
         yG6JlTgZzm2z2Czrsl5K5eP9cSoIK1pofP83Si6P/WDfvA14cuQJ9MHEUjQbWH6djvXz
         vqOGfarDBTe37eGN5Q1dnejdVTGP01nRM8dNnlOdNxYTnaifjacYJIM9G+6q+OR742xz
         1vwVEdeIwNrTzWQLO33+Likk+i4sy+MmDN9ADx5VM0fN+I9GBlUIbovQeStEJrxROJB/
         fD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=GRztdJ01iYovdrNZ04fZDxQfc9rWnVYpzdhMj38e+Ko=;
        b=rknmzIICMYhk6pZinaXzyBYfVQJM13959rd/t4cGU2+27J8lrdeaZm5hKY8S1JHLJm
         tVAsKUnz1+/91K0ja9zsiSHJk56JKExckrX39PXW7du9weDaoPD7M0S75BnE1t+sDFP9
         wFx6cISaFiSnIu6EQitppZHChHYtc885w/mcALo4YA828+stvaNVC/Mg8RJAngsarRDW
         qr5VKDjgTfYVJRf7D2e+TIUIj3gl66HC0wy7b5ZHDl4FHfZtmfsTiJkGZjOi20e71PKo
         X8cD9Pg9WbPmz8YnFGkonJeakmGV7jc8i/BrdIScBZMFdmKiZZjdDwUhbIw11YBzGCim
         Ah3Q==
X-Gm-Message-State: AGRZ1gJdCp+Js5weGdXbt9xEzFZoXyXpFizrA059YKB1/ZCz7Es+4kir
        cuzFM7LmnuoqpLK75RiHVEs0rBe34eo=
X-Google-Smtp-Source: AJdET5fNJFA2YyHQRBwgsh3GcNRqUr0Q6CO6ZElzK/xErrGZv5PdghBYC+x7qHv1CQJ8ZrGgJdTwGg==
X-Received: by 2002:a50:e442:: with SMTP id e2-v6mr17823271edm.80.1542571108525;
        Sun, 18 Nov 2018 11:58:28 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id d1-v6sm10565425edd.32.2018.11.18.11.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 11:58:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] tree-walk: support :(attr) matching
References: <20181118164800.32759-1-pclouds@gmail.com> <20181118164800.32759-6-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181118164800.32759-6-pclouds@gmail.com>
Date:   Sun, 18 Nov 2018 20:58:26 +0100
Message-ID: <87bm6m17kt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 18 2018, Nguyễn Thái Ngọc Duy wrote:

As noted in
https://public-inbox.org/git/87d0r217vr.fsf@evledraar.gmail.com/ I'm
happy to see this implemented. I have not read this patch in much
detail...

> [...]
>  Documentation/glossary-content.txt |  2 +
> [...]
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 0d2aa48c63..023ca95e7c 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -404,6 +404,8 @@ these forms:
>  - "`!ATTR`" requires that the attribute `ATTR` be
>    unspecified.
>  +
> +Note that when matching against a tree object, attributes are still
> +obtained from working tree, not from the given tree object.
>
>  exclude;;
>  	After a path matches any non-exclude pathspec, it will be run

Just a poke again about what I brought up in the thread you replied to
in
https://public-inbox.org/git/CACsJy8CLHQ0mKhKXvTDAqy9TLwEFBSvHEu5UbPxHX4is2mK+Cg@mail.gmail.com/

I.e. the documentation of these various wildmatch() / attributes
patterns we support is all over the place. Some in gitignore(5), some
not documented at all, and some in gitglossary(7) (which really should
not be serving as primary documentation for anything).
