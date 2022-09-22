Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A048C6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 15:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiIVPq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 11:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiIVPqo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 11:46:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912AFB656B
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 08:46:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x1so9159545plv.5
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1epnEgarVH4Q5g1YwqR9rKt/8ro/6t0gZQhugv2d7ik=;
        b=ehQRrZwl3ywuNI4Kb0PlS8b9DHh4UUYuBeSpaXBJ+sIXFlDgxwTSW4PKufHWnInP1a
         XinPlKjp3O2Tnt7/tpQp6O+VgavH4FUqSjn+ekIK/1h45y04JgB+GauW2/ptOzwTRtgt
         tS1igh0JQvkJbHp+4E6ixar7qpKJXii2Eg/kTqqtHLcB43iSA8VTiV0J2t+9LAeGw0uO
         HW8zFlbzJnv/vZGeG4crRYx9GQDRXubudZCggGX2C++3eOU2RRXW9eqmL1ceu7ESLqjb
         9YTPRVHaAyeb4xr4ydwveokq7i51g+cAYtEGiQNLzMbnDtPWQ/eaSQ8mB8r/YPPoGCK6
         FPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1epnEgarVH4Q5g1YwqR9rKt/8ro/6t0gZQhugv2d7ik=;
        b=wqmXVtL1+v6z4PeDno4hBo+z5CpXBYpxOEomoj9J7pC7SQ6ZEBI3P1LA3exZJkvbLZ
         0hDJ0oTVtREK4hJ+amALjbGpC0kJnhRwpJdEGC1pZM3rD6AAjyQV6xuuuTSUhsQr4bDd
         MTJye54fX3cjoitYVAfQI81T/g2voZ+MHjnynKJnDbgKv25bWyK52pGTV0AbdhUMYhBw
         OlMOpEitrllVF6ru23yiHytcEW0GgqqiAyPGPhM9eZcj2HZ9dBSFMMoGUs64KQSwHeF1
         +1UuAyEbOsenJ2Ajm6LtoPWxug82ujPN1widPCHa2gwJaQDk3mE66b2RniVcC/UQNOnl
         uUxg==
X-Gm-Message-State: ACrzQf2ADndQVM9ob1rNz46Dod+pjOZSVtnCRYqPRAIX+wXCySeEyX3g
        KljlYAO5dkxq9zF782fxB60I/BpzC+c6VUFBUVUfEH4g1IXz3g==
X-Google-Smtp-Source: AMsMyM5bT4QdbsnI1+nUsL4QTRNBRJ8D4Vio6k+LblH6xBc+I9o4Eakbtus6XK4qvGuvZYC21jYZqa9rIkQ3gleIvgw=
X-Received: by 2002:a17:903:32cc:b0:178:3d35:dfc4 with SMTP id
 i12-20020a17090332cc00b001783d35dfc4mr3966962plr.116.1663861602044; Thu, 22
 Sep 2022 08:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220922061824.16988-1-jacob@initialcommit.io>
In-Reply-To: <20220922061824.16988-1-jacob@initialcommit.io>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 22 Sep 2022 17:46:30 +0200
Message-ID: <CAN0heSr8HFR1y+aZUjFaeY3y-9yn+nfyDrkxQh82punLnSonGg@mail.gmail.com>
Subject: Re: [RFC PATCH] shortlog: add group-by options for year and month
To:     Jacob Stopak <jacob@initialcommit.io>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

On Thu, 22 Sept 2022 at 09:48, Jacob Stopak <jacob@initialcommit.io> wrote:
>
> Oh and third, for documentation, I updated "git-shortlog.txt", but
> wasn't able to test "git help shortlog" locally and see the updates. Is
> there a way to make that work locally or did I miss a step somewhere?

I can think of two steps. You need to build the documentation (`make
doc`). Look for "make doc" in INSTALL for some variants and
dependencies. Then you need to convince `git help ...` to pick up your
built docs. I would actually skip using/testing `git help` and just go
straight for the rendered page using, e.g, something like

  cd Documentation
  make ./git-shortlog.{1,html}
  man ./git-shortlog.1
  a-browser ./git-shortlog.html

Your docs render fine for me. Thanks for `backticking` for monospace.

> +-m::
> +--month::
> +       This is an alias for `--group=month`.
> +
> +-y::
> +--year::
> +       This is an alias for `--group=year`.
> +

Commit 2338c450b ("shortlog: add grouping option", 2020-09-27)
introduced `--group` and redefined `-c`  and `--committer` to alias to
that new thing. You could simply add a `--group` variant without
actually adding `--year` and `--month`. One of the nice things about
`--group` is that we can potentially have many groupings without having
to carry correspondingly many `--option`s.

In particular, it might be wise to wait with implementing `-y` and `-m`
until we know that your new feature turns out to be so hugely successful
that people start craving `-m` as a short form for `--group=month`. ;-)

See commit 47beb37bc6 ("shortlog: match commit trailers with --group",
2020-09-27) for some prior art of not adding a new `--option` for a new
way of grouping.

>         struct strbuf ident = STRBUF_INIT;
>         struct strbuf oneline = STRBUF_INIT;
> +       struct strbuf buffer;
> +       strbuf_init(&buffer, 100);
> +
>         struct strset dups = STRSET_INIT;
>         struct pretty_print_context ctx = {0};

This trips up `-Werror=declaration-after-statement`. If you build with
`DEVELOPER=Yes`, you should see the same thing.

I played a little with this functionality and it's quite cute. I can
easily imagine going even more granular with this (`--group=week`?), but
that can wait for some other time. :-)

BTW, I got this when `git am`-ing your patch:

  Applying: shortlog: add group-by options for year and month
  .git/rebase-apply/patch:82: space before tab in indent.
                  strftime(sb->buf, strbuf_avail(sb), "%Y/%m", &commit_date);
  .git/rebase-apply/patch:85: space before tab in indent.
                  strftime(sb->buf, strbuf_avail(sb), "%Y", &commit_date);
  .git/rebase-apply/patch:110: trailing whitespace.
                  format_commit_message(commit,
  .git/rebase-apply/patch:111: trailing whitespace, indent with spaces.
                                        buffer.buf,
  .git/rebase-apply/patch:112: indent with spaces.
                                        &ident, &ctx);
  warning: squelched 6 whitespace errors
  warning: 11 lines add whitespace errors.

Martin
