Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CBB1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 20:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbdBJU5x (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 15:57:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:53168 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752874AbdBJU5w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 15:57:52 -0500
Received: (qmail 3018 invoked by uid 109); 10 Feb 2017 20:57:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 20:57:52 +0000
Received: (qmail 12294 invoked by uid 111); 10 Feb 2017 20:57:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 15:57:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2017 15:57:50 -0500
Date:   Fri, 10 Feb 2017 15:57:50 -0500
From:   Jeff King <peff@peff.net>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     git@vger.kernel.org
Subject: Re: fuzzy patch application
Message-ID: <20170210205749.c72ajnld7zjfjkwj@sigill.intra.peff.net>
References: <CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2017 at 11:20:59AM -0800, Nick Desaulniers wrote:

> I frequently need to backport patches from the Linux kernel to older
> kernel versions (Android Security).  My usual workflow for simple
> patches is:
> 
> 1. try `git am patch.txt`.

This is not exactly an answer to your question, but "git am -3" is often
a better solution than trying to fuzz patches. It assumes the patches
are Git patches (and record their origin blobs), and that you have that
blob (which should be true if the patches are based on the normal kernel
history, and you just fetch that history into your repository).

I've found that this often manages to apply patches that "git apply"
will not by itself. And I also find the resulting conflicts to be much
easier to deal with than patch's ".rej" files.

-Peff
