Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7DE20D0A
	for <e@80x24.org>; Tue, 30 May 2017 06:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbdE3GGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 02:06:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:59665 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbdE3GF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 02:05:59 -0400
Received: (qmail 16558 invoked by uid 109); 30 May 2017 06:05:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 06:05:58 +0000
Received: (qmail 21189 invoked by uid 111); 30 May 2017 06:06:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 May 2017 02:06:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 May 2017 02:05:55 -0400
Date:   Tue, 30 May 2017 02:05:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
Message-ID: <20170530060555.ponbsyp4agdo4yau@sigill.intra.peff.net>
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
 <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
 <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 03:03:18PM +0900, Junio C Hamano wrote:

> > +test_expect_success 'generate builtin list' '
> > +	git --list-builtins >builtins
> > +'
> > +
> > +while read builtin
> > +do
> > +	test_expect_success "$builtin can handle -h" '
> > +		test_expect_code 129 git $builtin -h >output 2>&1 &&
> > +		test_i18ngrep usage output
> > +	'
> > +done <builtins
> > +
> 
> These still seem to need further tweaks?
> 
>     diff-files
>     diff-index
>     diff-tree
>     rev-list

How so? They pass the test for me, and the output for a manual run looks
sane.

-Peff
