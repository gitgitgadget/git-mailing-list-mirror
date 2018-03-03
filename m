Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07BAD1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 06:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeCCGCU (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 01:02:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:45380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750924AbeCCGCT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 01:02:19 -0500
Received: (qmail 8496 invoked by uid 109); 3 Mar 2018 06:02:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 06:02:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3584 invoked by uid 111); 3 Mar 2018 06:03:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 01:03:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 01:02:16 -0500
Date:   Sat, 3 Mar 2018 01:02:16 -0500
From:   Jeff King <peff@peff.net>
To:     Sam Kuper <sam.kuper@uclmail.net>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: "Use of uninitialized value $_ in print"
Message-ID: <20180303060215.GI27689@sigill.intra.peff.net>
References: <CAD-Jur+6m1SjqHVWBxW5HnTjutSVrkP+dEXdYmFHzoUf0FGdNA@mail.gmail.com>
 <20180302104232.GA11074@sigill.intra.peff.net>
 <CAD-JurJLDSzf7_A0ZGWPYGyRiSnHWSpUrVEd9_+N1J7BamMM=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD-JurJLDSzf7_A0ZGWPYGyRiSnHWSpUrVEd9_+N1J7BamMM=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 02, 2018 at 05:30:28PM +0000, Sam Kuper wrote:

> On 02/03/2018, Jeff King <peff@peff.net> wrote:
> > Unfortunately, I don't think there's an easy way to do what you want
> > (show word-diffs but apply the full diff).
> 
> Oh :(
> 
> That would be a *very* useful feature to have, especially where
> multiple small (e.g. single character or single word) changes are
> sprinkled throughout a large file.

You might want to try diff-highlight from Git's contrib/ directory. It
was the reason I added interactive.diffFilter in the first place. E.g.:

  cd contrib/diff-highlight
  make
  cp diff-highlight /to/your/$PATH
  git config --global interactive.diffFilter diff-highlight

It's not quite the same as a word-diff, because it doesn't find matches
across word boundaries. So if you re-wrap a paragraph, for example, it
won't be much help. But I do find it useful (and also as a general
filter for log and diff output).

> Should I start a separate thread for this as a feature request?

I think this thread can serve.

-Peff
