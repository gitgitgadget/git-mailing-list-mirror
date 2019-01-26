Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1DE31F453
	for <e@80x24.org>; Sat, 26 Jan 2019 14:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfAZO24 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 09:28:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:50050 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726052AbfAZO24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 09:28:56 -0500
Received: (qmail 24281 invoked by uid 109); 26 Jan 2019 14:28:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 26 Jan 2019 14:28:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14160 invoked by uid 111); 26 Jan 2019 14:29:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 26 Jan 2019 09:29:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jan 2019 09:28:54 -0500
Date:   Sat, 26 Jan 2019 09:28:54 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Setup working tree in describe
Message-ID: <20190126142854.GA20692@sigill.intra.peff.net>
References: <CA+xP2Sax+thitfKv4hTtKTYPhfVXJxD_qoJxgkCyZFTzskP-Tw@mail.gmail.com>
 <CACsJy8Df6XM55ExRfCjpUQsv2Vm0cOwrSAyNf6net__uztMOGQ@mail.gmail.com>
 <CA+xP2SaJYD+OKC18y0zz2V6A9J8rAB0-cxMnrDmWt==8v2_uBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+xP2SaJYD+OKC18y0zz2V6A9J8rAB0-cxMnrDmWt==8v2_uBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 26, 2019 at 03:07:54PM +0100, Sebastian Staudt wrote:

> Are you sure that it will fail without a working tree?
> Is it even possible to have *no* working tree?
> 
> I already tested this with some real life examples, e.g.
> 
>     git --git-dir /some/path/.git describe
> 
> From inside and outside of other repositories.
> I didn‘t hit any errors so far.

Try:

  git clone --bare . bare.git
  cd bare.git
  git describe

That works with current versions of Git, but yields "fatal: this
operation must be run in a work tree" with your patch.

-Peff

PS Your patches seem whitespace-damaged. You might want to look into
   using git-send-email.
