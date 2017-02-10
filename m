Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E4E61FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 21:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbdBJVsy (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 16:48:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:53277 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750874AbdBJVsx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 16:48:53 -0500
Received: (qmail 6930 invoked by uid 109); 10 Feb 2017 21:48:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 21:48:53 +0000
Received: (qmail 13072 invoked by uid 111); 10 Feb 2017 21:48:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 16:48:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2017 16:48:51 -0500
Date:   Fri, 10 Feb 2017 16:48:51 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: fuzzy patch application
Message-ID: <20170210214850.2ok62xdmemgotwnt@sigill.intra.peff.net>
References: <CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com>
 <20170210205749.c72ajnld7zjfjkwj@sigill.intra.peff.net>
 <CAGZ79kaG=oqDM=1+rz_zk6Qn-7wAszxPnBtqrkAJS29_qT7SoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaG=oqDM=1+rz_zk6Qn-7wAszxPnBtqrkAJS29_qT7SoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2017 at 01:37:12PM -0800, Stefan Beller wrote:

> > This is not exactly an answer to your question, but "git am -3" is often
> > a better solution than trying to fuzz patches. It assumes the patches
> > are Git patches (and record their origin blobs), and that you have that
> > blob (which should be true if the patches are based on the normal kernel
> > history, and you just fetch that history into your repository).
> >
> > I've found that this often manages to apply patches that "git apply"
> > will not by itself. And I also find the resulting conflicts to be much
> > easier to deal with than patch's ".rej" files.
> 
> I have been told this a couple of times before; do we want to make -3
> the default (in 2.13 then) ?

I dunno. I always use it, but I'm not sure if there are any downsides,
aside from a little extra processing time. It does have some
incompatibilities with other options. And I think it kicks in rename
detection (but I might be mis-remembering another feature). That could
be surprising, I guess.

The original dates all the way back to 47f0b6d5d (Fall back to three-way
merge when applying a patch., 2005-10-06), but I don't see any rationale
for not making it the default. Junio probably could give a better
answer.

-Peff
