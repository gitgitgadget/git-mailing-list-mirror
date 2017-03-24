Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5405120966
	for <e@80x24.org>; Fri, 24 Mar 2017 20:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935974AbdCXUBe (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 16:01:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:51341 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935840AbdCXUBd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 16:01:33 -0400
Received: (qmail 29611 invoked by uid 109); 24 Mar 2017 20:01:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 20:01:33 +0000
Received: (qmail 23718 invoked by uid 111); 24 Mar 2017 20:01:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 16:01:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 16:01:30 -0400
Date:   Fri, 24 Mar 2017 16:01:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv2 00/14] completion: speed up refs completion
Message-ID: <20170324200130.jpn4uxanvpdogaag@sigill.intra.peff.net>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
 <xmqqshm3dezf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqshm3dezf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 11:28:52AM -0700, Junio C Hamano wrote:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > This series is the updated version of 'sg/completion-refs-speedup'.
> > It speeds up refs completion for large number of refs, partly by
> > giving up disambiguating ambiguous refs and partly by eliminating most
> > of the shell processing between 'git for-each-ref' and 'ls-remote' and
> > Bash's completion facility.  The rest is a bit of preparatory
> > reorganization, cleanup and bugfixes.
> >
> > Changes since v1:
> > ...
> > [1] - http://public-inbox.org/git/20170206181545.12869-1-szeder.dev@gmail.com/
> 
> It seems Jacob Keller was the only person who was excited about
> these changes when v1 was posted?  It would be nice to see a bit
> more enthusiasm from other folks who are invested in the completion
> script, but you are the de-facto go-to person on the completion
> already, so ... ;-)
> 
> Will replace.  Let's advance this to 'next' soonish (say, by early
> next week).

I'm far from an expert in the completion scripts, but I read over the
whole thing and it looked good to me. As usual with bash, the
optimizations can make the code a bit non-intuitive, but I think the
changes are clearly explained and the performance results speak for
themselves.

-Peff
