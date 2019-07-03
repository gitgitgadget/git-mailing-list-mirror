Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E91A1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 13:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGCNEj (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 09:04:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51598 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 09:04:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so2145061wma.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UMKa+1KJQsAbqa63bNiR6jAwHDyJ9kfZnYvDSeQ+I3c=;
        b=H811yVsjiQ7lwMSzq12KmX8r/gKZ12ysKbx9w7xd7QsaqWOba2AMsMfOMS4yCBRjxm
         XlGpP+yU6UwqMkCEjkD1InzQgDiuunfST+werjTor1VbXseeJVKB9SNAV6QaIAkqc6as
         QK4d+8muoA1GxSdOCoex9EvVGiPDsSEfBfHFn1lg3aaDNJgJmifW4dM2R3UJe+jF+TrV
         X/lhTgTyE7lW2UgwHQXqLSyrgXRx8zGgTVbmmxsIWrmLWFPK1CLDeFwGwzVtHaUllctu
         9r4Bb1N3p3Rn3yXfRbVUM4QJEx5FffhNhTKei3/Q5zSK3U4qYjwbdTzdXZGERrVJCinL
         WdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UMKa+1KJQsAbqa63bNiR6jAwHDyJ9kfZnYvDSeQ+I3c=;
        b=m/XiMnXzYupKezYBN+WPp/SMocFx0DIdpYiGxzqwPXIXxTtWLRMuD/1a+s940qwsNV
         0ovuI9Z9Wgl0xLDfLF+ftREmDex0wn7+siF8yVXEkRdXkTYU3mbJwd7f9mznwCIT7ZgU
         yWX6Wp7kDP5854pdLZtqkjpO+9SQgTsM3MrtshXNJzD5qOW+YLYTdp1H5EaP+G9Jbofy
         bGsu21ePc2p8G6O+fKItlQA6PAgVL9Po9Mu3RaCNQYIXwYowatxrMokpg9a90Z/N56+O
         dqbfNZyP4/KfABcbYM6FzINb/LlOdWwzLmno5dOdkJ7mYcLyC30NEbo4mS9LF4NlDLsu
         uDMQ==
X-Gm-Message-State: APjAAAX/AQs7qFEKRG2mpE5Is+7nkxsYIdH5Cww+ccR3O6azJ99prF/R
        X09D1+i+mRQ7t8AmmQ0Av+s=
X-Google-Smtp-Source: APXvYqzpeY+sN2jeYj9fyVPpftg3Aa/y2K9gkzdUcYJRDkmE9mCmgr3WS3d8LCRC4XSKZm4qtgutxg==
X-Received: by 2002:a1c:a6d3:: with SMTP id p202mr8425047wme.26.1562159077195;
        Wed, 03 Jul 2019 06:04:37 -0700 (PDT)
Received: from szeder.dev (x4db51bef.dyn.telefonica.de. [77.181.27.239])
        by smtp.gmail.com with ESMTPSA id u13sm2465588wrq.62.2019.07.03.06.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:04:36 -0700 (PDT)
Date:   Wed, 3 Jul 2019 15:04:34 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] ci: disable Homebrew's auto cleanup
Message-ID: <20190703130434.GR21574@szeder.dev>
References: <20190629170108.GF21574@szeder.dev>
 <20190703104748.32533-1-szeder.dev@gmail.com>
 <20190703104748.32533-2-szeder.dev@gmail.com>
 <1d10ed33-5c33-8028-c375-d859ef6826dc@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d10ed33-5c33-8028-c375-d859ef6826dc@virtuell-zuhause.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 03, 2019 at 02:26:21PM +0200, Thomas Braun wrote:
> Am 03.07.2019 um 12:47 schrieb SZEDER Gábor:
> > Lately Homebrew learned to automagically clean up information about
> > outdated packages during other 'brew' commands, which might be useful
> > for the avarage user, but is a waste of time in CI build jobs, because
> > the next build jobs will start from the exact same image containing
> > the same outdated packages anyway.
> > 
> > Export HOMEBREW_NO_AUTO_UPDATE=1 to disable this auto cleanup feature,
> 
> The patch below adds HOMEBREW_NO_INSTALL_CLEANUP so maybe you meant
> HOMEBREW_NO_INSTALL_CLEANUP here as well?

Thanks, good catch.  Apparently copy-pasted the wrong env var from the
patch to the commit message...

> > shaving off about 20-30s from the time needed to install dependencies
> > in our macOS build jobs on Travis CI.
> > 
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  ci/install-dependencies.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 7f546c8552..8cc72503cb 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -34,7 +34,7 @@ linux-clang|linux-gcc)
> >  	popd
> >  	;;
> >  osx-clang|osx-gcc)
> > -	export HOMEBREW_NO_AUTO_UPDATE=1
> > +	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
> >  	# Uncomment this if you want to run perf tests:
> >  	# brew install gnu-time
> >  	test -z "$BREW_INSTALL_PACKAGES" ||
> > 
> 
