Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58811F404
	for <e@80x24.org>; Fri, 10 Aug 2018 17:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeHJTd5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:33:57 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:55431 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeHJTd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:33:56 -0400
Received: by mail-it0-f52.google.com with SMTP id d10-v6so3503713itj.5
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oba2nLlPV+1gsUkxCkRfvWp94R3pLfbD585Spu2tjnw=;
        b=jj1RtdGG4OWQV+HLRYm7xQukJnVxA2Bbvr/f+BysQIaA72eDepGQGEvhkE3XAiPwr4
         Cluuwcoyi8L5B46D8dhry+jSQwbKMom0u3FaU3MxR9TAv7gAAAivMqQa3MKfdOwxvagI
         DFwUE3ERwllNwDm4f5l0oQQgvP2YRIseceTs1gdSW/KGn+n5zlaqNrCP8Aop8YYNbpUO
         SAZ0otge6jjwCVdqfELLFTMefuHjTbk5QOJmXljnaW1H7v+3n0ja3cjGeVfM0nZvo75V
         zcd2IO0IMcLRxZ5PfGlBu9mR2pnskQJjANuOAaktZauqTeV0xEIhX/QhWiSpVdBoI553
         rQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oba2nLlPV+1gsUkxCkRfvWp94R3pLfbD585Spu2tjnw=;
        b=JFMjpPM3/ssB3NYHANgs1qVqeewiXO8bnjbj1XsSozxTxfvA8DEOqCmaKdMHqxZ1MA
         iHZJBG9TrQxRiV6A4zMQsBNym+fE6HmlE5hXD5fdoqnQ1Lql0VSQHHMGfRWmPkHSIZCY
         JeAFK5uZO3h7PG9/pCqmLItScmNSoeIxZeQLX4e8FOGFJTKasiqym+3FHreTiRmkF/JU
         10LBhOMyYh9NGCC4BctAcYBtZwpYUtVhgIvng7N++VluYSuvloyoXZ4HR4vuUIWPDKpj
         om0QrOH540nnpA1D596dVejXz8SrW+RZLwONTUQHNSCsKM6i0uD4C1jM+lgVSYTFk6Z5
         kdNw==
X-Gm-Message-State: AOUpUlFEyecMKV8Fw5dkIONg/FKtUUX5XvRWMx203OZ8doBFywm4L9Ey
        bf9GGe8yNt5q8KWtQCq/xFlIjtvOHH2AGSByxCI=
X-Google-Smtp-Source: AA+uWPyl2+4Mnr1YiEx2gGVGZZVULZ5Zxt+Xf0hDo8ezdiH1DejamQhhNTIFExyPAybwx/Qzhg0IoT9CNzfsukFGQmg=
X-Received: by 2002:a24:33c1:: with SMTP id k184-v6mr2933731itk.76.1533920594946;
 Fri, 10 Aug 2018 10:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPFHKzepqebXX7mrbeoc=+SHzWZ5N+6eOaLiC26tVGKogZoLGg@mail.gmail.com>
 <20180810030624.GA101965@aiede.svl.corp.google.com>
In-Reply-To: <20180810030624.GA101965@aiede.svl.corp.google.com>
From:   Jonathon Reinhart <jonathon.reinhart@gmail.com>
Date:   Fri, 10 Aug 2018 13:02:47 -0400
Message-ID: <CAPFHKze39tDyVVMg=op9RKty7OgWnscww7JvXAByNU7JxJJfLQ@mail.gmail.com>
Subject: Re: 'git submodule update' ignores [http] config
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jonathan.

The confirmation that the super-project config does not apply to the
submodules is what I was really looking for. We'll go from here.

This is a bit complicated, because this config is all generated
dynamically by the GitLab CI Runner when it is setting up a build job.
(See the linked issue in my first email for the gory details).

Thank you,
Jonathon
>
> +cc: Stefan, who has been looking at fetch --recurse-submodules recently
> Hi,
>
> Jonathon Reinhart wrote:
>
> > I've narrowed it down to an observation that the [http] config seems
> > to be ignored by 'git submodule update'. Shouldn't those options be
> > respected by submodules?
> >
> > Given a .git/config file like this:
> >
> > ------------------------------------------------------------------------
> > [fetch]
> >     recurseSubmodules = false
> > [http "https://gitlab.exmaple.com"]
> >     sslCAInfo = C:\\Users\\gitlab-runner\\builds\\deadbeef\\0\\somegroup\\someproj.git\\CA_SERVER_TLS_CA_FILE
> [...]
> > C:\Users\jreinhart\testrepo>set GIT_CURL_VERBOSE=1
> > C:\Users\jreinhart\testrepo>git fetch
> [...]
> > *   CAfile: C:\Users\gitlab-runner\builds\deadbeef\0\somegroup\someproj.git\CA_SERVER_TLS_CA_FILE
> [...]
> > C:\Users\jreinhart\testrepo>git checkout master
> > C:\Users\jreinhart\testrepo>git submodule update --init
> [...]
> > *   CAfile: C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
> [...]
> > Note that the CAfile reverted to its default instead of using the same
> > one from the `git fetch`.
>
> Interesting.
>
> The context is that "git submodule update" is simply running commands
> like "git fetch" inside the submodules, and the repository-local
> config of the superproject does not apply there.
>
> In the long run, commands like "git fetch --recurse-submodules" may
> chaange to use a single process.  It's possible that some of the
> repository-local configuration of the superproject would apply at that
> point, though the inconsistency would be confusing, so probably not
> these particular settings.  Anyway, that's a faraway future; today,
> "git fetch --recurse-submodules" is also running "git fetch" commands
> inside the submodules, and the repository-local config of the
> superproject does not apply there.
>
> Would it work for you to put this configuration in the global config
> file ("git config --global --edit")?  That way, it would be used by
> all repositories.  If you want it only to apply within the testrepo
> directory, you can use conditional includes --- something like:
>
>   in $HOME/.git/config/testrepo-ca:
>
>   [http "https://gitlab.example.com"]
>         sslCAInfo = ...
>
>   in $HOME/.git/config/git:
>
>   [includeIf "gitdir/i:~/testrepo/**"]
>         path = testrepo-ca
>
> Thanks and hope that helps,
> Jonathan
