Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3171F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 18:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbfJESNG (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 14:13:06 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33918 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbfJESNG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 14:13:06 -0400
Received: by mail-ua1-f68.google.com with SMTP id q11so2976155uao.1
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 11:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsCfc+VKfAS3joaXBthSH2b1Cuk0XtY49GnOZUkDddw=;
        b=P0S1KynI/0pi+UKiNK0dSGYP1aNd9YoJK0CKWWBCNBF6Q94omlJ/fCrt65Z6m9g+C7
         UoVRj5pSA1SCzUrYuIkwLCBDPyfys9GfAw2gOhK2+yjqox6dijunMDBmfk+uclH+0i38
         CMW3tNIMp77PGAahylLghtVRQH4ZgFxMJzivgy0p5TZs4cKkPI3wYvn75tcgSGD5JFng
         C2n8EurCo3Vn9dCrTIL4JixAFz/zhLoPFiAfqzshVBCyvOz+KD7i0qbYjIGxV/w/lJbV
         Go+5sEVO/7pyjbP/8Mbg940njasGVXOHd+0BZdyPN5T62XYX+PZdhG6PS+1MpMyG5MUI
         0IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsCfc+VKfAS3joaXBthSH2b1Cuk0XtY49GnOZUkDddw=;
        b=XoH6UhSAlSvTq8Luqy+BLSkU244qgc3EtYBL1Ln7QK7m84M1MUAWQk2E0JL/iT0CyI
         b8UtVWkuaYURJDXy3m4Ke20o5GYEyUcwc41sDuavGlwuZkI2JetXHcpg767H7Peiv0Vh
         ThF9zDfp3XeK12OI+pkw/3gL5DSbnCSureCKoQJzXj/tFFRsmCKlMawvuzaF20OKLc8z
         ublksxlWuw2Vjl5ZOxPr8UOhgQ6oTep0jS5h3ql2oSQwlJz+bw7jTnEJITTaCFIm3fV4
         jp3J0cL2PpbglEjHN5aYg/Y/fXmAmgrHjJHGDqR0hPm0zdga7ichriWoj1Hn7HI6lFt3
         OhxA==
X-Gm-Message-State: APjAAAU7neFcCfdn63etT4xgWGNv2fXM53wEGSpy/CIM3YkFGa0Y7ymH
        EU6x8wB5vQzuwz/gjFofi0B4F5vAjQEP4O5YQV0=
X-Google-Smtp-Source: APXvYqwxsZPwztnA7me4NNfWsL2VWPRYDegD8sCSzjeAmgE5Jai1mvlpEL58YiZWoaD3ctP9lE4yUS3Z0ASxkcClqL8=
X-Received: by 2002:ab0:4a83:: with SMTP id s3mr11114511uae.95.1570299184490;
 Sat, 05 Oct 2019 11:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190907115034.14933-1-rohit.ashiwal265@gmail.com> <20190907115034.14933-2-rohit.ashiwal265@gmail.com>
 <9e311cef-1f9d-4146-c2a7-c8179cdcdaf1@gmail.com>
In-Reply-To: <9e311cef-1f9d-4146-c2a7-c8179cdcdaf1@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Oct 2019 11:12:53 -0700
Message-ID: <CABPp-BFzFM8L=CB-nPfdP9AAg+vW0=cyqG7XzuwgRvS9vhzgyw@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] rebase -i: add --ignore-whitespace flag
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 4, 2019 at 2:29 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Rohit
>
> On 07/09/2019 12:50, Rohit Ashiwal wrote:
> > There are two backends available for rebasing, viz, the am and the
> > interactive. Naturally, there shall be some features that are
> > implemented in one but not in the other. One such flag is
> > --ignore-whitespace which indicates merge mechanism to treat lines
> > with only whitespace changes as unchanged. Wire the interactive
> > rebase to also understand the --ignore-whitespace flag by
> > translating it to -Xignore-space-change.
> >
> > Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> > ---
> >   Documentation/git-rebase.txt            | 13 ++++-
> >   builtin/rebase.c                        | 22 +++++++--
> >   t/t3422-rebase-incompatible-options.sh  |  1 -
> >   t/t3433-rebase-options-compatibility.sh | 65 +++++++++++++++++++++++++
> >   4 files changed, 94 insertions(+), 7 deletions(-)
> >   create mode 100755 t/t3433-rebase-options-compatibility.sh
> >
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 6156609cf7..873eb5768c 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -371,8 +371,16 @@ If either <upstream> or --root is given on the command line, then the
> >   default is `--no-fork-point`, otherwise the default is `--fork-point`.
> >
> >   --ignore-whitespace::
> > +     Behaves differently depending on which backend is selected.
> > ++
> > +'am' backend: When applying a patch, ignore changes in whitespace in
> > +context lines if necessary.
> > ++
> > +'interactive' backend: Treat lines with only whitespace changes as
> > +unchanged for the sake of a three-way merge.
> > +
> >   --whitespace=<option>::
> > -     These flag are passed to the 'git apply' program
> > +     This flag is passed to the 'git apply' program
> >       (see linkgit:git-apply[1]) that applies the patch.
> >   +
> >   See also INCOMPATIBLE OPTIONS below.
> > @@ -520,7 +528,6 @@ The following options:
> >    * --committer-date-is-author-date
> >    * --ignore-date
> >    * --whitespace
> > - * --ignore-whitespace
> >    * -C
> >
> >   are incompatible with the following options:
> > @@ -543,6 +550,8 @@ In addition, the following pairs of options are incompatible:
> >    * --preserve-merges and --interactive
> >    * --preserve-merges and --signoff
> >    * --preserve-merges and --rebase-merges
> > + * --preserve-merges and --ignore-whitespace
> > + * --rebase-merges and --ignore-whitespace
> >    * --rebase-merges and --strategy
> >    * --rebase-merges and --strategy-option
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 670096c065..f8a618d54c 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -79,6 +79,7 @@ struct rebase_options {
> >       int allow_rerere_autoupdate;
> >       int keep_empty;
> >       int autosquash;
> > +     int ignore_whitespace;
> >       char *gpg_sign_opt;
> >       int autostash;
> >       char *cmd;
> > @@ -99,6 +100,7 @@ struct rebase_options {
> >
> >   static struct replay_opts get_replay_opts(const struct rebase_options *opts)
> >   {
> > +     struct strbuf strategy_buf = STRBUF_INIT;
> >       struct replay_opts replay = REPLAY_OPTS_INIT;
> >
> >       replay.action = REPLAY_INTERACTIVE_REBASE;
> > @@ -114,9 +116,15 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
> >       replay.reschedule_failed_exec = opts->reschedule_failed_exec;
> >       replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
> >       replay.strategy = opts->strategy;
> > +
> >       if (opts->strategy_opts)
> > -             parse_strategy_opts(&replay, opts->strategy_opts);
> > +             strbuf_addstr(&strategy_buf, opts->strategy_opts);
> > +     if (opts->ignore_whitespace)
> > +             strbuf_addstr(&strategy_buf, " --ignore-space-change");
> > +     if (strategy_buf.len)
> > +             parse_strategy_opts(&replay, strategy_buf.buf);
> >
> > +     strbuf_release(&strategy_buf);
> >       return replay;
> >   }
> >
> > @@ -511,6 +519,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
> >       argc = parse_options(argc, argv, prefix, options,
> >                       builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
> >
> > +     opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
> > +
> >       if (!is_null_oid(&squash_onto))
> >               opts.squash_onto = &squash_onto;
> >
> > @@ -964,6 +974,8 @@ static int run_am(struct rebase_options *opts)
> >       am.git_cmd = 1;
> >       argv_array_push(&am.args, "am");
> >
> > +     if (opts->ignore_whitespace)
> > +             argv_array_push(&am.args, "--ignore-whitespace");
> >       if (opts->action && !strcmp("continue", opts->action)) {
> >               argv_array_push(&am.args, "--resolved");
> >               argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
> > @@ -1407,9 +1419,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >                       PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
> >               OPT_BOOL(0, "signoff", &options.signoff,
> >                        N_("add a Signed-off-by: line to each commit")),
> > -             OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
> > -                               NULL, N_("passed to 'git am'"),
> > -                               PARSE_OPT_NOARG),
> >               OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
> >                                 &options.git_am_opts, NULL,
> >                                 N_("passed to 'git am'"), PARSE_OPT_NOARG),
> > @@ -1417,6 +1426,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >                                 N_("passed to 'git am'"), PARSE_OPT_NOARG),
> >               OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
> >                                 N_("passed to 'git apply'"), 0),
> > +             OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
> > +                      N_("ignore changes in whitespace")),
> >               OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
> >                                 N_("action"), N_("passed to 'git apply'"), 0),
> >               OPT_BIT('f', "force-rebase", &options.flags,
> > @@ -1834,6 +1845,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >       }
> >
> >       if (options.rebase_merges) {
> > +             if (options.ignore_whitespace)
> > +                     die(_("cannot combine '--rebase-merges' with "
> > +                           "'--ignore-whitespace'"));
>
> --rebase-merges now supports --strategy_option so we should fix this.
>
> >               if (strategy_options.nr)
> >                       die(_("cannot combine '--rebase-merges' with "
> >                             "'--strategy-option'"));
> > diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> > index a5868ea152..4342f79eea 100755
> > --- a/t/t3422-rebase-incompatible-options.sh
> > +++ b/t/t3422-rebase-incompatible-options.sh
> > @@ -61,7 +61,6 @@ test_rebase_am_only () {
> >   }
> >
> >   test_rebase_am_only --whitespace=fix
> > -test_rebase_am_only --ignore-whitespace
> >   test_rebase_am_only --committer-date-is-author-date
> >   test_rebase_am_only -C4
> >
> > diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
> > new file mode 100755
> > index 0000000000..2e16e00a9d
> > --- /dev/null
> > +++ b/t/t3433-rebase-options-compatibility.sh
> > @@ -0,0 +1,65 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (c) 2019 Rohit Ashiwal
> > +#
> > +
> > +test_description='tests to ensure compatibility between am and interactive backends'
> > +
> > +. ./test-lib.sh
> > +
> > +# This is a special case in which both am and interactive backends
> > +# provide the same output.
>
> I'm still concerned that we have to construct a special test case to get
> both backends to generate the same output. If this series is about
> supporting the behavior of the am backend in the sequencer then I'm
> worried that having the same option name have two different behaviors
> will create more problems than it solves. Do you have a feeling for how
> often the two backends give different results?

I think the wording choice of "special case" was unfortunate; it's
actually a common case.  Most the time the two backends will give the
same results, it's only in special cases that they don't.  See
https://public-inbox.org/git/CABPp-BE+D-GFJaucgCCsBA8E7nQAxc0vNE92HaCpOTQrUp=mPA@mail.gmail.com/
