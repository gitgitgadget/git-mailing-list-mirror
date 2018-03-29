Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD9D1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 19:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeC2TnQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 15:43:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:47824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751114AbeC2TnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 15:43:16 -0400
Received: (qmail 23337 invoked by uid 109); 29 Mar 2018 19:43:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 29 Mar 2018 19:43:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21642 invoked by uid 111); 29 Mar 2018 19:44:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 29 Mar 2018 15:44:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2018 15:43:14 -0400
Date:   Thu, 29 Mar 2018 15:43:14 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 3/9] t1300: avoid relying on a bug
Message-ID: <20180329194313.GD2939@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <385674162d2853f6aea153d9d30482034d9fa3df.1522336130.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <385674162d2853f6aea153d9d30482034d9fa3df.1522336130.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 05:18:45PM +0200, Johannes Schindelin wrote:

> The test case 'unset with cont. lines' relied on a bug that is about to
> be fixed: it tests *explicitly* that removing the last entry from a
> config section leaves an *empty* section behind.
> 
> Let's fix this test case not to rely on that behavior, simply by
> preventing the section from becoming empty.

Seems like a good solution. I don't think we care in particular about
testing a multi-line value at the end of the file.

-Peff
