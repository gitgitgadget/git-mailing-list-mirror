Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75CBF1F404
	for <e@80x24.org>; Wed, 20 Dec 2017 13:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755204AbdLTNXi (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 08:23:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:44042 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754835AbdLTNXh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 08:23:37 -0500
Received: (qmail 9894 invoked by uid 109); 20 Dec 2017 13:23:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Dec 2017 13:23:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12493 invoked by uid 111); 20 Dec 2017 13:24:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 20 Dec 2017 08:24:03 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec 2017 08:23:35 -0500
Date:   Wed, 20 Dec 2017 08:23:35 -0500
From:   Jeff King <peff@peff.net>
To:     William Pursell <william.r.pursell@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: Fix specification of default (auto) for --color
Message-ID: <20171220132335.GE17569@sigill.intra.peff.net>
References: <CAJPQ5Na1Z5QpgqS+wUVPGq-E+wOgsW5m4NzGEUcAnmDnRz+9DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJPQ5Na1Z5QpgqS+wUVPGq-E+wOgsW5m4NzGEUcAnmDnRz+9DA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 05:14:02AM -0800, William Pursell wrote:

> Current documentation for branch, show-branch, and grep contain the following:
> 
> --color[=<when>]
>            Show colored matches. The value must be always (the
> default), never, or auto.
> 
> This is incorrect, as the default is "auto".

I think what this is trying to say is that if you specify "--color" but
not "<when>", then "<when>" defaults to "always". I.e., this is talking
about a different default than if you didn't specify "--color" at all
(and that default relies on the config, which in turn defaults to
"auto").

The wording is quite confusing, though. Maybe we could clarify that and
mention both "defaults":

  --color[=<when>]
	Show colored matches. The value of `<when>` must be `always`,
	`never`, or `auto`. If `<when>` is omitted (i.e., just
	`--color`), behave as if `--color=always` was specified. If no
	`--color` option is given, defaults, to the value of the
	`color.grep` config variable.

There may be a less clunky way of saying all that, though.

-Peff
