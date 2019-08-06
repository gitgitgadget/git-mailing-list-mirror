Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB871F731
	for <e@80x24.org>; Tue,  6 Aug 2019 23:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfHFXNe (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 19:13:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38367 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfHFXNe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 19:13:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so38437321plb.5
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VLmzMO5RMK8iJAYaUFHdZtqYJQNTwCTwaaJoBgFVQrs=;
        b=TD92VfPHw9JCN/LQwq5wRNqYnYhjYTnlwJjeN2kfxNo1mYguEFMcYfVRaMY9WYaT4o
         lNmZOf2pQ0MGyPlfq3SVdi+gQ0QDl17rIKydYWPr7fgNlFfU/12MwNEQYC2KDgDfjZo7
         icfdUfgUoRoaIhZj8a99oYLT6wlWnykNNbJwJO2en5Da7KJ3SxZ3U/6NBddIGU6j1DvY
         GoLtvGcHA0cBe2uL3D4O6b4lFOv7dUmqQzJ2/WOakj3/Vr7CRSNEJG+zMk/YJarKTlx8
         njqI47TOYU4NuQ0gL/1gqx5L8fZFDP5TZhhkhz2Wrcyv7ck0uh7vSJ278/SfUTseZqAi
         C5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VLmzMO5RMK8iJAYaUFHdZtqYJQNTwCTwaaJoBgFVQrs=;
        b=Tzp4DK5NL+YWQjhjYhcASSiqWR5K/jOnesn3dR4dRX1R4LIzx6bWK+Wf6GRmbTJhr8
         WZTEVY7EaPjkviXnlopVrCTQL+uC0zFsgQzJfieHc6y66l1/+gF0yhMVJQThDUu0ImIM
         LHRuUPnWRNw8eXcopfuorgIbGIGd3YB+TmfhUXbMMb3fgMLdxGtnS+gcm4rN48KLxx0w
         So955NEX3r4KFiHvhyaIy7pGzJUqBfA0ccDP3WhMkZVSggfD2u/QMes/hOSbvfa9dnv6
         hyoEcHIdEWiCyvl0zhhfASZ9ojksx2jTPQZU96HadJgFqbsy66ntSLEuGE8SS8gg6qtr
         6jrg==
X-Gm-Message-State: APjAAAUz92SSypn+vOAeUc/fedqiK51/jUQ/cR+nSmMmWvBlLQvpXPcS
        Fi+CACVbtKlxDY6Pshs7w3UJCgkZl98pdA==
X-Google-Smtp-Source: APXvYqwu2P16q9GyICCmp8uLAHX5Z6tU3siZybA+uh++tvcAeTin/VcWpjnqlBZvTNiplIsrEgGluQ==
X-Received: by 2002:a17:902:b905:: with SMTP id bf5mr5016657plb.342.1565133213616;
        Tue, 06 Aug 2019 16:13:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id n98sm20712625pjc.26.2019.08.06.16.13.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 16:13:32 -0700 (PDT)
Date:   Tue, 6 Aug 2019 16:13:28 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v3 00/13] example implementation of revwalk tutorial
Message-ID: <20190806231328.GB130824@google.com>
References: <20190701201934.30321-1-emilyshaffer@google.com>
 <20190701202014.34480-1-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1907251122260.21907@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907251122260.21907@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 25, 2019 at 11:25:02AM +0200, Johannes Schindelin wrote:
> Hi Emily,
> 
> On Mon, 1 Jul 2019, Emily Shaffer wrote:
> 
> > Since v2, mostly reworded comments, plus fixed the issues mentioned in
> > the tutorial itself. Thanks Eric for the review.
> >
> > Emily Shaffer (13):
> >   walken: add infrastructure for revwalk demo
> >   walken: add usage to enable -h
> >   walken: add placeholder to initialize defaults
> >   walken: add handler to git_config
> >   walken: configure rev_info and prepare for walk
> >   walken: perform our basic revision walk
> >   walken: filter for authors from gmail address
> >   walken: demonstrate various topographical sorts
> >   walken: demonstrate reversing a revision walk list
> >   walken: add unfiltered object walk from HEAD
> >   walken: add filtered object walk
> >   walken: count omitted objects
> >   walken: reverse the object walk order
> >
> >  Makefile         |   1 +
> >  builtin.h        |   1 +
> >  builtin/walken.c | 297 +++++++++++++++++++++++++++++++++++++++++++++++
> 
> Since this is not really intended to be an end user-facing command, I
> think it should not become a built-in, to be carried into every Git
> user's setup.

It's not intended to be checked into Git source as-is.

> 
> Instead, I would recommend to implement this as a test helper.

I'm not sure I follow how you imagine this looking, but the drawback I
see of implementing this in a different way than you would typically do
when writing a real feature for the project is that it becomes less
useful as a reference for new contributors.

> 
> This would have the following advantages:
> 
> - it won't clutter the end user installations,
> 
> - it will still be compile-tested with every build (guaranteeing that
>   the tutorial won't become stale over time as so many other tutorials),

This part of your suggestion appeals to me; so I'm really curious how
you would do it. Do you have something else written in the way you're
suggesting in mind?

> 
> - it really opens the door very wide to follow up with another tutorial
>   to guide new contributors to write stellar regression tests.
> 
> Thanks,
> Dscho
> 
> >  git.c            |   1 +
> >  4 files changed, 300 insertions(+)
> >  create mode 100644 builtin/walken.c
> >
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
> >
> >
