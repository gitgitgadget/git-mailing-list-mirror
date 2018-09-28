Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2CF51F453
	for <e@80x24.org>; Fri, 28 Sep 2018 17:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeI2AOl (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 20:14:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36650 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeI2AOl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 20:14:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id b7-v6so4814597pfo.3
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PGa9RM692nW/KD2W9T/Hl+SATa1DuWAEqfA8F1mJOaU=;
        b=bccrvYVd6DKf1LrUbodBQ+XGuiyesjZFgrlr6vYi96Mw6vlKMkAMdf6ffEbv71Aw93
         w6hcFER9aKW2Ka8uJ4MHierv9FRKzZD6Ramwny+R3RRRVISGrx8CSXoLiU5yjzoT2v47
         sGGsM4L96BuL6ECh4fj2EPWkbmL5Tf6BNsC/629J6m+yToH14YnxlOVjRieFv3+dWhNO
         6g8pNd3vQ+21xDtqTtkWanNm8gGEtyHbj7cH6eORdP3f7d1EJ+WEflDMBc4oSzPmVbLu
         cIStoqgHc/t01PpeU18v0ao72bIvAZDh1ZyAaC4O3+lBwLATB1Y1RgBDTTLQgiJ3lNa+
         pztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PGa9RM692nW/KD2W9T/Hl+SATa1DuWAEqfA8F1mJOaU=;
        b=XsEkT3fOVtK1+0HHVdjobgXmEpiCJFEDDEKZZ0CPnTBhkX+PqM3PFmaAB+WjOqLsgb
         GCP+CyY4wCJHyOPfhhcZG4alD6av8YLK1/Y+waBggw0NnT2U6XBld5p7f30Ru578tDj5
         ook5Li5HzZOUVbvHo/jP7onWadKpt5vbMQoYezdWfuU2NeHuCGP+IcxXFPJ3dO4IeVox
         /wVp/3RyYXzH7P7+oNLi1Vyh++Wtk1FfsGvhk21MbwAWkBHQPrYXTTEXafTXEXxQL5H7
         bLt97ZhXrt3tU/KSS/XC6pSkDp16437xQp6KqcMt9e9fmh6nAwSjLxGsG5rUU8FxPDGs
         +f/Q==
X-Gm-Message-State: ABuFfogKC3JChmrqnfLeLig7w5h+wgFrmPqTy8OGAFuUWO0gUw6/HLFY
        Ibyc2uWqNU848cgpDN1aT3sgUw==
X-Google-Smtp-Source: ACcGV63Dc341MGxuCH6Thl1/19ZRB+bnFB6bFM2i2HXjXTzW83cwOAVd0BoFZK1oAvoLVM/HEkNBeg==
X-Received: by 2002:a63:d946:: with SMTP id e6-v6mr6870990pgj.24.1538156988571;
        Fri, 28 Sep 2018 10:49:48 -0700 (PDT)
Received: from localhost ([205.175.107.157])
        by smtp.gmail.com with ESMTPSA id a15-v6sm9411291pfe.32.2018.09.28.10.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 10:49:47 -0700 (PDT)
Date:   Fri, 28 Sep 2018 10:49:46 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git help: promote 'git help -av'
Message-ID: <20180928174946.GE23652@syl>
References: <20180922174707.16498-1-pclouds@gmail.com>
 <20180924181927.GB25341@sigill.intra.peff.net>
 <xmqq4leesjdc.fsf@gitster-ct.c.googlers.com>
 <CACsJy8D1EMCqvBdxbta4oocMF33jwDf1=opXwZ0aRN7LYu=JXg@mail.gmail.com>
 <20180925174451.GA29454@duynguyen.home>
 <xmqq8t3omam8.fsf@gitster-ct.c.googlers.com>
 <20180928023724.GA89283@syl>
 <xmqqefddeg90.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefddeg90.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 09:30:51AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Wed, Sep 26, 2018 at 10:28:31AM -0700, Junio C Hamano wrote:
> >> Duy Nguyen <pclouds@gmail.com> writes:
> >>
> >> > Here's the patch that adds that external commands and aliases
> >> > sections. I feel that external commands section is definitely good to
> >> > have even if we don't replace "help -a". Aliases are more
> >> > subjective...
> >>
> >> I didn't apply this (so I didn't try running it), but a quick
> >> eyeballing tells me that the listing of external commands in -av
> >> output done in this patch seems reasonable.
> >>
> >> I do not think removing "-v" and making the current "help -a" output
> >> unavailable is a wise idea, though.
> >
> > I think that your point about having to react in a split-second in order
> > to ^C before we open the manual page for a command is a good one. So, I
> > agree with this.
>
> Responding to a wrong thread?

Ah, I certainly am. Thanks for catching my mistake :-).

> I thought "now I need ^C within a handful of deciseconds if I want
> only alias?" was not about the change to make "-v" default when
> "help -a" is asked, but about what to do with "git foo --help" that
> only gives "foo is aliased to ...".

Thanks,
Taylor
