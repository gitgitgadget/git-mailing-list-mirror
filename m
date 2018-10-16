Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987721F453
	for <e@80x24.org>; Tue, 16 Oct 2018 18:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeJQCh3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 22:37:29 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:39352 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 22:37:29 -0400
Received: by mail-ed1-f45.google.com with SMTP id d15-v6so22382861edq.6
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FS+eXcXNGaRTHh5orgXJRIfXSfwDisF5iL0SmXHntLc=;
        b=uv+5Le2l9jPADGgbfGDJZbiWQvDBSH3qTe2Ev/ih65YDlBUMgkkK1xwJIqHZH56Hpx
         YHZJUxvv/59piFM5xFPnqqQrPzHcUzgwEtjQ0xZxLp5/j+mifeEGKOEbM0adchmq0nkG
         QaRbJcU/pCo7MOfxhFsp64n1QVazw0lf3/KBL5c3u4SPvtZanv7BqtwVQ5DyBM/qn72L
         Y8MXp0Kof3btUf94rRQVqX6O2Yo3uiFr6Fumc3s8oP9HtKsbvD+LWYromoCCpfuUQbvP
         Mgdrcs2xCJ21C4pm8dbz+YANfYdM8s22FG8JfLTqJLcrm2yxrAuGBTCEQZBrQHaBuJe1
         2c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FS+eXcXNGaRTHh5orgXJRIfXSfwDisF5iL0SmXHntLc=;
        b=gqUejIbLwebF14Mg4HQaVV0Ni3LLML3cnn1Tu4rqwyBdztzYe1sLQwNRkmQcjPSfrN
         T3VBO0sgwx8irTXw04X+CNn466OKWASOCrCmtwWgNfJrda+YG0GgU8xgwFjJDuR7ykWj
         rZkTb4JWb659cfxZU55LMmcLtX6bo5wh+pquGWYyMJfGVI0HO0iOaunBiCmb18fXDq1V
         b4tARMZtTNLDCFBmacusQ3WZY4suybRqPmJs23yAUwAN2eg/1bp1vwY2HSUzH1dpswGj
         DNaWJhLVySJkkJxv3awwalfNP2BVlEgWLwglumDJCPCbkR0ZcTxfVA2iSmrbRgQtob2G
         ZPBw==
X-Gm-Message-State: ABuFfojGXy6eCcQHexP8l4+WGRl98ImF8KP2l79hOdTwhd9GD+kCytYB
        PRDhJ4Hm4Mov4C5bXc6akZvqIa9z
X-Google-Smtp-Source: ACcGV62gYcEOc99voy0j0GHid9LijodwyYskLQQ1KRu3f/kZ3A6pulIFGIqZq25Y5e20Fks8X4smnQ==
X-Received: by 2002:a50:b36e:: with SMTP id r43-v6mr32460305edd.284.1539715540875;
        Tue, 16 Oct 2018 11:45:40 -0700 (PDT)
Received: from szeder.dev (x4d0caaf1.dyn.telefonica.de. [77.12.170.241])
        by smtp.gmail.com with ESMTPSA id w56-v6sm5681034edw.79.2018.10.16.11.45.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 11:45:39 -0700 (PDT)
Date:   Tue, 16 Oct 2018 20:45:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Subject: On overriding make variables from the environment...
Message-ID: <20181016184537.GN19800@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our Makefile has lines like these:

  CFLAGS = -g -O2 -Wall
  CC = cc
  AR = ar
  SPATCH = spatch

Note the use of '=', not '?='.  This means that these variables can be
overridden from the command line, i.e. 'make CC=gcc-X.Y' will build
with that particular GCC version, but not from the environment, i.e.
'CC=gcc-X.Y make' will still build with 'cc'.

This can be confusing for developers who come from other projects
where they used to run 'CC=whatever make'.

And our build jobs on Travis CI are badly affected by this.  We have
dedicated build jobs to build Git with GCC and Clang both on Linux and
OSX from the very beginning (522354d70f (Add Travis CI support,
2015-11-27)).  But guess how Travis CI specifies which compiler to
use!  With 'export CC=gcc' and 'export CC=clang', respectively.
Consequently, our Clang Linux build job has always used gcc, because
that's where 'cc' points at on Linux by default, while the GCC OSX
build job has always used Clang.  Oh, well.  Furthermore, see
37fa4b3c78 (travis-ci: run gcc-8 on linux-gcc jobs, 2018-05-19), where
Duy added an 'export CC=gcc-8' in an attempt to use a more modern
compiler, but this had no effect either.

I'm not sure what to do.  I'm fine with updating our 'ci/' scripts to
explicitly respect CC in the environment (either by running 'make
CC=$CC' or by writing $CC into 'config.mak').  Or I could update our
Makefile to use '?=' for specific variables, but:

  - I'm afraid to break somebody's setup relying on the current
    behavior and CC having different values in the environment and in
    'config.mak'.

  - Where to stop, IOW which variables should be set with '?='?
    CFLAGS, LDFLAGS, CC, AR, ..., SPATCH, SPATCH_FLAGS?  Dunno.  We
    already have 'STRIP ?= strip' and there are variables that are
    checked explicitly (e.g. 'DEVELOPER=y make' works).

    Note also that prior to b05701c5b4 (Make CFLAGS overridable from
    make command line., 2005-08-06) our Makefile used 'CC?=gcc' as
    well.

