From: Jeff King <peff@peff.net>
Subject: Re: Doesn't disambiguate between 'external command failed' and
 'command not found'
Date: Wed, 6 Jul 2011 13:56:15 -0400
Message-ID: <20110706175615.GA17978@sigill.intra.peff.net>
References: <1309884564.18513.12.camel@umgah>
 <4E137701.1020007@elegosoft.com>
 <20110705231604.GC12085@sigill.intra.peff.net>
 <7vpqlnmidy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org,
	Alex Vandiver <alex@chmrr.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 19:56:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeWKm-0000Dl-E0
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 19:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab1GFR4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 13:56:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46130
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031Ab1GFR4S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 13:56:18 -0400
Received: (qmail 23077 invoked by uid 107); 6 Jul 2011 17:56:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Jul 2011 13:56:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jul 2011 13:56:15 -0400
Content-Disposition: inline
In-Reply-To: <7vpqlnmidy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176716>

On Wed, Jul 06, 2011 at 10:24:57AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not all that happy with the advice, though. It's pretty technical
> > and specific. I'm not sure whether it would be helpful to most users or
> > not.
> 
> Yeah, Michael's rewording makes it fuzzier by saying "exists, unable to
> execute, maybe git-%s is broken?".

Yeah, I like his better.

> I notice that we do not give the path to the file that implements the
> command. Perhaps we should walk the $PATH after we see this failure to
> pinpoint which one is to be inspected (I vaguely recall a weatherbaloon
> patch to a similar effect)?

That would be better still. But I don't know how much effort this is
really worth. It is about catching one specific uncommon
misconfiguration. If it were part of a more general exec wrapper that
gave better output (which I think is the weatherballoon you mean, that
you did a month or three ago), I think it might be more worthwhile.

But even then, I seem to remember the discussion fizzling out to "is
this really that common a problem?"

So I'm happy with just taking Michael's patch.

-Peff
