From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: shorten "push.default is unset" warning message
Date: Wed, 24 Feb 2016 05:11:15 -0500
Message-ID: <20160224101115.GA20807@sigill.intra.peff.net>
References: <000001530ea408ed-2b71a34a-32bb-434c-bba5-fdac28193e9c-000000@eu-west-1.amazonses.com>
 <xmqqtwkz1c4b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:11:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYWPn-0005Uh-Mn
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 11:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbcBXKLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 05:11:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:48165 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751512AbcBXKLS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 05:11:18 -0500
Received: (qmail 27439 invoked by uid 102); 24 Feb 2016 10:11:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:11:18 -0500
Received: (qmail 6690 invoked by uid 107); 24 Feb 2016 10:11:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:11:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 05:11:15 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtwkz1c4b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287186>

On Tue, Feb 23, 2016 at 11:05:08AM -0800, Junio C Hamano wrote:

> If most people are happy with "simple" (and certainly that was the
> assumption and hope behind the transtion we made at 2.0), we may be
> better off removing the warning altogether.  Keeping "and adopt the
> new behaviour" part pretends to be offering a chance to make an
> informed choice, but it will forever be unclear to the non-reader
> what the implication of not adopting the new behaviour is anyway, so
> overall we won't see reduced hits at stackoverflow with this change.

Yeah, this was my first thought on seeing Matthieu's patch. We inserted
that message to tell people about the impending change, and to catch any
stragglers even after the change had happened. At some point it simply
becomes obsolete history.

I dunno if that time is now or not. v2.3.0 (which actually flipped the
switch) is only a year old, but we've been showing the message since
v1.8.0, which is over 3 years old. Even Debian stable is way beyond
that. :)

So my inclination is to just rip out the warning entirely.

-Peff
