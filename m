Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C26FF1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 12:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967764AbeBNMxY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 07:53:24 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:33400 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967589AbeBNMxX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 07:53:23 -0500
Received: by mail-ua0-f195.google.com with SMTP id p12so13604501uad.0
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 04:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=op4x7hgthfF4qYFz/jT6Yr0CInL3900Pyq2KHHO9IX4=;
        b=IOVQ6GCTzRS+zOzEPBrfF41zqW13dhWVNHoBe3BWTdlQTkSswABzLu4enR/qv/tJg1
         gj0H2RDTt+dcoYq6WND1rU0XZQuvjTA7tdacMreBNA06gwrG2goD07FWwpvfXOTY4uKb
         X90Gq8B8LG6bdjjP5tCQP9cy6JHi8k7heZGF07efQzGocP6htoXYXt8wD0dZNpBz4fT0
         LxMqPENWirSHzWEIbD+8ySZCJ7p6J6d24WLMsFgjLorc0142oP1dnrrt7BCoSNyL4xdp
         W8Ur568K9Ve+YNwJYu5/9cZ6PHENWOG3netfhmGmq0TZW3elmjQH1IusKKmPFnvadRv/
         rJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=op4x7hgthfF4qYFz/jT6Yr0CInL3900Pyq2KHHO9IX4=;
        b=bHBEPz/aIrgkn6gx30uCaBJDgA/+hRLrK+v4zeLXvzv7qmDPeWIFrluzODlTs/hWGZ
         p+myOnY6CsBJr2hGKd7pU50fKTI5c0wMr0FoaFhFvKmk8MPfSqDnFQ6J4GFfKYxr1DsO
         Qy5APBiVhgyugLEAZ2qmB3WyajevgzpdiLppaPZrZSgav7yRk88WE2i63LakghtJFCth
         slpDOvUi+ZtR/T1/8/T1cieSU7+Ug/xacB1blxqyqJ+u1uyEtTcWdj3otvNpbHqUHneW
         tvrMcTVEeIGzFCJXDep9LH0B9sjFCpOBc9RfRVv7hZwm9L6zh52hQ/N34g0igWEOz/qb
         qC9w==
X-Gm-Message-State: APf1xPADTR2iVCH/BuomaT1mUGhH/7tp996+uAaFpgy4s4UvAfu9df9s
        uiA91gJaOta4gfTa1sU4+46bhIZE6n5soMelnTrmzg==
X-Google-Smtp-Source: AH8x225tFbojVtslT5oHz6xoi2/8BgS9qSWf6WovZOqJUIb7oJor8hKE4cF0UDu1R3mvP/ImYsHso0z6a4NGIJ2jOiI=
X-Received: by 10.176.5.66 with SMTP id 60mr4359994uax.180.1518612802599; Wed,
 14 Feb 2018 04:53:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Wed, 14 Feb 2018 04:53:22 -0800 (PST)
In-Reply-To: <20180209110221.27224-7-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-7-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 14 Feb 2018 13:53:22 +0100
Message-ID: <CAM0VKjmFEyr4qHdc1qfW0M_RZ7cM9bCfsn-M4Rapzt6CPhZE1g@mail.gmail.com>
Subject: Re: [PATCH v3 06/42] completion: use __gitcomp_builtin in _git_am
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

On Fri, Feb 9, 2018 at 12:01 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> The new completable options are:
>
> --directory
> --exclude
> --gpg-sign
> --include
> --keep-cr
> --keep-non-patch
> --message-id
> --no-keep-cr
> --patch-format
> --quiet
> --reject
> --resolvemsg=3D
>
> In-progress options like --continue will be part of --git-completion-help=
er
> then filtered out by _git_am() unless the operation is in progress. This
> helps keep marking of these operations in just one place.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  contrib/completion/git-completion.bash | 11 ++++-------
>  parse-options.h                        |  4 ++--
>  rerere.h                               |  3 ++-
>  3 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 1e0bd835fe..eba482eb9c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1105,12 +1105,13 @@ __git_count_arguments ()
>  }
>
>  __git_whitespacelist=3D"nowarn warn error error-all fix"
> +__git_am_inprogress_options=3D"--skip --continue --resolved --abort"
>
>  _git_am ()
>  {
>         __git_find_repo_path
>         if [ -d "$__git_repo_path"/rebase-apply ]; then
> -               __gitcomp "--skip --continue --resolved --abort"
> +               __gitcomp "$__git_am_inprogress_options"
>                 return
>         fi
>         case "$cur" in
> @@ -1119,12 +1120,8 @@ _git_am ()
>                 return
>                 ;;
>         --*)
> -               __gitcomp "
> -                       --3way --committer-date-is-author-date --ignore-d=
ate
> -                       --ignore-whitespace --ignore-space-change
> -                       --interactive --keep --no-utf8 --signoff --utf8
> -                       --whitespace=3D --scissors
> -                       "
> +               __gitcomp_builtin am "--no-utf8" \
> +                       "$__git_am_inprogress_options"
>                 return
>         esac
>  }
> diff --git a/parse-options.h b/parse-options.h
> index 3c32401736..009cd863e5 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -144,8 +144,8 @@ struct option {
>  #define OPT_STRING_LIST(s, l, v, a, h) \
>                                     { OPTION_CALLBACK, (s), (l), (v), (a)=
, \
>                                       (h), 0, &parse_opt_string_list }
> -#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NU=
LL, \
> -                                     (h), PARSE_OPT_NOARG, &parse_opt_te=
rtiary }
> +#define OPT_UYN(s, l, v, h, f)      { OPTION_CALLBACK, (s), (l), (v), NU=
LL, \
> +                                     (h), PARSE_OPT_NOARG|(f), &parse_op=
t_tertiary }
>  #define OPT_DATE(s, l, v, h) \
>         { OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,    \
>           parse_opt_approxidate_cb }

Shouldn't this hunk go into a commit of its own?  Or at least it would
deserve a mention in the commit message.


> diff --git a/rerere.h b/rerere.h
> index c2961feaaa..5e5a312e4c 100644
> --- a/rerere.h
> +++ b/rerere.h
> @@ -37,6 +37,7 @@ extern void rerere_clear(struct string_list *);
>  extern void rerere_gc(struct string_list *);
>
>  #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
> -       N_("update the index with reused conflict resolution if possible"=
))
> +       N_("update the index with reused conflict resolution if possible"=
), \
> +       PARSE_OPT_NOCOMPLETE)
>
>  #endif
> --
> 2.16.1.207.gedba492059
>
