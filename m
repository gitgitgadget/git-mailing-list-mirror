Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BD261F463
	for <e@80x24.org>; Thu, 26 Sep 2019 17:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfIZRiF (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 13:38:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46161 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZRiF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 13:38:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so1900679pgm.13
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hlIor1IDQ9oKNhLyvgzuF/R+FcpMmpVD8xkgDP0FyJ4=;
        b=kJ0eHRp3C9/6iR8fT0/0PpoYIlHJ8q9t+IXc0z7HEY/HUZkwq4/d1E+/jnM8icgJ0L
         I877bSM2vuT3dJ8Ri6i0Ye2pRba8/prKSEaYR8PJltJMfyNn2oZ6iteJ0OiW9pSfoCV3
         +HPth198PUBPl/eOPYd7J4X8MQVFF+JmfLNbz40Quyvt2sz4doFA/1HUqSv5+niOU/El
         GnRPRJC9+Q8uVlrp63RnQiIjFtlwRTKebpN4qpmXK/GcuUpi+Fzz0VqKeENr6d5QHO8K
         ybiwSFwBrqYB7ktja6hOo/N425kpkWAnRsvaucy1/uythWU+SV5Y6c8ZLYYG8+PNIAzj
         9lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hlIor1IDQ9oKNhLyvgzuF/R+FcpMmpVD8xkgDP0FyJ4=;
        b=cG++hXaa7z2QgVIsbuxqYbJRK7+igoNQylo8v77TITsuib6OQ0qsM0g2uLiwQX9g0m
         PQr9mJpH3TN4Rue9A17eGyBgk7AtUlirgBs/35WyEKNR90z3XdIYU1MHd/2oHgT95j/O
         gIZcT1QymcKObR3XeVzkvYAFqWY20cFnZyaK3ygKn8W8PXaXTYwpHTXoaijPwLyHZK/8
         SLfJ0ApDfTPE6i+N/niBmVzid1xan+vuccKbiP0yFTQ4+G9bHaMCAP58XZ5/FSWNiFya
         RPmXWvs1gY8Q24OVqLf/M16RhuLZ2Pprsq4qVr9ZuplsXZAF8b7L3XGZ3pjqSIcz2Obn
         hisQ==
X-Gm-Message-State: APjAAAWD3d+Y+hpy/Fy6IgcPbR1bVnmH3zQHedaxTPn81d9SRs5Ax2Bz
        OFZVGzoYk9S/0qzx7eRUZ1I=
X-Google-Smtp-Source: APXvYqy/t+DKBd00ZcTjzkmn1kaHk8ylHmzvOs5xsopVsU8VjHMACAby4wqX+apXrY4w1wok6kOQgQ==
X-Received: by 2002:a63:7b58:: with SMTP id k24mr4609068pgn.138.1569519484350;
        Thu, 26 Sep 2019 10:38:04 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id p68sm6660150pfp.9.2019.09.26.10.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:38:03 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:38:01 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] Makefile: use $(ALL_CFLAGS) in $(HCO) target
Message-ID: <20190926173801.GA42456@generichostname>
References: <cover.1569263631.git.liu.denton@gmail.com>
 <0336d1345abfef563d9228e250316cc58a01f2b3.1569263631.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.1909261449230.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909261449230.15067@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Sep 26, 2019 at 02:49:55PM +0200, Johannes Schindelin wrote:
> Hi Denton,
> 
> On Mon, 23 Sep 2019, Denton Liu wrote:
> 
> > On platforms that can run `make hdr-check` but require custom flags,
> > this target was failing because none of them were being passed to the
> > compiler. For example, on MacOS, the NO_OPENSSL flag was being set but
> > it was not being passed into compiler so the check was failing.
> >
> > Pass $(ALL_CFLAGS) into the compiler for the $(HCO) target so that these
> > custom flags can be used.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index f879697ea3..d8df4e316b 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2773,7 +2773,7 @@ CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
> >  HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
> >
> >  $(HCO): %.hco: %.h FORCE
> > -	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
> > +	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $(ALL_CFLAGS) $<
> 
> Isn't this essentially identical to what I sent in
> https://public-inbox.org/git/pull.129.git.gitgitgadget@gmail.com/
> ?

Whoops, didn't notice this. I heard there's some quote about great minds
or something ;).

Anyway, this patch is superceded by v2 4/4 which should emulate the
compilation process even better, as suggested by Peff. The only problem
with that patch is that it splashes temporary *.hcc files everywhere but
I think that if it's only a developer-run target, it should be fine.

Thanks,

Denton

> 
> Ciao,
> Dscho
> 
> >
> >  .PHONY: hdr-check $(HCO)
> >  hdr-check: $(HCO)
> > --
> > 2.23.0.565.g1cc52d20df
> >
> >
