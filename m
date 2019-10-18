Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F471F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 10:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407532AbfJRKvt (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 06:51:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38993 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407453AbfJRKvt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 06:51:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so5618540wml.4
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3oL6c3iBo80NF+W9jloDq0h4MV+/d8c/QVShPLNvpuw=;
        b=l7dPE/MLyHI0jw5ygrJD2v7TuQDUbD9HyU524KIXTBknOcsxOdfizgN67B4m/8ZaAE
         MtjAPNIsLEJ9SXnjr4FGg5GUoaIK28jDjkrpo+b4gAePeyFHE8bRtS3c4mFBvD5YbUJx
         +BIHEwi2aHpvZjh53me4t+Ru1WC/jORbKrO2taw0IJfGgSdGaYVUGzq2+w2U/r8UlIuT
         98JIFGHKeDegZC/peYVxsazqRRzmQw8xk2HeE9hKCvtzNu4o/X3ZRLFR+GoYgtnamWWU
         vTDSzZGuP9WQDm5AiBor/yU8Vj++PcvWYMPT4AA48koCYawryv3vIbmOnqYREtc97iyc
         HM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3oL6c3iBo80NF+W9jloDq0h4MV+/d8c/QVShPLNvpuw=;
        b=hAezV0H3vONfICeKjjOvQ/0jg23zrMgNPLTjU9TwN6YBv8QVwO2SM8GMu5EeT9lVAg
         TNmwVih27yJlQ+xAuMaC172e1ohUGXTUhsIhAJgN1VQKacTm0vvTpitx6GckQZLE/d/0
         HC65l29i0eCgGg5aWoHCfW/VJSUkuHHw0NrmcSmpsJiLLgUmw5iroa3MqP7AVJUtvyD7
         Hk+f71PIvamLaEKYHW7o59OpzApKmQ1jRzZbberjb/kkwffVOtGc9Bddql0LcHsUvrdN
         hC1sdJszbQ5m4ixpZRICazyspFKSj4HH91a44s+vyndDuNCm4Lcn1R9ubYpas/JXgfo5
         jsEw==
X-Gm-Message-State: APjAAAUsSuNBmdP4/YpNwENxdMu/sTG7kpWL+/n/WpovSdDLj3Nt4fhL
        EJ9qwYDv5+LYy5DNvx803ZI=
X-Google-Smtp-Source: APXvYqzwe/SCKKgoeHmvTrlDMt0l9gO6qrIhkRe4B02yWiLOnXRZhpBno2WuP88M3CzjQOF9lrQzHQ==
X-Received: by 2002:a1c:2407:: with SMTP id k7mr6615839wmk.99.1571395906505;
        Fri, 18 Oct 2019 03:51:46 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id p85sm5293611wme.23.2019.10.18.03.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 03:51:45 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:51:43 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] ci(osx): use new location of the `perforce` cask
Message-ID: <20191018105143.GY29845@szeder.dev>
References: <pull.400.git.1571160721.gitgitgadget@gmail.com>
 <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
 <372ab24acffbc956407cd93ed34135f83156e10d.1571316454.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <372ab24acffbc956407cd93ed34135f83156e10d.1571316454.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 12:47:33PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The CI builds are failing for Mac OS X due to a change in the

s/CI/Azure Pipelines/

Our Travis CI builds are fine.

> location of the perforce cask. The command outputs the following
> error:
> 
>     + brew install caskroom/cask/perforce
>     Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.
> 
> So let's try to call `brew cask install perforce` first (which is what
> that error message suggests, in a most round-about way).
> 
> The "caskroom" way was added in 672f51cb (travis-ci:
> fix Perforce install on macOS, 2017-01-22) and the justification
> is that the call "brew cask install perforce" can fail due to a checksum
> mismatch: the recipe simply downloads the official Perforce distro, and
> whenever that is updated, the recipe needs to be updated, too.

This paragraph is wrong, it mixes up things too much.

