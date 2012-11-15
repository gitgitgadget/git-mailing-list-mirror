From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Thu, 15 Nov 2012 09:28:47 -0800
Message-ID: <20121115172845.GA20298@sigill.intra.peff.net>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003640.GH17819@sigill.intra.peff.net>
 <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
 <20121115083315.GA23377@sigill.intra.peff.net>
 <CAMP44s2NBGDRLUKhBTU+kNy7Fyn8T6qm3nneSbS4rrNN1oPgdw@mail.gmail.com>
 <20121115104345.GA32465@sigill.intra.peff.net>
 <20121115111334.GA1879@sigill.intra.peff.net>
 <7vvcd6954q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 18:29:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ3FS-0000Wg-Eg
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 18:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993456Ab2KOR2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 12:28:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49604 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271Ab2KOR2v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 12:28:51 -0500
Received: (qmail 18657 invoked by uid 107); 15 Nov 2012 17:29:40 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 12:29:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 09:28:47 -0800
Content-Disposition: inline
In-Reply-To: <7vvcd6954q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209834>

On Thu, Nov 15, 2012 at 08:56:37AM -0800, Junio C Hamano wrote:

> > I think a much more compelling argument/commit message for your
> > suggested patch would be:
> >
> >   We currently prompt the user for the "From" address. This is an
> >   inconvenience in the common case that the user has configured their
> >   identity in the environment, but is meant as a safety check for when
> >   git falls back to an implicitly generated identity (which may or may
> >   not be valid).
> >
> >   That safety check is not really necessary, though, as by default
> >   send-email will prompt the user for a final confirmation before
> >   sending out any message. The likelihood that a user has both bothered
> >   to turn off this default _and_ not configured any identity (nor
> >   checked that the automatic identity is valid) is rather low.
> 
> This somehow reminds me of the first paragraph of f20f387 (commit:
> check committer identity more strictly, 2012-07-23).
> 
> I never use "send-email driving format-patch" workflow myself, but I
> suspect there are people among who do so who are using --compose to
> do the cover letter of their series.  Does the "confirmation as the
> last step" help them, or would they have to retype their message?

That is a good question. That confirmation step does come after they
have typed their cover letter. However, if they are using --compose,
they are dumped in their editor with something like:

  From Jeff King <peff@peff.net> # This line is ignored.
  GIT: Lines beginning in "GIT:" will be removed.
  GIT: Consider including an overall diffstat or table of contents
  GIT: for the patch you are writing.
  GIT:
  GIT: Clear the body content if you don't wish to send a summary.
  From: Jeff King <peff@peff.net>
  Subject: 
  In-Reply-To: 

which I think would count as sufficient notice of the address being
used.

-Peff
