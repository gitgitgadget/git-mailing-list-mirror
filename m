Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713A5C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjCUSRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjCUSRI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:17:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8A652F58
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:17:04 -0700 (PDT)
Received: (qmail 28456 invoked by uid 109); 21 Mar 2023 18:17:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 18:17:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2693 invoked by uid 111); 21 Mar 2023 18:17:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 14:17:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 14:17:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] doc: remove GNU troff workaround
Message-ID: <20230321181702.GI3119834@coredump.intra.peff.net>
References: <20230320190047.79836-1-felipe.contreras@gmail.com>
 <20230321173206.GC3119834@coredump.intra.peff.net>
 <xmqqcz52hu7n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz52hu7n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 10:47:56AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'd think 13 years is probably long enough, but I was curious about the
> > versions. You referenced the fix here:
> >
> >> [6] https://github.com/docbook/xslt10-stylesheets/commit/fb553434265906ed81edc6d5f533d0b08d200046
> >
> > but the earliest tag in that repository that contains that commit is
> > 1.79.1 from 2016. However, it seems like that repo is oddly missing
> > older tags. You mentioned 1.76 earlier, and the changelog for the Debian
> > package of docbook-xsl mentions the 1.76 release fixing it in 2010.
> 
> I wondered about the same thing, and did some digging myself
> yesterday.  The commit seems to have been merged to their 'master'
> branch with the commit 0418c172 (Merge branch 'master' of
> ../docbook-fixed, 2015-09-20), which is after a curious 5 year gap.

I suspect they were not using Git back then, and these commits were
later imported, which may have caused some of our confusion (searching
for docbook 1.76 shows releases on SourceForge, which implies a non-Git
VCS).

The announcement of 1.76.0 in 2010 mentions a fix for the apostrophe
issue:

  https://lists.oasis-open.org/archives/docbook-apps/201009/msg00023.html

> > So assuming the fix really was released in 2010, even long-running
> > distros like CentOS probably would have picked it up within a few years,
> > and our workaround should definitely be obsolete by now.
> 
> ... even if the fixed release was done in 2016, I would say that it
> shouldn't be too recent, especially for documentation where we still
> give preformatted ones (which I think about dropping once every few
> years).

I could believe that some people are still stuck on 2016-era versions of
dependencies, but yeah, I agree we can be a little more cavalier with
documentation. Anyway, I think the right date really is 2010, as above.

-Peff
