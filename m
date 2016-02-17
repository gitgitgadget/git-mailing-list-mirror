From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Tue, 16 Feb 2016 19:32:59 -0500
Message-ID: <20160217003259.GD1187@sigill.intra.peff.net>
References: <20160216192231.GA16567@sigill.intra.peff.net>
 <CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
 <20160216204954.GC27484@sigill.intra.peff.net>
 <CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
 <20160216223451.GB9014@sigill.intra.peff.net>
 <CAPig+cS+i5QfpUbs8T+CqcDkC4ybaTygE9bguiqQMNgV4JhDOQ@mail.gmail.com>
 <20160216231811.GA18634@sigill.intra.peff.net>
 <xmqqbn7gkxev.fsf@gitster.mtv.corp.google.com>
 <20160217002215.GA1187@sigill.intra.peff.net>
 <xmqq37sskwo5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 01:33:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVq3H-0005up-U5
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 01:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933496AbcBQAdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 19:33:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:43774 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933343AbcBQAdC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 19:33:02 -0500
Received: (qmail 11702 invoked by uid 102); 17 Feb 2016 00:33:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 19:33:02 -0500
Received: (qmail 1050 invoked by uid 107); 17 Feb 2016 00:33:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 19:33:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 19:32:59 -0500
Content-Disposition: inline
In-Reply-To: <xmqq37sskwo5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286468>

On Tue, Feb 16, 2016 at 04:28:10PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Feb 16, 2016 at 04:12:08PM -0800, Junio C Hamano wrote:
> >
> >> > To be honest, though, I am now on the fence, considering the possible
> >> > whitespace issue.
> >> 
> >> Certainly not having to see s[0]->buf over and over is a huge win ;-).
> >> 
> >> Is the "whitespace issue" a big deal?  Does it involve more than a
> >> similar sibling to string_list_split() that trims the whitespace
> >> around the delimiter (or allows a regexp as a delimiter "\s*,\s*")?
> >
> > I think that solution would work (and IMHO would actually be preferable
> > to the split-then-trim that strbuf_split does). But it does mean writing
> > new code.
> 
> True, but only when we decide to support trimming the whitespace,
> which can come later.
> 
> I do not even know if it is wise to accept %(align:position=left, width=4)
> when %(align:position=left,width=4) would do the job just fine.

Yeah, it was mostly just about being friendly to the user. But if nobody
is complaining, it may not even be worth worrying about.

-Peff
