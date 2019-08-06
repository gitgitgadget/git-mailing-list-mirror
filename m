Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB9D1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 13:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfHFNU5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 09:20:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:35262 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728582AbfHFNUx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 09:20:53 -0400
Received: (qmail 16889 invoked by uid 109); 6 Aug 2019 13:20:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 13:20:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1696 invoked by uid 111); 6 Aug 2019 13:23:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 09:23:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 09:20:52 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC - Git Developer Blog
Message-ID: <20190806132052.GB18442@sigill.intra.peff.net>
References: <20190806014935.GA26909@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190806014935.GA26909@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 05, 2019 at 06:49:35PM -0700, Emily Shaffer wrote:

> Are folks interested in writing and reviewing this kind of content? Any
> ideas for where we may be able to host (maybe git-scm)?

I think it would make sense to have blog.git-scm.com (and .org) with
this content. I'd be happy to deal with the technical side of setting
the name up. I think it should live in a different repository than the
main site, though (which is an overly-messy Rails app).

There actually used to be a blog section on the site. It discussed
various high-level concepts that hadn't made it into the Pro Git book
(whose content makes up most of the site). But as most of those were
eventually added to the book, the blog posts became staler versions of
the same content, and we dropped them.

Just to play devil's advocate for a moment: another venue for topics
like these:

>  - Using `git worktree` Effectively
>  - Overview of the Git Object Store
>  - Finding Regressions with `git bisect`
>  - Life of a Git Remote Request

might be to actually add them to the book (which started as a
single-author publication, but is CC-licensed and has taken lots of
community content over the years). The advantage there is that the book
content would always represent the most up-to-date coverage of those
topics, whereas blog posts sometimes grow stale over the years as nobody
is interested in updating them.

One downside is that it may be more annoying to try to integrate content
into the existing structure of the book. Another is that a blog is
something people subscribe to, so a post may generate attention/interest
in a topic (but nobody wants to see a feed of book updates!). A prime
example is something like a highlight of features after a new release,
which is not book content at all, and just serves to generate attention.
:)

So I don't think I'm really seriously suggesting this as an alternative,
but maybe something to ponder.

> It could make sense to review contributions like this on the mailing
> list, so that we get the attention of those who wrote the features
> that are being covered in the blog posts - are we okay with the
> additional traffic?

Additional traffic is fine. I do suspect that blog posts in particular
would benefit from a more integrated review system like GitHub (or
similar):

  - I'd expect there to be a lot of images, and those systems make
    image diffs easy to see

  - the formatted output is going to be important to review; a
    browser-based review system makes it easier to see the formatted
    output (especially if they're written in markdown)

  - we're more likely to get/want drive-by fixes like typo corrections,
    so reducing friction for non-regular contributors is more important

Obviously you can apply many of the same mailing list vs web review
arguments that we've already had for writing Git itself (e.g., is
reviewing formatted output much different than looking at the output of
a compiled program?). But I think the nature of blog posts pushes it a
bit further towards web-based review.

-Peff
