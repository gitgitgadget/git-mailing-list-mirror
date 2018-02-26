Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6461F404
	for <e@80x24.org>; Mon, 26 Feb 2018 20:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753729AbeBZUbA (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 15:31:00 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:42525 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbeBZUa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 15:30:58 -0500
Received: by mail-yw0-f179.google.com with SMTP id u84so1553657ywg.9
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 12:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JZxfTVVEx8gwQEwbEHS6/3Kprfg+gELypReL2DqJ6a8=;
        b=ayGfUOWXRrePMGe+/GzX/PSnItY4lipirXACbbjsvIZeLuvpVNzR3lWGHNQZUwUrtv
         Zj65jwpp0ycQCG3RCTRkghGUO96NFFd86LI0uD+pBds6NPy5w/pPSdsU/7mBczRcHQQQ
         479aRRrArvahCrdutCiBk0GsNOl1WebhOX5JDlklftboaXRGAa5QY/5pWsPweWVIZC4F
         nTmLsn9gqX6gOCaZJW1wwlfzF08MfSnJqB4QRSpNywTeTvzvwQXm1WD3A/Ywu3OvxgCY
         g68lb8gccxUe9+LzR9JaJ9XNzsqH9TR29RRBBIV3zWVnG91D0xGRpsvawWKEjCDalVd7
         zflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JZxfTVVEx8gwQEwbEHS6/3Kprfg+gELypReL2DqJ6a8=;
        b=RAKNUvIEI4Co//B3JpgNyF2aMjksRoAK5nL6QVRcwArl3lcparbiATAFPv5UUtJFDf
         UY4kj7nuaTQhdpVzyXUTlskpx8uJScCmcCvUOWMLU7T2+2qa/YJhDxCYODaSdIwTFqrj
         mTxr7OhaTm48ASPr2eeOvwuwgf/9RvSYPOWm4giL+2jHfnSLTqvlf/CdTsKfEeQSgWrK
         XgR7jjwk+WmaYAeoSpNUW0keWJGIPKmqJmaBkszDn799klnlYdqw9N72KCIFkiCkbiqf
         f5/CGPkQXAt2c7nISgDgNc5QHCBLiysYRuisV81HhpwdrD0w0E539zMgZ6ZfRRkMEsYu
         fpfw==
X-Gm-Message-State: APf1xPAFNNM78g80gLrdFUROkwr19bHQhQuaXhCgnwdilyeOaL8q58Uy
        bejfp76Zc8p5l742Zt/0I9+p5/J7bxgSfAPEoSTxjw==
X-Google-Smtp-Source: AH8x226QJEyOMpU1bBfzLPLuUo9BxR17ViN81o8lY8BLcKQ9XGZJwV08NxkWAmOCRJLXePUKYBL1CN595j7eTlsy+0w=
X-Received: by 10.13.237.70 with SMTP id w67mr7760869ywe.414.1519677057750;
 Mon, 26 Feb 2018 12:30:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Mon, 26 Feb 2018 12:30:57
 -0800 (PST)
In-Reply-To: <20180226103030.26900-2-pclouds@gmail.com>
References: <20180214180814.GA139458@google.com> <20180226103030.26900-1-pclouds@gmail.com>
 <20180226103030.26900-2-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Feb 2018 12:30:57 -0800
Message-ID: <CAGZ79kZHw3qr+-0QeE3j0nSjMkob8-QOCcbHRfoZGbapQsURaw@mail.gmail.com>
Subject: Re: [PATCH 1/4] repository.c: move env-related setup code back to environment.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/setup.c b/setup.c
> index c5d55dcee4..6fac1bb58a 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1116,8 +1116,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                         const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
>                         if (!gitdir)
>                                 gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
> -                       repo_set_gitdir(the_repository, gitdir);
> -                       setup_git_env();
> +                       setup_git_env(gitdir);
>                 }

What makes git_dir special, such that we have to pass it in here?
Could the check for getenv(GIT_DIR_ENVIRONMENT) and fallback to
DEFAULT_... be part of setup_git_env() ?
Oh I guess that cannot be done easily as the submodule code
spcifically doesn't want to discover the git dir itself.


>                 if (startup_info->have_repository)
>                         repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
> --
> 2.16.1.435.g8f24da2e1a
>
