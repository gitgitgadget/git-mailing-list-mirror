From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 1 Jun 2016 16:32:43 -0400
Message-ID: <20160601203243.GA15490@sigill.intra.peff.net>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
 <xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
 <xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
 <20160601163747.GA10721@sigill.intra.peff.net>
 <20160601183100.GN1355@john.keeping.me.uk>
 <20160601190759.GB12496@sigill.intra.peff.net>
 <20160601191621.GO1355@john.keeping.me.uk>
 <xmqqinxsy9q0.fsf@gitster.mtv.corp.google.com>
 <20160601202852.GP1355@john.keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jun 01 22:32:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Cos-0005w0-T5
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 22:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbcFAUcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 16:32:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:47504 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750765AbcFAUcq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 16:32:46 -0400
Received: (qmail 27192 invoked by uid 102); 1 Jun 2016 20:32:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 16:32:45 -0400
Received: (qmail 4773 invoked by uid 107); 1 Jun 2016 20:32:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 16:32:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 16:32:43 -0400
Content-Disposition: inline
In-Reply-To: <20160601202852.GP1355@john.keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296159>

On Wed, Jun 01, 2016 at 09:28:53PM +0100, John Keeping wrote:

> > So either way, I do not think "local variable names" that breaks
> > &&-chain can be justified.  Either the variable must be localized
> > for the script to work correctly, in which case we want local with
> > &&-chaining, or it does not have to, in which case we do not want to
> > have "local" that is not necessary, no?
> 
> Absolutely, my original point should have been prefixed with: I wonder
> if the reason we haven't had any problems reported is because ...
> 
> And we've got lucky because the clobbering of global variables happens
> not to matter in these particular cases.

Ah, OK, what you were saying makes much more sense to me now, then.

Even on a shell like ksh93 that does not grok local at all, there is a
good chance that nobody ever looked at the "-v" output for the test,
which would not have been failing, to see that it was complaining.

So I agree we can't really take "no problems reported" on these existing
cases as any kind of data point.

-Peff
