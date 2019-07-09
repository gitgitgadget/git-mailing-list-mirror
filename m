Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB301F461
	for <e@80x24.org>; Tue,  9 Jul 2019 16:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfGIQck (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 12:32:40 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43315 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfGIQck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 12:32:40 -0400
Received: by mail-yw1-f67.google.com with SMTP id n205so4781162ywb.10
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=thy3LiRmXZGBu++ijVOU2tCSQU3/cWCfW3yCN/WXlOM=;
        b=kbJdFDJSwBNCE0VhH4g1HRQOL0y8ekBhz3PGImq9eg+7Q69KGA59pB8SpH3vSk2cNj
         L1LSaFlymu6WtRJ2CmgaeEpKqsNKDnhqXoEkEfQljCpcHsRtedWvQxozfhc7UaRwevSk
         LIMNvhYM8+sVOBnRaEaUF3GXA0sVnwYd/8xVCxbTl1pmK0IL14D+vi+6Cfo5ihhqkGYw
         ai5MjffZqDHUMimosoQ3szWgiFsN2lpRhJvCru/ffxzw/+gg0JJBAtdyO5YEgTEKqYEf
         UITxx9tBo8B5AI6S4ELNGHTZ4wfPoXBE9xIJETqra1EFTvpd1xtli65jLbOqy9Um+0E1
         8ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=thy3LiRmXZGBu++ijVOU2tCSQU3/cWCfW3yCN/WXlOM=;
        b=eq0oeYXT9/CXSGdhkZXwOZ9ilicixMF3nzE10pgKoQ34Fj+Ygt0pntiYpV24YKMXwl
         K25h+ybDjN7t0yL0QHnIztAcSIxa4hXualT5XvivywZJnXhPGaSpx5ZS3JAj4n+QTeMS
         jIbsSs396Co96+dR7cXkVA/CFwrXj2RGu+d74b6P+PfQ0zDErOEorcGFGjt1tgvfiqA3
         +RKO4VMLYRxuQ5AdDacAQp7LpVI79NFxpdH+kUXvCqSuhfNp109HRMvwtOFA140Z6YDz
         tSBAuMfxxFF6XN/awhGbpID2ajyLDVdsgEHFDACMneG2GjJEfmWqvq0wCeDUzPCkf/z+
         Y7bw==
X-Gm-Message-State: APjAAAUjXfRoC6ZRxXuF0J/yINF0cq/JE8RLAEe4mhyBHBxitzMDtoqK
        yosj2UZQnXepN9qPQglJXtjm6g==
X-Google-Smtp-Source: APXvYqxRhYl5CCJa1msM1RTmzF4j0/By3e6d3cTw4x2BfG8lSAmPAOA1tuEMGfzaXhkhbWMWOcgIeg==
X-Received: by 2002:a81:1b41:: with SMTP id b62mr15545114ywb.206.1562689958954;
        Tue, 09 Jul 2019 09:32:38 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:2c87:56eb:7a09:3754])
        by smtp.gmail.com with ESMTPSA id h133sm336567ywb.9.2019.07.09.09.32.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 09:32:38 -0700 (PDT)
Date:   Tue, 9 Jul 2019 11:32:37 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci: don't update Homebrew
Message-ID: <20190709163237.GA62761@TaylorsMBP6986.attlocal.net>
References: <20190629170108.GF21574@szeder.dev>
 <20190703104748.32533-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190703104748.32533-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gábor,

On Wed, Jul 03, 2019 at 12:47:47PM +0200, SZEDER Gábor wrote:
> Lately our GCC macOS build job on Travis CI has been erroring out
> while installing dependencies with:
>
>   +brew link gcc@8
>   Error: No such keg: /usr/local/Cellar/gcc@8
>   The command "ci/install-dependencies.sh" failed and exited with 1 during .

Thanks for working on this. I think that the patch below is ultimately a
better approach than what we had discussed in a previous thread [1].

> Now, while gcc@8 is still pre-installed (but not linked) and would be
> perfectly usable in the Travis CI macOS image we use [1], it's at
> version 8.2.  However, when installing dependencies we first
> explicitly run 'brew update', which spends over two minutes to update
> itself and information about the available packages, and it learns
> about GCC 8.3.  After that point gcc@8 exclusively refers to v8.3,
> and, unfortunately, 'brew' is just too dumb to be able to do anything
> with the still installed 8.2 package, and the subsequent 'brew link
> gcc@8' fails.  (Even 'brew uninstall gcc@8' fails with the same
> error!)
>
> Don't run 'brew update' to keep the already installed GCC 8.2 'brew
> link'-able.  Note that in addition we have to 'export
> HOMEBREW_NO_AUTO_UPDATE=1' first, because 'brew' is so very helpful
> that it would implicitly run update for us on the next 'brew install
> <pkg>' otherwise.
>
> Disabling 'brew update' has additional benefits:
>
>   - It shaves off 2-3mins from the ~4mins currently spent on
>     installing dependencies, and the macOS build jobs have always been
>     prone to exceeding the time limit on Travis CI.
>
>   - Our builds won't suddenly break because of the occasional Homebrew
>     breakages [2].

This is sensible. We'll rely on the most-recent version of the Homebrew
packages that are known by the macOS image _from Travis_, ignoring any
changes that have happened in Homebrew core since the image snapshot.

Thanks also for paying attention to setting 'HOMEBREW_NO_AUTO_UPDATE' in
the environment. This will harden any other existing or future uses of
'brew' against accidentally spending a bunch of time trying to update
itself (and perhaps breaking a subsequent 'brew link', if it should
happen before that).

> The drawback is that we'll be stuck with slightly older versions of
> the packages that we install via Homebrew (Git-LFS 2.5.2 and Perforce
> 2018.1; they are currently at 2.7.2 and 2019.1, respectively).  We
> might want to reconsider this decision as time goes on and/or switch
> to a more recent macOS image as they become available.

I think that this may in fact be better than what we have now. If we
find ourselves wanting a newer version of, say, Git LFS, then I think
we'd be benefited by upgrading the image itself. Perhaps we should look
into that shortly, although I'm not aware of any urgency to do so (at
least as it pertains to Git LFS).

> [1] 2000ac9fbf (travis-ci: switch to Xcode 10.1 macOS image,
>     2019-01-17)
>
> [2] See e.g. a1ccaedd62 (travis-ci: make the OSX build jobs' 'brew
>     update' more quiet, 2019-02-02) or
>
>     https://public-inbox.org/git/20180907032002.23366-1-szeder.dev@gmail.com/T/#+u
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  ci/install-dependencies.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 7f6acdd803..7f546c8552 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -34,7 +34,7 @@ linux-clang|linux-gcc)
>  	popd
>  	;;
>  osx-clang|osx-gcc)
> -	brew update >/dev/null
> +	export HOMEBREW_NO_AUTO_UPDATE=1
>  	# Uncomment this if you want to run perf tests:
>  	# brew install gnu-time
>  	test -z "$BREW_INSTALL_PACKAGES" ||
> --
> 2.22.0.621.ge52941b842.dirty

Thanks,
Taylor

[1]: https://public-inbox.org/git/20190602112239.GO951@szeder.dev
