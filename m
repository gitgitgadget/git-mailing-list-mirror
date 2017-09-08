Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6353E202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 07:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932462AbdIHHpJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 03:45:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:60618 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932289AbdIHHpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 03:45:08 -0400
Received: (qmail 23905 invoked by uid 109); 8 Sep 2017 07:45:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 07:45:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6565 invoked by uid 111); 8 Sep 2017 07:45:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 03:45:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 03:45:06 -0400
Date:   Fri, 8 Sep 2017 03:45:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 07/10] t1404: demonstrate two problems with reference
 transactions
Message-ID: <20170908074505.r5luqgvi6e45shgg@sigill.intra.peff.net>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <caaa44126f18869158872e5473e53478db780ba9.1503993268.git.mhagger@alum.mit.edu>
 <xmqqshfxztn5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshfxztn5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 01:44:30PM +0900, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > +	git for-each-ref $prefix >actual &&
> > +	grep "Unable to create $Q.*packed-refs.lock$Q: File exists" err &&
> 
> I added a squash for doing s/grep/test_i18n&/ here; are there other
> issues in the series, or is the series more or less ready to be
> polished in 'next'?

I think we'd want the test fix to avoid busy-waiting that was discussed
upthread. I just left a few comments, too. I suspect they will all be
answered without code changes, but I think we'd probably want to wait
for a v2.

-Peff
