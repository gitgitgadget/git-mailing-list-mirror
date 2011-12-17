From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 16 Dec 2011 20:17:51 -0500
Message-ID: <20111217011751.GA20225@sigill.intra.peff.net>
References: <20111216110000.GA15676@sigill.intra.peff.net>
 <4EEB4F13.2010402@viscovery.net>
 <20111216192104.GA19924@sigill.intra.peff.net>
 <7vehw4ia5x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 02:17:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbiuU-0003n5-Ou
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 02:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756592Ab1LQBRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 20:17:55 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44477
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab1LQBRx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 20:17:53 -0500
Received: (qmail 9299 invoked by uid 107); 17 Dec 2011 01:24:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Dec 2011 20:24:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Dec 2011 20:17:51 -0500
Content-Disposition: inline
In-Reply-To: <7vehw4ia5x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187343>

On Fri, Dec 16, 2011 at 11:33:30AM -0800, Junio C Hamano wrote:

> I think we recently saw that the optional built-in one for C did not even
> understand a function that returns a pointer, and nobody complained about
> it for a long time,

Yeah. That implies to me that either people don't really care about
this feature, or that they are not actually using it because it requires
special configuration (we are not even using it in git.git, for
example).

> > And if it is bad on balance, is the right solution to avoid exposing
> > people to it, or is it to make our patterns better?
> 
> Can't we do both, by avoid exposing normal users to broken one while
> people who want to improve the pattern based one work on unbreak it?

Sure, we can do both. But if nobody is eating the dogfood, it will never
grow to taste better. Maybe we should start by using diff=c in git
itself?

> > I.e., is it fixable,
> > or is it simply too hard a problem to get right in the general case, and
> > we shouldn't turn it on by default?
> 
> I do not think that is the "either-or" question. My impression has been
> that even if it is fixable, it is too broken and produces worse result
> than the simple default in its current form.

What I meant by the either-or was: if it is fixable, then we should fix
it and consider turning it on as a default. If it's too hard to get
right, then we probably never want it on by default, and people who do
like it can turn it on (presumably because it works on their code
style).

-Peff
