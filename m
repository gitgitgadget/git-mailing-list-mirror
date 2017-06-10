Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4463C1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 06:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbdFJGo3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 02:44:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:37474 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbdFJGo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 02:44:28 -0400
Received: (qmail 29630 invoked by uid 109); 10 Jun 2017 06:44:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 06:44:27 +0000
Received: (qmail 29022 invoked by uid 111); 10 Jun 2017 06:44:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 02:44:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 02:44:26 -0400
Date:   Sat, 10 Jun 2017 02:44:26 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision.c: use skip_prefix() in
 handle_revision_opt()
Message-ID: <20170610064426.ylzdx2v4ffdz2jkh@sigill.intra.peff.net>
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
 <20170609181733.6793-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170609181733.6793-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 09, 2017 at 08:17:28PM +0200, SZEDER Gábor wrote:

> So, here comes v2.  The interdiff is below, the changes since v1 are:
> 
>  - Patch 1/5 is new to fix a more fundamental problem with
>    '--early-output'.
>  - Patch 3/5 is new to fix this '--early-output-foo' issue and also
>    to tighten up the parsing of its integer argument, while at it.
>  - A fix for '--show-linear-break-foo' in v1.
>  - A little cleanup in the handling of '--show-notes/--notes'.
> 
> 
> SZEDER Gábor (5):
>   revision.h: turn rev_info.early_output back into an unsigned int
>   revision.c: stricter parsing of '--no-{min,max}-parents'
>   revision.c: stricter parsing of '--early-output'
>   revision.c: use skip_prefix() in handle_revision_opt()
>   revision.c: use skip_prefix() in handle_revision_pseudo_opt()
> 
>  revision.c | 87 +++++++++++++++++++++++++++++---------------------------------
>  revision.h |  5 ++--
>  2 files changed, 44 insertions(+), 48 deletions(-)

I noted a minor nit in the first commit message, but otherwise these all
look good to me.

-Peff
