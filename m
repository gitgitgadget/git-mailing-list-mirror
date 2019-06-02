Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B2C51F462
	for <e@80x24.org>; Sun,  2 Jun 2019 11:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFBLWp (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 07:22:45 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36923 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfFBLWp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 07:22:45 -0400
Received: by mail-wr1-f51.google.com with SMTP id h1so9391234wro.4
        for <git@vger.kernel.org>; Sun, 02 Jun 2019 04:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8lxFn6tmt0MsJbKNdJIy1ToYq0wicGCh8t8Mbt0RdrI=;
        b=Po5Go15RVUmdf0ZW+t9Cxw6/5hgwAiDv4StSS1uMWVKrrvRiq0xgweJf+h3beOM/aB
         paJrtgOFCke3HLYpxF6yGmRvoP7Oni2dye0vAt6wvK1Q8FxUvu/HELASfVNgsBgbAHyt
         RngzlaxSRZE/0/b6/LAlco+3H1d1vvPDrehPqZ4+ONiWA60Vxt9fVDkL19hVzWy3xeBO
         gqVynZHJHqW0UvCgA9VJluAhK665/3JIR841E0YjTRpfzkyCleh4HByL383TkXO2f6rQ
         h5hLW4Nt+iuSTfp9sac8JbhaeK5QwcSdmROju+nMjiXITtNOssOndHbnX9zqSRuz13/r
         C8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8lxFn6tmt0MsJbKNdJIy1ToYq0wicGCh8t8Mbt0RdrI=;
        b=LJ6pwqKhcNboRg35oq4LDvEcsdiKaUPCsr6oPtgLJpMtoolHoJJRinw3bi1fhbqWYi
         2OKAV1OnkSmmFCZe8aHu6CoXpkClSRwHYO5pWTdymuAtOVYKZs47inddwcrVH/M6lEcs
         N84EYXi/eOHaUsI/CyAozAesDg+d0q+01GxcKqj6Cos1EQY5hZCKLfmE0OtdCOhEmIDJ
         69OlCezlR8tPshGlkzYWbbkQhYKzit9+e1UHFouZ8SqGyIhFWQwcND8MUPnLor6fM3rg
         q6fKj8peXdAGHapEBP7Zp0l98vICDpVnlzGQhi6NPre66i7m408V387LAQmQbz6xdOpZ
         Ludw==
X-Gm-Message-State: APjAAAVtzyJWjih2jpovFyFLfK9YV887sfq/RpZBlgHflikY95bg24Jl
        N20bLN2Reub6P+hpXAshPwE=
X-Google-Smtp-Source: APXvYqyA7WV57wwUssE2b2UIuNRT/7scTcFEm+HBc6BxOedxNxk8PAYpkTOULm+/AFZO5WNtB7UfDw==
X-Received: by 2002:adf:dd91:: with SMTP id x17mr441534wrl.291.1559474562752;
        Sun, 02 Jun 2019 04:22:42 -0700 (PDT)
Received: from szeder.dev (x4db46cf5.dyn.telefonica.de. [77.180.108.245])
        by smtp.gmail.com with ESMTPSA id y132sm19591351wmd.35.2019.06.02.04.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 04:22:41 -0700 (PDT)
Date:   Sun, 2 Jun 2019 13:22:39 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Travis not looking so good
Message-ID: <20190602112239.GO951@szeder.dev>
References: <nycvar.QRO.7.76.6.1905302125190.44@tvgsbejvaqbjf.bet>
 <20190601004143.GN8616@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190601004143.GN8616@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 01, 2019 at 12:41:43AM +0000, brian m. carlson wrote:
> On 2019-05-30 at 19:32:41, Johannes Schindelin wrote:
> > Hi Gábor,
> > 
> > do you have any idea why Travis is failing like this in the macOS/gcc
> > job?
> > 
> > > +case "$jobname" in
> > > +brew link gcc@8
> > > Error: No such keg: /usr/local/Cellar/gcc@8
> > > The command "ci/install-dependencies.sh" failed and exited with 1 during .
> > 
> > I usually only look at the Azure Pipelines (which gives me plenty enough
> > to do, what with pu's individual branches being tested individually), but
> > couldn't fail to notice that *all* four branches (maint, master, next and
> > pu) fail in Travis' macOS/gcc job (and only there, the Azure Pipelines are
> > all green):
> > 
> > https://github.com/git/git/branches/all
> > 
> > What's going on?

