Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4B1215F4
	for <e@80x24.org>; Tue,  1 May 2018 20:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750911AbeEAUZ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 16:25:28 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36535 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeEAUZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 16:25:27 -0400
Received: by mail-qk0-f195.google.com with SMTP id a202so9678348qkg.3
        for <git@vger.kernel.org>; Tue, 01 May 2018 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=aLOE0X/Hh/iZGT6vSJYq60JQEtum04MTqtWREK6vSEE=;
        b=QvfC0UBJh3aq70K0/OFotaDwtD6DQFIZHDiogukjvth6AVVck+rk+1+jwmVLrnxlMc
         MBKL5Yxp3NsWZEwJ4nTjx5FZiohcB6w6FQPZaDXnk+w9eOEBmgLm9RIGAE9zE2ID19+d
         KVBSI+wpKqdMwUngcZpxKYkvZ0Uf7bciv5cOTn9yRKdJGeqKD5FbUakk9L+xzOpLhJnb
         PkqF6uEGN+7caAf2QXjj0xk1oKhpG7rCxKPzz+AjgkWWwU9x61ZhRTJ2t4l86eG9dxh0
         x5RJOWhTDpPFAXKGwiryISoqjXfUVjVBI8n5QtXj/78hLPLZlZvllDJtgUNkyfwz966k
         MomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=aLOE0X/Hh/iZGT6vSJYq60JQEtum04MTqtWREK6vSEE=;
        b=O+fT/5zu7vBNQBsSZtS1F55lYoDX3Xee9j0egrK608NzNKf2gKenLttN5aCgSOMnO6
         L4+OtHkuLI9wywIBRETO0+u50SFJ/8Mr7EqJEJ3mn5F5wmgDWNzoDwmObV8NwaCysAin
         8KRHxFne1zvU0N7rF0MpkUjptyaAYJN5HKy6gaI4PPVma5fEU2NJHWu/8wnyVNxtCROU
         ixGtuGBWO9ZBKePNrI8GtVD2Oi8GeLPCQWdxyeQBoMPivirSYb9fWtIwNiqc+f7jZXdq
         ozFj2jzBrb6AOYCmf0SNbyzUg3GSNIzPJQKpbxtZotQ50GlqylhHCjuVcpVowWEB1+bG
         BAYg==
X-Gm-Message-State: ALQs6tAlyh+W/9etbVxhVWu/ZbVxJhQvd9gqqJAwveHHoVgxIBd86eg2
        CJK9vMOr8CgmOrStOD256nKWhvLEsHXJG5cF5RM=
X-Google-Smtp-Source: AB8JxZrbDpLbpG47inwdHU8+5UiNBfcgvY/oxOqHA6lVSO+b74hKNsHdWcEQQKMZaimOggqQMSWxBIqPJB4wxc+IbWM=
X-Received: by 10.233.220.1 with SMTP id q1mr12480845qkf.361.1525206326636;
 Tue, 01 May 2018 13:25:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Tue, 1 May 2018 13:25:25 -0700 (PDT)
In-Reply-To: <20180501180908.17443-3-kcghost@gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180501180908.17443-1-kcghost@gmail.com> <20180501180908.17443-3-kcghost@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 1 May 2018 16:25:25 -0400
X-Google-Sender-Auth: s-8fQDvdPAm1_uXNHXUc4S2gyo8
Message-ID: <CAPig+cSbOsdibX588ObTG5_O=Mmp1+pbxiaUFMx-P0jFLLUuHQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: Add --dissociate option to add/update commands
To:     Casey Fitzpatrick <kcghost@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 2:09 PM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
> submodule: Add --dissociate option to add/update commands

s/Add/add/

> Add --dissociate option to add and update commands, both clone helper commands
> that already have the --reference option --dissociate pairs with.
> Add documentation.
> Add tests.
>
> Signed-off-by: Casey Fitzpatrick <kcghost@gmail.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -1075,6 +1075,9 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
> +       if (dissociate) {
> +               argv_array_push(&cp.args, "--dissociate");
> +       }

Style: drop unnecessary braces

> @@ -1208,6 +1212,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
> +               OPT_BOOL(0, "dissociate", &dissociate,
> +                          N_("use --reference only while cloning")),

s/reference/dissociate/

> @@ -1575,6 +1584,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
> +               OPT_BOOL(0, "dissociate", &suc.dissociate,
> +                          N_("use --reference only while cloning")),

s/reference/dissociate/

> diff --git a/git-submodule.sh b/git-submodule.sh
> +               --dissociate)
> +                       dissociate="--dissociate"
> @@ -258,7 +262,7 @@ or you are unsure what this means choose another name with the '--name' option."
> -               git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"$progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
> +               git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"$progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"$dissociate"} ${depth:+"$depth"} || exit

I realize that you're just following existing practice in this script,
but it's a bit off-putting to see expansions for the new --progress
and --dissociate options being done via unnecessarily complex
${foobar:+"$foobar"} when the simpler $foobar would work just as well.

Just a comment; not necessarily a request for change. (A separate
preparatory cleanup patch which simplifies the existing complex
expansion expressions would be welcome but could also be considered
outside the scope of this patch series.)

> @@ -493,6 +497,9 @@ cmd_update()
> +               --dissociate)
> +                       dissociate="--dissociate"
> +                       ;;
> @@ -550,6 +557,7 @@ cmd_update()
>                 ${reference:+"$reference"} \
> +               ${dissociate:+"$dissociate"} \
>                 ${depth:+--depth "$depth"} \
