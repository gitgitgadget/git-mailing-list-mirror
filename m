Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED7720A28
	for <e@80x24.org>; Wed, 20 Sep 2017 18:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbdITS3Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 14:29:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:44866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751686AbdITS3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 14:29:24 -0400
Received: (qmail 6836 invoked by uid 109); 20 Sep 2017 18:29:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 18:29:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14988 invoked by uid 111); 20 Sep 2017 18:30:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Sep 2017 14:30:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Sep 2017 14:29:21 -0400
Date:   Wed, 20 Sep 2017 14:29:21 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 11/21] mmapped_ref_iterator_advance(): no peeled value
 for broken refs
Message-ID: <20170920182921.6c7zndcghivzevg3@sigill.intra.peff.net>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
 <d34d2cbde67e9ef0b0b11910de19c7f722c2314c.1505799700.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d34d2cbde67e9ef0b0b11910de19c7f722c2314c.1505799700.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 08:22:19AM +0200, Michael Haggerty wrote:

> If a reference is broken, suppress its peeled value.

Makes sense. Without this we might return an answer for "git show
tag^{commit}" even if the repo is broken and the object pointed to by
"tag" is missing.

-Peff
