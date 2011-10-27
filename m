From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Thu, 27 Oct 2011 16:44:29 -0700
Message-ID: <20111027234429.GA28187@sigill.intra.peff.net>
References: <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
 <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
 <20111024224558.GB10481@sigill.intra.peff.net>
 <7vvcrd411x.fsf@alter.siamese.dyndns.org>
 <20111027181303.GF1967@sigill.intra.peff.net>
 <7v7h3qz2yo.fsf@alter.siamese.dyndns.org>
 <20111027185220.GA26621@sigill.intra.peff.net>
 <7v39eez1ph.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 01:44:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJZcp-0007Nk-2b
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 01:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088Ab1J0Xod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 19:44:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56853
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591Ab1J0Xod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 19:44:33 -0400
Received: (qmail 5648 invoked by uid 107); 27 Oct 2011 23:50:20 -0000
Received: from c-67-169-41-183.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.41.183)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Oct 2011 19:50:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2011 16:44:29 -0700
Content-Disposition: inline
In-Reply-To: <7v39eez1ph.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184331>

On Thu, Oct 27, 2011 at 12:14:34PM -0700, Junio C Hamano wrote:

> > Minor nit, but this is just for diff, so it is not about clean/smudge
> > but rather about doing something like textconv.
> 
> I can understand if some tools in the Windows land prefer to work with
> these encodings, so clean/smudge to have the checkout in these encodings
> would be a reasonable thing not just diff but things like grep. On the
> other hand, I do doubt the sanity of these people if they want to have
> in-repository representation also in these encodings.

I'm pretty much of the same mind. We do have people with utf-16 in their
repositories on github. I have no idea why they do such a thing, or what
kinds of tricks they do to make it usable (because without it, they just
get "binary files differ").

My interest is to make things like bare-repository diff (and everything
built on it; i.e., things like github, gitweb, or whatever) do the sane
thing for these people, even if I think what they're doing is wrong. And
as always, I try to structure the git portions of that as much as
possible to be general and help everybody, so they can be pushed
upstream (also, then I don't have to worry about managing local changes
:) ).

But it sounds like this is probably just too ugly and should end up as a
github-specific thing.

-Peff
