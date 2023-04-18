Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04986C7EE25
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 09:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjDRJDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjDRJDX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 05:03:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9F6580
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 02:03:15 -0700 (PDT)
Received: (qmail 3935 invoked by uid 109); 18 Apr 2023 09:03:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 09:03:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32473 invoked by uid 111); 18 Apr 2023 09:03:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 05:03:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 05:03:10 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH] doc: remove custom callouts format
Message-ID: <20230418090310.GA414708@coredump.intra.peff.net>
References: <20230418011828.47851-1-felipe.contreras@gmail.com>
 <20230418040034.GC60552@coredump.intra.peff.net>
 <643e2aeae0515_217cdb29473@chronos.notmuch>
 <20230418061713.GA169940@coredump.intra.peff.net>
 <643e43824a220_21b043294f8@chronos.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <643e43824a220_21b043294f8@chronos.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 01:15:14AM -0600, Felipe Contreras wrote:

> Have you looked at the HTML output with asciidoc-py? It has the same
> indentation problem you spotted in the manpages.
> 
> I don't see it in git-scm.com, but I presume that documentation there is
> generated with asciidoctor.

I hadn't looked at it, but yeah, I see it has the same issue. That makes
sense, since the XML output from asciidoc was wrong (and our xslt was
papering over it for the manpage build).

And yes, the pages no git-scm.com are built with asciidoctor.

> > So I'd prefer the open block.
> 
> What if I add a proper title?
> 
>     === 2. Merge

From the perspective of somebody skimming through the examples, that
doesn't seem to help much. But I'm not sure if there _is_ a succinct and
descriptive title for each of those examples (or at least I could not
easily come up with one, which is why I didn't offer a suggestion).

> It's not something that's probably going to be used in practice, but to me it
> makes total semantic sense to have big chunks of prose in a section of its own.
> 
> Having a huge list item on the other hand does not make sense, it would be like
> having a list item that spans more than one page of a book.

We may have to agree to disagree on that. But this is exactly why I
suggested doing the syntactic fix first, rather than reorganizing. Once
the fix is done, then there can be a separate discussion on reorganizing
(which, frankly, I don't really have much interest in either way; I gave
my opinion and I don't have anything else to say).

-Peff
