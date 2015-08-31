From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] date: allow any format to display local time
Date: Mon, 31 Aug 2015 16:44:45 -0400
Message-ID: <20150831204444.GA4385@sigill.intra.peff.net>
References: <d3b9f8f6524e45c9fc7a3e104669572c8c4ddd8a.1440942688.git.john@keeping.me.uk>
 <xmqqtwrfweo7.fsf@gitster.mtv.corp.google.com>
 <20150831185018.GA20555@sigill.intra.peff.net>
 <20150831200016.GC30659@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:44:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVwi-0005Cj-Ms
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbbHaUot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 16:44:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:52651 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753054AbbHaUor (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:44:47 -0400
Received: (qmail 25685 invoked by uid 102); 31 Aug 2015 20:44:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 15:44:47 -0500
Received: (qmail 27016 invoked by uid 107); 31 Aug 2015 20:44:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 16:44:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2015 16:44:45 -0400
Content-Disposition: inline
In-Reply-To: <20150831200016.GC30659@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276938>

On Mon, Aug 31, 2015 at 09:00:16PM +0100, John Keeping wrote:

> Are you willing to resend this as a proper patch?

Yup.

  [1/2]: fast-import: switch crash-report date to iso8601
  [2/2]: date: make "local" orthogonal to date format

> I'm happy to build documentation & tests on top, although there don't
> seem to be any tests for date formats outside t6300-for-each-ref.sh at
> the moment

I've added documentation, but not tests. Tests on top would be very much
appreciated.

> (and the "format" mode is neither tested nor documented for
> git-for-each-ref although it does work)..

I think it is the opposite for testing: we test only for-each-ref.  I
remember when I did the original patch finding that there were no
existing tests for log --date, and I was too lazy to add them. It would
be nice to add some now.

I agree that the documentation for for-each-ref is not up to date. I
think it should do a better job of just pointing to the existing
date-format (and then we do not have to keep documenting new features in
two places).

We could also push the content into a new file and include it from both
places. But I'd be much more in favor of actually pulling the date
discussion into a separate "gitdates(7)" manpage and just referencing it
from both places.  Even though it creates more work for a user following
the reference (in manpages, at least, which are not hyperlinked), I
think there is a cognitive benefit to the user in realizing that the
same concept can be applied in both places.

-Peff
