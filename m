Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C95FE1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754624AbdDKKxT (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:53:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:59866 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753289AbdDKKxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:53:16 -0400
Received: (qmail 26048 invoked by uid 109); 11 Apr 2017 10:53:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 10:53:15 +0000
Received: (qmail 1110 invoked by uid 111); 11 Apr 2017 10:53:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 06:53:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 06:53:13 -0400
Date:   Tue, 11 Apr 2017 06:53:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 10/12] grep: change the internal PCRE macro names to be
 PCRE1
Message-ID: <20170411105312.5h6gc35lhxvz4ro2@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com>
 <20170408132506.5415-11-avarab@gmail.com>
 <20170411103523.tlub4v65er32ikix@sigill.intra.peff.net>
 <CACBZZX7gmmTm6qU-6sviRQ3znwkOXG6999C6SDD_oJe6pqdTWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7gmmTm6qU-6sviRQ3znwkOXG6999C6SDD_oJe6pqdTWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 12:51:09PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Yeah, I think it's nice to keep the build-time knobs compatible. In the
> > long run I assume we'll want to add a USE_LIBPCRE1 flag and USE_LIBPCRE
> > just becomes a synonym for it (in fact, we could do that in this
> > commit).
> 
> I could just add that. Hints for how to do that without entirely
> copy/pasting the "ifdef USE_LIBPCRE" in the Makefile welcome. The
> Makefile syntax doesn't support some form of "ifdef X || ifdef Y"
> AFAICT, so it looks like I'll need to copy those lines...

Maybe:

  USE_LIBPCRE1 ?= $(USE_LIBPCRE)
  ifdef USE_LIBPCRE1
  ...
  endif

-Peff
