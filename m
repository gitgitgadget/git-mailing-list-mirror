From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format_commit_message: honor `color=auto` for `%C(auto)`
Date: Tue, 31 May 2016 18:18:05 -0400
Message-ID: <20160531221805.GB3824@sigill.intra.peff.net>
References: <20160525015649.GA13258@zoidberg>
 <20160525223904.GD13776@sigill.intra.peff.net>
 <CACsJy8BF6woZy8WUsJzVFqaMDCOMEYK-3xFNNeOQ6B+OMyqJLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:18:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7rzL-0001sL-F5
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 00:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbcEaWSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 18:18:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:46784 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750730AbcEaWSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 18:18:09 -0400
Received: (qmail 1014 invoked by uid 102); 31 May 2016 22:18:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 18:18:09 -0400
Received: (qmail 27798 invoked by uid 107); 31 May 2016 22:18:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 18:18:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2016 18:18:05 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BF6woZy8WUsJzVFqaMDCOMEYK-3xFNNeOQ6B+OMyqJLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296022>

On Tue, May 31, 2016 at 07:23:32PM +0700, Duy Nguyen wrote:

> I think the (old) "auto" here means "automatically select the
> color" and what you do would be equivalent to %(auto,auto) where the
> first (and new) "auto" is about on/off switch, and the second is about
> selecting the actual color.

Ah, right. The current behavior does make more sense if you realize we
are talking about two different meaning of "auto" here.

> > I think it's worth mentioning this explicitly in the commit message. We
> > could also add "%C(on)", I guess, but it's unclear to me whether anybody
> > would want it (they would probably just use "--color" in that case,
> > unless they really want unconditional coloring for just _some_
> > elements).
> 
> If I could redo, I would go with %C(default) instead of %C(auto) then
> we could have %C(auto,default). Perhaps we can make %C(auto) an
> equivalent of %C(auto,default) now (i.e. exactly what this patch does)
> and at some point in future add %C(default) which is what %C(auto) is
> now if people really need to force it on?

That makes a lot of sense to me. It does change the current meaning of
"%C(auto)", but the current state is sufficiently confusing that I think
we can call the existing behavior a bug. I'm ambivalent on either
implementing %C(default) now, or waiting until somebody actually wants
it.

Thanks for clarifying the history.

-Peff
