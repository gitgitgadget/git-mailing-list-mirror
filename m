Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A97F20226
	for <e@80x24.org>; Thu,  4 Aug 2016 07:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbcHDHpT (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 03:45:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:54628 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751198AbcHDHpS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 03:45:18 -0400
Received: (qmail 12444 invoked by uid 102); 4 Aug 2016 07:38:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:38:38 -0400
Received: (qmail 10781 invoked by uid 107); 4 Aug 2016 07:39:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:39:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 03:38:33 -0400
Date:	Thu, 4 Aug 2016 03:38:33 -0400
From:	Jeff King <peff@peff.net>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/8] Better heuristics make prettier diffs
Message-ID: <20160804073833.7s3hh26hkalifima@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1470259583.git.mhagger@alum.mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 12:00:28AM +0200, Michael Haggerty wrote:

> I've talked about this quite a bit on the list already. The idea is to
> improve ugly diffs like
> 
>     @@ -231,6 +231,9 @@ if (!defined $initial_reply_to && $prompting) {
>      }
> 
>      if (!$smtp_server) {
>     +       $smtp_server = $repo->config('sendemail.smtpserver');
>     +}
>     +if (!$smtp_server) {
>             foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
>                     if (-x $_) {
>                             $smtp_server = $_;

Not that you probably need more random cases of C code, but I happened
to be looking at a diff in git.git today, b333d0d6, which is another
regression for the compaction heuristic. The indent heuristic here gets
it right.

Coincidentally, another example is the final patch in this series.

So I am already happier even without digging further yet. :)

-Peff
