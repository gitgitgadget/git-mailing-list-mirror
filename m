From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib: GnomeKeyring support + generic helper
 implementation
Date: Fri, 24 Aug 2012 17:33:42 -0400
Message-ID: <20120824213342.GB16285@sigill.intra.peff.net>
References: <1345741068-11004-1-git-send-email-pah@qo.cx>
 <7vfw7cyx4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	"Philipp A. Hartmann" <pah@qo.cx>, git@vger.kernel.org,
	John Szakmeister <john@szakmeister.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 23:34:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T51Vv-0007ug-NJ
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 23:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760242Ab2HXVdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 17:33:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47682 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757172Ab2HXVdq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 17:33:46 -0400
Received: (qmail 4973 invoked by uid 107); 24 Aug 2012 21:34:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Aug 2012 17:34:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2012 17:33:42 -0400
Content-Disposition: inline
In-Reply-To: <7vfw7cyx4n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204234>

On Fri, Aug 24, 2012 at 11:15:36AM -0700, Junio C Hamano wrote:

> >   The third and fourth patches port the existing helpers to this generic
> > implementation.
> >
> It struck me somewhat odd to see a new one added as the first step
> in the series, and then "the generic", the third patch only to lose
> code from the first one, and then use the same code reduction of
> existing one with the last one in the series.  A natural progression
> would have been the introduction of generic infrastructure
> (including the tiny bit this series had to add as part of 4/4) as
> the first patch, update existing OSX one to it as the second, and
> then build a new Gnome one on the infrastructure as the third and
> final patch; that way we have to review less code, too ;-).

I think this is partially because I talked with Phillipp off-list and
was somewhat unsure how much we wanted to factor out of the helpers. My
initial thought was that the protocol would be sufficiently simple that
helpers would just be stand-alone and not need to share code with each
other. Then the generic bits would not have to worry about being
cross-platform compatible.

However, the shared bits are simple enough that maybe that is not a
concern. An interesting test would be to add a 5/4 porting Erik's win32
credential helper, since that is the platform least like our other ones.

So I am OK with this series, but I am also OK with leaving it at patch
1, and just keeping the implementations separate.

-Peff
