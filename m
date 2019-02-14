Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACCBA1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 03:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfBND4E (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 22:56:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:43566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726952AbfBND4E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 22:56:04 -0500
Received: (qmail 28498 invoked by uid 109); 14 Feb 2019 03:56:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 03:56:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6069 invoked by uid 111); 14 Feb 2019 03:56:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Feb 2019 22:56:15 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2019 22:56:02 -0500
Date:   Wed, 13 Feb 2019 22:56:02 -0500
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2] protocol-capabilities.txt: document symref
Message-ID: <20190214035602.GA7209@sigill.intra.peff.net>
References: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
 <cb1b2834b7365f6277d1ec573cee7fd68a7329d0.1550100949.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb1b2834b7365f6277d1ec573cee7fd68a7329d0.1550100949.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 03:41:28PM -0800, Josh Steadmon wrote:

> ---
> Range-diff against v1:
> 1:  4ffb11ff77 ! 1:  cb1b2834b7 protocol-capabilities.txt: document symref
>     @@ -12,6 +12,17 @@
>       diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
>       --- a/Documentation/technical/protocol-capabilities.txt
>       +++ b/Documentation/technical/protocol-capabilities.txt
>     +@@
>     + Git Protocol Capabilities
>     + =========================
>     + 
>     ++NOTE: this document describes capabilities for versions 0 and 1 of the pack
>     ++protocol. For version 2, please refer to the link:protocol-v2.html[protocol-v2]
>     ++doc.
>     ++
>     + Servers SHOULD support all capabilities defined in this document.
>     + 
>     + On the very first line of the initial server response of either

I think this makes sense. I wondered to what degree the v2 protocol doc
may say "...and you can use capabilities from protocol-capabilities.txt
here". But it doesn't. It newly lists the capabilities, which makes this
paragraph the right thing to say.

It does mean that if we teach v1 a new capability, we'll have to
document it in both places. But moving forward, we'd hopefully not be
doing that too often (I haven't seen talk of flipping the v2 switch yet
by default, but obviously that's where we want to end up).

I probably would have put this in its own patch, but barring that we
should probably at least mention in the commit message what this
paragraph is doing here.

-Peff
