Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0018B1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 15:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeI2WQ1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 18:16:27 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39966 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbeI2WQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 18:16:27 -0400
Received: by mail-it1-f195.google.com with SMTP id i191-v6so568659iti.5
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X8Xi+LZ6D85awBILdWh2sdhTRocLp4t09iHfzGjf6xU=;
        b=Hy9lRJG+hJ0xW5MOcPFjq/IuETLAQiRI8cqKDsAqVI2X4ol/rmcQddcBCeg0RYIpmm
         j2ZMXhIdyA15xG3HyoTYZRq572XVdGfSj19Siu+/f8Mix/eGFaQWYdCX5roLxEHFKS9a
         GAmuEu488t/F/qmg1+9db4UMtaB8VxN0CQl8Utp2QAmqnAm4YubP9eJm7rnedT45FhHC
         T54rVGzhuYVEW+nC2NWn+Qy2l+ybi2+oKHxfU8VrKbHYnEEeqJCz1KH5v+R/OsqHuEV+
         R+RAZTErVdMav/qvUs18euJqWiU0+lZ9vTyFMzg1NlGo8r8Sl9HUTgoATy8++q8gIalq
         QYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X8Xi+LZ6D85awBILdWh2sdhTRocLp4t09iHfzGjf6xU=;
        b=WWp3aDNv68MpciD3lCEbJk+CUj5Y510/zdMesEjx/4zqZsTlru/bpqC4Ei+OO4HxJF
         XqzrxWMA1O7/GD2auRnxqT2WDe6lOJHdOYlCnWNjI+P3nEynCMVQX1GGJvrnTLBW5VBS
         AHHJytQEciUFE0sPCrWVqw2mNf5uPSy8PzbaEYeV3y8qadnj13ThaGRQcYKVYXp774ws
         56NEyhnc7zndvBaTrSBoxKCOqdy+r/NQjg+6qkeEjYN+1eXSRMe0CmiRIm5s/Ic6h5uV
         LAiOg4/ZjcGJ8GGtWW8rjjsUxmLPfY1CBruGDYsuPT4UFWtx93vI0OJGAec3FDHx8tQE
         twuA==
X-Gm-Message-State: ABuFfoiOLQCPssfo8P6+j9uKZKj2jXhPE/1lxflOjxXATOBIAw/0oVMi
        a8m7EH6QVhMcVLVQrgpY+sEoneg0fA5Adt4gsZY=
X-Google-Smtp-Source: ACcGV615psU57XfuI7ErC9KLEWZlZt2ziRsL0yYT9xooSd7Ma4fKOGPt0p7Rzlz7I/enRxudhHHdWIJTnBljgCAKfH4=
X-Received: by 2002:a02:940a:: with SMTP id a10-v6mr2514469jai.94.1538236053267;
 Sat, 29 Sep 2018 08:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180929140132.GA31238@msg.df7cb.de> <20180929145527.23444-1-avarab@gmail.com>
 <CACsJy8A6MqAmSZ=bhatX0MZTWRjR9Ci9h9NhJEshtpmqpHr4JA@mail.gmail.com> <87d0swiavd.fsf@evledraar.gmail.com>
In-Reply-To: <87d0swiavd.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 29 Sep 2018 17:47:06 +0200
Message-ID: <CACsJy8C7hxpxaXvvgv5CRh4gCKLF2ZvOn6FZ5-yMyVLcFi26rg@mail.gmail.com>
Subject: Re: [PATCH] grep: provide a noop --recursive option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, myon@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 5:25 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sat, Sep 29 2018, Duy Nguyen wrote:
>
> > On Sat, Sep 29, 2018 at 4:58 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> This --recursive (-r) option does nothing, and is purely here to
> >> appease people who have "grep -r ..." burned into their muscle memory.
> >
> > GNU grep -r recurses infinitely but Git grep also has --max-depth. How
> > do these interact? My knee-jerk reaction is -r equals --max-depth=3D-1
> > (i.e. overriding previous --mex-depth options on command line, or from
> > alias)
>
> I didn't know about --max-depth, we could squash the following in to
> deal with that, but that still leaves --max-depth=3D123 --no-recursive as
> using depth 123, and we'd need different options parsing than OPT_BOOL
> to deal with that.

I think if you initialize recursive variable below to -1, then you can
detect both --recursive (1) and --no-recursive (0).

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 02d4384225..2e048d9b49 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -785,7 +785,7 @@ int cmd_grep(int argc, const char **argv, const char =
*prefix)
>         int use_index =3D 1;
>         int pattern_type_arg =3D GREP_PATTERN_TYPE_UNSPECIFIED;
>         int allow_revs;
> -       int unused_recursive; /* this is never used */
> +       int recursive =3D 0;
>
>         struct option options[] =3D {
>                 OPT_BOOL(0, "cached", &cached,
> @@ -803,7 +803,7 @@ int cmd_grep(int argc, const char **argv, const char =
*prefix)
>                         N_("show non-matching lines")),
>                 OPT_BOOL('i', "ignore-case", &opt.ignore_case,
>                         N_("case insensitive matching")),
> -               OPT_BOOL('r', "recursive", &unused_recursive,
> +               OPT_BOOL('r', "recursive", &recursive,
>                         N_("does nothing, git-grep is always recursive, f=
or grep(1) muscle memory compatibility")),
>                 OPT_BOOL('w', "word-regexp", &opt.word_regexp,
>                         N_("match patterns only at word boundaries")),
> @@ -926,6 +926,8 @@ int cmd_grep(int argc, const char **argv, const char =
*prefix)
>                              PARSE_OPT_STOP_AT_NON_OPTION);
>         grep_commit_pattern_type(pattern_type_arg, &opt);
>
> +       if (opt.max_depth !=3D -1 && recursive)
> +               die(_("The --max-depth and --recursive options are incomp=
atible"));
>         if (use_index && !startup_info->have_repository) {
>                 int fallback =3D 0;
>                 git_config_get_bool("grep.fallbacktonoindex", &fallback);
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index c48d1fa34b..ad25cd50f5 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -1697,4 +1697,8 @@ test_expect_success 'grep does not report i-t-a and=
 assume unchanged with -L' '
>         test_cmp expected actual
>  '
>
> +test_expect_success 'grep --recursive is incompatible with --max-depth' =
'
> +       test_must_fail git grep --recursive --max-depth=3D1
> +'
> +
>  test_done



--=20
Duy
