Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7F8202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 19:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbdJSTz5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 15:55:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:58114 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753443AbdJSTzz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 15:55:55 -0400
Received: (qmail 1482 invoked by uid 109); 19 Oct 2017 19:55:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 19:55:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11812 invoked by uid 111); 19 Oct 2017 19:55:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 15:55:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Oct 2017 15:55:52 -0400
Date:   Thu, 19 Oct 2017 15:55:52 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] diff.c: increment buffer pointer in all code path
Message-ID: <20171019195552.sg7su63a4qqwa4v5@sigill.intra.peff.net>
References: <20171012200536.m6oz4zrjcze3yw4i@sigill.intra.peff.net>
 <20171012233322.31203-1-sbeller@google.com>
 <20171013001837.43nx5paeqisbrflq@sigill.intra.peff.net>
 <20171013002057.froqi54olmhmah6b@sigill.intra.peff.net>
 <20171019050459.p2cx63yrxfwq4ta3@sigill.intra.peff.net>
 <20171019052457.gqenoshgyjcw53tb@sigill.intra.peff.net>
 <CAGZ79kbRFVd=hbc4DCrdkOJ4aUE_g1_NhMbG-tfPGnOJikf1GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbRFVd=hbc4DCrdkOJ4aUE_g1_NhMbG-tfPGnOJikf1GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 12:53:03PM -0700, Stefan Beller wrote:

> > @@ -771,7 +771,7 @@ static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_opti
> >  {
> >         if (o->xdl_opts & XDF_WHITESPACE_FLAGS) {
> >                 static struct strbuf sb = STRBUF_INIT;
> > -               const char *ap = es->line, *ae = es->line + es->len;
> > +               const char *ap = es->line, *ae = es->line + es->len - 1;
> >                 int c;
> >
> >                 strbuf_reset(&sb);
> >
> > it does. It just adjusts our "end pointer" to point to the last valid
> > character in the string (rather than one past),
> 
> Thanks for spotting. I can send a proper patch with tests if you'd like.

I'm putting the finishing touches on a series that should be out in a
few minutes. Hold off until then.

-Peff
