Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A1F81F453
	for <e@80x24.org>; Wed, 13 Feb 2019 18:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfBMS42 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 13:56:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33657 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405269AbfBMSjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 13:39:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id h22so2526679wmb.0
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 10:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=djcrwep60lUB0gubu0Rf9I9f3qrhuiDCs0KebohQ0eQ=;
        b=abE67ReLMJz/5v/e/bLklRfCEmTV6vmkRWmBqnUsLXW3wE5ZxX76R/NagwFkrHIvL4
         lyuzsktOFCNb2cBun5VDXFdTL7bjEmVj66YfXa6Qz0aaGkbTnRpJRGw2Dx9CMzZIPxUf
         GKQvggJhTAdIH0SqVEYxgKkhg/lMr05gPNcpUHqyl0plao3Kiqi4QDo2xMwOBekCiH4g
         tet4zWqRnkZxrirHIGrHx647EQnTpow9MumAQpvYxwjs4PQfBL4T+D2ca9qQ0rHOLDwT
         lI6kEvh27n2tozg0ECrgh4VQDN6BqDKX3MqDKkDarcb6Mu4lXI1DX5Y30ZwKqCSQ7eLS
         Ek0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=djcrwep60lUB0gubu0Rf9I9f3qrhuiDCs0KebohQ0eQ=;
        b=r8AKhabDI19DB8kQd6fh7M6XITHzGHwJWyU9e4y1vwsa7DrTRJrVJXFKKMdNDzznnH
         x0EPDPAYbgat9iFJnYM3gnylyOnhT/m381e8NEBc2/LiA+W/00yHSWwPGLgGAcDM9why
         TYKWlHzp0EdUkmGGpwgwQMHcwyd/EhE7WuVhzzCt/CNd6GcWw+c0hffKQcDDIu3x1URG
         AKeF0kQhhSC704BoEbQr4fQr4ndoLY+1DaA58AJntFfrrJyYKPyknEaOmhynlCz2sAxd
         Wnd2yIvYLXQCBg6yt/GRz1uIMkxoqGu6CQamFkcGXnoe3vzOERD+zeRB76rj38dTWniA
         GsqQ==
X-Gm-Message-State: AHQUAub/yhMOzeGGIJ37+nXskwgcgzSXFsB+RLjMHZ96oMVwlj5CvG2V
        9zs+nExc93VAcwisfmhLc1U=
X-Google-Smtp-Source: AHgI3Ib0d0EhBwSwgSkT6iP8ngpAw4QyD4gLDnd/wDgKId5gA+J+bFXpzxsKRwdOvQlyPFb8HVNPQw==
X-Received: by 2002:a1c:e086:: with SMTP id x128mr1493617wmg.10.1550083189875;
        Wed, 13 Feb 2019 10:39:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a4sm8007wmm.22.2019.02.13.10.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 10:39:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2 3/3] submodule: document default behavior
References: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
        <cover.1549965172.git.liu.denton@gmail.com>
        <d8785cdd01503f2a7b9a6fbc19105c41a9a04046.1549965172.git.liu.denton@gmail.com>
Date:   Wed, 13 Feb 2019 10:39:48 -0800
In-Reply-To: <d8785cdd01503f2a7b9a6fbc19105c41a9a04046.1549965172.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 12 Feb 2019 01:56:13 -0800")
Message-ID: <xmqqzhqzbki3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This patch documents the default behavior of submodule if no subcommands
> are given, similar to how remote documents it in both git-remote.txt and
> in its usage output.

Let's stop saying "This patch does this, this patch does that".

Instead (1) state what you think is wrong with the status quo in the
present tense, (2) describe what the right approach to make it
better is and why, and (3) order the codebase to "be like so" to
make that happen.  Often (1) or (2) can be omitted when they are
obvious from (3), but be mindful to others---the "obviousness" you
may feel may come from your staring the problem longer and thinking
about it deeper than the readers of your patch.  When in doubt, err
on the side of over-clarity.

    The SYNOPSIS section for 'git submodule' does not say what the
    command does when given no subcommand.  Document it.

does (1)+(3), which I think is sufficient.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/git-submodule.txt | 4 ++++
>  git-submodule.sh                | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 65a952fb96..2fdf9f4cf3 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -9,6 +9,7 @@ git-submodule - Initialize, update or inspect submodules
>  SYNOPSIS
>  --------
>  [verse]
> +'git submodule' [--quiet] [--cached]
>  'git submodule' [--quiet] 'add' [<options>] [--] <repository> [<path>]
>  'git submodule' [--quiet] 'status' [--cached] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] 'init' [--] [<path>...]
> @@ -28,6 +29,9 @@ For more information about submodules, see linkgit:gitsubmodules[7].
>  
>  COMMANDS
>  --------
> +With no arguments, the default command is 'status'.  Several subcommands are
> +available to perform operations on the submodules.

I am not sure if "default is status" is really true.

   $ git submodule status --recursive
   $ git submodule --recursive
   usage: git submodule [--quiet] ...
      or: ...
   $ git submodule -- sha1collisiondetection
   usage: git submodule [--quiet] ...
      or: ...

If 'status' were truly the default, wouldn't the form without any
subcommand take any option and parameter the 'status' subcommand
would accept? 

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 5e608f8bad..1ccc758e79 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -5,7 +5,8 @@
>  # Copyright (c) 2007 Lars Hjemli
>  
>  dashless=$(basename "$0" | sed -e 's/-/ /')
> -USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
> +USAGE="[--quiet] [--cached]
> +   or: $dashless [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
>     or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
>     or: $dashless [--quiet] init [--] [<path>...]
>     or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
