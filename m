Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F30E1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 19:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeDRTvk (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 15:51:40 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:37142 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDRTvj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 15:51:39 -0400
Received: by mail-ua0-f175.google.com with SMTP id d3so1938316uae.4
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=S9Sl2D2Ja+AKSc4/egOqLsPRj2IGHeJAx/BU17c0pAE=;
        b=H1cCNtWsySDHI/Y9Fg8JywV+s2MXf7TgJQ8ZXXQrXMIrwbgqettG8aivjrpRjAcWnD
         Bm8E3NWGg1ye1dX61i5Ahc9jMB2yU8JX6OJrxAKMaZLlfSaTk57/brqCHPWoCwobZk5Z
         cHJsdm8nzej8TGQD26VGVQKPGELIT+Y38ssFvN8B2gpjq8R5VytS1xsLimQXo5rYnffH
         VBDryTPpjXZTFgxIY2QvwA9yIY3Tn+BwG5kbedjFa6TxIcC7vRipZM9zR81OStYChj0w
         T625OGGR5R5MxjYKkqDZ8O9egY9EQUyrY8mGzfc8nPvquKuBPAOr+nA31Kiv0M9VMZJJ
         L74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=S9Sl2D2Ja+AKSc4/egOqLsPRj2IGHeJAx/BU17c0pAE=;
        b=TBbledg5OE+rrpOYbNgx+xEufLFLNFHMHrcczyTvnQxmesYGNTdwAZrQqBCLlpaybF
         IdZN0LOGMh/MQIuWP8cwNu0gZ9z/1K6XaPgRqU2iTa0Fa9Fs8527wV8aP5nCeWdYsv2w
         Ro79MGdQGcZqH5Jlud4MvVeQMZfgQ2lkZmHOlIMb/bJsamveIahiPCXnSvW+Yh9MOqZE
         I0UIB+an2LxX783qa27vo8qqH0idpWwQDazhPglxAAMckE/shrT8YKk3RO10+gfgpaoF
         dZtWy/j3v0TTYww/D7VhiJ1tmPBo+oI2lmRG6y2gCnsAQS26emOJfiDiT7Pzmtjnz6uV
         3mrg==
X-Gm-Message-State: ALQs6tDeKdXQleQMtpln+e+na9rCWIp7KaNzI9seiK5SZJ7qWcxB1Lir
        rtW0uInaqdtb7BIUSZhTFIdZ8RWq2Fn9cUokclj6jg==
X-Google-Smtp-Source: AIpwx48q8oPOb36lgJXdRTh7kh0tJXTEfSFCdtoD2aoFfTSaY4ZGL35tJhDRoDL+K7j8yMNQeNfr1ecbFyPfAVNKha8=
X-Received: by 10.176.72.201 with SMTP id y9mr2696965uac.48.1524081098581;
 Wed, 18 Apr 2018 12:51:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Wed, 18 Apr 2018 12:51:32 -0700 (PDT)
In-Reply-To: <20180410202758.5877-2-mail@floga.de>
References: <20180410202758.5877-1-mail@floga.de> <20180410202758.5877-2-mail@floga.de>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 18 Apr 2018 21:51:32 +0200
Message-ID: <CAM0VKj=pDVxfJtUZx7c6uCmPxwQFPBOQYdd7NH=YnVG86iK0Pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] completion: load completion file for external subcommand
To:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Szeder_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 10, 2018 at 10:28 PM, Florian Gamb=C3=B6ck <mail@floga.de> wrot=
e:
> Adding external subcommands to Git is as easy as to put an executable
> file git-foo into PATH. Packaging such subcommands for a Linux
> distribution can be achieved by unpacking the executable into /usr/bin
> of the user's system. Adding system-wide completion scripts for new
> subcommands, however, can be a bit tricky.
>
> Since bash-completion started to use dynamical loading of completion
> scripts since v1.90 (preview of v2.0),

I believe the main bash-completion repository can be found at:

  https://github.com/scop/bash-completion.git

This repository still contains the branch 'dynamic-loading'; for the
record it points to 3b029892f6f9db3b7210a7f66d636be3e5ec5fa2.

Two commits on that branch are worth mentioning:

  20c05b43 (Load completions in separate files dynamically, get rid of
            have()., 2011-10-12)
  5baebf81 (Add _xfunc for loading and calling functions on demand,
            use it in apt-get, cvsps, rsync, and sshfs., 2011-10-13)

> it is no longer sufficient to
> drop a completion script of a subcommand into the standard completions
> path, /usr/share/bash-completion/completions, since this script will not
> be loaded if called as a git subcommand.
>
> For example, look at https://bugs.gentoo.org/544722. To give a short
> summary: The popular git-flow subcommand provides a completion script,
> which gets installed as /usr/share/bash-completion/completions/git-flow.
>
> If you now type into a Bash shell:
>
>     git flow <TAB>
>
> You will not get any completions, because bash-completion only loads
> completions for git and git has no idea that git-flow is defined in
> another file. You have to load this script manually or trigger the
> dynamic loader with:
>
>     git-flow <TAB> # Please notice the dash instead of whitespace
>
> This will not complete anything either, because it only defines a Bash
> function, without generating completions. But now the correct completion
> script has been loaded and the first command can use the completions.
>
> So, the goal is now to teach the git completion script to consider the
> possibility of external completion scripts for subcommands, but of
> course without breaking current workflows.
>
> I think the easiest method is to use a function that is defined by
> bash-completion v2.0+, namely __load_completion.

This is wrong, __load_completion() was introduced in cad3abfc
(__load_completion: New function, use in _completion_loader and
_xfunc, 2015-07-15), and the first release tag containg it is '2.2'
from 2016-03-03.

The release tags '1.90' and '2.0' are from 2011-11-03 and 2012-06-17,
respectively.  This leaves a couple of years long hole where
completions were already loaded dynamically but there was no
__load_completion() function.

Would it be possible to use _xfunc() instead to plug that hole?  It
seems the be tricky, because that function not only sources but also
_calls_ the completion function.

> It will take care of
> loading the correct script if present. Afterwards, the git completion
> script behaves as usual.
>
> This way we can leverage bash-completion's dynamic loading for git
> subcommands and make it easier for developers to distribute custom
> completion scripts.
>
> Signed-off-by: Florian Gamb=C3=B6ck <mail@floga.de>
> ---
>  contrib/completion/git-completion.bash | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index b09c8a236..09a820990 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3096,12 +3096,22 @@ __git_main ()
>         fi
>
>         local completion_func=3D"_git_${command//-/_}"
> +       if ! declare -f $completion_func >/dev/null 2>/dev/null &&
> +               declare -f __load_completion >/dev/null 2>/dev/null
> +       then
> +               __load_completion "git-$command"
> +       fi
>         declare -f $completion_func >/dev/null 2>/dev/null && $completion=
_func && return
>
>         local expansion=3D$(__git_aliased_command "$command")
>         if [ -n "$expansion" ]; then
>                 words[1]=3D$expansion
>                 completion_func=3D"_git_${expansion//-/_}"
> +               if ! declare -f $completion_func >/dev/null 2>/dev/null &=
&
> +                       declare -f __load_completion >/dev/null 2>/dev/nu=
ll
> +               then
> +                       __load_completion "git-$expansion"
> +               fi
>                 declare -f $completion_func >/dev/null 2>/dev/null && $co=
mpletion_func
>         fi
>  }
> --
> 2.16.1
>
