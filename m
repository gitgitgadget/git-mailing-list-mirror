Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31321F453
	for <e@80x24.org>; Mon, 29 Oct 2018 15:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeJ3Abi (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 20:31:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:59210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727659AbeJ3Abi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 20:31:38 -0400
Received: (qmail 23520 invoked by uid 109); 29 Oct 2018 15:42:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 15:42:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18732 invoked by uid 111); 29 Oct 2018 15:41:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 11:41:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 11:42:28 -0400
Date:   Mon, 29 Oct 2018 11:42:28 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: introduce the '-V' short option for
 '--verbose-log'
Message-ID: <20181029154228.GA27538@sigill.intra.peff.net>
References: <20181029121359.7323-1-szeder.dev@gmail.com>
 <20181029142108.GD17668@sigill.intra.peff.net>
 <20181029135335.GS30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181029135335.GS30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 02:53:35PM +0100, SZEDER Gábor wrote:

> > Interesting. I'm not opposed to something like this, but I added
> > "--verbose-log" specifically for scripted cases, like running an
> > unattended "prove" that needs to preserve stdout. When running
> > individual tests, I'd just use "-v" itself, and possibly redirect the
> > output.
> > 
> > For my curiosity, can you describe your use case a bit more?
> 
> Even when I run individual test scripts by hand, I prefer to have a
> file catching all output of the test, because I don't like it when the
> test output floods my terminal (especially with '-x'), and because the
> file is searchable but the terminal isn't.  And that's exactly what
> '--verbose-log' does.
> 
> Redirecting the '-v' output (i.e. stdout) alone is insufficient,
> because any error messages within the tests and the '-x' trace go to
> stderr, so they still end up on the terminal.  Therefore I would have
> to remember to redirect stderr every time as well.
> 
> I find it's much easier to just always use '--verbose-log'... except
> for the length of the option, that is, hence this patch.

OK, fair enough. Maybe I should start using "-V" too, then. ;)

(I find myself most often coupling "-v" with "-i" to stop at the failure
and just read what's left on the screen).

-Peff
