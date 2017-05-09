Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C49C1FC44
	for <e@80x24.org>; Tue,  9 May 2017 03:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbdEID1e (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 23:27:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:47860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754928AbdEID1d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 23:27:33 -0400
Received: (qmail 13643 invoked by uid 109); 9 May 2017 03:27:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 03:27:32 +0000
Received: (qmail 19395 invoked by uid 111); 9 May 2017 03:28:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 23:28:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 23:27:29 -0400
Date:   Mon, 8 May 2017 23:27:29 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Marc Branchaud <marcnarc@xiplink.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 0/4] Make diff plumbing commands respect the
 indentHeuristic.
Message-ID: <20170509032729.bhq6ui23c3p6oyz3@sigill.intra.peff.net>
References: <f867af6f-b601-251a-86a4-ede0bb942efb@xiplink.com>
 <20170508160339.4551-1-marcnarc@xiplink.com>
 <CAGZ79kbLKQ0jS0xfQO1MSp5T2_m9dShx0oYeTDAjDdUcydm3uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbLKQ0jS0xfQO1MSp5T2_m9dShx0oYeTDAjDdUcydm3uQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 10:13:41AM -0700, Stefan Beller wrote:

> > -test_expect_success 'diff: nice spaces with diff.indentHeuristic' '
> > +test_expect_success 'diff: nice spaces with diff.indentHeuristic=true' '
> 
> Adding the '=true' seems weird to me (I'd think the true is implied,
> similar to C,
> where we do "if (!null_pointer)" instead of an explicit "!=null".
> However we do have these '=true' sprinkled all over the tests,
> so I guess it is a valid dialect in our test suite.

I think it's better to be explicit here. I think the original was less
about "implied true", as it was making the assumption that the feature
was off in the first place. Now that we've flipped that, just saying
"diff.indentHeuristic" is unclear whether you mean the "implied true"
of:

  git -c diff.indentHeuristic diff ...

or if you mean setting diff.indentHeuristic at all but aren't saying
which (which I think is how the original meant it).

I dunno. I guess it is subjective, but IMHO the "=true" is much clearer.

-Peff
