Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CDD31F461
	for <e@80x24.org>; Thu, 29 Aug 2019 19:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfH2Tkw (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 15:40:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40974 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2Tkw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 15:40:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so2119255pgg.8
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nnfLuvTryVg4FYfK9/8nEU4DRWfYT7bbF9D/zs0HPe0=;
        b=TslX6JiF1LAmja7rXINC2229AxXyuIewPtw2uYm2kmpL3fN2qmyzO+pJZnqfBwk8ya
         dieDbuRYHYPm5ZlqgAnLYpfUT6OgFl7eVp6smBMk7HF1Wk0ucQXiuym7I+s6dLAzSp7r
         XmlFaya2IlzuPJls6cHuYO2ceoqyNK37zKYdahg+ZBD1ahlXj/mklFqThczF8s8oUW9R
         mM8stX/rGxzYJntMU5cIB748wjnhK3eCDmjV5mTksX3QE2pnEoA1I2B8nVFOZP4IcVAf
         8a5kNjg8L+NJJUlZTJbCUD2m3fH0K+1NNEszboIEecAlTDUpkFaNr0E3m1VIEvzHByZe
         5MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nnfLuvTryVg4FYfK9/8nEU4DRWfYT7bbF9D/zs0HPe0=;
        b=S6igmA+QdRh/OLvAA3a9QpWQsB+7vqFf3YiAfCLnoxJLCrLoUIbbXEOQiEqc91+bIb
         q/QV1lzkcCI2lLIbrvTWM6auAyvVPLjJUdsf8sFRHsQsSXAODS3caxSe6chZCLEVSgkP
         H/qbdwxwnJhwf2SQYIOY6ENa3Ok7M9BeDQg2EYVspJZMxoi64FFawfiYhRMpm7MuxWaB
         NtyGbEJbaTtsWa8ihDr69nduvLu2we4zM+CEkiT5DS5BVq8o5N8FqGZEajTwF1SGLA+7
         AtPgdOxn3bWBfRoogb8edRS3EYJvpzwu+i/jHYUr6NaUqVUi7afdNEe8e4kjWr9ejyw8
         HQ3A==
X-Gm-Message-State: APjAAAXlDXN7tenSgmSAWgZqqWUbG7rl94uVt2gwPQBSOJxq9j1MTh6K
        fiBjYE8ZY+VVil6I8bd5cSOla51t7A8ksci/B8uxe58+
X-Google-Smtp-Source: APXvYqysIPbVN80VvVYJplFhtPJF9VMFJ05qB4xmxjTgTtO2HgSOLLcUDdaKdhM0Tg8gHsZd8vo2ejaljkjFTds5vQ4=
X-Received: by 2002:a63:d741:: with SMTP id w1mr9550760pgi.155.1567107651387;
 Thu, 29 Aug 2019 12:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <d0606d19-0900-3908-2962-ceb24015f753@web.de>
In-Reply-To: <d0606d19-0900-3908-2962-ceb24015f753@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 29 Aug 2019 21:40:39 +0200
Message-ID: <CAN0heSp4bdJt4NKELOkvdpoygbkNZVn-96FrZnu9ymE5UNOSag@mail.gmail.com>
Subject: Re: [PATCH] help: make help_unknown_ref() NORETURN
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Aug 2019 at 21:15, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Announce that calling help_unknown_ref() exits the program.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Patch generated with --function-context for easier review.
>
>  help.c | 3 ++-
>  help.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/help.c b/help.c
> index 5261d83ecf..9ff2be6b18 100644
> --- a/help.c
> +++ b/help.c
> @@ -774,22 +774,23 @@ static struct string_list guess_refs(const char *re=
f)
>         return similar_refs;
>  }
>
> -void help_unknown_ref(const char *ref, const char *cmd, const char *erro=
r)
> +NORETURN void help_unknown_ref(const char *ref, const char *cmd,
> +                              const char *error)
>  {
>         int i;
>         struct string_list suggested_refs =3D guess_refs(ref);
>
>         fprintf_ln(stderr, _("%s: %s - %s"), cmd, ref, error);
>
>         if (suggested_refs.nr > 0) {
>                 fprintf_ln(stderr,
>                            Q_("\nDid you mean this?",
>                               "\nDid you mean one of these?",
>                               suggested_refs.nr));
>                 for (i =3D 0; i < suggested_refs.nr; i++)
>                         fprintf(stderr, "\t%s\n", suggested_refs.items[i]=
.string);
>         }
>
>         string_list_clear(&suggested_refs, 0);
>         exit(1);
>  }

Indeed, this function always ends up exit()-ing.

> diff --git a/help.h b/help.h
> index b8780fbd0f..7a455beeb7 100644
> --- a/help.h
> +++ b/help.h
> @@ -42,8 +42,8 @@ void list_commands(unsigned int colopts, struct cmdname=
s *main_cmds, struct cmdn
>  /*
>   * call this to die(), when it is suspected that the user mistyped a
>   * ref to the command, to give suggested "correct" refs.
>   */
> -void help_unknown_ref(const char *ref, const char *cmd, const char *erro=
r);
> +NORETURN void help_unknown_ref(const char *ref, const char *cmd, const c=
har *error);

Funny how this claims we'll call `die()`, when we'll actually call
`exit(1)`. If we actually did call `die()`, I suppose the compiler
should/could figure out by itself that this function, too, won't ever
return.

I wonder whether the real bug here is that the implementation calls
`exit(1)`, not `die()`. That is, the exit code is wrong (1 !=3D 128) and
we're missing out on the flexibility offered by `set_die_routine()`. If
not that, then I'd say the documentation is buggy. Hm?

In any case, your patch seems correct. Just wondering what should be
done on top of it...

Martin
