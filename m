Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380231F406
	for <e@80x24.org>; Fri, 11 May 2018 15:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbeEKPFo (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 11:05:44 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33383 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbeEKPFn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 11:05:43 -0400
Received: by mail-ua0-f193.google.com with SMTP id i2-v6so3810761uah.0
        for <git@vger.kernel.org>; Fri, 11 May 2018 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yBUzTspCTYXqbqaYJDwciQIhoVtxQ5BVVcFGKUQnBcc=;
        b=gWgTNhoj///bwy279QgybyoVSHRCsson1Pc4K7urccY3yjrSp4KAZpSxFvIN8UmlQd
         oMq8fL4MgVMU4fKHzFUvJ7U2RmBUKjSeLAvveyPojhcuR2YsqEMJqTq87egH6SCHtV+9
         6QsSt4qFGoWhjoTAQg/ubPKj9iLI4V9SBL5KEPtW726YkcgA3bU6yYPowRHU5y/DntAg
         6cwmMhF00U4O8s2CTQ9AO6ph0qRc7FzCA1BHGAVSeagUqvMPDqwLJA+CK5nys4uM+m0Z
         O65xzHEmSVFhmnxkjRXX1IqyG6OaAcqsI8t7bVEyR2rO4vMZE1cOCdZc/eMz2v/2Rp88
         jkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yBUzTspCTYXqbqaYJDwciQIhoVtxQ5BVVcFGKUQnBcc=;
        b=L//uD/mZAd6bJaq7MTbMDKyw2m/ewIialoZozsWeX/unL2bGZnVrB8a49Je5hntO8Y
         91W975MB55HY8/0cPkDRsYc5Baf5JDeeh6G4hCiYSSbbPyAKGB9wndd+ytpG/AHuLb2k
         Z/ncETB3gh7MNva3DpAC99h/c926wM4Dpe/DfVNfriOqbQ9qz8dfN+St1X95TENBR3/W
         TPJ6EdEW+1nJHLEr7dSMyHjTyrTMF8E86xzcFMb0eQbS8VpRT74tz91lCKWvQ177IEuA
         7/YTGEXUtCHJr+QLfjdEZ11MYdr2cRTerJTQjR3mG9YUowzSpGuwAIHRjAuh9/Gp4spm
         90DQ==
X-Gm-Message-State: ALKqPwefgGm5btSJnSHVBOFs5FJLhyutxdqulz5QLaAyHYsENWHme0xt
        Y10Mzo4f3zwfxnj9It2gPxXowpNXHb9q9WR0/D8=
X-Google-Smtp-Source: AB8JxZotFH+r9sZfCQcV87q2HLRY3VMTv9X2dA2hcJAIPPcQFE4tFIF4jdf2yqKr6SoMkAEic4ZklL5XfYEdcyAJVY0=
X-Received: by 2002:ab0:a81:: with SMTP id d1-v6mr1652997uak.39.1526051142972;
 Fri, 11 May 2018 08:05:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.22.212 with HTTP; Fri, 11 May 2018 08:05:42 -0700 (PDT)
In-Reply-To: <20180510084652.25880-13-pclouds@gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com> <20180510084652.25880-1-pclouds@gmail.com>
 <20180510084652.25880-13-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 11 May 2018 17:05:42 +0200
Message-ID: <CAM0VKjmL=OfKcveHRW+eAzvwS2o8TjcOS-uRNzD1JuKY2DYfFw@mail.gmail.com>
Subject: Re: [PATCH v7 12/13] completion: let git provide the completable
 command list
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 10:46 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> Instead of maintaining a separate list of command classification,
> which often could go out of date, let's centralize the information
> back in git.
>
> While the function in git-completion.bash implies "list porcelain
> commands", that's not exactly what it does. It gets all commands (aka
> --list-cmds=3Dmain,others) then exclude certain non-porcelain ones. We
> could almost recreate this list two lists list-mainporcelain and
> others. The non-porcelain-but-included-anyway is added by the third
> category list-complete.
>
> list-complete does not recreate exactly the command list before this
> patch though. The following commands are not part of neither
> list-mainporcelain nor list-complete and as a result no longer
> completes:
>
> - annotate             obsolete, discouraged to use
> - difftool-helper      not an end user command
> - filter-branch        not often used
> - get-tar-commit-id    not often used
> - imap-send            not often used
> - interpreter-trailers not for interactive use
> - lost-found           obsolete
> - p4                   too short and probably not often used (*)
> - peek-remote          deprecated
> - svn                  same category as p4 (*)
> - tar-tree             obsolete
> - verify-commit        not often used

'git name-rev' is plumbing as well.

I think this commit should be split into two:

  - first do the unequivocally beneficial thing and get rid of the
    long, hard-coded command list in __git_list_porcelain_commands(),
    while keeping its output unchanged,

  - then do the arguable thing and change the list of commands.

> Note that the current completion script incorrectly classifies
> filter-branch as porcelain and t9902 tests this behavior. We keep it
> this way in t9902 because this test does not really care which
> particular command is porcelain or plubmbing, they're just names.
>
> (*) to be fair, send-email command which is in the same
> foreignscminterface group as svn and p4 does get completion, just
> because it's used by git and kernel development. So maybe should
> include them.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  command-list.txt                       |  37 ++++----
>  contrib/completion/git-completion.bash | 117 ++++++-------------------
>  t/t9902-completion.sh                  |   5 +-
>  3 files changed, 48 insertions(+), 111 deletions(-)

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 4e724a5b76..908692ea52 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -835,18 +835,30 @@ __git_complete_strategy ()
>  }
>
>  __git_commands () {
> -       if test -n "${GIT_TESTING_COMMAND_COMPLETION:-}"
> -       then
> -               printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
> -       else
> -               git --list-cmds=3Dmain,others
> -       fi
> +       case "$1" in
> +       porcelain)
> +               if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
> +               then
> +                       printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
> +               else
> +                       git --list-cmds=3Dlist-mainporcelain,others,list-=
complete
> +               fi
> +               ;;
> +       all)
> +               if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
> +               then
> +                       printf "%s" "$GIT_TESTING_ALL_COMMAND_LIST"
> +               else
> +                       git --list-cmds=3Dmain,others
> +               fi
> +               ;;
> +       esac
>  }
>
> -__git_list_all_commands ()
> +__git_list_commands ()

Please add comments before these functions to document their mandatory
argument.

>  {
>         local i IFS=3D" "$'\n'
> -       for i in $(__git_commands)
> +       for i in $(__git_commands $1)
>         do
>                 case $i in
>                 *--*)             : helper pattern;;

Is this loop to exclude helper commands with doubledash in their name
still necessary?
