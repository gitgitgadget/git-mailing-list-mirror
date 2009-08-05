From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] transport: don't show push status if --quiet is
 given
Date: Wed, 5 Aug 2009 16:48:35 -0400
Message-ID: <20090805204835.GA24539@coredump.intra.peff.net>
References: <20090805201937.GB9004@coredump.intra.peff.net>
 <20090805202326.GC23226@coredump.intra.peff.net>
 <7vhbwm0zcs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnPn-0004or-KU
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbZHEUsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbZHEUsk
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:48:40 -0400
Received: from peff.net ([208.65.91.99]:60577 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295AbZHEUsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:48:39 -0400
Received: (qmail 12636 invoked by uid 107); 5 Aug 2009 20:50:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 05 Aug 2009 16:50:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2009 16:48:35 -0400
Content-Disposition: inline
In-Reply-To: <7vhbwm0zcs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124976>

On Wed, Aug 05, 2009 at 01:39:31PM -0700, Junio C Hamano wrote:

> > When --quiet is given, the user generally only wants to see
> > errors.
> 
> That does not match what my cron job at day job expects.
> 
> I'd welcome the warm and fuzzy feeling of seeing "ah, yes, we had changes
> on those branches to push out last night".
> 
> Maybe it is just me, but my gut feeling is that it would be more
> appropriate to squelch only "already up to date" refs at least, at the
> default level of quietness.

I don't understand. Isn't that what "git push" _already_ does? Or are
you saying you would like the "squelch progress" feature of 2/3, but not
the "squelch ref status" of 3/3? In that case, are you not already doing
something to squelch the progress?

We could accomodate that by doubling --quiet to suppress ref status,
though the transport interface seems to rely on flags (I guess we could
have QUIET and REALLY_QUIET).

-Peff
