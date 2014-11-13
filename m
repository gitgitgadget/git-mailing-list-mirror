From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Thu, 13 Nov 2014 16:37:19 -0500
Message-ID: <20141113213719.GC7563@peff.net>
References: <CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
 <CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
 <CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
 <20141108083040.GA15833@peff.net>
 <xmqqbnoge1ci.fsf@gitster.dls.corp.google.com>
 <20141113183033.GA24107@peff.net>
 <xmqqbnoa29ps.fsf@gitster.dls.corp.google.com>
 <20141113192655.GA3413@peff.net>
 <20141113200315.GA3869@peff.net>
 <xmqqmw7uztn0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:37:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp25H-00060g-Id
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934113AbaKMVhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:37:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:40131 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934655AbaKMVhV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:37:21 -0500
Received: (qmail 17461 invoked by uid 102); 13 Nov 2014 21:37:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 15:37:21 -0600
Received: (qmail 32089 invoked by uid 107); 13 Nov 2014 21:37:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 16:37:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 16:37:19 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmw7uztn0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 01:18:43PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Nov 13, 2014 at 02:26:55PM -0500, Jeff King wrote:
> >
> >> > Makes sense, including the use of strbuf (otherwise you would
> >> > allocate ce and then discard when it turns out that it is not
> >> > needed, which is probably with the same allocation pressure, but
> >> > looks uglier).
> >> 
> >> Exactly. Constructing it in ce->name does save you an allocation/memcpy
> >> in the case that we actually use the new entry, but I thought it would
> >> look weirder. It probably doesn't matter much either way, so I tried to
> >> write the most obvious thing.
> >
> > Actually, it is not that bad:
> 
> Yeah, actually it does look better; want me to squash it into the
> patch before queuing?

Yeah, if you like it, too, then let's go with it. Thanks.

-Peff
