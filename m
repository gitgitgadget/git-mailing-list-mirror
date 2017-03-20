Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2031C20958
	for <e@80x24.org>; Mon, 20 Mar 2017 17:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755630AbdCTRvw (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 13:51:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:47845 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755533AbdCTRvv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 13:51:51 -0400
Received: (qmail 12191 invoked by uid 109); 20 Mar 2017 17:51:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 17:51:50 +0000
Received: (qmail 3792 invoked by uid 111); 20 Mar 2017 17:52:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 13:52:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 13:51:46 -0400
Date:   Mon, 20 Mar 2017 13:51:46 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 11/20] refs: record the ref_store in ref_cache, not
 ref_dir
Message-ID: <20170320175145.zwfqp7varl4hwink@sigill.intra.peff.net>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
 <745f1ed3781083f99da31a33dec08f03bffa7d4f.1490026594.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <745f1ed3781083f99da31a33dec08f03bffa7d4f.1490026594.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 05:33:16PM +0100, Michael Haggerty wrote:

> Instead of keeping a pointer to the ref_store in every ref_dir entry,
> store it once in `struct ref_cache`, and change `struct ref_dir` to
> include a pointer to its containing `ref_cache` instead. This makes it
> easier to add to the information that is stored in `struct ref_cache`
> without inflating the size of the individual entries.

This last sentence confused me. It's a pointer either way, no?

Do you just mean that we are free to add whatever we like to the
"ref_cache" without polluting the "ref_store" that is a more public data
structure?

-Peff
