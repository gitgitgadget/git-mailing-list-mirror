Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01B11F404
	for <e@80x24.org>; Sat,  3 Mar 2018 13:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeCCNJT (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 08:09:19 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33099 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbeCCNJT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 08:09:19 -0500
Received: by mail-ua0-f196.google.com with SMTP id f6so2452940ual.0
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 05:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=poyJwqWssQdc7O0qdsY4AS0k5DGXuH0jk0UnwZAuOmc=;
        b=UP/mwKTaLNdAKdTVeGAh5smD18zJtTVF+YXdivi19XWTIfYuAfMZvdL8TCTEJRk407
         OERa6Tzak2GbiZ+Y5meBVjA+c4ZZdKblofcqnkrApO0y7Ymv/2AN6j4+UW9pmX5yASi0
         WWJ3bxK3/E755h7RJrD6RjZEK7onbEeHGqdHmT2UrurNu3BjquAG0wYJf6ddCSQTX96L
         RIdLRDRlDvWiKZ2d2AwuKVEwfViDeDxQH/2TxthbTUEkv0EqGGteWg0qCMCeureBNlR1
         H9waAh6vM4PiiCoSQuxO3i6J4qUXdmH//CbKXnOPeJPq359cpsd+EZAkx74yuT1x6Xne
         +bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=poyJwqWssQdc7O0qdsY4AS0k5DGXuH0jk0UnwZAuOmc=;
        b=QLO3bZdZJAIDSzYdJNwi3khuycI9D96SizXb+httQBuJdUQniIKAbqsWYuIzbWVJPN
         8OBqTKsgvV7PHkAWT9jXtlaDMSpYshGV4KCQSB2jqdSXU0w0NMQD88y9g+fDpfhBiasX
         O8kpN/oyAn07Ejo7Iwarb9BvsyMDiBDEIPLDTS/Pg94TIEZSMYbiY+4v01hbQT+rl+RK
         xCoqjBFo5mirQXKnqljUhXZpTTr0TV6L6VUIzfKXmqq6Pf0VNiJNa8pW9nyZRzRRi5/i
         t6wRglTX4chCsJE/sJ+QeoLKZeWjuG3mMHqKxOY8bHtoDUtpH/PGzeEyy+FnauKg5VO1
         JY/g==
X-Gm-Message-State: APf1xPDcVnGcPTw/C+DpZd/mIzwJjwMkn7Ed1iJcLxg2pMIecMZDmsjp
        Lqsnk9suC/r5kFG/XoXXOkyCmhYnFSpR2crzhYc=
X-Google-Smtp-Source: AG47ELuVxdQhHI4KosEcbLtBlhnDdHynyLKEGrZ+DIxnWwjdXEXu3IF2M4KDOFdQDR65F3tO+3GNDdLdWJ6qVxVGL54=
X-Received: by 10.176.1.116 with SMTP id 107mr6214343uak.27.1520082558216;
 Sat, 03 Mar 2018 05:09:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Sat, 3 Mar 2018 05:09:17 -0800 (PST)
In-Reply-To: <20180303092307.3796-3-pclouds@gmail.com>
References: <20180303092307.3796-1-pclouds@gmail.com> <20180303092307.3796-3-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 3 Mar 2018 14:09:17 +0100
Message-ID: <CAM0VKjmmF2t=B2s3rJoKmO3j6Bk5d6PEfCV==ONRGMcdUMLFpQ@mail.gmail.com>
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
> without even running --git-completion-helper. But since this is an error
> case (and we're not doing anything destructive, it's probably ok for now)
>
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

There is a minor behaviour change here, though.  This

  prune,*)
    ;;

case arm ensured that we don't list refs for 'git notes prune <TAB>',
because it doesn't accept them (and then we take our usual fallback and
let Bash complete filenames;  yeah, 'git notes prune' doesn't accept
filenames either, but, as I said, that's our usual fallback when we
can't offer anything for completion).

This patch removes that case arm, and refs will be offered for 'git
notes prune <TAB>'.

> +       *,--*)
> +               __gitcomp_builtin notes_$subcommand
>                 ;;
>         *)
>                 case "$prev" in
> --
> 2.16.1.435.g8f24da2e1a
>
