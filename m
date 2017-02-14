Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD771FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 06:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbdBNGW6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 01:22:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:54921 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbdBNGW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 01:22:58 -0500
Received: (qmail 13531 invoked by uid 109); 14 Feb 2017 06:22:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 06:22:58 +0000
Received: (qmail 977 invoked by uid 111); 14 Feb 2017 06:22:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 01:22:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 01:22:55 -0500
Date:   Tue, 14 Feb 2017 01:22:55 -0500
From:   Jeff King <peff@peff.net>
To:     Oleg Taranenko <olegtaranenko@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Developing git with IDE
Message-ID: <20170214062255.5oumhsou7isaei7n@sigill.intra.peff.net>
References: <CABEd3j-kxA+ap7vqr85X-4HpQCvShPJUsS2Qq0BrMEK09BYS7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABEd3j-kxA+ap7vqr85X-4HpQCvShPJUsS2Qq0BrMEK09BYS7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 12:15:00AM +0100, Oleg Taranenko wrote:

> being last decade working with java & javascript I completely lost
> relation to c/c++ world. Trying to get into git internals I'm facing
> with issue what IDE is more suitable for developing git @ macos ?
> 
> Have googled, but any my search queries following to non-relevant
> themes, like supporting git in IDEs etc.
> 
> my first attempt - CLion (as far as I'm Jetbrains fan) - got failed,
> as far as doesn't support makefile-based projects, only CMake.
> 
> There are a number of free C/C++ dev tools: Xcode, CodeBlocks,
> CodeLite. Gnat, Qt creator, Dev C++, C++ Builder (Borland? :),
> Eclipse, NetBeans... what else?
> 
> Because of  lack my modern C experience, could somebody share his own
> attempts/thoughts/use cases how more convenient dive into the git
> development process on the Mac?

I think most people just use a good editor (emacs or vim), and no IDE. I
do recommend using ctags or similar (and there is a "make tags" target
to build the tags) to help with jumping between functions.

> Tried to find in the git distribution Documentation more information
> about this, nothing as well...  Would be nice to have a kind of
> 'Getting Started Manual'

There is Documentation/CodingGuidelines, but that's mostly about how to
_write_ code, not read it. Some protocols and subsystems are covered in
Documentation/technical. If you want a "big picture", I think you'd do
best to read something like:

  https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain

That talks about the system as a whole, not the code, but the layout of
the code follows the overall system design (e.g., the entry point for
the "log" command is cmd_log(), and you can see which subsystems it uses
from there).

-Peff
