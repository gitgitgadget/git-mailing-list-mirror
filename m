From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-cvsimport: allow author-specific timezones
Date: Tue, 16 Oct 2012 02:31:52 -0400
Message-ID: <20121016063152.GB22941@sigill.intra.peff.net>
References: <1350261054-5171-1-git-send-email-crorvick@cogcap.com>
 <7vpq4jws4d.fsf@alter.siamese.dyndns.org>
 <CAEUsAPY3fJJSzX8WPRVQPNOF0A0KAMCXr1u0ZzjEFvXDF=v6JA@mail.gmail.com>
 <7v4nlvulc2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:32:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO0hD-00065s-Us
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 08:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033Ab2JPGb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 02:31:56 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54590 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880Ab2JPGbz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 02:31:55 -0400
Received: (qmail 12681 invoked by uid 107); 16 Oct 2012 06:32:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Oct 2012 02:32:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2012 02:31:52 -0400
Content-Disposition: inline
In-Reply-To: <7v4nlvulc2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207804>

On Mon, Oct 15, 2012 at 08:50:21PM -0700, Junio C Hamano wrote:

> Chris Rorvick <chris@rorvick.com> writes:
> 
> > It occurred to me that the success of the unit test depends on the
> > host platform's zoneinfo database.  I think this problem is inherent
> > with this functionality.  Should the unit test attempt to detect
> > support for the used timezones and short circuit if this fails?  Not
> > sure exactly how I'd do this, but wondering if it's worth thinking
> > about.
> 
> Yeah, that did indeed cross my mind.
> 
> You could say TZ=QST6QDT or something silly like that but that in
> turn has to assume your tzset() is POSIX.1 compliant anyway.

We use EST5 in t0006 (it was originally just "EST" but IRIX complained).
It's been in the test suite for two years without a problem, so it may
be simple and safe enough to just use that.

-Peff
