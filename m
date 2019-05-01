Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85671F453
	for <e@80x24.org>; Wed,  1 May 2019 10:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfEAKBN (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 06:01:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43849 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfEAKBN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 06:01:13 -0400
Received: by mail-io1-f67.google.com with SMTP id v9so14446651iol.10
        for <git@vger.kernel.org>; Wed, 01 May 2019 03:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1sHTjZIj7aDoNFx+5uCLi5kkWi8b3s+DZrTiYqUMrUo=;
        b=ozl+EnhnEmSIO37vSg/CYrFUk0PY4XHcL66qS64LaC8YVvXHhVN2PYp/a8+zOpeIwl
         yqD1RkwCghM663yiePBpqjlCY46O4DeRQwq66C6ERq4eVWF/ldW2rZO0Jx23l6Mg/cs0
         Q/0z0NdYhBxNDGJFPRxUAYwzYAZF/epkSOt5YPqJIhk5TKsYnndY5cB2Xd44qK/HryOU
         GIMZ5Ki02R+rxcLrTbjMbOwu+1Q1R/sZOXVp+qBgGMnPgzUBIXtr+jt/tgCcujqmubN/
         lNppWnV7E2zL8WHXmzAeOzEd2VeHlt5AP5+vkQWIT1O8bEXhkLFhB7FIQwnjzWV1jH/u
         sKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1sHTjZIj7aDoNFx+5uCLi5kkWi8b3s+DZrTiYqUMrUo=;
        b=G8mo54r2O6ICZeUpI0dVEA2jJXIPYoP5T0Nrk18jwffhpXvtf0BoL5arotjvgfIpHF
         vmRsdtRXCa65a9mZthfKA6+EnFZqdvcOUVr7ANfRjge3+kfweeQdNcRiwyrGg/soEWGC
         Wfj5jXyJ4DOypKXQok8AryCcZ8jYKMUEZFRY1T4JNCtxSh71uhXzjmi+zMwDX6zNIiPN
         8KWOfx8cQC+HWFAKXxJdu2QeqSXdPaXWWw29Byk/ttrznUg3tc+NqN4yPHZ9oE17fL14
         4Ncj01BUubLw+Coab73TVpTOnQcnISEYOYggx9jIvHKoNN4ZJflJ5IOzW8qxLvKZuM0G
         oPEg==
X-Gm-Message-State: APjAAAU/TZ1CBe+rEOXzZ7DmaCXcFdeCiUkMdaM22Og3st6ff+1LppQ3
        ComWD6CtzYmR+DKyf2n30gY=
X-Google-Smtp-Source: APXvYqwIdehexCX/hdNtpbqtmwniDcNt/9vc2X+Dl72friAOPCoTy9FaOHm5SZ/wIzCJJS98iD94Vw==
X-Received: by 2002:a6b:5915:: with SMTP id n21mr31742386iob.198.1556704872561;
        Wed, 01 May 2019 03:01:12 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id 2sm2081391itl.15.2019.05.01.03.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 03:01:11 -0700 (PDT)
Date:   Wed, 1 May 2019 06:01:08 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <20190501100108.GA8954@archbookpro.localdomain>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net>
 <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Tue, Apr 30, 2019 at 07:21:40PM -0400, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 25 Apr 2019, SZEDER Gábor wrote:
> 
> > On Mon, Apr 22, 2019 at 05:49:01PM -0400, Jeff King wrote:
> > > On Wed, Apr 17, 2019 at 12:58:31AM -0700, Denton Liu wrote:
> >
> > > >  compat/mingw.c                    |   2 +-
> > > >  compat/mingw.h                    |   6 +-
> > > >  compat/nedmalloc/malloc.c.h       |   6 +-
> > > >  compat/obstack.h                  |  14 +-
> > > >  compat/poll/poll.h                |   2 +-
> > > >  compat/regex/regex.h              |  66 ++---
> > > >  compat/win32/pthread.h            |   8 +-
> > >
> > > We sometimes avoid touching compat/ code for style issues because it's
> > > copied from elsewhere. And diverging from upstream is more evil than a
> > > pure style issue. So potentially we could drop these hunks (though I
> > > think maybe mingw is our own thing?).
> > >
> > > >  contrib/coccinelle/noextern.cocci |   6 +
> > >
> > > I have mixed feelings on this cocci script.
> >
> > I have actual bad experience with this :)
> >
> > v4 of this patch series excluded 'compat/' from the conversion, but
> > the semantic patch is applied to 'compat/' all the same, resulting in
> > failed CI builds because of the four 'extern's in 'compat/obstack.h',
> > and will continue to do so.
> 
> Is it not possible to exclude certain directories for certain semantic
> patches?
> 
> I guess we could also simply declare that *all* Coccinelle patches should
> leave `compat/` alone, on the basis that those files are likely coming
> from some sort of upstream. But then, `compat/mingw.c` and `compat/win32/`
> seem not to fall into that category...
> 
> Ciao,
> Dscho

Deciding whether this is a good idea is above my paygrade ;)

However, if this is a good idea, we could use this patch to make it
happen:

-- >8 --
Subject: [PATCH] Makefile: filter out compat/ from coccicheck

Since most files in compat/ are pulled from external sources, ensure
that they do not get modified when we run coccicheck because we do not
want them to differ from upstream as much as possible.

Make exceptions for mingw.c and win32/*.c as these are files that we
have created and not pulled from upstream.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 9f1b6e8926..b083c038c3 100644
--- a/Makefile
+++ b/Makefile
@@ -2782,11 +2782,14 @@ check: command-list.h
 	fi
 
 C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
+COCCI_COMPAT_SOURCES = $(addprefix compat/,mingw.c win32/%)
 ifdef DC_SHA1_SUBMODULE
-COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
+COCCI_SOURCES := $(filter-out sha1collisiondetection/%,$(C_SOURCES))
 else
-COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
+COCCI_SOURCES := $(filter-out sha1dc/%,$(C_SOURCES))
 endif
+COCCI_SOURCES := $(filter-out compat/%,$(COCCI_SOURCES))
+COCCI_SOURCES += $(filter $(COCCI_COMPAT_SOURCES),$(C_SOURCES))
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	@echo '    ' SPATCH $<; \
-- 
2.21.0.1033.g0e8cc1100c

