From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push: --follow-tag
Date: Tue, 5 Mar 2013 13:18:50 -0500
Message-ID: <20130305181850.GA10928@sigill.intra.peff.net>
References: <7vd2vewu24.fsf@alter.siamese.dyndns.org>
 <7v6216wtrk.fsf@alter.siamese.dyndns.org>
 <20130305082204.GB13552@sigill.intra.peff.net>
 <7vlia1vnwq.fsf@alter.siamese.dyndns.org>
 <20130305172233.GA9379@sigill.intra.peff.net>
 <7vobexu30n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 19:19:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCwSM-0008EB-OE
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 19:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758132Ab3CESSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 13:18:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35474 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756385Ab3CESSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 13:18:52 -0500
Received: (qmail 16740 invoked by uid 107); 5 Mar 2013 18:20:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Mar 2013 13:20:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2013 13:18:50 -0500
Content-Disposition: inline
In-Reply-To: <7vobexu30n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217471>

On Tue, Mar 05, 2013 at 10:15:20AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But I wonder if fetching and pushing are different in that respect. You
> > are (usually) fetching from a public publishing point, and it is assumed
> > that whatever is there is useful for sharing. The only reason to limit
> > it is to save time transferring objects the user does not want.
> 
> There are those who have to emulate "git fetch" with a reverse "git
> push" (or vice versa) due to network connection limitations, so I do
> not think hardcoding such a policy decision in the direction is
> necessarily a good idea.

Yeah, but I think it makes sense to optimize the defaults for the common
cases, and let people doing unusual things override the behavior via
options (or even config).

Don't get me wrong, I think there is value in the simplicity of having
the push/fetch transactions be as symmetric as possible. But given the
potentially high cost of a mistaken push (i.e., retracting published
history can be embarrassing or complicated), there's also value in safe
defaults. And I feel like we've already gone in that direction with the
default refspecs being different between fetch and push.

-Peff
