From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 18:24:40 -0400
Message-ID: <20120521222440.GB22664@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <201205211215.14455.mfick@codeaurora.org>
 <20120521194114.GA28358@sigill.intra.peff.net>
 <7vvcjp6vbl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 00:24:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWb1z-0007Nr-Nj
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759437Ab2EUWYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:24:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51169
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab2EUWYn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:24:43 -0400
Received: (qmail 7203 invoked by uid 107); 21 May 2012 22:25:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 18:25:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 18:24:40 -0400
Content-Disposition: inline
In-Reply-To: <7vvcjp6vbl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198144>

On Mon, May 21, 2012 at 03:08:46PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Anyway, my point is that we don't even have to talk about "reasonable"
> > or "absurd".  Git should be fast even on absurd cases,...
> 
> I agree with you 98%.
> 
> If we can make Git fast even on "absurd" cases without penalizing less
> extreme and boring cases and/or maintainability of the code, we should
> strive to do so.  And I think the codepaths mentioned in this thread falls
> into that category.
> 
> The remaining 2% is only to allow me to say that we reserve the right to
> label cases "absurd" when it is extremely painful to support without
> penalizing the code and performance of less extreme and boring cases ;-)

Yes, I should be more careful with what I promise. :) I agree very much
that we should reserve that right.

-Peff
