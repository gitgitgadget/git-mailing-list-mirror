Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13E320401
	for <e@80x24.org>; Fri, 16 Jun 2017 04:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbdFPEbk (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 00:31:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:41240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbdFPEbj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 00:31:39 -0400
Received: (qmail 19103 invoked by uid 109); 16 Jun 2017 04:31:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 04:31:39 +0000
Received: (qmail 32342 invoked by uid 111); 16 Jun 2017 04:31:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 00:31:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jun 2017 00:31:37 -0400
Date:   Fri, 16 Jun 2017 00:31:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Scott Baker <scott@perturb.org>
Subject: Re: [PATCH] diff-highlight: split code into module
Message-ID: <20170616043137.xqgxpnop2svqe6io@sigill.intra.peff.net>
References: <20170615163055.b63hcivjogafkerq@sigill.intra.peff.net>
 <xmqqpoe512rc.fsf@gitster.mtv.corp.google.com>
 <xmqqlgot12o4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgot12o4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2017 at 12:17:15PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >>  contrib/diff-highlight/.gitignore                  |  2 ++
> >>  .../{diff-highlight => DiffHighlight.pm}           | 40 +++++++++++++---------
> >>  contrib/diff-highlight/Makefile                    | 21 ++++++++++--
> >>  contrib/diff-highlight/README                      | 30 ++++++++++++++++
> >>  contrib/diff-highlight/diff-highlight.perl         |  8 +++++
> >>  5 files changed, 82 insertions(+), 19 deletions(-)
> >>  create mode 100644 contrib/diff-highlight/.gitignore
> >>  rename contrib/diff-highlight/{diff-highlight => DiffHighlight.pm} (91%)
> >>  mode change 100755 => 100644
> >>  create mode 100644 contrib/diff-highlight/diff-highlight.perl
> >
> > Do you want +x bit for the last one?  I could throw that bit in
> > while queuing if you want.
> 
> Ah, I do not think you want it, as this is not something to be
> executed as-is (it is a source file, which diff-highlight that is
> executable is made out of).

Yes, exactly. Although many of our .sh files, though generally
"compiled" with the Makefile, still have the executable bit. I don't
mind adding it if we'd rather follow that pattern in general.

-Peff
