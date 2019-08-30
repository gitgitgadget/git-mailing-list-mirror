Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 977611F461
	for <e@80x24.org>; Fri, 30 Aug 2019 09:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfH3JJu (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 05:09:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36110 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfH3JJu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 05:09:50 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so12619532iom.3
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5tuHPHD6IpNGURqWFM15tNoctll5lXF/lBom2xTL410=;
        b=hsyb5z0mj8KCrMsawcEx3pFAqPhir2E6GGTgpdFD7TdaEDZrDotTtZlI8RmgbJPz/L
         fj/RYbbWUL7jdOdJxE0Yb0NyXk/AarPrARGVGqNeh1K11LaqjiJ0gV/MSX3+FdnmqJIm
         bunM7OWlnFXl6snsXE4DZ2SZyTf68AtPHWFG0RfAzAH4HgvobOlDTensglW0fMPBAJU0
         Q+TSMK9ceAFTIHldxDZNWEKvoAgf+VqPm5Q2RVLziB6kmDuaYp6bZrEj62/HBnAqa37t
         YJcNxx163EeBfZWiMZLlA6amtVYrzJT9ABHvAvT40f450/NUjew0MDEJMihLwmcFl4TZ
         J/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5tuHPHD6IpNGURqWFM15tNoctll5lXF/lBom2xTL410=;
        b=Z3Xf5nPoWhS7ug77k1VDOcyxcbkWjnzlZZqJv1aiiV64+sNWALbOau/V+7p2Q3xoYV
         Y5JEtByf2UyysJOrjBSPUJKYt12Wa9AI0uOEe4KpS82H932SNJ21oPnnipyImeOmE0ka
         yzrfZeiZIyKkzZVHHl3mZROnbbgARSpEb45zZBiYYgsoqkHfVuAZHpPHv74j2qLytKSw
         EGxfoMYQ9TqenrRtOApXuokhqiEVv1QB+eK47psNKGBjYNm5rujH2Dqi+PRbwBTKvzq6
         81IGBTjRxrVtXw7jCf+sWLNlQ4puULWU4wh35fqw8mzf7YHybNeNPfwqu96j2DdLqyaJ
         Wn+Q==
X-Gm-Message-State: APjAAAXNbVK4XLRzZNwq/J/LBOt+E+3r0q0glxyykOom5JJG0b4QfGyx
        AkCIU5bkK04jENwiaBNWMBHXK9TezG4PTiD9VDo=
X-Google-Smtp-Source: APXvYqwJaZHkbXrQQa1XAl63xTbsZejXYkRldQEp9I/aclJ/BzRn//I8NwWrzdri/xQKhBzFVnBckaS6mtbkK9ASvhs=
X-Received: by 2002:a6b:4014:: with SMTP id k20mr4776505ioa.277.1567156189325;
 Fri, 30 Aug 2019 02:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566863604.git.matheus.bernardino@usp.br>
 <4920d3c474375abb39ed163c5ed6138a5e5dccc6.1566863604.git.matheus.bernardino@usp.br>
 <CACsJy8Dry7MfKBi5EKw4Ka9r63QVmDjPv9nAozS0mC6Z7-sG=w@mail.gmail.com>
 <CAHd-oW4h80xrp6y65dqZbq_a67ncArC9rrNq7F7rAhBbrALOkA@mail.gmail.com>
 <CAHd-oW6doh=06nxUkMLWZOwNMyUOogLRbLstD0bJVQxLauR_Aw@mail.gmail.com>
 <CACsJy8DpTxpejkOHCYPnt3saC-h-3Ez0TthAPnPvHHThaG64bQ@mail.gmail.com>
 <20190829140013.GC1797@sigill.intra.peff.net> <CAHd-oW6JdTSWHy6UwGhL5PUoiscayh9xVqs5ktsXzotg_vexmQ@mail.gmail.com>
In-Reply-To: <CAHd-oW6JdTSWHy6UwGhL5PUoiscayh9xVqs5ktsXzotg_vexmQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 30 Aug 2019 16:09:23 +0700
Message-ID: <CACsJy8CzNBWHtaO4E4efTKU5ZJ=rH5uNEW1YNzRbofxwAVpTzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] config: allow config_with_options() to handle any repo
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 29, 2019 at 11:44 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
> > I'm sure there are other gotchas in the config code, though, related to
> > things for which we _do_ need a repository. E.g., include_by_branch()
> > looks at the_repository, and should use a repository struct matching the
> > git_dir we're looking at (though it may be acceptable to bail during
> > early pre-repo-initialization config and just disallow branch includes,
> > which is what happens now).
>
> I think config_with_options() is another example of a place where we
> should have a reference to a repo (but we currently don't). When
> configuring from a given blob, it will call
> git_config_from_blob_ref(), which calls get_oid() and
> read_object_file(). Both of these functions will use the_repo by
> default. But the git_dir and commondir fields passed to
> config_with_options() through 'struct config_options' may not refer to
> the_repo, right?
>
> I'm not sure what is the best solution to this, though. I mean, we
> could add a 'struct repository' in 'struct config_options', but as you
> already pointed out, some callers might not have a repository struct
> yet...

Early setup code has always been special (there's a lot of stuff you
don't have access too). Ideally we could have a lower level API that
takes git_dir and git_commondir only, no access to 'struct
repository'. This is used for early access. And we have a higher level
API that only takes struct repo and pass repo->gitdir down to the that
lowlevel one. But I guess that's not the reality we're in.

Since early setup code is special, perhaps you could make 'struct
config_options' take both git_dir and struct repo, but not both at the
same time. Early setup code sets repo to NULL and git_dir something
else. Other code always leave git_dir and git_common_dir to NULL,
documented to say those are for early setup only.

PS. Again still not looking at the code so I may just be talking rubbish here.
-- 
Duy
