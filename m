Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B93021F404
	for <e@80x24.org>; Wed, 14 Feb 2018 15:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031501AbeBNPfa (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 10:35:30 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:38266 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031287AbeBNPf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 10:35:29 -0500
Received: by mail-vk0-f48.google.com with SMTP id z9so13097858vkd.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HGQZVVJ2zm8AE3NHkT2wjy4CfEzEmVT5/9E07H3ucS8=;
        b=oD+/Fe0vg0HZ7uiOV+N51J06wAr0Z+AutL7do4FNbvdCsG5UqDcfNfHLpBwaqUKQYx
         HjmtuNjrDlLSg6fU4j/uyByh8IWv/9Ek6LH6WUn70TOnHbq2T4KWf5UlY/Dw3ZFNnL0Q
         2KJPP3OvuhPJlihdJ4XftXHjY32FFChf1Heax3KG0EoBQvQiwpWu/yFNdRmNbdD7CUGV
         CU7RxkTev/Oq8kSk87fWrrYRh4MlMkCWmc42DkVHS0opFB4Ejcfc85Ukh8CPmroX7cyi
         HAwDnfUUnVJyuz28GmF0EVY/Lk7QwUgrL3MbZPeZGHYQ3DfcoEBzuzFEcmHuMwLTsyoz
         4guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HGQZVVJ2zm8AE3NHkT2wjy4CfEzEmVT5/9E07H3ucS8=;
        b=Cewe9AHUke8pmoQcCw0QOqhF2hZX4BAU08D8wnISFIYKUThs4B94lSMeULtZTJuMZS
         wPRXYKOH5GY2i/fV8LMa1PP9q0i6E6655TUUjNCNBxJb0ETvU56Gm+rcX4M2x9KK+mgo
         yZmzl786ea8qgk5QY21IPqrM7XlRuALhUJEgDgxlDGMYIhNfC/SRDMIgofH/vkN6hkQv
         BoF08IHdwWcMuIf6XgrwZUNWloVW/3Z2OUs50f0cnwjPqtJsYd7VJ87KrHcOJnkev0X9
         Dfrtryn/KoFWyqw84Vk46WL0Tmn7FUIIwkxzQCrWxaUUdxAEqXvPHri113GIhw5hvWsC
         WOpA==
X-Gm-Message-State: APf1xPAjzCsijnkI5wYRXrQeQJ8sm3cRxMyH83ht0i28MwxfllChrSx7
        DFfnS7Hy4L29bVqDAxOjwR7xuL+fz7jgygZ6y2I=
X-Google-Smtp-Source: AH8x2278vDZXH5AMC5mEL+XCD7GbZRtdxTznXYmIKIELrB5NfK3Mpm63jULgUSUwefIEWKWySLQhcfRotVI3rfql7P4=
X-Received: by 10.31.161.20 with SMTP id k20mr5019713vke.82.1518622528620;
 Wed, 14 Feb 2018 07:35:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Wed, 14 Feb 2018 07:35:28 -0800 (PST)
In-Reply-To: <20180209110221.27224-5-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180209110221.27224-1-pclouds@gmail.com>
 <20180209110221.27224-5-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 14 Feb 2018 16:35:28 +0100
Message-ID: <CAM0VKjk17VgGAHr8jJXft4twij61KPLUDYSeHm6TXttksynd8Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/42] git-completion.bash: introduce __gitcomp_builtin
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

Thanks for working on this.  I anticipated that the completion script
lack some options, but wow, I didn't expect that there are so many
missing.

On Fri, Feb 9, 2018 at 12:01 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This is a __gitcomp wrapper that will execute
>
>     git ... --git-completion-helper
>
> to get the list of completable options. The call will be made only
> once and cached to avoid performance issues, especially on Windows.

Nit: the call will be made every time; 'git ... --git-completion-helper'
will be executed only once.

> __gitcomp_builtin() allows callers to change its output a bit by adding
> some more options, or removing some.
>
> - Current --git-completion-helper for example does not output --no-foo
>   form, this has to be added manually by __gitcomp_builtin() callers
>   when necessary
>
> - Some options from --git-completion-helper should only be available in
>   certain conditions (e.g. --continue and friends). __gitcomp_builtin()
>   callers can remove them if the conditions are not met.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  contrib/completion/git-completion.bash | 33 ++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 3683c772c5..85e7f26328 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -280,6 +280,39 @@ __gitcomp ()
>         esac
>  }
>
> +# This function is equivalent to
> +#
> +#    __gitcomp "$(git xxx --git-completion-helper) ..."
> +#
> +# except that the output is cached. Accept 1-3 arguments:
> +# 1: the git command to execute, this is also the cache key
> +# 2: extra options to be added on top (e.g. negative forms)
> +# 3: options to be excluded
> +__gitcomp_builtin ()

Please excuse the bikeshed at v3, but I don't like the name of this
function.  It indicates that it completes builtins, but it completes
options of builtins, and even then only the options of those using parse
options.  Furthermore, the '__gitcomp' prefix is usually used for
functions that merely put words into COMPREPLY, but this function does a
whole lot more (getting the options from builtins, include and exclude
options, caching).

Alas I don't have any great name; __git_complete_options is better,
because it uses the right function name prefix, but only slightly
better, because it can't generally be used to complete options, as it
won't work with scripts or with builtins not using parse options (though
with time more scripts will be turned into builtins and more builtins
will use parse options).  I'm not sure it's that match better to make it
worth changing fourty-odd patches.

> +{
> +       # spaces must be replaced with underscore for multi-word
> +       # commands, e.g. "git remote add" becomes remote_add.
> +       local cmd=3D"$1"

The alternative would be 'command subcommand', i.e. keeping that space,
and in that case we could spare the ${cmd/_/ } in this function, and
could even say '__gitcomp "$(git $1 --git-completion-helper)" in the
equivalent example above; OTOH we would need quoting on all callsites
with subcommands.  Again, I'm not sure it's worth it.

> +       local incl=3D"$2"
> +       local excl=3D"$3"
> +
> +       local var=3D__gitcomp_builtin_"${cmd/-/_}"
> +       local options
> +       eval "options=3D\$$var"
> +
> +       if [ -z "$options" ]; then
> +               # leading and trailing spaces are significant to make
> +               # option removal work correctly.
> +               options=3D" $(__git ${cmd/_/ } --git-completion-helper) $=
incl "
> +               for i in $excl; do
> +                       options=3D"${options/ $i / }"
> +               done
> +               eval "$var=3D\"$options\""
> +       fi
> +
> +       __gitcomp "$options"
> +}
> +
>  # Variation of __gitcomp_nl () that appends to the existing list of
>  # completion candidates, COMPREPLY.
>  __gitcomp_nl_append ()
> --
> 2.16.1.207.gedba492059
>
