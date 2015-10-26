From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] detecting delete/modechange conflicts
Date: Mon, 26 Oct 2015 17:54:06 -0400
Message-ID: <20151026215406.GB17419@sigill.intra.peff.net>
References: <20151026213502.GA17244@sigill.intra.peff.net>
 <xmqq8u6pfgl9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 22:54:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqpiY-0004Sy-Lh
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 22:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbbJZVyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 17:54:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:48167 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751429AbbJZVyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 17:54:08 -0400
Received: (qmail 10160 invoked by uid 102); 26 Oct 2015 21:54:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 16:54:08 -0500
Received: (qmail 18281 invoked by uid 107); 26 Oct 2015 21:54:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 17:54:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Oct 2015 17:54:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8u6pfgl9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280232>

On Mon, Oct 26, 2015 at 02:46:42PM -0700, Junio C Hamano wrote:

> > After looking through the history and the list archive, I don't _think_
> > this was intentional, and we simply missed the case in both places. But
> > maybe somebody else knows something I don't. It seems like we should be
> > punting to the user under the general principle of stupid and safe
> > merges.
> 
> Yes, I do not recall ever discussing and agreeing with Linus that we
> should resolve to deletion over mode change, and I agree that it
> would be very likely that this never came up in practice simply
> because in real life removal is already rare, mode change is rarer,
> and these happening to the same path in the same timeperiod to
> matter in merges is even more rare.
> 
> We should definitely signal a conflict.

Thanks, that matches my thinking exactly.

BTW, this came up because libgit2 does signal the conflict, and we are
regression-testing a switch from merge-resolve over to libgit2 to power
GitHub's "merge" button. Run it on enough test cases and you will find
one of everything. :)

-Peff
