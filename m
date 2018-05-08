Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D52F8200B9
	for <e@80x24.org>; Tue,  8 May 2018 14:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932561AbeEHOoq (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 10:44:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:60478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932141AbeEHOop (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 10:44:45 -0400
Received: (qmail 3219 invoked by uid 109); 8 May 2018 14:44:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 May 2018 14:44:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5486 invoked by uid 111); 8 May 2018 14:44:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 May 2018 10:44:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2018 10:44:43 -0400
Date:   Tue, 8 May 2018 10:44:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 06/12] get_short_oid: sort ambiguous objects by type,
 then SHA-1
Message-ID: <20180508144443.GC30183@sigill.intra.peff.net>
References: <20180501120651.15886-1-avarab@gmail.com>
 <20180501184016.15061-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180501184016.15061-7-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 01, 2018 at 06:40:10PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Change the output emitted when an ambiguous object is encountered so
> that we show tags first, then commits, followed by trees, and finally
> blobs. Within each type we show objects in hashcmp() order. Before
> this change the objects were only ordered by hashcmp().
> 
> The reason for doing this is that the output looks better as a result,
> e.g. the v2.17.0 tag before this change on "git show e8f2" would
> display:

FWIW, I agree that this gives a big improvement to readability.

-Peff
