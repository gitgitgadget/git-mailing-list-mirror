Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24FA31FC44
	for <e@80x24.org>; Tue,  9 May 2017 03:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbdEIDWm (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 23:22:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:47845 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751250AbdEIDWl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 23:22:41 -0400
Received: (qmail 13356 invoked by uid 109); 9 May 2017 03:22:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 03:22:41 +0000
Received: (qmail 19335 invoked by uid 111); 9 May 2017 03:23:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 23:23:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 23:22:39 -0400
Date:   Mon, 8 May 2017 23:22:39 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 2/4] diff: have the diff-* builtins configure diff
 before initializing revisions
Message-ID: <20170509032238.uvgg7sezfzlig2ko@sigill.intra.peff.net>
References: <f867af6f-b601-251a-86a4-ede0bb942efb@xiplink.com>
 <20170508160339.4551-1-marcnarc@xiplink.com>
 <20170508160339.4551-3-marcnarc@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170508160339.4551-3-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 12:03:37PM -0400, Marc Branchaud wrote:

> This matches how the diff Porcelain works.  It makes the plumbing commands
> respect diff's configuration options, such as indentHeuristic, because
> init_revisions() calls diff_setup() which fills in the diff_options struct.

I don't know if you want to note here that this is only _some_ options.
I.e., ones that we handle by copying via diff_setup(). Maybe it's
obvious from the description already (it's hard for me to tell because I
already know it either way :) ).

-Peff
