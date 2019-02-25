Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FA3020248
	for <e@80x24.org>; Mon, 25 Feb 2019 08:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfBYI7c (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 03:59:32 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41161 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfBYI7c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 03:59:32 -0500
Received: by mail-io1-f66.google.com with SMTP id i5so6863127ioq.8
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 00:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uy/Slip6MmKaaYYocgKzQXE1M9g/5cLmbz0gYz7B2hQ=;
        b=rue0vBQaB6P2OZEh1exyc0wZa1uv0HFsU63nN5Ybt2MvtTXWfIVID7XY3QQnvdWcb7
         uhxFretStlGh+4EKW1E0kLrwxAqjJxei1B+kQU9po3VQhowV5qJACaeyqhMaeNhQ9SwM
         MisgP3KhNuMHVTSO7+WwGLe3RKbuM6a3tzg1KADD60hl8yZ9b3H/nnXr3hsuGMJTmgon
         OwVCm4qW0V9qBGmzdh0XE16cnU0i36/o9Tvd7yQ/9MgizSv7Tm9xTiCdQlrk8sSQvXLj
         hqAK4mQmcz3U1q0HfLEpRN8vCl3FLYysEW+vX7g1pHIkSvdxq0kKEU+uUW7AFc9cnyOQ
         XnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uy/Slip6MmKaaYYocgKzQXE1M9g/5cLmbz0gYz7B2hQ=;
        b=mp/3meldXptne/xymYjzu+l8K8jxdyUty4juGqM1aLJV5aLr/+V4gJi2MmfFno2Ujk
         nkoyEuLQjLCRDNIzm1kEvnbKm8HrMht73tOP5l+vXCkH54D+Eqr4fiGuGzF/dOY//31l
         i4M62C9ECPnugqISUGOL9t8qUBw3re6OYb0nUvK5eUtH9FL0BTi6iXLk9noDpGz6sbUy
         uFwAP6YZlIvMSkEA6V+33q+AJyhVhIdgBO8Csukr1gKUkOjnaHIT5xz2tx9M9rJQMaEJ
         QHdYNDPkfKDQ48j1o8pFpO63AKHwk8FZyS7U7ZPuwbGgutp8v30bRAokPYJS7UTAQ07A
         GmXQ==
X-Gm-Message-State: AHQUAuYAIO/N3sKOE+eP5Q2PqoVC2fi5T0wHfLpPnwNQCfBM02oGzofO
        y2UkkeL6XyA/ZC75sDixTPFXe7GPz8gi8n/vaH+1Yg==
X-Google-Smtp-Source: AHgI3IbHnH5O1CuaPSGkk+AYWpeYctHesmqCTr8/E5Id42DcuBSV/LSiycTGjzNiaeJE3PdDs/DaYCtlAkzWmF208nM=
X-Received: by 2002:a5d:9357:: with SMTP id i23mr7490009ioo.236.1551085170912;
 Mon, 25 Feb 2019 00:59:30 -0800 (PST)
MIME-Version: 1.0
References: <87y36rcanq.fsf@rustcorp.com.au> <20190208024800.GA11392@sigill.intra.peff.net>
 <87va1btaic.fsf@rustcorp.com.au>
In-Reply-To: <87va1btaic.fsf@rustcorp.com.au>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 25 Feb 2019 15:59:04 +0700
Message-ID: <CACsJy8DjHrCSXsOpH-pm5n-KUEm4BhJmhWYxZEWygmTEj1ykLA@mail.gmail.com>
Subject: Re: `git status -u no` suppresses modified files too.
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 12:37 PM Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> Jeff King <peff@peff.net> writes:
> > On Fri, Feb 08, 2019 at 12:18:57PM +1030, Rusty Russell wrote:
> >
> >> This broke my "is this clean?" sanity check and very much violates
> >> the man page description.
> >
> > Wow, this one had me scratching my head for a minute. What you're
> > describing here:
> >
> >>         $ git status -u no
> >>         On branch guilt/repro
> >
> > ...seems horribly broken, and the behavior goes back to the beginnings
> > of "-u". So I wondered how we would not have noticed for so long.
> >
> > But what is going on is quite subtle. The "-u" option takes an optional
> > argument, and so must be used in its "stuck" form. I.e.,
> >
> >   git status -uno
>
> Urgh, manual page even *says* this, and I missed it:
>
>         It is optional: it
>         defaults to all, and if specified, it must be stuck to the option (e.g.  -uno, but not -u
>         no).
>
> Note that optional arguments are fundamentally broken like this: you
> should *never* add them to your programs.  If -u suddently wanted an
> argument, a new option should have been added.

This -uno thing is bugging me too and I've seen a couple more options
like this. Maybe we can start moving to -u=no or something like that.
It's still broken if we accept -= as a valid option (I don't think we
do as of now), but at least it does not look as misleading as -uno,
which reads -u -n -o by everybody else who has not read all the man
pages.

> But despite that "well, I wouldn't start from here!" advice, I think
> your patch seems really helpful.
>
> Thanks for clue contribution!
> Rusty.
>
> > does do what you expect. We cannot allow the separated form here,
> > because that would conflict with another actual option, like:
> >
> >   git status -u --porcelain
> >
> > So why does it behave as it does? We accept "no" as its own pathspec
> > argument, and thus we limit the status to that path. And that's why
> > there's "nothing to commit"; there's nothing in that pathspec.
> >
> > This is a pretty horrible UI trap. Most of the time with pathspecs we
> > require them to be on the right-hand side of a "--" unless the paths
> > actually exist in the filesystem. But then, in most of those cases we're
> > making sure they're not ambiguous between revisions and paths. So maybe
> > it's overkill here. I dunno. But the patch below certainly makes what's
> > going on in your case less subtle:
> >
> >   $ git status -u no
> >   fatal: no: no such path in the working tree.
> >   Use 'git <command> -- <path>...' to specify paths that do not exist locally.
> >
> > You do still have to figure out why it wasn't stuck to "-u", though.
> >
> > ---
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 2986553d5f..7177d7d82f 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -1300,6 +1300,16 @@ static int git_status_config(const char *k, const char *v, void *cb)
> >       return git_diff_ui_config(k, v, NULL);
> >  }
> >
> > +static void verify_pathspec(const char *prefix, const char **argv)
> > +{
> > +     while (*argv) {
> > +             const char *arg = *argv++;
> > +             if (!strcmp(arg, "--"))
> > +                     return;
> > +             verify_filename(prefix, arg, 0);
> > +     }
> > +}
> > +
> >  int cmd_status(int argc, const char **argv, const char *prefix)
> >  {
> >       static int no_renames = -1;
> > @@ -1351,7 +1361,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
> >       status_init_config(&s, git_status_config);
> >       argc = parse_options(argc, argv, prefix,
> >                            builtin_status_options,
> > -                          builtin_status_usage, 0);
> > +                          builtin_status_usage, PARSE_OPT_KEEP_DASHDASH);
> >       finalize_colopts(&s.colopts, -1);
> >       finalize_deferred_config(&s);
> >
> > @@ -1362,6 +1372,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
> >           s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
> >               die(_("Unsupported combination of ignored and untracked-files arguments"));
> >
> > +     verify_pathspec(prefix, argv);
> >       parse_pathspec(&s.pathspec, 0,
> >                      PATHSPEC_PREFER_FULL,
> >                      prefix, argv);



-- 
Duy
