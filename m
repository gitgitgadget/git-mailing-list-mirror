Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7DD120248
	for <e@80x24.org>; Mon, 18 Mar 2019 21:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfCRVbl (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 17:31:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:55548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726876AbfCRVbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 17:31:41 -0400
Received: (qmail 10812 invoked by uid 109); 18 Mar 2019 21:31:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Mar 2019 21:31:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23890 invoked by uid 111); 18 Mar 2019 21:32:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 17:32:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 17:31:39 -0400
Date:   Mon, 18 Mar 2019 17:31:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 2/4] gc docs: include the "gc.*" section from "config" in
 "gc"
Message-ID: <20190318213139.GF29661@sigill.intra.peff.net>
References: <20190318161502.7979-1-avarab@gmail.com>
 <20190318161502.7979-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318161502.7979-3-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 05:15:00PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Rather than duplicating the documentation for the various "gc" options
> let's include the "gc" docs from git-config. They were mostly better
> already, and now we don't have the same docs in two places with subtly
> different wording.
> 
> In the cases where the git-gc(1) docs were saying something the "gc"
> docs in git-config(1) didn't cover move the relevant section over to
> the git-config(1) docs.

Makes sense.

I think we lose the actual example for gc.*.reflogExpire:

> -The above two configuration variables can be given to a pattern.  For
> -example, this sets non-default expiry values only to remote-tracking
> -branches:
> -
> -------------
> -[gc "refs/remotes/*"]
> -	reflogExpire = never
> -	reflogExpireUnreachable = 3 days
> -------------

I don't actually think it's that big a loss. If we wanted to retain it,
though, it might make sense in the "EXAMPLES" section.

-Peff
