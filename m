Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA151F424
	for <e@80x24.org>; Mon, 23 Apr 2018 13:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755342AbeDWNdC (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 09:33:02 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43062 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755016AbeDWNdB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 09:33:01 -0400
Received: by mail-vk0-f66.google.com with SMTP id v134so9355344vkd.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jELbs7ujrksgx5u46qdkSgT1HP4R/W5W8ua7PogRPvk=;
        b=fbtzGhCJ/TIeUlOSu2ES+SO8P75ZSxH1KK9rtqvNjyD7WKtofF4iIpHp30Ne5rwG+G
         V4cVBGj787y3CVNdqAFeO9uB/F1hYgjx8vS4wc23bkGmXyIWULHbcdjrA/B7PFT+NFvy
         LtGTdJWZd0Jg7d8Wu/1RPhJ+1jfBmbHp8biUhQ0ISDPRj5Vas9cLOMUmAT1iWYcuaNMG
         jv/n12RdAKYI3onb96yrRbIWWMu7jXluMs4eI/y6O4N1aJsHKFv34kNDGMgPDANMr/+8
         Wu/sn0dG6bwPSd8quY2XVrhy60PPtFNy0493UEIUejSrWT5ibiJ+tyLRD9e3HIqwJ05S
         xeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jELbs7ujrksgx5u46qdkSgT1HP4R/W5W8ua7PogRPvk=;
        b=uXqvbV82njnDZUYkydyqKZjgxR0rwrZ05luW5UVks95JMk1m0xeJ9EOk8xgXDbKHVz
         9NKaEVksI149SoQMVgwSKYKsDiGkXIMU4gVGPVOLcKcMdOC6V6nkol+3hSOf3OAEnaOJ
         qmHTCBeqyBKcAXYRrrt1c2kekMwsBdGR2VDXD6nH8h8oeGzz7R2GbjVP+TeMpKgVCAsa
         ryjw0NI0OZMmNwJdnMNbTIdraEOjkAief+WCkIu8HGsrJD+Yca22afaQQmCMnqxJ0jPN
         zAKjqTXpvQx9/zGMN7CNLhIOZSZcyYHo20/bTjVcxnozkZaiZB7KS5hVWJudfxQfbVGi
         bAHg==
X-Gm-Message-State: ALQs6tCWypqUwssf3wMrn4iGdOAVqg2PEsh9J2abmyUtGt86FoEgPx4R
        NuWPm9O/i87JBtug7CbibpDnCIJijU0kfukeYL0=
X-Google-Smtp-Source: AIpwx4/rxcPH8Y1V9OpFL50O/wjnAEzHsG0itbMDfsWYUUYAhAS8IIZUBB/0jaETFBMb94Mai6w2r1qsKO9/DkN8NOs=
X-Received: by 10.31.4.145 with SMTP id 139mr15413778vke.113.1524490374110;
 Mon, 23 Apr 2018 06:32:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Mon, 23 Apr 2018 06:32:50 -0700 (PDT)
In-Reply-To: <20180421165414.30051-5-pclouds@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com> <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165414.30051-5-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 23 Apr 2018 15:32:50 +0200
Message-ID: <CAM0VKjkd7OZspeTPumi4NVOM=7yXEq=nSjCNntkJ9d-8mPfR2w@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] git.c: implement --list-cmds=porcelain
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 6:54 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This is useful for git-completion.bash because it needs this set of
> commands. Right now we have to maintain a separate command category in
> there.

I don't really understand this paragraph, in particular its second
sentence.  I would have described this change like this:

  To get the list of commands offered after 'git <TAB>', the
  completion script filters out plumbing commands from the list of all
  git commands.  To do so, it contains a long hard-coded list of the
  names of all known plumbing commands, which is redundant with the
  categorization in 'command-list.txt', is a maintenance burden, and
  tends to get out-of-sync when new plumbing commands are added.

  Implement 'git --list-cmds=3Dporcelain' to list only commands
  categorized as porcelains, so we can get rid of that long hard-coded
  command list from the completion script.

But then I noticed that it's not an accurate description of the
current situation, because there is a wide grey area between
porcelains and plumbing, and the completion script doesn't "filter out
plumbing commands", but rather filters out commands that can be
considered too low-level to be useful for "general" usage.
Consequently, after 'git <TAB>' we also list:

  - some 'ancillaryinterrogators': blame, annotate, difftool, fsck,
    help
  - some 'ancillarymanipulators': config, mergetool, remote
  - some 'foreignscminterface': p4, request-pull, svn, send-email
  - even some plumbing: apply, name-rev (though 'name-rev' could be
    omitted; we have 'git describe')
  - and also all "unknown" 'git-foo' commands that can be found in
    $PATH, which can be the user's own git scripts or other
    git-related tools ('git-annex', Git LFS, etc.).

With this change we wouldn't list any of the above commands, but only
those that are explicitly categorized as 'mainporcelain'.  I'd much
prefer the current behaviour.


> Note that the current completion script incorrectly classifies
> filter-branch as porcelain and t9902 tests this behavior. We keep it
> this way in t9902 because this test does not really care which
> particular command is porcelain or plubmbing, they're just names.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  contrib/completion/git-completion.bash | 106 +++----------------------
>  git.c                                  |   2 +
>  help.c                                 |  12 +++
>  help.h                                 |   1 +
>  t/t9902-completion.sh                  |   6 +-
>  5 files changed, 31 insertions(+), 96 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index a5f13ade20..7d17ca23f6 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash


> @@ -859,101 +864,14 @@ __git_all_commands=3D
>  __git_compute_all_commands ()
>  {
>         test -n "$__git_all_commands" ||
> -       __git_all_commands=3D$(__git_list_all_commands)
> -}
> -
> -__git_list_porcelain_commands ()
> -{
> -       local i IFS=3D" "$'\n'
> -       __git_compute_all_commands
> -       for i in $__git_all_commands
> -       do
> -               case $i in
> -               *--*)             : helper pattern;;
> -               applymbox)        : ask gittus;;
<...>
> -               verify-tag)       : plumbing;;

I will be glad to see this enormous list go.

> -               *) echo $i;;
> -               esac
> -       done
> +       __git_all_commands=3D$(__git_list_commands all)
>  }
