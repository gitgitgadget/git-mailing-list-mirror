Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0755A1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 03:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfBND7r (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 22:59:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:43576 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726906AbfBND7q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 22:59:46 -0500
Received: (qmail 28666 invoked by uid 109); 14 Feb 2019 03:59:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 03:59:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6089 invoked by uid 111); 14 Feb 2019 03:59:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Feb 2019 22:59:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2019 22:59:44 -0500
Date:   Wed, 13 Feb 2019 22:59:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2019, #03; Wed, 13)
Message-ID: <20190214035944.GB7209@sigill.intra.peff.net>
References: <xmqq4l979h8d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4l979h8d.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 07:33:22PM -0800, Junio C Hamano wrote:

> [Graduated to "master"]
> [...]
> * js/smart-http-detect-remote-error (2019-02-06) 3 commits
>   (merged to 'next' on 2019-02-06 at ec1a6f67c1)
>  + t5551: test server-side ERR packet
>  + remote-curl: tighten "version 2" check for smart-http
>  + remote-curl: refactor smart-http discovery
> 
>  Some errors from the other side coming over smart HTTP transport
>  were not noticed, which has been corrected.

Hmm, this was maybe a risky one to merge as part of -rc1. It is just
enforcing the rules from the spec document, but it's possible that it
may trigger on some poorly-behaved server.

I'm not worried enough to suggest pulling it back, but it's something we
should keep an eye on during the -rc period.

-Peff