The usual: Homebrew desperately tries to be overly clever and helpful,
but ends up being dumb and annoying. :)

I was hoping that this issue will just solve itself, like several
other brew breakages in the past, but apparently it won't...


> I'm certainly not an expert on macOS, so I could be getting things wrong
> here, but it looks like we don't ever explicitly install the gcc@8
> package from Homebrew. It may have happened to be installed
> automatically by Travis in the past, but they may have upgraded now that
> GCC 9 has been released.

gcc@8 is still installed in the Travis CI macOS image we use, but it
is version 8.2.  It's still perfectly usable, but:

When installing dependencies on macOS, we first explicitly run 'brew
update', which spends over two minutes to update itself and
information about the available packages.  This way it learns about
GCC 8.3, and after that gcc@8 refers to v8.3, and, unfortunately,
'brew' is just too dumb to be able to do anything with the still
installed 8.2 package, and the subsequent 'brew link gcc@8' fails.
But hey, even 'brew uninstall gcc@8' fails with the same error after
that, which is simply unacceptable from a package manager in my book.


> I suspect if we want to use GCC 8, we need to explicitly install it by
> using "brew install gcc@8", or we can just pick the latest released GCC
> by using "brew install gcc" if we like that better. We will still need
> to do "brew link gcc" (or "gcc@8"), since I suspect Homebrew won't
> auto-link it since macOS provides a gcc binary.

Yeah, installing gcc@8 or gcc works.  Back in 2c8921db2b (travis-ci:
build with the right compiler, 2019-01-17) I opted for simply linking
the already installed gcc@8 package, because GCC is big, installing it
takes time, and the macOS build jobs have always been prone to
exceeding the time limit.  (Note that these packages provide 'gcc-8'
and 'gcc-9' binaries, not 'gcc', and after 'brew install'-ing them we
won't need an additional link step (I'm not sure why linking is
necessary with the gcc@8 package already installed in the Travis CI
image).)

Another possibilities are:

  - Running 'brew link gcc@8' before 'brew update' works:

      https://travis-ci.org/szeder/git/jobs/540027012#L139

  - Not running 'brew update' at all works as well:
  
      https://travis-ci.org/szeder/git/jobs/514960153#L179
  
    However, it's not as simple as removing the 'brew update' command
    from our ci script, because 'brew' is so very helpful that it
    implicitly runs update for us on the next 'brew install' anyway...
    we have to 'export HOMEBREW_NO_AUTO_UPDATE=1' first to disable
    that.

    As an additional benefit, disabling 'brew update' shaves off over
    2mins from the ~4mins currently spent on installing dependencies
    [1].

    I've been running my somewhat customized builds on Travis CI [2]
    without 'brew update' for about a month now, no ill effects yet.
    Initially I was worried that without 'brew update' a subsequent
    'brew install <pkg>' might fail, if the package repositories
    contain only a newer version of 'pkg'.  I haven't seen any such
    issues yet, and my builds can still 'brew install' Git-LFS 2.5.2
    and Perforce 18.1, although their current versions are 2.7.2 and
    19.1, respectively.


[1] And disabling the recently introduced auto cleanup feature saves
    some more time, and installing all dependencies in the macOS
    builds can be done in ~20-30secs:

      https://travis-ci.org/szeder/git/jobs/514960153#L92

[2] https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/branches
