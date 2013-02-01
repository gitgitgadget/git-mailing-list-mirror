From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Fri, 1 Feb 2013 04:14:31 -0500
Message-ID: <20130201091431.GC30644@sigill.intra.peff.net>
References: <20130126224011.GA20675@sigill.intra.peff.net>
 <7vlibfxhit.fsf@alter.siamese.dyndns.org>
 <20130129082939.GB6396@sigill.intra.peff.net>
 <7vwquwrng6.fsf@alter.siamese.dyndns.org>
 <20130129211932.GA17377@sigill.intra.peff.net>
 <CAJo=hJuGw8x=VrjWhvZhzakuhWrCWr2FRuEsNt5gQNC=6PPuVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 01 10:15:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1Ci2-0005Tz-Pg
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 10:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab3BAJOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 04:14:36 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55319 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755837Ab3BAJOf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 04:14:35 -0500
Received: (qmail 19618 invoked by uid 107); 1 Feb 2013 09:15:58 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 04:15:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 04:14:31 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJuGw8x=VrjWhvZhzakuhWrCWr2FRuEsNt5gQNC=6PPuVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215222>

On Thu, Jan 31, 2013 at 08:47:37AM -0800, Shawn O. Pearce wrote:

> >>  - System resource cost we incur by having to keep 50 file
> >>    descriptors open and maintaining 50 mmap windows will reduce by
> >>    50 fold.
> >
> > I wonder how measurable that is (and if it matters on Linux versus less
> > efficient platforms).
> 
> It does matter. We know it has a negative impact on JGit even on Linux
> for example. You don't want 300 packs in a repository. 50 might be
> tolerable. 300 is not.

I'd love to see numbers if you have them. It's not that I don't believe
it is slower, but knowing _how much_ is important when thinking about
what kind of performance increase we are looking to get (which in turn
impacts how much effort to put into the repacking).

-Peff
