From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Tue, 16 Feb 2016 15:49:54 -0500
Message-ID: <20160216204954.GC27484@sigill.intra.peff.net>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
 <1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
 <20160216192231.GA16567@sigill.intra.peff.net>
 <CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 21:50:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVmZN-0003LG-Iw
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 21:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832AbcBPUt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 15:49:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:43546 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751522AbcBPUt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 15:49:57 -0500
Received: (qmail 1746 invoked by uid 102); 16 Feb 2016 20:49:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 15:49:56 -0500
Received: (qmail 30497 invoked by uid 107); 16 Feb 2016 20:50:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 15:50:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 15:49:54 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286431>

On Tue, Feb 16, 2016 at 03:12:29PM -0500, Eric Sunshine wrote:

> > Did you consider just using string_list_split for this? AFAICT, you
> > don't care about the results being strbufs themselves, and it would do
> > what you want without having to bother with patch 1. [...]
> >
> > Sorry to waltz into a review of v5 with a suggestion to throw out all
> > the work done in previous iterations. :-/ I just think the strbuf_split
> > interface is kind of clunky and I'd be happy if we could slowly get rid
> > of it rather than growing it. [...]
> 
> That's a nice idea, however, I'm not sure if making it part of this
> series this late in the game is a good idea. The series has gone
> through major changes and heavy review in each of the preceding
> versions, and turnaround time has been consequently quite slow (due
> both to the amount of work required by Karthik for each version, and
> to the amount of time needed by reviewers to digest all the new
> changes). v4 was the first one which had settled to the point where
> only minor changes were needed, and we were hoping to land the series
> with v5. (A few larger changes were also discussed in v4 reviews, but
> we concluded that they could be done as follow-up patches.)
> 
> With that in mind, it might be better to make this change as a
> followup to this series. On the other hand, as you say, waiting would
> expand the strbuf_split interface undesirably, so the alternative
> would be for Karthik to submit v6 with this change only (to wit: drop
> patch 1 and rewrite patch 2 as you've shown). While such a change will
> again require careful review, at least it is well localized, and
> Karthik's turnaround time shouldn't be too bad. So...

Yeah, I don't insist, and like I said, I'm not 100% sure we can get rid
of the strbuf_split interface anyway. I thought it might actually make
things easier by making the series _shorter_ (so my regret was that
mentioning earlier could have saved reviewing effort on patch 1).

It does mean extra review of the patch I posted, but my hope was that
it's small and localized, and wouldn't impact the later stuff seriously
(there are some textual tweaks to carry it forward, though).

Anyway, I've said my piece, and you guys can do what you will with it.

-Peff
