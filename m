Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536051F463
	for <e@80x24.org>; Fri, 27 Sep 2019 06:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfI0GK6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 02:10:58 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44162 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfI0GK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 02:10:58 -0400
Received: by mail-ua1-f66.google.com with SMTP id n2so1567551ual.11
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 23:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMhHog0u7RAPk/OPQmfsC2pq/bf+Jh7uMf3K5bHG5eo=;
        b=MDq/kQQh+EYmwzBTxa9vsvbyiHDJzO/BNZ1/ZJiuwSSSTFNcSRYeE6R/YcanOKEUqK
         qUf0pthi+POFeFTEouACgQpPjayYTimKFEtKcthBEcX/7Cqo+mLsfO2YdijUZ+KgLTvX
         XlTbkuCRvjF0oepZe7IKgT5V5IxvWC9SASPGMJX5G/2YIjxDrammqgB+UC4Kx59u04Zo
         3vfh356hBi7tscGHINDlRbiQDjuctg1sxYkcP0HkXodEwlLYxDK1JFAO8ZlDPyqjxYWe
         Fji/DWpyE4PtT2wpgZdxf3GiqnPhLJFZwnrmk0f80yMgW7p4x7aBQ630Ww4XXQgJM8EP
         vMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMhHog0u7RAPk/OPQmfsC2pq/bf+Jh7uMf3K5bHG5eo=;
        b=AVn5mGIGfkAGbfACX+FhfLFMpmW/AYsT5yS/wL5F1TgDI1qn1N/WzDmkX8wzIM6V9m
         s5GXiUD1R4b+oeLWco5jZwHCxAmpUDRHwEI3A43bOF+Pmbu2XvGrNj4lOw6FBzuu5WM2
         IttDJDadmjjunwlUDP0DfhygV9PybiAR06ChyH39VJIabYTUiVk9LAX26c+22j104WOM
         s20HQuqBqXoPe9PKPCwah4kpu1Pg4mMI2S+Zwm8wl48NPGqAa94X2xnc6Vjpk92guXJl
         oT9VjK91LSZBVyvPCFV+iBVkhrN+7csPKjZF6Koa9Wx6Nr00bCE+b5YboC+AQzK5Xq5d
         IEwQ==
X-Gm-Message-State: APjAAAXY+lig8ko/nVpDeaE+KeK+HHnKH+JAskgZXLoaUG6vLtsNacMf
        lazIupITaMQPrz4CNpMQk5zRBHS5QCZUS2dNow4=
X-Google-Smtp-Source: APXvYqwoGKcTujHpOZwFWVZG/car0qC6TQeEIqgqspMj75NfW1qFknz0k5Sv6fHITSVJ6dpW1cgxBriKjaBNX+gR+Vs=
X-Received: by 2002:ab0:30d4:: with SMTP id c20mr3300173uam.136.1569564657524;
 Thu, 26 Sep 2019 23:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.361.git.gitgitgadget@gmail.com> <eca193f91b85fc4ffea453bc3adb64bc5c8831a8.1569532628.git.gitgitgadget@gmail.com>
 <20190926223638.6tk2qhc4e62hs2wt@yadavpratyush.com>
In-Reply-To: <20190926223638.6tk2qhc4e62hs2wt@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 27 Sep 2019 08:10:45 +0200
Message-ID: <CAKPyHN1P713bTb2TYXFuXcM5Dg=7vXBVgchwvJUrNsQ6EcP5Rg@mail.gmail.com>
Subject: Re: [PATCH 1/1] respect core.hooksPath, falling back to .git/hooks
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 27, 2019 at 12:40 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi,
>
> On 26/09/19 02:17PM, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >
> > Since v2.9.0, Git knows about the config variable core.hookspath
> > that allows overriding the path to the directory containing the
> > Git hooks.
> >
> > Since v2.10.0, the `--git-path` option respects that config
> > variable, too, so we may just as well use that command.
> >
> > For Git versions older than v2.5.0 (which was the first version to
> > support the `--git-path` option for the `rev-parse` command), we
> > simply fall back to the previous code.
> >
> > This fixes https://github.com/git-for-windows/git/issues/1755
> >
> > Initial-patch-by: Philipp Gortan <philipp@gortan.org>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  git-gui.sh | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/git-gui.sh b/git-gui.sh
> > index fd476b6999..b2c6e7a1db 100755
> > --- a/git-gui.sh
> > +++ b/git-gui.sh
> > @@ -623,7 +623,11 @@ proc git_write {args} {
> >  }
> >
> >  proc githook_read {hook_name args} {
> > -     set pchook [gitdir hooks $hook_name]
> > +     if {[package vcompare $::_git_version 2.5.0] >= 0} {
> > +             set pchook [git rev-parse --git-path "hooks/$hook_name"]
> > +     } else {
> > +             set pchook [gitdir hooks $hook_name]
> > +     }
>
> gitdir is used in a lot of places, and I think all those would also
> benefit from using --git-path. So I think it is a better idea to move
> this to the procedure gitdir. It would have to be refactored to take any
> number of arguments, instead of the two it takes here.

gitdir already takes an arbitrary number of arguments and joins them
to a path. The more imminent challenge is, that gitdir caches the
GIT_DIR, thus it tries to avoid calling "git rev-parse". Which works
for most, but not for hooks.

We could either maintain a blacklist, for what we cache the result
too, or always call "git rev-parse --git-dir".

This blacklist would need to be in sync with the one in Git's
path.c::adjust_git_path() than.

Bert

>
> Other than that, looks good. Thanks.
>
> --
> Regards,
> Pratyush Yadav
