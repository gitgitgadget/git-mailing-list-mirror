Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ADC31F42D
	for <e@80x24.org>; Thu, 10 May 2018 07:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756653AbeEJHLG (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 03:11:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:34440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756582AbeEJHLF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 03:11:05 -0400
Received: (qmail 22385 invoked by uid 109); 10 May 2018 07:11:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 07:11:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21139 invoked by uid 111); 10 May 2018 07:11:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 03:11:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 03:11:03 -0400
Date:   Thu, 10 May 2018 03:11:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] doc: cleaning up instances of \--
Message-ID: <20180510071103.GC31779@sigill.intra.peff.net>
References: <CAN0heSru4-VoCTxZ6OHU_jdTs0__xvRmd45Dd0H3L8apMKkW6w@mail.gmail.com>
 <cover.1523991648.git.martin.agren@gmail.com>
 <xmqq1sfdjg4o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1sfdjg4o.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 18, 2018 at 01:24:55PM +0900, Junio C Hamano wrote:

> Martin Ågren <martin.agren@gmail.com> writes:
> 
> > This is a patch series to convert \-- to -- in our documentation. The
> > first patch is a reiteration of 1c262bb7b2 (doc: convert \--option to
> > --option, 2015-05-13) to fix some instances that have appeared since.
> > The other three patches deal with standalone "\--" which we can't
> > always turn into "--" since it can be rendered as an em dash.
> 
> All looked sensible.  As you mentioned in [2/4], "\--::" that is
> part of an enumulation appear in documentation for about a dozen
> commands after the series, but I do not think we can avoid it.
> 
> One thing that makes me wonder related to these patches is if a
> newer AsciiDoc we assume lets us do without {litdd} macro.  This
> series and our earlier effort like 1c262bb7 ("doc: convert \--option
> to --option", 2015-05-13) mentions that "\--word" is less pleasant
> on the eyes than "--word", but the ugliness "two{litdd}words" has
> over "two--words" is far worse than that, so...

I think many cases that use {litdd} would be better off using literal
backticks anyway (e.g., git-add.txt mentions the filename
`git-add--interactive.perl`).

There are certainly a few that can't, though (e.g., config.txt uses
linkgit:git-web{litdd}browse[1]).  I agree that "\--" is less ugly there
(and seems to work on my modern asciidoc). There's some history on the
litdd versus "\--" choice in 565e135a1e (Documentation: quote
double-dash for AsciiDoc, 2011-06-29). That in turn references the
2839478774 (Work around em-dash handling in newer AsciiDoc, 2010-08-23),
but I wouldn't be surprised if all of that is now obsolete with our
AsciiDoc 8+ requirement.

-Peff

PS Late review, I know, but the patches look good to me. :)
