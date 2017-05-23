Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21B220281
	for <e@80x24.org>; Tue, 23 May 2017 17:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967751AbdEWRfZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 13:35:25 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36705 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937107AbdEWRfX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 13:35:23 -0400
Received: by mail-pf0-f176.google.com with SMTP id m17so121177251pfg.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EWSG9tD8FzjQL+EsYW82hZf8MFYGy8tVQJZ+8U0594g=;
        b=KhVOkxCoD+dp3snj6fAewK5ESz++Rve1/aobdsU1ZreI5gHAObqjuadGKTjfCN/+zo
         BJpuV0f6F6IBhWfHXcx3e4lwAvZF82LA/e1HX/Prucj6NK8FMmdP2diSnjyDQO279aoT
         Zu2LU8mx+iS5O4vFntJmkRHtGCGH3/gnLgM6JoYG2I0x8/xmJkUBVUnuItqAZn0LE8G+
         aJbCfv0kHoYghRGZQB4A1kPDSw2qyLUkhjSa/L1y7i3R2qJjemI44PDqLF2MMh2ATPPi
         GmjrPN/TsKY1BVKQ7FuVwmI9sfwUaETG4HvW02X/YHOWpx0Pt05kms+FYRlpjret0/Ih
         4Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EWSG9tD8FzjQL+EsYW82hZf8MFYGy8tVQJZ+8U0594g=;
        b=GhS42BvuQJOPzyv6agAvI/OTXti7Hv5J+55P/xKNT3DLJ91ds8EJDxMipJB9jb4ehG
         ucmnMnmn6Z1kQlORf40HL8uA2pRQuOqsrPl9pcKL4oaU+HXMwdmZwJJAgxlXHG2TDnPt
         fKqVlZHKhdVJaSFr1LkuoF+M/VDDl+djlrKkwNAHW8FGzmwgBYGZhUmWdTUMiI+MDWO3
         2UudWfx2YaJHsaZDptBX6nVckdluAIHR7aAV7crukNbNGvsF9LrqCgyPP2lsD0SLnfoY
         PsiegP3WW6oUzBZdQJ7FvqZf7Kipay/PHSxHQhHKEsIku2XugFaXWMmlmXQAEXIKPIpS
         2a/A==
X-Gm-Message-State: AODbwcCE/DEip5u0g/BSm5VCLyerOvb9ozTrPI6PESy+9Ybnnxj4Q2X/
        0Em/sPqSacVguvfa
X-Received: by 10.98.209.65 with SMTP id t1mr32734226pfl.132.1495560912293;
        Tue, 23 May 2017 10:35:12 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6539:887d:745f:6fdf])
        by smtp.gmail.com with ESMTPSA id b1sm3502303pfc.27.2017.05.23.10.35.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 10:35:11 -0700 (PDT)
Date:   Tue, 23 May 2017 10:35:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [WIP/RFC 17/23] repo: introduce new repository object
Message-ID: <20170523173509.GC115919@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
 <20170518232134.163059-18-bmwill@google.com>
 <CAGZ79kZoCkrF_ruzkpULQVSZ7=WEgFP+8PcgDhacWBh7ZCac5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZoCkrF_ruzkpULQVSZ7=WEgFP+8PcgDhacWBh7ZCac5Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/20, Stefan Beller wrote:
> On Thu, May 18, 2017 at 4:21 PM, Brandon Williams <bmwill@google.com> wrote:
> > Introduce 'struct repo' an object used to represent a repository.
> 
> Is this the right place to outline what you expect from a repo object?
> Are you planning to use it everywhere?
> Is it lazy-init'd and it takes care of it itself, or would the caller
> have to take
> care of the state of the repo? ("the repo object is just a place to put the
> current globals")

Those are all great questions, questions that I don't think I have all
the answers for right now.  Since this is still in the idea phase I'm
hoping to hear what other people think this would look like in an ideal
world.  I don't think everything would need to be lazy-init'd or can
easily be done that way.  At least the index stuff isn't set up to
be able to do that.  I can see the config being lazy-init'd in one way
or another, though that would require passing in a repo object instead
of a config-set when you want to look-up a config value (which is
probably very reasonable) that way the config-set stored in the repo
object can be properly initialized.

> 
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  Makefile |  1 +
> >  repo.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  repo.h   | 15 +++++++++++++++
> >  3 files changed, 58 insertions(+)
> >  create mode 100644 repo.c
> >  create mode 100644 repo.h
> >
> > diff --git a/Makefile b/Makefile
> > index e35542e63..a49d2f96a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -821,6 +821,7 @@ LIB_OBJS += refs/ref-cache.o
> >  LIB_OBJS += ref-filter.o
> >  LIB_OBJS += remote.o
> >  LIB_OBJS += replace_object.o
> > +LIB_OBJS += repo.o
> >  LIB_OBJS += rerere.o
> >  LIB_OBJS += resolve-undo.o
> >  LIB_OBJS += revision.o
> > diff --git a/repo.c b/repo.c
> > new file mode 100644
> > index 000000000..d47e98d95
> > --- /dev/null
> > +++ b/repo.c
> > @@ -0,0 +1,42 @@
> > +#include "cache.h"
> > +#include "repo.h"
> > +
> > +int
> > +repo_init(struct repo *repo, const char *gitdir, const char *worktree)
> 
> style ;)

Darn, I forgot to change this before sending out.  An easy fix, though I
still like this style better :P

> 
> 
> > +       /* Maybe need a check to verify that a worktree is indeed a worktree? */
> 
> add NEEDSWORK/FIXME prefix to comment?
> 
> > +void
> > +repo_clear(struct repo *repo)
> 
> style ;)

-- 
Brandon Williams
