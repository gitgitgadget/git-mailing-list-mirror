Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB8C01F404
	for <e@80x24.org>; Wed, 14 Feb 2018 14:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030760AbeBNO3g (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 09:29:36 -0500
Received: from mail-ua0-f179.google.com ([209.85.217.179]:40826 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030429AbeBNO3f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 09:29:35 -0500
Received: by mail-ua0-f179.google.com with SMTP id t6so13777676ual.7
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 06:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iVe7gW75N1SO4HWXj7/PA49oVayszQDeo6Fv/h7LJYA=;
        b=trGNBe+G9UKohxghrcP4lneKzNWd6tiQTN+ZJPS/Sv5B849ShzBRebc4mU4NIdk+0p
         gS1Tk4UbyyAd7TVTnvnfQWCBVFPfnU31d8XUyOIWewKIJ4UUcaLAzIFwiANPIq7/QdCp
         KNEWSn2wiFB4Y7sooMNHtOS2MiaZNVCjHp918EUjWKvyGl7+2IVcXZ6nCzm0bXSjztdz
         uY1udSrYagIiBZdsN3IlbWCpc2UkULw67KDjybizAKxo7bFS7m9KMCxhTH8nU8N9fuLX
         TBkuL8D/fU90iwcErVOZCEupXXBVBKQY40EPLoogJvgkc1LDTRuyas8q7w15pjPoCl2I
         bXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iVe7gW75N1SO4HWXj7/PA49oVayszQDeo6Fv/h7LJYA=;
        b=DGzTnEWJeT3g5mz5IN5e/4Iqu7Ilo+OObIqz35cW0wQ/iIBazYi/rlEFxCOqyECM23
         kjbZSzgXjIHTQAFkFIqYS/FgIS29jkf2WzAdHtYcZFaii1BWkL4z682+sjJt/N3rfLiL
         chpyp2ENnxV5MKtHDDgTtcJd0mT+N7GaauzYfVS6xDXkjpt6ip0xW4+4X7TaopHpA/iS
         e2PFZ5Asy8375fuwlQyrlNoi+m+FV6CTxs7BcNbpIvwBpyqeUvLblJ/CSCICJ6X/8eN0
         Qg8aPNxGRggCy/DsSx9qV7Uvy21j5USQyYKW5OgBnomyWlJTWdcOKl0pm90O0GCDsYXI
         Iqsw==
X-Gm-Message-State: APf1xPBdDyBqTK8HV0rS/QQioUDvf6iMTBIh9GNtygScnKFKvMyvBDTs
        OEGqhvb42ZwOUc4x4n0XnM3IwLh3/lonMWV+f4Q43g==
X-Google-Smtp-Source: AH8x226OD4d6SVJlBpU1DxwanK1JsTfbTiKi4tX57wSiJPfNe52SsnS82kxe5haAurfk6t3+QX49t0GY5JBeAGZcooE=
X-Received: by 10.176.72.178 with SMTP id x47mr4835395uac.24.1518618574710;
 Wed, 14 Feb 2018 06:29:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Wed, 14 Feb 2018 06:29:34 -0800 (PST)
In-Reply-To: <20180209110221.27224-30-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-30-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 14 Feb 2018 15:29:34 +0100
Message-ID: <CAM0VKjmJwDUv4gTQ+22SgfX+=PahXRPeP=774hV7mxxm3nXiYg@mail.gmail.com>
Subject: Re: [PATCH v3 29/42] completion: use __gitcomp_builtin in _git_notes
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 9, 2018 at 12:02 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index c7b8b37f19..60127daebf 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash

> @@ -1851,15 +1851,17 @@ _git_notes ()
>         add,--reedit-message=3D*|append,--reedit-message=3D*)
>                 __git_complete_refs --cur=3D"${cur#*=3D}"
>                 ;;
> -       add,--*|append,--*)
> -               __gitcomp '--file=3D --message=3D --reedit-message=3D
> -                               --reuse-message=3D'
> +       add,--*)
> +               __gitcomp_builtin notes_add
> +               ;;
> +       append,--*)
> +               __gitcomp_builtin notes_append
>                 ;;
>         copy,--*)
> -               __gitcomp '--stdin'
> +               __gitcomp_builtin notes_copy
>                 ;;
>         prune,--*)
> -               __gitcomp '--dry-run --verbose'
> +               __gitcomp_builtin notes_prune
>                 ;;
>         prune,*)
>                 ;;

This could be simplified to:

  add,--*|append,--*|copy,--*|prune,--*)
        __gitcomp_builtin notes_$subcommand
        ;;

And we could even go one step further:

  *,--*)
        __gitcomp_builtin notes_$subcommand
        ;;

This would have the benefit that if any of the remaining subcommands
learn --options, then they would be completed right away, without the
need to add that subcommand to the case arms.  Case in point is 'git
notes remove', which already accepts two options, but they are not
completed because of the missing 'remove,--*)' case arm.  The same would
also apply to 'git notes merge's options, except that the completion
script completely misses the 'merge' subcommand in the first place
(blame on me, 2a5da75579 (bash: support more 'git notes' subcommands and
their options, 2010-10-10)).

This also applies to the completion functions of other commands with
subcommands ('remote', 'worktree').

The downside is that we would run 'git cmd subcmd
--git-completion-helper' even if a subcommand doesn't use parse options.
I think that's acceptable.
