Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE33B207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbdEDJKO (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:10:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36859 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753399AbdEDJKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:10:09 -0400
Received: by mail-it0-f68.google.com with SMTP id x188so923459itb.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 02:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SqQvEnBb+Lrh6ePvvd5vsMk8iih8zoWam2MKt0f3sT0=;
        b=QJUDn0vPORwXpi6PzQo67fE8cfnwlR19Qn2mAx8CrBOWaAx4w5cSj6X389EW6xMjiK
         lUIgf0gxjooN79IWXVv/tYKS9E3NUC4z8iX9auBUPVBuxBCrWY4s4V1U0e5/JIasKTaV
         QW/XyBmYLRAKThhHDUzh9G7L+UU9n5tDrXPLCcdFhDdejGAGjCA0jNnMglO7JhnUexhn
         BYg1oTHw+8Q5L6A59Q1DE5wvbmBXmWV2zHZ3zrxkd7X7ynlje8Xgv78JpeUoacH4XV4N
         Cysedxls4ZUB33PTFyPHI6khktRRjtkEJHu/v/X0JzAQu20F3JAQRrhyRFq8uhx+FUMS
         ICbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SqQvEnBb+Lrh6ePvvd5vsMk8iih8zoWam2MKt0f3sT0=;
        b=KqT/a/TqNLlytu7USJ7VfcbiMr46PUn9fPeLk16B/70wvTDHWUymqYA5rO/SFWCwIl
         X13/gM74YdE6ky89/hB8jKgLfPgq9wESE//YBZVNsXEZBfvDlsYPInsSVnArtgm5Dw1U
         cm8ohP37JRbGRg6+EDyI5EQhQFkhhuey85Pfn5q2SoStuo8GUCcrRzSmUU9BpVlOcZmn
         sYfMU8qI/Dn8gbTduEVSvGGawBZoz1p6o2pYSSalgy0uvFbEPQOk6bEDrYRyPjdEeW2O
         9oufxDGQO/6NMIgvJuHfoMrBMt9s2sEMbhNFpkd7EXQyyXrZD7kFieIfok7i2lQSpbaF
         qpog==
X-Gm-Message-State: AN3rC/53NZ9tEg6erfc5G/1gSCN+1ZUGPRRbuJ9TnIzlY/1orjFzrdN5
        N03iKOkEVcw89sYBaT7+hTXidfsN6w==
X-Received: by 10.36.89.207 with SMTP id p198mr958030itb.71.1493889007992;
 Thu, 04 May 2017 02:10:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 4 May 2017 02:09:47 -0700 (PDT)
In-Reply-To: <61C67DC73308BD49B2D4B65072480DBA2BDA554E@DEERLM99EZ1MSX.ww931.my-it-solutions.net>
References: <20170503162931.30721-1-jn.avila@free.fr> <20170503210726.24121-1-jn.avila@free.fr>
 <61C67DC73308BD49B2D4B65072480DBA2BDA554E@DEERLM99EZ1MSX.ww931.my-it-solutions.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 4 May 2017 11:09:47 +0200
Message-ID: <CACBZZX77Ad120bgTxJd+jqvPEX81BEYWrXnN2TeK+UgT63816w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] usability: don't ask questions if no reply is required
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 4, 2017 at 10:52 AM, Kerry, Richard <richard.kerry@atos.net> wr=
ote:
>
> May I suggest that " The most approaching commands" doesn't make much sen=
se as English (I don't think a command can "approach").
> Perhaps it should be " The most appropriate commands".

I had the same concern, saying "appropriate" is IMO also confusing.
The point of this UI is not to point out what you should be running,
which "appropriate" implies, but just "we couldn't find what you
meant, did you mean one of these?".

I think nothing needs to change here. The whole premise here is that a
program should never ask a question when you can't give an answer, I
think that's nonsense. There's such a thing as a rhetorical question,
and sometimes using that form is the most obvious & succinct way to
put things.

Which is not to say that phrasing these things as a non-question can't
be better, but the suggestions so far just seem more complex.

Also keep in mind that a huge part of the user base for git using the
English UI consists of non-native speakers, and when in doubt we
should definitely be picking simpler English like "did you mean?" v.s.
alternatives with >10 character more obscure words.

> Richard Kerry
> BNCS Engineer, SI SOL Telco & Media Vertical Practice
>
> T: +44 (0)20 3618 2669
> M: +44 (0)7812 325518
> Lync: +44 (0) 20 3618 0778
> Room G300, Stadium House, Wood Lane, London, W12 7TA
> richard.kerry@atos.net
>
>
>
>
> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Beh=
alf Of Jean-Noel Avila
> Sent: Wednesday, May 03, 2017 10:07 PM
> To: git@vger.kernel.org
> Cc: rashmipai36@gmail.com; Jean-Noel Avila <jn.avila@free.fr>
> Subject: [PATCH v2 1/3] usability: don't ask questions if no reply is req=
uired
>
> There has been a bug report by a corporate user that stated that "spellin=
g mistake of stash followed by a yes prints character 'y'
> infinite times."
>
> This analysis was false. When the spelling of a command contains errors, =
the git program tries to help the user by providing candidates which are cl=
ose to the unexisting command. E.g Git prints the
> following:
>
>         git: 'stahs' is not a git command. See 'git --help'.
>         Did you mean this?
>
>         stash
>
> and then exits.
>
> The problem with this hint is that it is not formally indicated as an hin=
t and the user is in fact encouraged to reply to the question, whereas the =
Git command is already finished.
>
> The user was unlucky enough that it was the command he was looking for, a=
nd replied "yes" on the command line, effectively launching the `yes` progr=
am.
>
> The initial error is that the Git programs, when launched in command-line=
 mode (without interaction) must not ask questions, because these questions=
 would normally require a user input as a reply while they won't handle ind=
eed. That's a source of confusion on UX level.
>
> To improve the general usability of the Git suite, the following rule was=
 applied:
>
> if the sentence
>  * appears in a non-interactive session
>  * is printed last before exit
>  * is a question addressing the user ("you")
>
> the sentence is turned into affirmative and proposes the option.
>
> The basic rewording of the question sentences has been extended to other =
spots found in the source.
>
> Requested at https://github.com/git/git-scm.com/issues/999 by rpai1
>
> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> ---
>  builtin/am.c       | 4 ++--
>  builtin/checkout.c | 2 +-
>  help.c             | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c index a95dd8b4e..f5afa438d 10064=
4
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1312,7 +1312,7 @@ static int parse_mail(struct am_state *state, const=
 char *mail)
>         }
>
>         if (is_empty_file(am_path(state, "patch"))) {
> -               printf_ln(_("Patch is empty. Was it split wrong?"));
> +               printf_ln(_("Patch is empty. It may have been split wrong=
."));
>                 die_user_resolve(state);
>         }
>
> @@ -1940,7 +1940,7 @@ static void am_resolve(struct am_state *state)
>
>         if (unmerged_cache()) {
>                 printf_ln(_("You still have unmerged paths in your index.=
\n"
> -                       "Did you forget to use 'git add'?"));
> +                       "You might want to use 'git add' on them."));
>                 die_user_resolve(state);
>         }
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c index bfa5419f3..050=
37b9b6 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1287,7 +1287,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
>                  */
>                 if (opts.new_branch && argc =3D=3D 1)
>                         die(_("Cannot update paths and switch to branch '=
%s' at the same time.\n"
> -                             "Did you intend to checkout '%s' which can =
not be resolved as commit?"),
> +                             "'%s' can not be resolved as commit, but it=
 should."),
>                             opts.new_branch, argv[0]);
>
>                 if (opts.force_detach)
> diff --git a/help.c b/help.c
> index bc6cd19cf..4658a55c6 100644
> --- a/help.c
> +++ b/help.c
> @@ -411,8 +411,8 @@ const char *help_unknown_cmd(const char *cmd)
>
>         if (SIMILAR_ENOUGH(best_similarity)) {
>                 fprintf_ln(stderr,
> -                          Q_("\nDid you mean this?",
> -                             "\nDid you mean one of these?",
> +                          Q_("\nThe most approaching command is",
> +                             "\nThe most approaching commands are",
>                            n));
>
>                 for (i =3D 0; i < n; i++)
> --
> 2.12.0
>
> Atos, Atos Consulting, Worldline and Canopy The Open Cloud Company are tr=
ading names used by the Atos group. The following trading entities are regi=
stered in England and Wales: Atos IT Services UK Limited (registered number=
 01245534), Atos Consulting Limited (registered number 04312380), Atos Worl=
dline UK Limited (registered number 08514184) and Canopy The Open Cloud Com=
pany Limited (registration number 08011902). The registered office for each=
 is at 4 Triton Square, Regent=E2=80=99s Place, London, NW1 3HG.The VAT No.=
 for each is: GB232327983.
>
> This e-mail and the documents attached are confidential and intended sole=
ly for the addressee, and may contain confidential or privileged informatio=
n. If you receive this e-mail in error, you are not authorised to copy, dis=
close, use or retain it. Please notify the sender immediately and delete th=
is email from your systems. As emails may be intercepted, amended or lost, =
they are not secure. Atos therefore can accept no liability for any errors =
or their content. Although Atos endeavours to maintain a virus-free network=
, we do not warrant that this transmission is virus-free and can accept no =
liability for any damages resulting from any virus transmitted. The risks a=
re deemed to be accepted by everyone who communicates with Atos by email.
