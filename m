From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] rev-parse and "--"
Date: Fri, 6 Dec 2013 18:30:04 -0500
Message-ID: <20131206233004.GA29524@sigill.intra.peff.net>
References: <20131206211222.GB20482@sigill.intra.peff.net>
 <20131206211509.GB20536@sigill.intra.peff.net>
 <20131206220520.GA30652@sigill.intra.peff.net>
 <20131206232556.GN29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 00:30:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp4qb-0004YO-7S
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 00:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760265Ab3LFXaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 18:30:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:51917 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760263Ab3LFXaG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 18:30:06 -0500
Received: (qmail 16627 invoked by uid 102); 6 Dec 2013 23:30:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Dec 2013 17:30:06 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Dec 2013 18:30:04 -0500
Content-Disposition: inline
In-Reply-To: <20131206232556.GN29959@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238964>

On Fri, Dec 06, 2013 at 03:25:56PM -0800, Jonathan Nieder wrote:

> >   commit=$(git rev-parse HEAD)
> >
> > I'm tempted to say that people who did that are stupid and wrong (and
> > ugly, too). They should probably be using "--verify" in this case. But
> > it has been that way for a long time, and there are two instances in our
> > test scripts that are broken by the patch.
> 
> Wouldn't the same thing happen for $(git rev-parse HEAD^..HEAD) when
> there is a 'HEAD^..HEAD' file, too?  --verify doesn't support that.

True, but they can use "rev-parse HEAD^..HEAD --", which is probably a
better alternative to --verify.

> I think it's a nice idea to provide this functionality for people who
> need it, which would mean protected by an option (--check-ambiguity or
> something).  I don't think it's a good change to do it
> unconditionally.

I don't think it's worth making it conditional. Literally nobody has
asked for it. I was mostly trying to harmonize "rev-parse" and the rest
of the revision parser. If that's not worth doing, I'd just as soon drop
it (and people using "--" properly already get the right behavior).

-Peff
