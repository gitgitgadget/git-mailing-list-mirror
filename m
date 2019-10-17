Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9F21F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 06:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392709AbfJQGao (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 02:30:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:50526 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390993AbfJQGao (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 02:30:44 -0400
Received: (qmail 21301 invoked by uid 109); 17 Oct 2019 06:30:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 06:30:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6269 invoked by uid 111); 17 Oct 2019 06:33:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 02:33:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 02:30:43 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, mh@glandium.org
Subject: Re: [PATCH 4/6] index-pack: calculate {ref,ofs}_{first,last} early
Message-ID: <20191017063043.GE10862@sigill.intra.peff.net>
References: <cover.1570663470.git.jonathantanmy@google.com>
 <0f0ffe71c5df9129a04546b8e3ed13a3ece1b9b1.1570663470.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f0ffe71c5df9129a04546b8e3ed13a3ece1b9b1.1570663470.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 04:44:20PM -0700, Jonathan Tan wrote:

> Whenever we make a struct base_data, immediately calculate its delta
> children. This eliminates confusion as to when the
> {ref,ofs}_{first,last} fields are initialized.

That _seems_ like a good idea, but I'm a little worried just because I
don't entirely understand why it was being done lazily before. If you've
puzzled all that out, it would be nice to make the argument in the
commit message.

-Peff
