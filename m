From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] pkt-line: support tracing verbatim pack contents
Date: Tue, 16 Jun 2015 13:18:49 -0400
Message-ID: <20150616171849.GD18667@peff.net>
References: <20150612212526.GA25447@peff.net>
 <20150612212827.GC25757@peff.net>
 <CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
 <20150616171005.GB18667@peff.net>
 <CAHcr6HYA=gpMTaJ5WOOmtEp+J4wBMz9D59fbByzsdBkPRf4CZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:19:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4uVn-000292-SJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 19:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbbFPRSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 13:18:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:46893 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751162AbbFPRSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 13:18:52 -0400
Received: (qmail 14491 invoked by uid 102); 16 Jun 2015 17:18:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 12:18:52 -0500
Received: (qmail 16853 invoked by uid 107); 16 Jun 2015 17:18:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 13:18:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 13:18:49 -0400
Content-Disposition: inline
In-Reply-To: <CAHcr6HYA=gpMTaJ5WOOmtEp+J4wBMz9D59fbByzsdBkPRf4CZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271782>

On Tue, Jun 16, 2015 at 01:14:03PM -0400, Augie Fackler wrote:

> Yeah, not having it for the push side is a slight bummer, but in
> general I haven't had problems debugging git clients pushing bogus
> data in the same way that I've had problems with weirdness in new
> server features.

Being in charge of a large git server farm, I think I have the opposite
problem. :)

> > Here's a rough cut at the "trace stdin" idea I mentioned earlier (which
> > is essentially an internal "tee"). You can collect the incoming pack
> > like:
> 
> Neat, but not sure I like the extra overhead of having to grab the
> full trace and then reconstruct some arguments to be able to diagnose
> the pack. Having the verbatim pack just land on disk is really handy,
> because then any existing tools one has cooked up (my team has a few
> weird one-off ones by now) just work without extra fussing or looking
> up steps to reconstruct the whole file.

I guess there is really room for both. Just because you _can_ accomplish
the same thing with both does not mean we cannot have two ways to do it
(an easy way, and a harder, more flexible way).

-Peff
