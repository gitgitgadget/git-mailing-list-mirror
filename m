Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CB791F453
	for <e@80x24.org>; Thu, 17 Jan 2019 14:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfAQO4S (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 09:56:18 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40709 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfAQO4S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 09:56:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so1351746wmf.5
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 06:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BAEcVifgevB06smH2Z2GneiFo5ApRdIdYjlJwuEGoiY=;
        b=SOe/ugqbC5YO2xUqPZUbv0E42kWnuJOxzB/zp78LQ5FBfPLzBYXTfw2D7WLzmTNX7k
         dREGHR3DIPgHY+/2vFomR1X/Jzj/xBHuHcV7s4isNSdAzCQItiJPcNUL5uWWT7mih/N0
         ccIFCU4Y4mrx4VvsZSpdIx4JUSUcIAq5WG4hXILhi45yojqDPhZGqqXpR/qMaNX9HCpX
         V7VxvX0DUwPIqquUGXz0o00ls5MPNspBGDxeuP2sOT+nyXJ7fc3aVomuRwDvXZaPN9x9
         QuSfplEcjr/pOH9aKauTe1sbRWDe5LHa/V2HhSNoZ6f5xFWf8XKmAUggyNhkam9WEE9p
         iwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BAEcVifgevB06smH2Z2GneiFo5ApRdIdYjlJwuEGoiY=;
        b=mz2Z844HRuvmy7jp0qhF0SEu0ScCqCnFmDy3Xpa1ywRe3k18LUBMVYaZJu1qteCxj/
         C16UzZSuwVgZjaJkvWVTOvFu9wDuOhsZ6AltSdPr4jdu6Qc/6pWWYl7F61MFOqvDqVlZ
         4aOpy0/vLY1zanuqyukW71c+WN9NgKa0pNaLJIJatx+aAmwopmf6BCoAKDMwIjRv8hT/
         4BEYjemBoiHa35P7aL57U365zncfNz5/yYLD/j/Sv8OxzQ1YkcVNpHkHMR+U/1uIh8DW
         uC+4xMUoI2Z+3NDYhC4CXvuhwPAfPrFSHouIhPkmJj0Fg8nkLO+h06lwDXiVC4k9rQqC
         c9QA==
X-Gm-Message-State: AJcUukeTl6OZFlQ7o0Iv/4bKI87eteI3aiTRVzAbFaSf35xn2nPMMh9v
        S8N73midV399/pP/rF6jWTs=
X-Google-Smtp-Source: ALg8bN41B82LbYYEpc4lkA7NND4wV3CHqwBSJoH78yNMDiXI1YAsnCXUMoVTTkW1hNtIQigFuxmMuQ==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr11579394wmj.129.1547736975649;
        Thu, 17 Jan 2019 06:56:15 -0800 (PST)
Received: from szeder.dev (x4d0c457d.dyn.telefonica.de. [77.12.69.125])
        by smtp.gmail.com with ESMTPSA id a62sm31343447wmf.47.2019.01.17.06.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 06:56:14 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:56:12 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] travis-ci: build with the right compiler
Message-ID: <20190117145612.GL840@szeder.dev>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
 <20190117012913.30562-1-szeder.dev@gmail.com>
 <20190117012913.30562-6-szeder.dev@gmail.com>
 <nycvar.QRO.7.76.6.1901171439280.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1901171439280.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 02:44:59PM +0100, Johannes Schindelin wrote:
> Hi Gábor,
> 
> On Thu, 17 Jan 2019, SZEDER Gábor wrote:
> 
> > Our 'Makefile' hardcodes the compiler to build Git as 'CC = cc'.  This
> > CC variable can be overridden from the command line, i.e. 'make
> > CC=gcc-X.Y' will build with that particular GCC version, but not from
> > the environment, i.e. 'CC=gcc-X.Y make' will still build with whatever
> > 'cc' happens to be on the platform.
> > 
> > Our build jobs on Travis CI are badly affected by this.  In the build
> > matrix we have dedicated build jobs to build Git with GCC and Clang
> > both on Linux and macOS from the very beginning (522354d70f (Add
> > Travis CI support, 2015-11-27)).  Alas, this never really worked as
> > supposed to, because Travis CI specifies the compiler for those build
> > jobs as 'export CC=gcc' and 'export CC=clang' (which works fine for
> > projects built with './configure && make').  Consequently, our
> > 'linux-clang' build job has always used GCC, because that's where 'cc'
> > points at in Travis CI's Linux images, while the 'osx-gcc' build job
> > has always used Clang.  Furthermore, 37fa4b3c78 (travis-ci: run gcc-8
> > on linux-gcc jobs, 2018-05-19) added an 'export CC=gcc-8' in an
> > attempt to build with a more modern compiler, but to no avail.
> > 
> > Set MAKEFLAGS with CC based on the $CC environment variable, so 'make'
> > will run the "right" compiler.  The Xcode 10.1 macOS image on Travis
> > CI already contains the gcc@8 package from Homebrew, but we have to
> > 'brew link' it first to be able to use it.
> > 
> > So with this patch our build jobs will build Git with the following
> > compiler versions:
> > 
> >   linux-clang: clang version 5.0.0 (tags/RELEASE_500/final)
> >   linux-gcc:   gcc-8 (Ubuntu 8.1.0-5ubuntu1~14.04) 8.1.0
> > 
> >   osx-clang: Apple LLVM version 10.0.0 (clang-1000.11.45.5)
> >   osx-gcc:   gcc-8 (Homebrew GCC 8.2.0) 8.2.0
> > 
> >   GETTEXT_POISON: gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
> > 
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> 
> Nicely explained and implemented. Thank you!
> 
> Apart from the single typo I stumbled over (quite honestly, I do not
> really care about typos, I just point them out when I see them to beat
> Eric to it)

Heh ;)

> I have just one more wish: I would *love* to see a Travis
> run.
> 
> Surely you opened a PR at https://github.com/git/git. Oh wait, I can look
> for it! But no, there does not seem to be one.

Nope, "all pull requests are ignored", so I don't bother.

> So probably in your fork,
> https://github.com/szeder/git. No PRs. Ah, but there are branches! 60 of
> them.

Oh, wow, 60, that really needs to be cleaned up and all the already
upstreamed, obsolete, or test branches removed.  And, more
importantly, my WIP branches finished and finally upstreamed...
Sigh, maybe someday...

> And yes, I guess I found a Travis build:
> 
> 	https://travis-ci.org/szeder/git/builds/480654256

That would be the right build, but it was the result of a rebase
squashing a fixup commit and editing commit messages while leaving the
resulting tree intact, and then 9cc2c76f5e (travis-ci: record and skip
successfully built trees, 2017-12-31) kicked in and optimized away the
build.

Anyway, I deleted the branch's cache and restarted the build, it will
most likely be finished by the time I send this email.

> But no, the associated branch does not look like it reflects this patch
> series...

That's the right branch, though, except that it contains a debug patch
on top (that I didn't submitted) that shows the used compiler and its
version from within the Makefile, to make sure that the build jobs do
indeed use the compilers that I think they should be using.

The other patches on that branch are the same that were submitted in
this patch series.


Here are the most interesting bits of the problematic build jobs, i.e.
the compiler versions from that debug patch:

  linux-clang:  https://travis-ci.org/szeder/git/jobs/480654257#L824
  osx-gcc:      https://travis-ci.org/szeder/git/jobs/480654264#L824


> In any case, this series is:
> 
> 	Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks.

