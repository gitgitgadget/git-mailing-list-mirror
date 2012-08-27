From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/17] Name local variables more consistently
Date: Mon, 27 Aug 2012 05:25:02 -0400
Message-ID: <20120827092502.GA2428@sigill.intra.peff.net>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <1345709442-16046-5-git-send-email-mhagger@alum.mit.edu>
 <20120823083918.GB6963@sigill.intra.peff.net>
 <7vvcg5v9hh.fsf@alter.siamese.dyndns.org>
 <503B3C5C.1020109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 27 11:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5vZN-0000Vl-Jj
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 11:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab2H0JZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 05:25:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39552 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab2H0JZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 05:25:07 -0400
Received: (qmail 11415 invoked by uid 107); 27 Aug 2012 09:25:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Aug 2012 05:25:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2012 05:25:02 -0400
Content-Disposition: inline
In-Reply-To: <503B3C5C.1020109@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204330>

On Mon, Aug 27, 2012 at 11:22:36AM +0200, Michael Haggerty wrote:

> > Using one name is better, but I wonder "heads" is the better one
> > between the two.
> > 
> > After all, this codepath is not limited to branches these days as
> > the word "head" implies.  Rather, <nr_thing, thing> has what we
> > asked for, and <refs> has what the other sides have, and we are
> > trying to make sure we haven't asked what they do not have in this
> > function.
> > 
> > And the way we do so is to match the "thing"s with what are in
> > "refs" to find unmatched ones.
> > 
> > So between the two, I would have chosen "match" instead of "heads"
> > to call the "thing".
> 
> When I decided between "heads" and "match", my main consideration was
> that "match" sounds like something that has already been matched, not
> something that is being matched against.  The word "match" also implies
> to me that some nontrivial matching process is going on, like glob
> expansion.
> 
> But I agree with you that "heads" also has disadvantages.
> 
> What about a third option: "refnames"?  This name makes it clear that we
> are talking about simple names as opposed to "struct ref" or some kind
> of refname glob patterns and also makes it clear that they are not
> necessarily all branches.  It would also be distinct from the "refs"
> linked list that is often used in the same functions.

Yeah, I agree that "refnames" would be better. I think something like
"spec" or "refspec" would indicate better that they are to be matched
against, but then you run afoul of confusing that with colon-delimited
refspecs (which I do not think fetch-pack understands at all).

-Peff
