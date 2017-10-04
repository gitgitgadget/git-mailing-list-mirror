Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D640620281
	for <e@80x24.org>; Wed,  4 Oct 2017 07:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbdJDHqE (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 03:46:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:60176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751297AbdJDHpu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 03:45:50 -0400
Received: (qmail 14894 invoked by uid 109); 4 Oct 2017 07:45:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 07:45:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15782 invoked by uid 111); 4 Oct 2017 07:45:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 03:45:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 03:45:48 -0400
Date:   Wed, 4 Oct 2017 03:45:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] oidmap: map with OID as key
Message-ID: <20171004074547.56ks2efcr7cbldbq@sigill.intra.peff.net>
References: <20170927221910.164552-1-jonathantanmy@google.com>
 <20170929225422.81467-1-jonathantanmy@google.com>
 <20171002234848.GG5189@google.com>
 <20171003063119.iht5kl7zsiuxpaqz@sigill.intra.peff.net>
 <CAGf8dgKtwdT912CaARdjYnSAd2m7mmdOzM=OGCUupw80snrd_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGf8dgKtwdT912CaARdjYnSAd2m7mmdOzM=OGCUupw80snrd_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 05:29:01PM -0700, Jonathan Tan wrote:

> At this point I decided that I prefer the thin wrapper, but the "light
> touch" (struct oidmap_entry, oidcmpfn(), oidmap_get() only) still
> better than the status quo.

OK. I can certainly live with that. And worst case, I suppose, is that a
caller wants some underlying hashmap function and we just have to extend
the oidmap API to include it. It's not like we're adding new hashmap
functions willy-nilly.

-Peff
