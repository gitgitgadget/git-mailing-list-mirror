Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E81ECAAD4
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 02:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345397AbiH0CTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 22:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbiH0CTd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 22:19:33 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E59ABD40
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 19:19:32 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-33dc345ad78so77364977b3.3
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 19:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3i8R4MJCdjsGW6OCyUDBBZxpHlbXIGXVhAIsAF6xVDE=;
        b=ewPVJK2kSG68zeMzWNoGBDmKR6keJcCxfRFV7L7jhu9NrN4mcr1XIDzIEZgzL4wl3E
         5MZMtDLdMtzmZ2aBAd/kEI1PvdKIfKPJmkE/fIEH84y8K7lQWF9ZxhOQnyCVWillXBss
         HsqaIajziKBIKycS4WhnXsXiBXRdsdkGgYQkq5gHt+0zsDWY50ZCalwINW6wdC9Rv098
         3Ta19VlNfiYOs5A9pGJXE1uu/wRO6o7Zpl6gyeKkIvd5iXyry4miOqD01iI5yw8THsqk
         1SvmlLXvn5rV+IFpUe+2WmbZWU1WEwGTwgXURMznDJsD/TtHpTinTSm6WZnWvQwmi2F5
         7kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3i8R4MJCdjsGW6OCyUDBBZxpHlbXIGXVhAIsAF6xVDE=;
        b=ygGYCb0gjGC7o98KdcpqgUiB/sLK2G6H2sgOo7j8lVF9xY3GbRIgIwtavascsAX05i
         8l/loETWgZHogdWeRI/b3hV61mqAuzPLRWx+O+KCaxP7UmbNo8VELWAYZZu6Uo8aHVuc
         z+nupT/B2ect5I0prlh3cIkVtUWfM4298Bh64Y/tEMdKyU+1kb/SDY3RapPlP5dV5x5X
         Fa8rWsHSMGgFikyDj0gJ7pcYJ8eiInS8A+OazZcvWt/hio232K7n4wKqIY/hGPsUNINT
         C9d3i2L+To891LsM5Q4likcEBaT6C9IkWNdxhMQLnru4BPV6dvVNmuvOUCW3nR0fhfeU
         eG7w==
X-Gm-Message-State: ACgBeo3VJMIvmt1OcfwgBKYqEEnW6rtqgzWSH02tSPcnEteFQZfXeQHV
        zqEWR7PgMXeb84n4z8dbXF00qHnVyra6Mb1l+Z/klrRRQUA=
X-Google-Smtp-Source: AA6agR53zw7YyzmIdP7jk2fMO7FTEvGqIXLKmrbTVrULTP5pq76xYX34xxOTZTwqbVgzmAdQzPp/LBCFXcdzRaMX7vU=
X-Received: by 2002:a81:e4b:0:b0:338:6762:ba3a with SMTP id
 72-20020a810e4b000000b003386762ba3amr2453211ywo.320.1661566771625; Fri, 26
 Aug 2022 19:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220827000810.2917816-1-felipe.contreras@gmail.com>
In-Reply-To: <20220827000810.2917816-1-felipe.contreras@gmail.com>
From:   Justin Donnelly <justinrdonnelly@gmail.com>
Date:   Fri, 26 Aug 2022 22:18:55 -0400
Message-ID: <CAGTqyRzZ-cOp1C4f30fGFhjH1hh5U137=77pEHp_bmBzNcmTCw@mail.gmail.com>
Subject: Re: [PATCH] completion: prompt: use generic colors
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Joakim Petersen <joak-pet@online.no>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2022 at 8:08 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> When the prompt command mode was introduced in 1bfc51ac81 (Allow
> __git_ps1 to be used in PROMPT_COMMAND, 2012-10-10) the assumption was
> that it was necessary in order to properly add colors to PS1 in bash,
> but this wasn't true.
>
> It's true that the \[ \] markers add the information needed to properly
> calculate the width of the prompt, and they have to be added directly to
> PS1, a function returning them doesn't work.
>
> But that is because bash coverts the \[ \] markers in PS1 to \001 \002,
> which is what readline ultimately needs in order to calculate the width.
>
> We don't need bash to do this conversion, we can use \001 \002
> ourselves, and then the prompt command mode is not necessary to display
> colors.
>
> This is what functions returning colors are supposed to do [1].
>
> [1] http://mywiki.wooledge.org/BashFAQ/053
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>
> FTR, it's possible zsh will implement these \001 \002 markers too, so
> there would be no need for different behavior depending on the shell.
>
>  contrib/completion/git-prompt.sh | 19 +++++++------------
>  t/t9903-bash-prompt.sh           |  8 ++++----
>  2 files changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 1435548e00..01bd807657 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -96,9 +96,7 @@
>  #
>  # If you would like a colored hint about the current dirty state, set
>  # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
> -# the colored output of "git status -sb" and are available only when
> -# using __git_ps1 for PROMPT_COMMAND or precmd in Bash,
> -# but always available in Zsh.
> +# the colored output of "git status -sb".
>  #
>  # If you would like __git_ps1 to do nothing in the case when the current
>  # directory is set up to be ignored by git, then set
> @@ -255,12 +253,12 @@ __git_ps1_colorize_gitstring ()
>                 local c_lblue='%F{blue}'
>                 local c_clear='%f'
>         else
> -               # Using \[ and \] around colors is necessary to prevent
> +               # Using \001 and \002 around colors is necessary to prevent
>                 # issues with command line editing/browsing/completion!
> -               local c_red='\[\e[31m\]'
> -               local c_green='\[\e[32m\]'
> -               local c_lblue='\[\e[1;34m\]'
> -               local c_clear='\[\e[0m\]'
> +               local c_red=$'\001\e[31m\002'
> +               local c_green=$'\001\e[32m\002'
> +               local c_lblue=$'\001\e[1;34m\002'
> +               local c_clear=$'\001\e[0m\002'
>         fi
>         local bad_color=$c_red
>         local ok_color=$c_green
> @@ -564,11 +562,8 @@ __git_ps1 ()
>                 b="\${__git_ps1_branch_name}"
>         fi
>
> -       # NO color option unless in PROMPT_COMMAND mode or it's Zsh
>         if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
> -               if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
> -                       __git_ps1_colorize_gitstring
> -               fi
> +               __git_ps1_colorize_gitstring
>         fi
>
>         local f="$h$w$i$s$u$p"
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 6a30f5719c..594042f562 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -13,10 +13,10 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
>
>  actual="$TRASH_DIRECTORY/actual"
> -c_red='\\[\\e[31m\\]'
> -c_green='\\[\\e[32m\\]'
> -c_lblue='\\[\\e[1;34m\\]'
> -c_clear='\\[\\e[0m\\]'
> +c_red='\001\e[31m\002'
> +c_green='\001\e[32m\002'
> +c_lblue='\001\e[1;34m\002'
> +c_clear='\001\e[0m\002'
>
>  test_expect_success 'setup for prompt tests' '
>         git init otherrepo &&
> --
> 2.37.2.351.g9bf691b78c.dirty
>

This appeared to work for me with a quick test. I probably don't have
any sway, but FWIW I would use it.

Justin
