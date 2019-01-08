Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1A11F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfAHVOF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:14:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:58312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729297AbfAHVOF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:14:05 -0500
Received: (qmail 8327 invoked by uid 109); 8 Jan 2019 21:14:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Jan 2019 21:14:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16558 invoked by uid 111); 8 Jan 2019 21:14:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 Jan 2019 16:14:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jan 2019 16:14:03 -0500
Date:   Tue, 8 Jan 2019 16:14:03 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, avarab@gmail.com, git@vger.kernel.org,
        bwilliamseng@gmail.com, steadmon@google.com
Subject: Re: [PATCH v3 4/4] fetch-pack: support protocol version 2
Message-ID: <20190108211402.GA22946@sigill.intra.peff.net>
References: <xmqqva2z3pdp.fsf@gitster-ct.c.googlers.com>
 <20190108203826.564-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108203826.564-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 08, 2019 at 12:38:26PM -0800, Jonathan Tan wrote:

> > Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> > 
> > > From: Jonathan Tan <jonathantanmy@google.com>
> > 
> > 
> > I was looking at the topics in 'pu' and noticed that I had v2 of
> > this series, wanted to update to v3, but major part of it was
> > superseded by another topic (jk/proto-v2-hidden-refs-fix).  That
> > leaves only this patch in the v3 of this series.
> > 
> > Is this one still relevant?
> 
> This patch is more relevant to the GIT_TEST_PROTOCOL_VERSION patches,
> since it means that several tests work even if
> GIT_TEST_PROTOCOL_VERSION=2 is set. I think it can be dropped until
> someone restarts the GIT_TEST_PROTOCOL_VERSION effort, but I'm not sure
> if Ævar has another opinion.

I think it's independently useful. If you set protocol.version=2 in your
config, then you can no longer run fetch-pack directly. Most people
don't, but it's possible their scripts might (we also use fetch-pack
under the hood for smart-http, but I wasn't able to get it to complain,
though).

-Peff
