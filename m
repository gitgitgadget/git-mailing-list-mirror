Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1892420248
	for <e@80x24.org>; Sat, 23 Mar 2019 07:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfCWHFv (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 03:05:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:33528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726052AbfCWHFu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 03:05:50 -0400
Received: (qmail 25356 invoked by uid 109); 23 Mar 2019 07:05:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Mar 2019 07:05:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26866 invoked by uid 111); 23 Mar 2019 07:06:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 23 Mar 2019 03:06:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Mar 2019 03:05:48 -0400
Date:   Sat, 23 Mar 2019 03:05:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] t5551: mark half-auth no-op fetch test as v0-only
Message-ID: <20190323070548.GA24065@sigill.intra.peff.net>
References: <20190321174719.151877-1-jonathantanmy@google.com>
 <20190322190139.151189-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190322190139.151189-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 12:01:39PM -0700, Jonathan Tan wrote:

> When using protocol v0, upload-pack over HTTP permits a "half-auth"
> configuration in which, at the web server layer, the info/refs path is
> not protected by authentication but the git-upload-pack path is, so that
> a user can perform fetches that do not download any objects without
> authentication, but still needs authentication to download objects.
> 
> But protocol v2 does not support this, because both ref and pack are
> obtained from the git-upload-pack path.
> 
> Mark the test verifying this behavior as protocol v0-only, with a
> description of what needs to be done to make v2 support this.

Thanks, this looks like a fine solution to me.

I do not really expect anyone will ever get around to this NEEDSWORK,
but we can see. :)

-Peff
