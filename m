Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605DE1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 10:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbeKOVBt (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 16:01:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:40324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729006AbeKOVBt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 16:01:49 -0500
Received: (qmail 16212 invoked by uid 109); 15 Nov 2018 10:54:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 10:54:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14182 invoked by uid 111); 15 Nov 2018 10:53:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 05:53:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 05:54:27 -0500
Date:   Thu, 15 Nov 2018 05:54:27 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] clone: use a more appropriate variable name for the
 default refspec
Message-ID: <20181115105427.GA19032@sigill.intra.peff.net>
References: <20181114104620.32478-1-szeder.dev@gmail.com>
 <20181114104620.32478-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181114104620.32478-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 11:46:18AM +0100, SZEDER Gábor wrote:

> cmd_clone() declares two strbufs 'key' and 'value' on the same line,
> suggesting that they are used to contruct a config variable's name and
> value.  However, this is not the case: 'key' is used to construct the
> names of multiple config variables, while 'value' is never used as a
> value for any of those config variables, or for any other config
> variable for that matter, but only to contruct the default fetch
> refspec.
> 
> Let's rename 'value' to 'default_refspec' to make the intent clearer.

Yep, this is much nicer.

-Peff
