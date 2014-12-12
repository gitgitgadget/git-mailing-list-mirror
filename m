From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 20/23] reflog_expire(): new function in the reference API
Date: Fri, 12 Dec 2014 03:50:22 -0500
Message-ID: <20141212085022.GA11891@peff.net>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-21-git-send-email-mhagger@alum.mit.edu>
 <20141208233217.GL25562@google.com>
 <548AA5E9.9090201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:50:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzLvh-0002LB-L5
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900AbaLLIuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:50:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:51992 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753122AbaLLIuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 03:50:24 -0500
Received: (qmail 19776 invoked by uid 102); 12 Dec 2014 08:50:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 02:50:25 -0600
Received: (qmail 9202 invoked by uid 107); 12 Dec 2014 08:50:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 03:50:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Dec 2014 03:50:22 -0500
Content-Disposition: inline
In-Reply-To: <548AA5E9.9090201@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261314>

On Fri, Dec 12, 2014 at 09:23:05AM +0100, Michael Haggerty wrote:

> On 12/09/2014 12:32 AM, Stefan Beller wrote:
> >> +enum expire_reflog_flags {
> >> +	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
> >> +	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
> >> +	EXPIRE_REFLOGS_VERBOSE = 1 << 2,
> >> +	EXPIRE_REFLOGS_REWRITE = 1 << 3
> >> +};
> > 
> > Sometimes we align the assigned numbers and sometimes we don't in git, so an alternative would be
> > 
> > enum expire_reflog_flags {
> >      EXPIRE_REFLOGS_DRY_RUN    = 1 << 0,
> >      EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
> >      EXPIRE_REFLOGS_VERBOSE    = 1 << 2,
> >      EXPIRE_REFLOGS_REWRITE    = 1 << 3
> > }
> > 
> > Do we have a preference in the coding style on this one?

I think vertically aligned lists look really nice. But they often wreak
havoc with diffs, because introducing one longer line means re-aligning
the whole thing. IMHO, it's not worth it (but if you're going to do it,
leave lots of extra room for expansion).

Just my two cents, of course. I don't recall this particular style point
coming up before.

> Both styles are used in our codebase, and I don't think the style guide
> says anything about it. My practice in such cases is:
> 
> * If I'm modifying existing code, preserve the existing style (to avoid
> unnecessary churn)
> * If most of our code uses one style, then use that style
> * If our code uses both styles frequently, just use whatever style looks
> better to me

I think that is a very good philosophy in general.

-Peff
