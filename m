From: Jeff King <peff@peff.net>
Subject: Re: git-config: case insensitivity for subsections
Date: Thu, 25 Aug 2011 17:39:52 -0400
Message-ID: <20110825213952.GA16914@sigill.intra.peff.net>
References: <20110818063528.GH13342@hal.rescomp.berkeley.edu>
 <20110825205849.GA10384@sigill.intra.peff.net>
 <7vpqjti3dq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: milki <milki@rescomp.berkeley.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 23:40:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwheb-0004LR-I3
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab1HYVj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:39:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46893
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492Ab1HYVjz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:39:55 -0400
Received: (qmail 20505 invoked by uid 107); 25 Aug 2011 21:40:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Aug 2011 17:40:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Aug 2011 17:39:52 -0400
Content-Disposition: inline
In-Reply-To: <7vpqjti3dq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180123>

On Thu, Aug 25, 2011 at 02:32:17PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure it makes sense to do so. I can see how:
> >
> >   [section.SUBSECTION]
> >
> > and
> >
> >   [section.subsection]
> >
> > should be merged. But isn't:
> >
> >   [section "SUBSECTION"]
> >
> > conceptually a different section entirely?
> 
> I still recall getting scolded by Linus after writing [sec.tion]; this was
> way back when he was still active on this list. I essentially was told
> that [sec "tion"] is _the_ only supported way, and [sec.tion] may work but
> it purely does by accident, not by design.

Hmm. It is a little weird that color.branch.local would have to be
spelled:

  [color "branch"]
    local = blue

and that the "branch" must be case-sensitive.

But then, that wouldn't be my first complaint about our config syntax,
which sort of pretends to be hierarchical (with the dot-syntax) but
isn't really. E.g., I'd really much rather it be spelled:

  [color]
    branch.local = blue

> Do we still even list the bogus [section.SUBSECTION] syntax anywhere in
> our docs? If so, we should remove them and if not we simply just should
> deprecate the code to read such input.

It's in Documentation/config.txt. It seems to blame to e136f33
(Documentation/config.txt: Document config file syntax better,
2007-01-22).

-Peff
