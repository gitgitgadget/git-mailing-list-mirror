Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1341F453
	for <e@80x24.org>; Fri,  3 May 2019 14:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfECOmS (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 10:42:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54686 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfECOmR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 10:42:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id b10so7431528wmj.4
        for <git@vger.kernel.org>; Fri, 03 May 2019 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Er5r9QFDyYMDUvkF8hEtfqkjOQa+hmUlxGx8MyUluHc=;
        b=fYNNK5V8Lva2+gzcTC/GT1YNEMMr/YGvmlzVDdg3DiMTS53JRih4/frcv6I82vV8VS
         yHD94qcv4nmupBT3vrN8suIVqj9sVOgQjJ0dFMW4B3koXqOfeAHteXu4H4YN3zRD1zpg
         sl/VPNWlgJWylEITOkE0z+kHd4C5q+fIgM8BrpkUJ6nVH3SsR9WuU8tgejrnexY2JcDm
         Z6bXDyMmNkzX+3bEF7Xza5mvxVOOt0p+C4X7YGZ/MUCAgyh5tWKN7GrZHp1S8jEBs4H3
         50qgjX99wbUD7w5VbK864DYUp6Ey/qsDBsDNmgB4ifwEn1x+NcMZ6+BqgPE/cruJoMF5
         WZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Er5r9QFDyYMDUvkF8hEtfqkjOQa+hmUlxGx8MyUluHc=;
        b=hs4cZDMehx7F7TmGdrMXMkn0leJc8QiLdQmMniQJxY9s7ZmlLGzGrrAWuJeAVnQ9h6
         +nXImNC0I/yhBR3AqjeEo44XMSb42AJUm5r/eE/7PEzIVbGTObLQj6x5wFvzdW6rVhPi
         QAB35nm21fqWV4UULvsvN1+WqCxs6AroJXd+ZaB1DGNBM+oTFR8v0LVkX5jeaQXxv/SF
         +PCfpGKw2BtyJCPauNZEh1b9oJgDk/dBsFEhe6Pe+dTF9cWMz0ZL08MQ04082xsap1hm
         ecu0ieqPeXMztPSAgHM1raGbn2DdQ+gqTK4YlpQWCYfHHqx+EcSiBHoidrvFl6sRGN3z
         wavQ==
X-Gm-Message-State: APjAAAW7QPvDLsPDXIEDjDT+uO46nSQyeGJHe+fXWvpBaezj1HMjEnie
        8ksYqqkmNUeiIf7EuvdL7ws=
X-Google-Smtp-Source: APXvYqzGpa1WpNNG3MZVjSn4AP+8903XPcACk7BIXJrtjvLqhUChXCTlQg6NlXVtZqQ6eBVnVwXITA==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr6401232wml.59.1556894535672;
        Fri, 03 May 2019 07:42:15 -0700 (PDT)
Received: from szeder.dev (x4db507c5.dyn.telefonica.de. [77.181.7.197])
        by smtp.gmail.com with ESMTPSA id y7sm4522272wrg.45.2019.05.03.07.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 07:42:14 -0700 (PDT)
Date:   Fri, 3 May 2019 16:42:11 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <20190503144211.GH14763@szeder.dev>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net>
 <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev>
 <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 03, 2019 at 11:32:32AM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 2 May 2019, SZEDER Gábor wrote:
> 
> > On Wed, May 01, 2019 at 06:01:08AM -0400, Denton Liu wrote:
> > > > Is it not possible to exclude certain directories for certain semantic
> > > > patches?
> > > >
> > > > I guess we could also simply declare that *all* Coccinelle patches should
> > > > leave `compat/` alone, on the basis that those files are likely coming
> > > > from some sort of upstream. But then, `compat/mingw.c` and `compat/win32/`
> > > > seem not to fall into that category...
> > > >
> > > > Ciao,
> > > > Dscho
> > >
> > > Deciding whether this is a good idea is above my paygrade ;)
> 
> :-)
> 
> As a software developer, you surely have an opinion, though :-D

I don't even have an opinion yet. :)

> > FWIW, out of curiosity I've run 'make coccicheck' on Linux with
> > 'compat/mingw.c' and its friends explicitly added to C_SOURCES, and it
> > seems to work...  it even found two places in 'mingw.c' where
> > COPY_ARRAY could replace memcpy() :)
> 
> TBH I had not even known that those files were excluded from coccicheck by
> default.

Well, there was this line in the patch context:

    C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))

> I had assumed that all of Git's sources (and not just the
> Linux-specific ones) were included in the target.
> 
> Since you *could* include it, I now assume that Coccinelle does not need
> to follow the `#include`s (otherwise, it would have complained about not
> finding the `windows.h` header in your setup).

We invoke Coccinelle/spatch with the '--all-includes' option, see the
SPATCH_FLAGS make variable.  And it does indeed include header files:
I've seen it find something to transform in 'cache.h', and then the
resulting 'contrib/coccinelle/<whatever>.cocci.patch' included the
exact same transformation as many times as the number of files
including 'cache.h'... which is a lot :)

I don't really know what can cause 'spatch' to error out (besides
unknown command line option or non-existing file specified on the
command line), and this is all that 'man spatch' has to say:

       --all-includes
              causes all available include files to be used

Since it explicitly mentions _available_ include files, I would
venture to guess that non-available include files are not used, and
since it doesn't explicitly mention that such a file causes an error,
it doesn't.


> If this new assumption is true, I wonder why we cannot make my former
> assumption true as well: why not include *all* of Git's `.c` files in
> `coccicheck`?
> 
> Ciao,
> Dscho

