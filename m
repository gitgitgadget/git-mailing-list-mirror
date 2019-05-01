Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF311F45F
	for <e@80x24.org>; Wed,  1 May 2019 23:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEAXTA (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 19:19:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40162 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfEAXTA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 19:19:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so579976wre.7
        for <git@vger.kernel.org>; Wed, 01 May 2019 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e4su812mQEFOW/+R1QeNHo7QCx9UliIleCTQ0VEP0uE=;
        b=YqoGeYOWhviY1SwV/FkiJsV/JMycpjeO8VK3NVEm6RXUxP8HuLY6rx8tufJkB2YrrI
         IDVpAaH9EcPTAM8JoRWZOZ3yTXBwILnYE/c1BWGlpgU6v8XUt3JEFBEdODUot5Pwevcb
         XA99LIhpiixm66Ewy9NKli/8uPi9euF6mshvK5xXp5s3gD2x6HOjp0lJMgXluy+KsNoI
         +h7Gr+CjRZici+L79R8jjiNF3jgtunnN9BEQsrXXV8XFt6zBiSxfp6orJxJCP5/65RC8
         76BbvmkgUBlUt9GzhJFXMrV+pXS+s+OLe4wFTzsTHPzL8djX4g1oxQPxrXgtwAJf4KyH
         g2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e4su812mQEFOW/+R1QeNHo7QCx9UliIleCTQ0VEP0uE=;
        b=KNK6eyBno92Dg5gxkTNXVUgRP4oElzWmecypG9EIcfRJ0X+I4C9kPVtudGE4oJQTnn
         W1Hs9euhXubXKDhkt0K2lXQ9r+wGYaplT+xq00HtXSEJn5rl9MFn2F5qe/YbKaGBT9Y/
         Yi97MvavWUsoZMa1grrXba1ZoYw0qY3W4K3mhc8b9pYwFIyc10lUV/2XCnocYNA3R/G7
         kpfqlPdzOQTx02qANum9Am9BZNciXuP7gRu3Vi7+p3Ey8303N2AkUufz6ZEhNuqlgeuE
         cxhQ78ehKegwAZi4u0dzh0W1JuSWuS/2D/ha+RwsdZZSshn525pIjHdP7K11tVRMwUyP
         3W4Q==
X-Gm-Message-State: APjAAAUXQwOYn4N/yXwjZp69BThyQYWOoAEhcL+ZGH+YVMFp43HVVIHe
        uJ3kzps2NKxQ2nVpGEs+hmqTcuAE
X-Google-Smtp-Source: APXvYqwVYeHAiOJ3KnSBi8Fy1VJMD/E7V9gPLeROXQ3Wt6NsTj+MxlyQRwvJtDEaDghoqM/EzIgQsg==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr362043wrw.315.1556752737397;
        Wed, 01 May 2019 16:18:57 -0700 (PDT)
Received: from szeder.dev (x4db31769.dyn.telefonica.de. [77.179.23.105])
        by smtp.gmail.com with ESMTPSA id z6sm21212651wrw.87.2019.05.01.16.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 16:18:56 -0700 (PDT)
Date:   Thu, 2 May 2019 01:18:54 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: install 'libsvn-perl' instead of 'git-svn'
Message-ID: <20190501231854.GE14763@szeder.dev>
References: <20190430123724.16150-1-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.1904301816200.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1904301816200.45@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 30, 2019 at 06:16:48PM -0400, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 30 Apr 2019, SZEDER Gábor wrote:
> 
> > Since e7e9f5e7a1 (travis-ci: enable Git SVN tests t91xx on Linux,
> > 2016-05-19) some of our Travis CI build jobs install the 'git-svn'
> > package, because it was a convenient way to install its dependencies,
> > which are necessary to run our 'git-svn' tests (we don't actually need
> > the 'git-svn' package itself).  However, from those dependencies,
> > namely the 'libsvn-perl', 'libyaml-perl', and 'libterm-readkey-perl'
> > packages, only 'libsvn-perl' is necessary to run those tests, the
> > others arent, not even to fulfill some prereqs.
> >
> > So update 'ci/install-dependencies.sh' to install only 'libsvn-perl'
> > instead of 'git-svn' and its additional dependencies.
> >
> > Note that this change has more important implications than merely not
> > installing three unnecessary packages, as it keeps our builds working
> > with Travis CI's Xenial images.  In our '.travis.yml' we never
> > explicitly specified which Linux image we want to use to run our Linux
> > build jobs, and so far they have been run on the default Ubuntu 14.04
> > Trusty image.  However, 14.04 just reached its EOL, and Travis CI has
> > already began the transition to use 16.04 Xenial as the default Linux
> > build environment [1].  Alas, our Linux Clang and GCC build jobs can't
> > simply 'apt-get install git-svn' in the current Xenial images [2],
> > like they did in the Trusty images, and, consequently, fail.
> > Installing only 'libsvn-perl' avoids this issue, while the 'git svn'
> > tests are still run as they should.
> >
> > [1] https://blog.travis-ci.com/2019-04-15-xenial-default-build-environment
> >
> > [2] 'apt-get install git-svn' in the Xenial image fails with:
> >
> >       The following packages have unmet dependencies:
> >        git-svn : Depends: git (< 1:2.7.4-.)
> >       E: Unable to correct problems, you have held broken packages.
> >
> >     The reason is that both the Trusty and Xenial images contain the
> >     'git' package installed from 'ppa:git-core/ppa', so it's
> >     considerably newer than the 'git' package in the corresponding
> >     standard Ubuntu package repositories.  The difference is that the
> >     Trusty image still contains these third-party apt repositories, so
> >     the 'git-svn' package was installed from the same PPA, and its
> >     version matched the version of the already installed 'git'
> >     package.  In the Xenial image, however, these third-party
> >     apt-repositories are removed (to reduce the risk of unrelated
> >     interference and faster 'apt-get update') [3], and the version of
> >     the 'git-svn' package coming from the standard Ubuntu package
> >     repositories doesn't match the much more recent version of the
> >     'git' package installed from the PPA, resulting in this dependecy
> >     error.
> >
> >     Adding back the 'ppa:git-core/ppa' package repository would solve
> >     this dependency issue as well, but since the troublesome package
> >     happens to be unnecessary, not installing it in the first place is
> >     better.
> >
> > [3] https://docs.travis-ci.com/user/reference/xenial/#third-party-apt-repositories-removed
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  ci/install-dependencies.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 52a44c690a..7f6acdd803 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -12,7 +12,7 @@ case "$jobname" in
> >  linux-clang|linux-gcc)
> >  	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
> >  	sudo apt-get -q update
> > -	sudo apt-get -q -y install language-pack-is git-svn apache2
> > +	sudo apt-get -q -y install language-pack-is libsvn-perl apache2
> 
> Makes sense.
> 
> I assume you verified that this works also with our Azure Pipeline?

No, I didn't; only on Travis CI's 14.04 and 16.04 images and on a
local 16.04 install.

