Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E7B201A7
	for <e@80x24.org>; Mon, 15 May 2017 22:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbdEOWqS (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 18:46:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:52230 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752308AbdEOWqR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 18:46:17 -0400
Received: (qmail 906 invoked by uid 109); 15 May 2017 22:46:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 22:46:17 +0000
Received: (qmail 22505 invoked by uid 111); 15 May 2017 22:46:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 18:46:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 18:46:15 -0400
Date:   Mon, 15 May 2017 18:46:15 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCHv3 0/4] clone: respect configured fetch respecs during
 initial fetch
Message-ID: <20170515224615.f6hnnfngwpierqk4@sigill.intra.peff.net>
References: <20170515110557.11913-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170515110557.11913-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 01:05:53PM +0200, SZEDER Gábor wrote:

> This is a reroll of sg/clone-refspec-from-command-line-config.
> Sorry for the delay, family visit.

No problem. Thanks for letting us know before it went to 'next'. ;)

> The first patch is the updated version of what is now the first commit
> of that topic.  The changes are those mentioned in [1]:
> 
>  - updated commit message,
>  - renamed 'refspec_count' to 'refspec_nr',

Good.

>  - use the parsed fetch refspecs returned by remote.c:remote_get()
>    instead of parsing them ourselves (look at the third hunk of the
>    diff of builtin/clone.c, how much shorter it looks),

Yeah, that is much nicer. It does feel a little dirty modifying
remote->fetch, though. I'll comment on the specific patch.

>  - modified tests to check that refs matching the default refspecs are
>    transferred as well, and
>  - added a test for the combination of '-c
>    remote.<remote>.fetch=<refspec> --origin=<name>'.

Sounds good.

> The second patch is a doc update to warn users that not all
> configuration variables are supported via 'git clone -c ...' at the
> moment.

Good idea.

> Patches 3 and 4 are the last two patches from Peff from this morning
> [2].  I picked those up, because his last patch required a bit of
> variable name adjustments.  I didn't pick up his first patch, because
> using remote_get() already factors out refspec parsing.

Makes sense. Thanks for including them.

-Peff
