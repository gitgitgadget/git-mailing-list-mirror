From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] transport-helper: mention helper name when it dies
Date: Wed, 10 Apr 2013 17:28:33 -0400
Message-ID: <20130410212833.GA5909@sigill.intra.peff.net>
References: <20130410211311.GA24277@sigill.intra.peff.net>
 <20130410211603.GB3256@sigill.intra.peff.net>
 <CAGdFq_j5vB+OJAkuk-EMLjyrbiY7QrBiwWPraPA7SWTtuUqgZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:28:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2ZR-0004nf-CN
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935371Ab3DJV2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:28:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39261 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934621Ab3DJV2k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:28:40 -0400
Received: (qmail 7923 invoked by uid 107); 10 Apr 2013 21:30:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 17:30:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 17:28:33 -0400
Content-Disposition: inline
In-Reply-To: <CAGdFq_j5vB+OJAkuk-EMLjyrbiY7QrBiwWPraPA7SWTtuUqgZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220774>

On Wed, Apr 10, 2013 at 02:23:56PM -0700, Sverre Rabbelier wrote:

> On Wed, Apr 10, 2013 at 2:16 PM, Jeff King <peff@peff.net> wrote:
> > When we try to read from a remote-helper and get EOF or an
> > error, we print a message indicating that the helper died.
> > However, users may not know that a remote helper was in use
> > (e.g., when using git-over-http), or even what a remote
> > helper is.
> >
> > Let's print the name of the helper (e.g., "git-remote-https");
> > this makes it more obvious what the program is for, and
> > provides a useful token for reporting bugs or searching for
> > more information (e.g., in manpages).
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> 
> Better than nothing:
> 
> Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

Now that's the kind of whole-hearted endorsement I strive for. :)

If you have better wording, I'm open to it. I do note that we don't
actually have a manpage for "git-remote-https", though we do for others.
Probably "man git-remote-helpers" is the most sensible thing to point
the user to. But I don't even think this is worthy of a big advice
message. It's a bug in the helper, it shouldn't really happen, and
giving the user a token they can use to report or google for the error
is probably good enough.

-Peff
