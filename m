Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103BD20248
	for <e@80x24.org>; Thu, 14 Mar 2019 05:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfCNF6e (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 01:58:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34342 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfCNF6e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 01:58:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id n6so2644226qkf.1
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 22:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ELHD4gichrauGbzX64400Jn7//kJazWe4kp6q7L8tG4=;
        b=rpcijVclzc/7kUzm39qS6Dcz15VZ2tkosZv7sQAD7LzW/kjaeGvMBgzF+eaVgCMX3k
         YULwdkEUGa1xmUZQ/TG8MBFuUySsqFOz9+y0Jw5raNzn9PkZFQh/0c1kUAdeD6f1PJfs
         ynbKKzbpBdCwxcIsbQi5eHZnYYUJZVwMsATZ1iifPSRBbBKa9tsnQG9M6/owkDfpg5OP
         vARw2YTkQ26EdNFSMyOjoioBGPGh2vgiUwz/pq4CVwT4VJc7cD75HG1IqioVcsR8r6lk
         olQBTdBn9vQhhGfILFamAc/eoaqPdt2ZCOar1GFIfmRnRYZE2pykb8vU4G/XdTT+A6ga
         EfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELHD4gichrauGbzX64400Jn7//kJazWe4kp6q7L8tG4=;
        b=qsK2/Rq3S7r25xhKkmEnkkgTHQXyK22DZRH97tx3C8OR76ApTl6ywAY0F5t8kV8L8x
         3pmBfYxuRaOd/TCRrBdolBIPmMDgOyJcb5IhqA14x6uGUaD5gAnnkYyYUGPLRz4T1l/Q
         gY1Rr9uovec2BdRPkhSf20nwkU8weeqvT8vJ9yqZi/l/6DhS4QnynDN5NlMBZqqgq1/d
         uiI/F/Gm3Sr7kkTiurKW3i3Qo+mAomoy0LHPX2PlgRAvp7qsN2zjy0ZurvArKjwqss/T
         9J8bu2n7SP9Uo1PyBtoW91jI44tKuV0/iQsgJLoYeoaTWlgqqbfHSTtvd0Tpcy920xgW
         8/1w==
X-Gm-Message-State: APjAAAVr6/GmG/0WQjKp+7pI4tWUexPNyqydvB0aN5uvIz+siBY+xlZo
        vICxfegk0DoT/Ep2yETjqA9t46mcNe8AQPCkV9g=
X-Google-Smtp-Source: APXvYqwmpRzPlJ9J35qLOE811p+FdKSPfdIwEhk5YPPfIBCkuiVSSkAfIlyJXx2T9HTMBzzQ/VX44/XioA0qzIcb5jM=
X-Received: by 2002:a37:654e:: with SMTP id z75mr13110636qkb.314.1552543112979;
 Wed, 13 Mar 2019 22:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190219083123.27686-4-nbelakovski@gmail.com> <20190221125952.GB13403@sigill.intra.peff.net>
In-Reply-To: <20190221125952.GB13403@sigill.intra.peff.net>
From:   Nickolai Belakovski <nbelakovski@gmail.com>
Date:   Wed, 13 Mar 2019 22:58:06 -0700
Message-ID: <CAC05385Q0EQWX8B5PfR2m6N7o573NTF+a0HyXS+zqYAAdgTVOw@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] branch: add worktree info on verbose output
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 4:59 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 19, 2019 at 05:31:23PM +0900, nbelakovski@gmail.com wrote:
>
> > From: Nickolai Belakovski <nbelakovski@gmail.com>
> >
> > To display worktree path for refs checked out in a linked worktree
>
> This would be a good place to describe why this is useful. :)
>
> I do not have an opinion myself. Patch 2 makes a lot of sense to me, but
> I don't know if people would like this one or not. I don't use "-v"
> myself, though, so what do I know. :)
I threw this one in because I thought it wouldn't be clear to the
average user why some
branches are in cyan. By putting the worktree path in cyan on the next
level of output
I thought this would help the user make the connection, but actually I
don't have strong
feelings about this one.
>
> > diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> > index f2e5a07d64..326a45f648 100644
> > --- a/Documentation/git-branch.txt
> > +++ b/Documentation/git-branch.txt
> > @@ -168,8 +168,10 @@ This option is only applicable in non-verbose mode.
> >       When in list mode,
> >       show sha1 and commit subject line for each head, along with
> >       relationship to upstream branch (if any). If given twice, print
> > -     the name of the upstream branch, as well (see also `git remote
> > -     show <remote>`).
> > +     the path of the linked worktree, if applicable (not applicable
> > +     for current worktree since user's path will already be in current
> > +     worktree) and the name of the upstream branch, as well (see also
> > +     `git remote show <remote>`).
>
> That parenthetical feels a bit awkward. Maybe:
>
>   ...print the path of the linked worktree (if any) and the name of the
>   upstream branch, as well (see also `git remote show <remote>`). Note
>   that the current worktree's HEAD will not have its path printed (it
>   will always be your current directory).
Sure I can make that change
>
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > index c2a86362bb..0b8ba9e4c5 100644
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -367,9 +367,13 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
> >               strbuf_addf(&local, " %s ", obname.buf);
> >
> >               if (filter->verbose > 1)
> > +             {
> > +                     strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
> > +                                 branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
> >                       strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
> >                                   "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
> >                                   branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
> > +             }
>
> Another unreadable long line (both the one you're adding, and the existing
> one!). I don't know if it's worth trying to clean these up, but if we
> do, it might be worth hitting the existing ones, too.
>
> I'm OK if that comes as a patch on top later on, though.
Agreed, but there's enough lines like this that it'll just look
inconsistent if only one were broken up.
>
>
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 012ddde7f2..8065279be6 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -284,22 +284,20 @@ test_expect_success '--color overrides auto-color' '
>         test_cmp expect.color actual
>  '
>
> -# This test case has some special code to strip the first 30 characters or so
> -# of the output so that we do not have to put commit hashes into the expect
>  test_expect_success 'verbose output lists worktree path' '
> +       one=$(git rev-parse --short HEAD) &&
> +       two=$(git rev-parse --short master) &&
>         cat >expect <<-EOF &&
> -       one
> -       one
> -       two
> -       one
> -       two
> -       ($(pwd)/worktree_dir) two
> -       two
> -       two
> +       * (HEAD detached from fromtag) $one one
> +         ambiguous                    $one one
> +         branch-one                   $two two
> +         branch-two                   $one one
> +         master                       $two two
> +       + master_worktree              $two ($(pwd)/worktree_dir) two
> +         ref-to-branch                $two two
> +         ref-to-remote                $two two
>         EOF
> -       git branch -vv >tmp &&
> -       SUBSTRLENGTH=$(head -1 tmp | awk "{print index(\$0, \"one\")}") &&
> -       awk -v substrlength="$SUBSTRLENGTH" "{print substr(\$0,substrlength,length(\$0))}" <tmp >actual &&
> +       git branch -vv >actual &&
>         test_cmp expect actual
>  '
>
>
> I don't like how it depends on the space alignment of the branches, but
> I do like that you can clearly see which branch is being annotated.
Thanks for the suggestion. While I'm kinda proud of my awk thing, I
think yours is a lot easier to read. Will add.
>
> -Peff
