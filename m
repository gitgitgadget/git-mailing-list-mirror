Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3C6202F8
	for <e@80x24.org>; Mon, 13 Mar 2017 19:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbdCMTJl (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:09:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:43367 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbdCMTJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:09:39 -0400
Received: (qmail 29858 invoked by uid 109); 13 Mar 2017 19:09:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 19:09:38 +0000
Received: (qmail 20827 invoked by uid 111); 13 Mar 2017 19:09:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Mar 2017 15:09:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Mar 2017 15:09:36 -0400
Date:   Mon, 13 Mar 2017 15:09:36 -0400
From:   Jeff King <peff@peff.net>
To:     Anthony Scian <ascian@auvik.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: 'git add --patch' no longer allows you to select files before
 selecting patches
Message-ID: <20170313190936.vjyzdr2s2rc66frc@sigill.intra.peff.net>
References: <DF55CDE6-E556-4C07-B661-0F5AA00D306E@auvik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DF55CDE6-E556-4C07-B661-0F5AA00D306E@auvik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 02:51:52PM -0400, Anthony Scian wrote:

> Similarly the patch sub-command in ‘git add —interactive’ goes
> immediately to selecting patches starting with the first file.
> Is there a git configuration that would being back the old behaviour?
> Why was this changed?

My, this seems to be a popular bug. This is the third report already. :)

The answer to your final question is that it's a bug. The fix is in
c852bd54bd87fdcdc825f5d45c26aa745be13ba6, which is currently in the
"master" branch of git.git.

Junio, I notice this isn't in "maint", and probably should be. It's a
regression in v2.12.0, so hopefully we'd fix it in v2.12.1.

-Peff
