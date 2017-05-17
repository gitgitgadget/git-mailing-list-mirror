Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C082027B
	for <e@80x24.org>; Wed, 17 May 2017 12:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753819AbdEQMnM (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:43:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:53564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753227AbdEQMnL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 08:43:11 -0400
Received: (qmail 2750 invoked by uid 109); 17 May 2017 12:42:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 12:42:58 +0000
Received: (qmail 9077 invoked by uid 111); 17 May 2017 12:43:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 08:43:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 08:42:56 -0400
Date:   Wed, 17 May 2017 08:42:56 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 01/23] t3600: clean up permissions test properly
Message-ID: <20170517124255.62hdqwvcvfy2tdr7@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <bb244c72ec6e6ab56171d82f7379a75c4eb5481f.1495014840.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb244c72ec6e6ab56171d82f7379a75c4eb5481f.1495014840.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 02:05:24PM +0200, Michael Haggerty wrote:

> The test of failing `git rm -f` removes the write permissions on the
> test directory, but fails to restore them if the test fails. This
> means that the test temporary directory cannot be cleaned up, which
> means that subsequent attempts to run the test fail mysteriously.
> 
> Instead, do the cleanup in a `test_must_fail` block so that it can't
> be skipped.

This should be `test_when_finished` in the final paragraph, right?

The patch itself looks obviously fine.

-Peff