Prior to 672f51cb we used to install the 'perforce' _package_ with
'brew install perforce' (note: no 'cask' in there).  The justification
for 672f51cb was that the command 'brew install perforce' simply
stopped working, after Homebrew folks decided that it's better to move
the 'perforce' package to a "cask".  It was _their_ justification for
this move that 'brew install perforce' "can fail due to a checksum
mismatch ...", and casks can be installed without checksum
verification.  And indeed, both 'brew cask install perforce' and 'brew
install caskroom/cask/perforce' printed something along the lines of:

  ==> No checksum defined for Cask perforce, skipping verification

It's unclear to me why 672f51cb used 'brew install
caskroom/cask/perforce' instead of 'brew cask install perforce'.  It
appears (by running both commands on old Travis CI macOS images) that
both commands worked all the same already back then.

Anyway, as the error message at the top of the log message shows,
'brew install caskroom/cask/perforce' has stopped working recently,
but 'brew cask install perforce' still does, so let's use that.

Note that on Travis CI we explicitly specify which macOS image to use,
and nowadays we don't run 'brew update' during the build process [1],
so both commands work in our builds there.

[1] f2f4715033 (ci: don't update Homebrew, 2019-07-03)

> CI servers are typically fresh virtual machines, but not always. To
> accommodate for that, let's try harder if `brew cask install perforce`
> fails, by specifically pulling the latest `master` of the
> `homebrew-cask` repository.

Homebrew didn't record a checksum for Perforce versions r17.1, r17.2
and r18.1, so installing those still works fine.  Our Travis CI images
install r18.1.

However, when Homebrew updated to Perforce r19.1, they included the
checksum again for some reason (intentional or accidental; I didn't
look why).  This worked fine for a while, until a couple of days ago
Perforce updated the r19.1 binaries in place, breaking those
checksums.

If we were to still run 'brew update', then it would shortly fix the
checksum mismatch.  But we don't run it, and we do not want to run it
because it takes ages.  Falling back to pull from the 'homebrew-cask'
repository could be a reasonable and quick workaround.

> This will still fail, of course, when `homebrew-cask` falls behind
> Perforce's release schedule. But once it is updated, we can now simply
> re-run the failed jobs and they will pick up that update.

In our CI builds we don't at all care what the checksums of the
Perforce binaries are, so I would really like to tell 'brew' to ignore
any checksum mismatch when installing 'perforce'.  Alas, it appears
that 'brew' has no public options to turn of or to ignore checksum
verification.

Now, let's take a step back.

All 'brew cask install perforce' really does is run 'curl' to download
a tar.gz from the Perforce servers, verify its checksum, unpack it,
and put the executables somewhere on $PATH.  That's not rocket
science, we could easily do that ourselves; we don't even have to deal
with a tar.gz, the 'p4' and 'p4d' binaries for mac are readily
available for download at:

  http://filehost.perforce.com/perforce/r19.1/bin.macosx1010x86_64/

And, in fact, that's what we have been doing in some of our Linux jobs
since the very beginning, so basically only the download URL has to be
adjusted.


> As for updating `homebrew-cask`: the beginnings of automating this in
> https://dev.azure.com/gitgitgadget/git/_build?definitionId=11&_a=summary
> will be finished once the next Perforce upgrade comes around.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  ci/install-dependencies.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 85a9d6b15c..ce149ed39c 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -40,6 +40,11 @@ osx-clang|osx-gcc)
>  	test -z "$BREW_INSTALL_PACKAGES" ||
>  	brew install $BREW_INSTALL_PACKAGES
>  	brew link --force gettext
> +	brew cask install perforce || {
> +		# Update the definitions and try again
> +		git -C "$(brew --repository)"/Library/Taps/homebrew/homebrew-cask pull &&
> +		brew cask install perforce
> +	} ||
>  	brew install caskroom/cask/perforce
>  	case "$jobname" in
>  	osx-gcc)
> -- 
> gitgitgadget
