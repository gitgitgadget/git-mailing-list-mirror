Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC722018A
	for <e@80x24.org>; Fri,  1 Jul 2016 22:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbcGAWjR (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 18:39:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:39421 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752182AbcGAWjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 18:39:16 -0400
Received: (qmail 1796 invoked by uid 102); 1 Jul 2016 22:39:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 18:39:17 -0400
Received: (qmail 24123 invoked by uid 107); 1 Jul 2016 22:39:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 18:39:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 18:39:12 -0400
Date:	Fri, 1 Jul 2016 18:39:12 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"dmh@ucar.edu" <dmh@ucar.edu>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] consistent setup code for external commands
Message-ID: <20160701223912.GB32545@sigill.intra.peff.net>
References: <7210bce6-093b-9fdf-9a9b-94059ad0d4e3@ucar.edu>
 <20160701040715.GB4832@sigill.intra.peff.net>
 <20160701055532.GA4488@sigill.intra.peff.net>
 <xmqq4m89vw5i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m89vw5i.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 01, 2016 at 03:19:37PM -0700, Junio C Hamano wrote:

> > Here they are:
> >
> >   [1/5]: add an extra level of indirection to main()
> >   [2/5]: common-main: call git_extract_argv0_path()
> >   [3/5]: common-main: call sanitize_stdfds()
> >   [4/5]: common-main: call restore_sigpipe_to_default()
> >   [5/5]: common-main: call git_setup_gettext()
> 
> As this is also a fix to maint-2.8 track, I tweaked them to ensure
> that they apply there, and queued the result as jk/common-main.  I
> double checked the result by comparing the result of applying these
> five patches directly on top of master, and the result of merging
> that jk/common-main (based on maint-2.8) into master, and they seem
> to match.

Thanks, this obviously is a regression in v2.8, but I didn't even think
about that and just built it on top of master.

I think the cleanup that Dscho suggested elsewhere in the thread is a
good idea on top, but that can also just wait and come separately.

-Peff
