Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A4E20248
	for <e@80x24.org>; Mon, 18 Mar 2019 21:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfCRV1W (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 17:27:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:55520 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726973AbfCRV1W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 17:27:22 -0400
Received: (qmail 10645 invoked by uid 109); 18 Mar 2019 21:27:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Mar 2019 21:27:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23856 invoked by uid 111); 18 Mar 2019 21:27:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 17:27:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 17:27:20 -0400
Date:   Mon, 18 Mar 2019 17:27:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 1/4] gc docs: modernize the advice for manually running
 "gc"
Message-ID: <20190318212719.GE29661@sigill.intra.peff.net>
References: <20190318161502.7979-1-avarab@gmail.com>
 <20190318161502.7979-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318161502.7979-2-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 05:14:59PM +0100, Ævar Arnfjörð Bjarmason wrote:

> The docs have been recommending that users need to run this manually,
> but that hasn't been needed in practice for a long time.
> 
> Let's instead have this reflect reality and say that most users don't
> need to run this manually at all.

Yeah, I think this makes sense.

> -Users are encouraged to run this task on a regular basis within
> -each repository to maintain good disk space utilization and good
> -operating performance.
> +Most users should not have to run this command manually. When common
> +porcelain operations that create objects are run, such as
> +linkgit:git-commit[1] and linkgit:git-fetch[1], `git gc --auto` will
> +be run automatically.

This is in the description, before "--auto" is introduced. I wonder if
it is worth just describing it briefly, like:

  When common porcelain operations that creates objects are run, they
  will check whether the repository has grown substantially since the
  last maintenance, and if so run `git gc` automatically.

That gives a first-time reader an idea of whether they need to care
about this command without having to dig into what "--auto" is.

-Peff
