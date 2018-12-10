Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31CB920A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 20:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeLJU0x (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 15:26:53 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35825 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbeLJU0x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 15:26:53 -0500
Received: by mail-vk1-f193.google.com with SMTP id b18so2851937vke.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3ewwIvKPt5oAHpSEzCwJyjWNoiY1AC87Z/0mQaHBB0=;
        b=cL15LbKytlShLpLl9ZIEX/qqSUhiGWwVXFqpWKn6lGELKCVCR/2x1p05T+gxjjN49E
         V/Sfj9yqio3fjYpwb27PWjCJBuNlGIzW2stS/2UDRGiN7TPM5H5BWS+TuA9yPSU3m7Z3
         aftEl4rW8zGC14NMCs92Oh+Gjz+flZvDEnugBQcg2+sQqxAQLZcD4MGgMWUX8yvdP46K
         wWgjVj2E9ORmd7rJ3rV17Fi0w0ugogmo19APcnIrHkC8uAEhZOa5keIqruTIl8Ny2yof
         OVmyYfoHxhU0OkhsNUeSrP1yytXm4yEZQY6vT9SDFJbfGIkV5IrSuLUDm1CLuMvW0eDx
         +nqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3ewwIvKPt5oAHpSEzCwJyjWNoiY1AC87Z/0mQaHBB0=;
        b=IDgjbaDR4Dm719TMQwbqB4EZWO0YtkDmtogoTpCca9Cg2O+fMgFKyvCK9DE6oWE2y5
         nUcXLz75l0pywbJSADzRRuFq+1wmbFgKvvwJVSKnrXupOqFs9luzfhHloyg+NUgacqKx
         8MWtFFejKcLgNqX5IibLjYai58O6+BRPTEPypjr+VWbd1Akvn0gCtX8O31clnDleJrRm
         8umP7Rzj8VoUoX/paG7/jcvHSUxR8nfIWIdLq+6LgW/TRM48Qhvue0zyk/7VtCyjhB3e
         wf3hyspdhjKhIJf0TcKYTo5j+INnShQ6CRiaGT2zDBihOTxV0AUTJEFZDiqXwNzinmDA
         D9ZQ==
X-Gm-Message-State: AA+aEWYDiGsT3hUvN0pK8MziWKZs2kH6+PrGbOnuW+fQ7llyoWUDPw0Z
        3WCn0uZUCpLS+LRDOfPW2J8H9nY2TpjuOwriZkA=
X-Google-Smtp-Source: AFSGD/X0CI1pbTblLJjixdx5w8GGC0aAk6Iyz+04pScvQxjLRBex1m0inpjMJWak/VR2Y1dFNAAf0d3YwyRClcGexzo=
X-Received: by 2002:a1f:97d1:: with SMTP id z200mr5812967vkd.15.1544473611647;
 Mon, 10 Dec 2018 12:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-9-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-9-t.gummerer@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Dec 2018 12:26:38 -0800
Message-ID: <CABPp-BHHC2ADhW5iPhAocCv7a-F+6T5vGboYa8kyHhLsBRCn-A@mail.gmail.com>
Subject: Re: [PATCH 8/8] stash: use git checkout --no-overlay
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 12:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Now that we have 'git checkout --no-overlay', we can use it in git
> stash, making the codepaths for 'git stash push' with and without
> pathspec more similar, and thus easier to follow.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> As mentioned in the cover letter, not sure if we want to apply this
> now.  There are two reasons I did this:
> - Showing the new functionality of git checkout
> - Increased test coverage, as we are running the new code with all git
>   stash tests for free, which helped look at some cases that I was
>   missing initially.
>
>  git-stash.sh | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 94793c1a91..67be04d996 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -314,19 +314,15 @@ push_stash () {
>
>         if test -z "$patch_mode"
>         then
> -               test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
> -               if test -n "$untracked" && test $# = 0
> +               test "$untracked" = "all" && CLEAN_X_OPTION=-X || CLEAN_X_OPTION=
> +               if test -n "$untracked"
>                 then
> -                       git clean --force --quiet -d $CLEAN_X_OPTION
> +                       git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
>                 fi
>
>                 if test $# != 0
>                 then
> -                       test -z "$untracked" && UPDATE_OPTION="-u" || UPDATE_OPTION=
> -                       test "$untracked" = "all" && FORCE_OPTION="--force" || FORCE_OPTION=
> -                       git add $UPDATE_OPTION $FORCE_OPTION -- "$@"
> -                       git diff-index -p --cached --binary HEAD -- "$@" |
> -                       git apply --index -R
> +                       git checkout --quiet --no-overlay --ignore-unmatched HEAD -- "$@"

Nice.  :-)
