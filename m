From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: dereference tags with
 --ignore-if-in-upstream
Date: Mon, 1 Jun 2015 13:47:12 -0400
Message-ID: <20150601174712.GA18364@peff.net>
References: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
 <1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqqr3pv8okj.fsf@gitster.dls.corp.google.com>
 <xmqq6177728a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 19:47:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTo3-0004hn-GC
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbbFARrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 13:47:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:39004 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753726AbbFARrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 13:47:15 -0400
Received: (qmail 16644 invoked by uid 102); 1 Jun 2015 17:47:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 12:47:14 -0500
Received: (qmail 32506 invoked by uid 107); 1 Jun 2015 17:47:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 13:47:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 13:47:12 -0400
Content-Disposition: inline
In-Reply-To: <xmqq6177728a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270447>

On Mon, Jun 01, 2015 at 10:44:21AM -0700, Junio C Hamano wrote:

> > Shouldn't you ensure o1 and o2 are commits here?
> 
> Heh, I should have read the remainder of the thread before
> responding.
> 
> How about doing it this way?  We know and trust that existing
> revision traversal machinery is doing the right thing, and it is
> only that the clear_commit_marks() calls are botched.

Yeah, I think this matches the recommendation I gave in the last round.

I do still think we could get rid of this "second" traversal entirely in
favor of using "--cherry", but that is a much larger topic. Even if
somebody wants to pursue that, the immediate fix should look like this.

-Peff
