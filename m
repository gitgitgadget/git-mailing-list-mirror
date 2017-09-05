Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A082208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 17:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbdIERDP (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 13:03:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:57590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751934AbdIERDO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 13:03:14 -0400
Received: (qmail 19248 invoked by uid 109); 5 Sep 2017 17:03:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 17:03:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15118 invoked by uid 111); 5 Sep 2017 17:03:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 13:03:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 13:03:12 -0400
Date:   Tue, 5 Sep 2017 13:03:12 -0400
From:   Jeff King <peff@peff.net>
To:     Ross Kabus <rkabus@aerotech.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] commit-tree shouldn't append an extra newline to commit
 messages
Message-ID: <20170905170311.yhcksrw2bxevd3hk@sigill.intra.peff.net>
References: <CAEVs+za9do_wXC12SSRznF9v9oGw3_Grq2EFDVf8nH1CRgM-Qw@mail.gmail.com>
 <20170902083319.lcugfpkkk5lahieb@sigill.intra.peff.net>
 <CAEVs+zbbWQuM-=5d04bkpTu38Mr4PyczskNhni5K1u_nzh-2Qw@mail.gmail.com>
 <20170905153636.tsmlq3wv7ztpc67z@sigill.intra.peff.net>
 <CAEVs+zbCj0Zv0t4_WG6y2jcLoXwHy-Mu-LH31c_QgFaE9i3HtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEVs+zbCj0Zv0t4_WG6y2jcLoXwHy-Mu-LH31c_QgFaE9i3HtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 12:57:21PM -0400, Ross Kabus wrote:

> On Tue, Sep 5, 2017 at 11:36 AM, Jeff King <peff@peff.net> wrote:
> 
> > So I'd argue that "git commit -F" is doing a reasonable
> > thing, and "commit-tree -F" should probably change to match it (because
> > it's inconsistent, and because if anything the plumbing commit-tree
> > should err more on the side of not touching its input than the porcelain
> > commit command).
> 
> I would agree that "commit-tree -F" should change to match the behavior of
> "git commit -F --cleanup=verbatim". I feel pretty strongly that this type of
> cleanup logic shouldn't be done in a plumbing command, though I'm not sure
> it is a big enough deal to change behavior/compatibility for everyone.

OK. Do you want to try your hand at a patch?

> Yup, confusion #2. I was using "-F -" which I see now is a different code
> path. Reading via stdin without "-F -" _is_ the verbatim option. This
> difference burned someone else on the mailing list as well. See:

Ah, OK, your confusion makes more sense now.

-Peff
