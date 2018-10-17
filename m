Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFBF1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 14:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeJQWZZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 18:25:25 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:32860 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeJQWZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 18:25:25 -0400
Received: by mail-ed1-f43.google.com with SMTP id l14-v6so16097520edq.0
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8w37t6rYVP0K7y374zbrzM7+MPcQFcUyJHeIUVn9qH8=;
        b=L+sUVlKx1fIsRHxkkYq8Sag79mfMg/9Hp0jujpKAgWyuUFuwXbjKIbyPRYIipE2bXH
         9HfKIT+BSqI/hINhvY+ByyJNnwSntjIFyKHCsaC64eLqBvJ9FP6krX1NCEuoewxooXrf
         vCZMp70OgGFYE+9GfqL0umpFxk6ztANXrs71D3IfYL69lsaPiAQeGAYj7aV2nPlGMj9S
         CScueQPECQIM5MRva6YgyywYd8kiFuMmR8rTrDX4T0V1l9RHEZVFTAZx7OWZEEIOFHiA
         MuyCIBuQT0kT7PoVhmGSjcwE+6Mhlp8l/eVMPaOwtyvQxGaYbdeXgI7flHjWvqvlHQ8p
         bLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8w37t6rYVP0K7y374zbrzM7+MPcQFcUyJHeIUVn9qH8=;
        b=BYG/dgZnPIumLvU9OwdO2ZkOp6yr8pG+qxlZ3dKqIMPGQpe3/G1tcPG+Yc8XFIPxW5
         HwJwyMkHNG8wXWcevEAA4JaSAtqwSFFlu30feFcE2sBq4sB2jOUW2aGb4XxEgyI5T0wX
         3uDw2WWMDs3YaTwP8xkS7I2imjL2aInJ+9izezF2ggHVHl6dNlfO3JFuzFy3qIH7a69n
         3Mgv04/Hw3bcSAXro3bGdC+3JYJwKTJrD2bN37JAUoadz1Zw9SSFXhMy8isIwKxaWKrO
         NfpCzxObewJoa6JDBQZdV56wGFoEXOj+hanAb/zSh0bFF0yruIpL18eNFvbNRwSM7H46
         U7xg==
X-Gm-Message-State: ABuFfogeh+pA2P9GVKjYjU93zmT4ImEmacojvJNBLP10QMfcWN8lt/t6
        4yV3DntqG0KT82Kn7d9uDmWWpXLw
X-Google-Smtp-Source: ACcGV63N0S8EJP+5guEi9+Q1UJ77JSqPEN/mo+Ntb8Lk7N0kTUHeZ98s7gnpIk/fs27W/XTZP7l1Bw==
X-Received: by 2002:a17:906:d20d:: with SMTP id w13-v6mr27044240ejz.5.1539786566667;
        Wed, 17 Oct 2018 07:29:26 -0700 (PDT)
Received: from szeder.dev (x4db11ffa.dyn.telefonica.de. [77.177.31.250])
        by smtp.gmail.com with ESMTPSA id i1-v6sm6916707edg.3.2018.10.17.07.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 07:29:25 -0700 (PDT)
Date:   Wed, 17 Oct 2018 16:29:23 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: On overriding make variables from the environment...
Message-ID: <20181017142923.GR19800@szeder.dev>
References: <20181016184537.GN19800@szeder.dev>
 <20181016215456.GB96853@aiede.svl.corp.google.com>
 <20181016223330.GP19800@szeder.dev>
 <20181016224001.GC96853@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016224001.GC96853@aiede.svl.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 03:40:01PM -0700, Jonathan Nieder wrote:
> SZEDER Gábor wrote:
> > On Tue, Oct 16, 2018 at 02:54:56PM -0700, Jonathan Nieder wrote:
> >> SZEDER Gábor wrote:
> 
> >>> Our Makefile has lines like these:
> >>>
> >>>   CFLAGS = -g -O2 -Wall
> >>>   CC = cc
> >>>   AR = ar
> >>>   SPATCH = spatch
> [...]
> >>> I'm not sure what to do.  I'm fine with updating our 'ci/' scripts to
> >>> explicitly respect CC in the environment (either by running 'make
> >>> CC=$CC' or by writing $CC into 'config.mak').  Or I could update our
> >>> Makefile to use '?=' for specific variables, but:
> >>
> >> That's a good question.  I don't have a strong opinion myself, so I
> >> tend to trust larger projects like Linux to have thought this through
> >> more, and they use 'CC = cc' as well.
> >
> > I don't think Linux is a good example to follow in this case, see e.g.
> > 6d62c983f7 (Makefile: Change the default compiler from "gcc" to "cc",
> > 2011-12-20) (in short: Git is supposed to be buildable with compilers
> > other than GCC as well, while Linux not really, so they can hardcode
> > 'CC = gcc').
> 
> Nowadays Linux builds with clang as well.  People also have other
> reasons to override the CC setting (cross-compiling, etc) and to
> override other settings like CFLAGS.
> 
> > Also, the projects I have on hand usually have 'CC = gcc' hardcoded in
> > their Makefiles, too, but those Makefiles were generated by their
> > ./configure script (which in turn by ./autogen.sh...), and those tend
> > to write CC from the environment into the generated Makefiles.
> 
> Yes, I think that's what makes travis's setup normally work.  It makes
> sense to me since ./configure is expected to have more implicit or
> automatic behavior.  For "make", I kind of like that it doesn't depend
> on environment variables that I am not thinking about when debugging a
> reported build problem.
> 
> When building Git without autoconf, the corresponding place for
> settings is config.mak.  Would it make sense for the ci scripts to
> write a config.mak file?

A first I though it doesn't, but it turns out it acually does.

'ci/run-build-and-tests.sh' basically runs:

  make
  make test

I naively put a 'CC=$CC' argument at the end of the first command,
thinking it should Just Work...  but then that second 'make test' got
all clever on me, said "* new build flags", and then proceeded to
rebuild everything with the default 'cc'.  (With the additional
complication, that on Travis CI we actually run 'make --quiet test',
which rebuilds everything, well, quietly...  so the rebuild itself is
not even visible in the build logs.)

So, then it's either 'config.mak', or passing a 'CC=$CC' argument to
_all_ make commands, including those that are not supposed to build
anything, but only run the tests.  I find the latter aesthetically not
particularly pleasing.

