Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D9191F453
	for <e@80x24.org>; Thu, 27 Sep 2018 15:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeI0VwN (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 17:52:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42362 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0VwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 17:52:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id b11-v6so3094747wru.9
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 08:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=PHizjlzOk41Jnx5FlS4uaJQaRYazAChdYzqEg1rZ0co=;
        b=ef8FUbThygyO+7bXA7LL0MtgfCuAkBKXwqqOR31whFvpqxHuMv694osQh0k21VbVpl
         zqbFoXzO5S9ptz5aymFrTCa0WgU6c51GX0V75OQVW2ONAEKzxr9+SQ7Iyz1GgQDWH1yf
         YimbrpCx7sH4acWi58eqX/0oe5ZmzRWXrmqIsQQRkFq0PmEjqhgytFljguRodGJBlIz4
         zNFxRw00iYo1KGS9zvjDfcq4qUyk3LNFVrVOgDAkDvLvhMUChGe0B9RrovuHYtX6nSrL
         HpJbMo66RxnSPLiz8UroKsPLDDxML7u2U9ZslBulfD4BZdprCfR7P3h1+UnqIlTFonWp
         V5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=PHizjlzOk41Jnx5FlS4uaJQaRYazAChdYzqEg1rZ0co=;
        b=q4yYFxa91wAQ0jma4eorId6Lk4SKqTEdrFnrGJ4vZPVxW9JwITTtmsI10RQz6ivJd4
         6+j9p+sLS+D90d5gbQwEDJGM+XKrUl3TamOI7gFhU1JF0ogmv4Yr3ZU15mau9zOoXa9d
         QXvk7Lu7fYZSTbULCT2q/n7SqTipJWqIZCbzy5eaK+nXF4VhstRk593snmIgPDN0H8aN
         06FikSJhKOkVd/oj/P1hP0zx3wtAZJzO1/FDio4xiu+bhILjAoyf22t7jzznvwaehJ91
         5/ZO2r9jmhXAmsgGVf+GKVJ9CTPFMuYMoT378HcakSzSfDPUytZHpWzfghtVxmVujHuF
         9ErQ==
X-Gm-Message-State: ABuFfogfgDZyYNFL9Yjk7trxCwlISe9wQBXUBIZoSS0QxYD2qoCue+KQ
        vHrqM5HVAoWRnsJ400o7gP8=
X-Google-Smtp-Source: ACcGV62iAEatlASfuXhJx8DUA55e2+d+OAIhlNQbOy9oUQRhzLfypOj8uQ6pw5dCv2DzDRo2qtRklA==
X-Received: by 2002:adf:b6a0:: with SMTP id j32-v6mr9103045wre.55.1538062403345;
        Thu, 27 Sep 2018 08:33:23 -0700 (PDT)
Received: from evledraar (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id q5-v6sm3831499wmd.29.2018.09.27.08.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:33:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked working tree the same way as the current branch is colorized
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
Date:   Thu, 27 Sep 2018 17:33:21 +0200
Message-ID: <87y3bnhs5a.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Nickolai Belakovski wrote:

> In order to more clearly display which branches are active, the output
> of git branch is modified to colorize branches checked out in any linked
> worktrees with the same color as the current branch.
>
> This is meant to simplify workflows related to worktree, particularly
> due to the limitations of not being able to check out the same branch in
> two worktrees and the inability to delete a branch checked out in a
> worktree. When performing branch operations like checkout and delete, it
> would be useful to know more readily if the branches in which the user
> is interested are already checked out in a worktree.
>
> The git worktree list command contains the relevant information, however
> this is a much less frquently used command than git branch.
>
> Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>

Sounds cool, b.t.w. would be neat-o to have some screenshot uploaded to
imgur or whatever just to skim what it looks like before/after.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 4fc55c350..65b58ff7c 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -334,11 +334,36 @@ static char *build_format(struct ref_filter
> *filter, int maxwidth, const char *r
>         struct strbuf local = STRBUF_INIT;
>         struct strbuf remote = STRBUF_INIT;
>
> -       strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %s%%(end)",
> -                   branch_get_color(BRANCH_COLOR_CURRENT),
> -                   branch_get_color(BRANCH_COLOR_LOCAL));
> -       strbuf_addf(&remote, "  %s",
> -                   branch_get_color(BRANCH_COLOR_REMOTE));
> +       // Prepend the current branch of this worktree with "* " and
> all other branches with "  "


We use /* ... */ C comments, not C++-style // (well, it's in C now, but
not the ancient versions we need to support).

It also seems all of this patch was copy/pasted into GMail or something,
it has wrapping and doesn't apply with "git am".

Also most/all of these comments I'd say we could better do without,
i.e. the ones explaining basic code flow that's easy to see from the
code itself.
