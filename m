From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] document string_list_clear
Date: Wed, 10 Dec 2014 03:52:01 -0500
Message-ID: <20141210085201.GB29776@peff.net>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <xmqq61dkl8e3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 09:52:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyd0E-0000rq-5s
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 09:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484AbaLJIwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 03:52:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:50932 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755294AbaLJIwE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 03:52:04 -0500
Received: (qmail 24921 invoked by uid 102); 10 Dec 2014 08:52:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 02:52:04 -0600
Received: (qmail 7544 invoked by uid 107); 10 Dec 2014 08:52:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 03:52:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 03:52:01 -0500
Content-Disposition: inline
In-Reply-To: <xmqq61dkl8e3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261196>

On Tue, Dec 09, 2014 at 03:18:28PM -0800, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Jeff King wrote:
> >
> >> Elsewhere I mentioned a tool to extract comments and format them. But do
> >> people actually care about the formatting step?
> >
> > If formatting means "convert to a straightforward text document that I
> > can read through", then I do.
> 
> If the result becomes unparsable by AsciiDoc(or), those who
> AsciiDoc'ified the api-*.txt may feel unhappy.  I however strongly
> suspect that the primary consumer of these api-*.txt documents are
> consuming the text version, not AsciiDoc-to-html output.

Yeah, that was my point. They were not even asciidoc'd for a long time,
then one contributor, who does not otherwise work on the code,
volunteered to asciidoc them. AFAIK there are no regular developers who
wanted this feature (but I do not know for sure, which is why I asked).

I do not _mind_ if they can be asciidoc'd, but if nobody does so, they
are bound to develop formatting errors. And matching asciidoc syntax
does come at a readability cost to the text.

> The documentation that was written with an explicit purpose to serve
> as documentation would explain how each pieces fit in the whole
> system much better than a list of pieces extracted from per-function
> comments, unless the header comment that serves as the source of
> generated document is written carefully.

If we split the header files sanely (i.e., to match what would be one
api-* file), then I had imagined each header file having a long
free-form comment at the top giving the overview, followed by commented
structures and functions, with possibly other free-form comments in the
middle as necessary. That's what I did for the strbuf.h conversion I
just sent.

> I am a bit hesitant to see us spending extra cycles either to
> reinvent doxygen (if we do our own) or working around quirks in
> third-party tools (if we decide to use existing ones).

Me too. That's what I hoped that we could come up with a form whose
in-header source is readable enough that people would use it. Then there
is really no tool necessary.

-Peff
