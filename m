Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5E442021E
	for <e@80x24.org>; Mon, 31 Oct 2016 15:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbcJaP6H (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 11:58:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:36488 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754154AbcJaP5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 11:57:12 -0400
Received: (qmail 6976 invoked by uid 109); 31 Oct 2016 15:57:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Oct 2016 15:57:11 +0000
Received: (qmail 18654 invoked by uid 111); 31 Oct 2016 15:57:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Oct 2016 11:57:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Oct 2016 11:57:09 -0400
Date:   Mon, 31 Oct 2016 11:57:09 -0400
From:   Jeff King <peff@peff.net>
To:     ryenus <ryenus@gmail.com>
Cc:     Alexei Lozovsky <a.lozovsky@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [git rebase -i] show time and author besides commit hash and
 message?
Message-ID: <20161031155709.nimnuucq75kn6mau@sigill.intra.peff.net>
References: <CAKkAvazX1gDzwhQLTbRvxc84sjz72ONy2-P7qWijQUnQqJ+K8g@mail.gmail.com>
 <CALhvvbYJ8G12Lbe2FgP8PWKZ-LABcw2M-M-zWPkT12UUqq1vaw@mail.gmail.com>
 <CAKkAvay4YuRuGhub6W308+DmrZtrO3+NWu8NvfB--Mb9Z59Xzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKkAvay4YuRuGhub6W308+DmrZtrO3+NWu8NvfB--Mb9Z59Xzw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2016 at 11:27:33PM +0800, ryenus wrote:

> > It is possible to change the format globally via config option
> > rebase.instructionFormat:
> >
> >     $ git config rebase.instructionFormat "%an (%ad): %s"
> >
> > The format is the same as for 'git log'. This one outputs author
> > name, date, and the first line of commit message.
> 
> Thanks for the prompt response!
> I tried immediately, it works just as you have pointed out.
> 
> Just it seems coloring is not supported? probably because
> we're inside an editor?

Yes. If git outputs its own ANSI codes there, they generally look bad in
an editor (interpreted as raw bytes, not as coloring). Any existing
coloring you see is likely due to syntax highlighting done by your
editor. You can extend that to match your desired format, but exactly
how would depend on which editor you're using.

-Peff
