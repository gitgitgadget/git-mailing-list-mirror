Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30DB91FF34
	for <e@80x24.org>; Thu, 11 May 2017 06:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754536AbdEKG31 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 02:29:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:49133 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752639AbdEKG31 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 02:29:27 -0400
Received: (qmail 22575 invoked by uid 109); 11 May 2017 06:29:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 06:29:26 +0000
Received: (qmail 9446 invoked by uid 111); 11 May 2017 06:29:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 02:29:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 02:29:24 -0400
Date:   Thu, 11 May 2017 02:29:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        raphael.stolt@gmail.com, Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Possible bug in includeIf / conditional includes
Message-ID: <20170511062924.6euaynsbyocjcw3q@sigill.intra.peff.net>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
 <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com>
 <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
 <20170511062616.f7rg6f5cgrqeh7gf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511062616.f7rg6f5cgrqeh7gf@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 02:26:16AM -0400, Jeff King wrote:

> > So whether this is a bug in the code or not it seems to definitely be
> > a doc bug, whatever it does with relative files should be in the docs.
> 
> The includeIf variables should behave exactly as the documentation you
> quoted above. The conditional impacts whether we respect the keys in
> that section, but not the meaning of the keys.
> 
> I thought that was clear, but as somebody who was involved in the
> development of both the original and the conditional includes, my
> opinion probably doesn't count. I wouldn't mind a patch to make that
> more explicit in the documentation.

I figured I'd just do this while we're thinking about it, since it
should be trivial. But it's actually there already:

  You can include a config file from another conditionally by setting a
  `includeIf.<condition>.path` variable to the name of the file to be
  included. The variable's value is treated the same way as
  `include.path`.

I'm open to suggestions to make that more obvious, though.

-Peff
