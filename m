Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18D8020401
	for <e@80x24.org>; Tue, 13 Jun 2017 00:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753195AbdFMAuk (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 20:50:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:38686 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752987AbdFMAuj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 20:50:39 -0400
Received: (qmail 18216 invoked by uid 109); 13 Jun 2017 00:50:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 00:50:39 +0000
Received: (qmail 18480 invoked by uid 111); 13 Jun 2017 00:50:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 20:50:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 20:50:37 -0400
Date:   Mon, 12 Jun 2017 20:50:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCHv2 1/5] revision.h: turn rev_info.early_output back into
 an unsigned int
Message-ID: <20170613005037.cz4udzfzkpuvdent@sigill.intra.peff.net>
References: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
 <20170609181733.6793-1-szeder.dev@gmail.com>
 <20170609181733.6793-2-szeder.dev@gmail.com>
 <20170610064102.w4kp6omxdznfe7fa@sigill.intra.peff.net>
 <xmqq60g1ndtz.fsf@gitster.mtv.corp.google.com>
 <20170612215902.62cnfxdivv76337p@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170612215902.62cnfxdivv76337p@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 05:59:02PM -0400, Jeff King wrote:

> The nice thing about deprecating it is that I think callers need to be
> prepared to handle the case already that it does nothing. So if we just
> ripped out the code and treated it as a silent noop, everything would
> just work.

Actually, I take that back. We might or might not have early output, but
we always say "Final output". So in theory a caller would be confused if
we no longer print that.

(I do still suspect that there are no callers).

-Peff
