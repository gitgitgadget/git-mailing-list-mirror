From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Thu, 15 Nov 2012 03:13:47 -0800
Message-ID: <20121115111334.GA1879@sigill.intra.peff.net>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003640.GH17819@sigill.intra.peff.net>
 <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
 <20121115083315.GA23377@sigill.intra.peff.net>
 <CAMP44s2NBGDRLUKhBTU+kNy7Fyn8T6qm3nneSbS4rrNN1oPgdw@mail.gmail.com>
 <20121115104345.GA32465@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 12:14:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYxOX-0006yv-S6
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 12:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423609Ab2KOLNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 06:13:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49267 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423250Ab2KOLNv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 06:13:51 -0500
Received: (qmail 15513 invoked by uid 107); 15 Nov 2012 11:14:40 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 06:14:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 03:13:47 -0800
Content-Disposition: inline
In-Reply-To: <20121115104345.GA32465@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209815>

On Thu, Nov 15, 2012 at 02:43:58AM -0800, Jeff King wrote:

> > And doesn't have any of the following:
> > 
> >  * configured user.name/user.email
> >  * specified $EMAIL
> >  * configured sendemail.from
> >  * specified --from argument
> > 
> > Very unlikely.
> 
> That is certainly the opinion you have stated already. I'm not sure I
> agree. Linus, for example, was an advocate of such a configuration early
> on in git's history. I don't think he still runs that way, though.
> 
> > And then, what would be the consequences of not receiving this prompt?
> 
> An email would be sent with the generated identity.

I suspect you did not need me to answer that question, but were setting
it up as a rhetorical trap to mention the final confirmation, which I
failed to note in my response.

I think a much more compelling argument/commit message for your
suggested patch would be:

  We currently prompt the user for the "From" address. This is an
  inconvenience in the common case that the user has configured their
  identity in the environment, but is meant as a safety check for when
  git falls back to an implicitly generated identity (which may or may
  not be valid).

  That safety check is not really necessary, though, as by default
  send-email will prompt the user for a final confirmation before
  sending out any message. The likelihood that a user has both bothered
  to turn off this default _and_ not configured any identity (nor
  checked that the automatic identity is valid) is rather low.

I could accept that line of reasoning.  I see that this argument is
buried deep in your commit message, but I will admit to not reading your
9-point list of conditions all that closely, as the first 7 points are,
in my opinion, not relevant (and I had already read and disagreed with
them in other messages).

-Peff
