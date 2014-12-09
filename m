From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] doc: document error handling functions and
 conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a
 strbuf)
Date: Tue, 9 Dec 2014 13:49:45 -0500
Message-ID: <20141209184944.GA31158@peff.net>
References: <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
 <20141204030133.GA16345@google.com>
 <xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
 <20141204234147.GF16345@google.com>
 <20141204234432.GA29953@peff.net>
 <CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>
 <20141205000128.GA30048@peff.net>
 <xmqqfvcuq8nu.fsf@gitster.dls.corp.google.com>
 <20141207100755.GB22230@peff.net>
 <xmqqk320mzo7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 19:49:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyPr6-0004Iq-Gm
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 19:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbaLISts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 13:49:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:50606 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751252AbaLISts (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 13:49:48 -0500
Received: (qmail 13158 invoked by uid 102); 9 Dec 2014 18:49:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 12:49:47 -0600
Received: (qmail 2685 invoked by uid 107); 9 Dec 2014 18:49:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 13:49:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 13:49:45 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk320mzo7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261139>

On Tue, Dec 09, 2014 at 10:43:52AM -0800, Junio C Hamano wrote:

> > Unless we can do something clever with a set of global error strbufs or
> > something (i.e., that expand as needed, but the caller does not have to
> > free themselves, as they will get recycled eventually). That has its own
> > corner cases, though.
> 
> I do share your concern that "strbuf"-approach calls for more
> boilerplate leading to unmaintainable code, but I offhand do not
> have a magic silver bullet for it.  globals are indeed tempting, but
> I'd have to say that what Jonathan has may probably be the least bad
> of the possibilities.

OK. I'm not sure I agree that it is the least bad, but I don't think
it's worth arguing over more. Let's go with it, and you can note my
objection in the captain's log. :)

-Peff
