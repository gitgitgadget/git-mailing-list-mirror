Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 886042018F
	for <e@80x24.org>; Wed, 13 Jul 2016 22:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbcGMWnF (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 18:43:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:44387 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751349AbcGMWnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 18:43:04 -0400
Received: (qmail 22348 invoked by uid 102); 13 Jul 2016 22:43:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jul 2016 18:43:03 -0400
Received: (qmail 18081 invoked by uid 107); 13 Jul 2016 22:43:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jul 2016 18:43:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2016 18:42:56 -0400
Date:	Wed, 13 Jul 2016 18:42:56 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, Shawn Pearce <sop@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
Message-ID: <20160713224256.GA8980@sigill.intra.peff.net>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY7pWUG7Q0fDhieHCBCpR5RCongzHth6DWOJaEkcGqMEA@mail.gmail.com>
 <xmqqpoqh1m0o.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYUMX7wewo2QEWQGU9sGR76XjrKJ3uJxpLnyWoZeZ6WXA@mail.gmail.com>
 <xmqqinw9yxdu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinw9yxdu.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 03:41:01PM -0700, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> >>> I think Shawns proposal to have a receive.maxCommandBytes is a
> >>> good way for an overall upper bound, but how does it stop us from
> >>> going forward with this series?
> >>
> >> If we were to do maxcommandbytes, then max_options would become
> >> irrelevant, no?
> >
> > Maybe?
> >
> > I do not know what kind of safety measures we want in place here, and
> > if we want to go for overlapping things?
> >
> > Currently there are none at all in your upstream code, although you cannot
> > push arbitrary large things to either Shawns or Peffs $Dayjob servers, so
> > I wonder if we want to either agree on one format or on many overlapping
> > things, as some different hosts may perceive different things as DoS threats,
> > so they can fine tune as they want?
> 
> I think those extra knobs can come later.  If we are not going to
> limit with max_options in the end, however, wouldn't it be more
> natural for the initial iteration without any configuration not to
> have hard-coded max_options at all?

Yeah, I am OK with adding restrictive knobs later as a separate topic.
As Stefan notes, upstream does not have the other knobs anyway, and IIRC
the push-options feature is not even enabled by default.

-Peff
