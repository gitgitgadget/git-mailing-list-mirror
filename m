Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD9820248
	for <e@80x24.org>; Thu, 11 Apr 2019 18:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDKS3G (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 14:29:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:55382 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726538AbfDKS3F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 14:29:05 -0400
Received: (qmail 11938 invoked by uid 109); 11 Apr 2019 18:29:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 18:29:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31573 invoked by uid 111); 11 Apr 2019 18:29:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 14:29:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 14:29:03 -0400
Date:   Thu, 11 Apr 2019 14:29:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?B=C3=A1rbara?= de Castro Fernandes 
        <barbara.fernandes@usp.br>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git <git@vger.kernel.org>
Subject: Re: Feature request: Add --no-edit to git tag command
Message-ID: <20190411182903.GA32528@sigill.intra.peff.net>
References: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
 <20190404015744.GF4409@sigill.intra.peff.net>
 <20190404032606.GA39148@Taylors-MBP.hsd1.wa.comcast.net>
 <20190404120613.GB22324@sigill.intra.peff.net>
 <CAHd499CUCoShsQHYZotFqprfDUf_owg_Urbt29fkNRV6LhFc3Q@mail.gmail.com>
 <20190405222100.GA10787@sigill.intra.peff.net>
 <CAJ+V80pY0L7onX600dmSaMuFFnH5n52-3CmnRyDKr-7ZkZ92mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+V80pY0L7onX600dmSaMuFFnH5n52-3CmnRyDKr-7ZkZ92mA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 03:20:52PM -0300, Bárbara de Castro Fernandes wrote:

> This new proposed --amend option, although semantically different,
> would have a very similar functionality to the already existing -f
> option. So should we, perhaps, change -f's behavior to treat the tag
> as a new one, treating the old one as if it never existed (as I think
> Junio was saying)? By this I mean the command should fail if the user
> doesn't give a SHA-1 and the previous message wouldn't be preloaded.
> --amend, on the other hand, would give the user an opportunity to
> revise the tag by opening, by default, the editor with the
> pre-existing message unless given the '--no-edit' option, and if not
> given a SHA-1 it would keep on using the previous one.

Yes, that's what I'd expect it to do (so yes, it's also different from
"-f" in that it defaults to the existing tag destination instead of
HEAD).

-Peff
