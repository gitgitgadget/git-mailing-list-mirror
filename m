Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30F21F597
	for <e@80x24.org>; Tue, 17 Jul 2018 00:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbeGQBZO (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 21:25:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:49038 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729871AbeGQBZO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 21:25:14 -0400
Received: (qmail 26509 invoked by uid 109); 17 Jul 2018 00:55:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Jul 2018 00:55:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18249 invoked by uid 111); 17 Jul 2018 00:55:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 20:55:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 20:55:17 -0400
Date:   Mon, 16 Jul 2018 20:55:17 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/7] gpg-interface: add new config to select how to
 sign a commit
Message-ID: <20180717005517.GA23398@sigill.intra.peff.net>
References: <cover.1531470729.git.henning.schild@siemens.com>
 <5e88da5eac1e1aea8a946960d455ba321e3e42b1.1531470729.git.henning.schild@siemens.com>
 <20180717000310.GA980821@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717000310.GA980821@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 12:03:11AM +0000, brian m. carlson wrote:

> > +gpg.format::
> > +	Specifies which key format to use when signing with `--gpg-sign`.
> > +	Default is "openpgp", that is also the only supported value.
> 
> I think, as discussed in the other thread, perhaps a different prefix
> for these options is in order if we'd like to plan for the future.
> Maybe this could be "signature.format", "sign.format", "signing.format",
> or "signingtool.format" (I tend to prefer the former, but not too
> strongly).
> 
> I anticipate that some projects will prefer other formats, and it makes
> it easier if we don't have to maintain two sets of legacy names.

Heh. This is slowly morphing into the original signingtool series.

For the record (since I think my response is what you meant by the
"other thread"), I'm OK with going down this gpg.* road for now, and
dealing with other tools if and when they appear (via the extra level of
indirection).

-Peff
