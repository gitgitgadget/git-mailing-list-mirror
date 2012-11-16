From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Fri, 16 Nov 2012 11:08:11 -0800
Message-ID: <20121116190811.GB2310@sigill.intra.peff.net>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003640.GH17819@sigill.intra.peff.net>
 <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
 <20121115083315.GA23377@sigill.intra.peff.net>
 <CAMP44s2NBGDRLUKhBTU+kNy7Fyn8T6qm3nneSbS4rrNN1oPgdw@mail.gmail.com>
 <20121115104345.GA32465@sigill.intra.peff.net>
 <20121115111334.GA1879@sigill.intra.peff.net>
 <7vvcd6954q.fsf@alter.siamese.dyndns.org>
 <20121115172845.GA20298@sigill.intra.peff.net>
 <7vzk2i6s9h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 20:08:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZRHA-0007D0-Iw
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 20:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab2KPTIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 14:08:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50563 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193Ab2KPTIO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 14:08:14 -0500
Received: (qmail 29891 invoked by uid 107); 16 Nov 2012 19:09:03 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Nov 2012 14:09:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2012 11:08:11 -0800
Content-Disposition: inline
In-Reply-To: <7vzk2i6s9h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209895>

On Thu, Nov 15, 2012 at 09:17:30PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That is a good question. That confirmation step does come after they
> > have typed their cover letter. However, if they are using --compose,
> > they are dumped in their editor with something like:
> >
> >   From Jeff King <peff@peff.net> # This line is ignored.
> >   GIT: Lines beginning in "GIT:" will be removed.
> >   GIT: Consider including an overall diffstat or table of contents
> >   GIT: for the patch you are writing.
> >   GIT:
> >   GIT: Clear the body content if you don't wish to send a summary.
> >   From: Jeff King <peff@peff.net>
> >   Subject: 
> >   In-Reply-To: 
> >
> > which I think would count as sufficient notice of the address being
> > used.
> 
> OK.  Tentatively I replaced your old series with these 8 patches
> including the last one, as I tend to agree with the value the
> earlier clean-up in the series gives us in the longer term.  As you
> and Felipe discussed, we may want to replace the last one with a
> simpler "don't bother asking" patch, but I think that is more or
> less an orthogonal issue.

I'm not sure how orthogonal it is. The latter half of my series is about
exposing the user_ident_sufficiently_given() flag. If we go with
Felipe's patch, then that exposed information has no users, and it may
not be worth it (OTOH, it's possible that some third-party script may
want it).

-Peff
