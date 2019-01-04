Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A74A1F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 08:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfADIpH (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 03:45:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:54470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725931AbfADIpG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 03:45:06 -0500
Received: (qmail 28091 invoked by uid 109); 4 Jan 2019 08:45:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 04 Jan 2019 08:45:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16132 invoked by uid 111); 4 Jan 2019 08:44:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 04 Jan 2019 03:44:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2019 03:45:04 -0500
Date:   Fri, 4 Jan 2019 03:45:04 -0500
From:   Jeff King <peff@peff.net>
To:     Charles Kerr <kerr262@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git clone on page 44 of progit-en.1084.pdf (2nd try)
Message-ID: <20190104084504.GC26014@sigill.intra.peff.net>
References: <CABMGpwQ5psB0DGJkWSbczAj+cTKXdsJ+cR6YbQhJpZMQZOHNrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABMGpwQ5psB0DGJkWSbczAj+cTKXdsJ+cR6YbQhJpZMQZOHNrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 03, 2019 at 04:43:32PM -0800, Charles Kerr wrote:

> I am an easily-derailed newbie reading chapter 2 of progit-en.1084.pdf

Sort of orthogonal to your question, but I think this is a slightly
older version of the book.  Note that it's constantly undergoing
revisions, and the latest version can always be gotten from:

  https://github.com/progit/progit2/releases

(or https://git-scm.com/book, which is updated daily from that
repository).

The content in question is on page 26 in the most recent version, or
here in the web version:

  https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository

Now, on to your actual questions...

> (1) On page 44 of my copy, where it first discusses git clone, there's
> reference to a "linkable library".  How does this relate to
> "repository".  I thought the aim here was to get a clone of a remote
> repository....

That is the aim. They just needed a sample repository to talk about, so
they used the libgit2 repository as an example. And that repository
holds code for a linkable library, but what it holds is not really
important for the example.

I think it would be more clear if the example used some name that was
more obviously an example repository (or even say, the repository for
git itself, which is easy to explain).

> (2) In each of the two example git-clone commands, the "libgit2" appears twice:
> 
> git clone https://github.com/libgit2/libgit2

Right. On GitHub, there is a "libgit2" organization (for all work around
that library), which in turn has a repository named "libgit2" with the
actual library code (other repositories are things like bindings, etc).

But the "user/repo" convention is a GitHub thing (that is also used by
other hosting sites). Git only cares about what's in the final part of
the URL (and even then, only to choose a default directory name for the
local clone).

> What did make sense to me and worked:
> 
> $ git clone https://github.com/komwomak/shtoza SNOW
> 
> My  GitHub user name: komwomak
> The name of the remote repository out on my GitHub stuff: shtoza
> The name of the local repository on the PC: SNOW
>
> I would appreciate knowing whether I have gotten the wrong end of some stick.

I think you understand it perfectly. If you're interested in suggesting
an improvement to the book, you can open an issue or a pull request at
the progit/progit2 repository I linked above.

-Peff
