Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D31E1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 12:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeCCMcT (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 07:32:19 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34225 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbeCCMcS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 07:32:18 -0500
Received: by mail-vk0-f66.google.com with SMTP id z190so7288933vkg.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 04:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VGuViHItKCruq5amQkIMUibSIMpyvUGXr/rostwxxqk=;
        b=aZKa5CBvyuIrLD1xnWQ6oyCnfUlMHHuBymvaGK5bfJPYc4fZQ6nYsE43KlNm2SjhvT
         4Gj2DBLT4oZ35ibIzw5d9rM9uva3UIzl3xZaw4dDwj0TdkQ1UQmawk1hcggpd1CNWMFl
         NHsywC92OZDN2UcLXEO/CbiA7KIIOXZY6iJJe5g4ophNeBLjAgtyMpaJ0jJZZqp0/Jes
         YN14F/uNtIZRNlIwsLkLxhENt55t1bUng4gnDrOycoyMoN/BhI4FaYEm9s4RbGU3ltqJ
         ZYrnAC8fmpDL/8DCbce2bGh41EhTZ9IpgHXv7Cxy0fN19cUoMhP+nawKsaWUs1mnadx7
         SF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VGuViHItKCruq5amQkIMUibSIMpyvUGXr/rostwxxqk=;
        b=ftnl5AsqK7hytRed0oe+9GN8qyeL1z+XRLafYg4droCibwi3yDpzFv22ot6B3ruNG2
         vHsLGEuDV6fvmRjpaboVpbaLRxIHoo04zjqzG+5LlfEb7PqfTg1R/CnQWvVtqtk+JWw7
         wFUmPuzmEZmf5qD40/AHA8+x0MZK/LBFaZ5mz1P52VrllAy/z5eDZXZylMs25so/qFqr
         8ANxZbM9LXjcF4mRhZJsG6onFhDFf+ikbSodsaEmcKlb1kMu2+n/Kn0OGpDHLOqz6vcr
         YhWdgzEDHPrhTufYVjhFLl5gxRz0BCYR90vEb2qWiLUt2uHqKdjZfZP4HtXHAQN2I1gU
         u1Yw==
X-Gm-Message-State: APf1xPCm09hi4Dqu7LDJH9/H4jacUjVqZp3lTxlviK3001v887xSBOQi
        4PBe+lt0GHz+WEBxc7FIRDihccr/zEWjkc11nf6Eww==
X-Google-Smtp-Source: AG47ELssIDV+VPgf3l35BCvH+FYMYQA0V7ET2l301IRNCX42Hr8ARDFAgoVhAZ13Y0e6I4bLoJIQnq6gNvh2bHU8WEg=
X-Received: by 10.31.78.68 with SMTP id c65mr5855582vkb.58.1520080337321; Sat,
 03 Mar 2018 04:32:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Sat, 3 Mar 2018 04:32:16 -0800 (PST)
In-Reply-To: <20180303092307.3796-3-pclouds@gmail.com>
References: <20180303092307.3796-1-pclouds@gmail.com> <20180303092307.3796-3-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 3 Mar 2018 13:32:16 +0100
Message-ID: <CAM0VKj=Kgw5Yh50HjdoD_OteF0n8C-pJo9z09x6jEPQt1w+96A@mail.gmail.com>
Subject: Re: [PATCH 2/2] completion: simplify _git_notes
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 3, 2018 at 10:23 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This also adds completion for 'git notes remove' with two options:
> --ignore-missing and --stdin.
>
> For some strange reason, 'git notes undefined --<tab>' completes --ref
> without even running --git-completion-helper.

There is nothing strange about it.  _git_notes() first looks for the
presence of any subcommands on the command line, and if it doesn't find
any, it will list 'git notes's subcommands and options for completion.
And it does so by running '__gitcomp "$subcommands --ref"'

> But since this is an error
> case (and we're not doing anything destructive, it's probably ok for now)

I agree; and it matches the behaviour before the patch.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  contrib/completion/git-completion.bash | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index c310b241d3..ab80f4e6e8 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1836,19 +1836,8 @@ _git_notes ()
>         add,--reedit-message=3D*|append,--reedit-message=3D*)
>                 __git_complete_refs --cur=3D"${cur#*=3D}"
>                 ;;
> -       add,--*)
> -               __gitcomp_builtin notes_add
> -               ;;
> -       append,--*)
> -               __gitcomp_builtin notes_append
> -               ;;
> -       copy,--*)
> -               __gitcomp_builtin notes_copy
> -               ;;
> -       prune,--*)
> -               __gitcomp_builtin notes_prune
> -               ;;
> -       prune,*)
> +       *,--*)
> +               __gitcomp_builtin notes_$subcommand
>                 ;;
>         *)
>                 case "$prev" in
> --
> 2.16.1.435.g8f24da2e1a
>
