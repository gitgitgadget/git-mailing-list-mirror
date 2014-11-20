From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] refs.c: make ref_transaction_create a wrapper for
 ref_transaction_update
Date: Thu, 20 Nov 2014 13:18:32 -0500
Message-ID: <20141120181831.GC2559@peff.net>
References: <1416433224-29763-1-git-send-email-sbeller@google.com>
 <1416433224-29763-2-git-send-email-sbeller@google.com>
 <20141120160000.GA31738@peff.net>
 <20141120180315.GA15945@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	sahlberg@google.com, git@vger.kernel.org, mhagger@alum.mit.edu
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:18:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWJX-00052P-EB
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757923AbaKTSSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:18:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:42884 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757903AbaKTSSe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:18:34 -0500
Received: (qmail 20040 invoked by uid 102); 20 Nov 2014 18:18:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 12:18:33 -0600
Received: (qmail 14579 invoked by uid 107); 20 Nov 2014 18:18:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 13:18:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 13:18:32 -0500
Content-Disposition: inline
In-Reply-To: <20141120180315.GA15945@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 10:03:15AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Wed, Nov 19, 2014 at 01:40:23PM -0800, Stefan Beller wrote:
> 
> >> -	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
> >> -		strbuf_addf(err, "refusing to create ref with bad name %s",
> >> -			    refname);
> >> -		return -1;
> >> -	}
> >
> > You claimed in the cover letter that only BUG messages were changed. But
> > I think this third one is a real user-visible message.
> >
> > That being said, I think the sum total of the change to the message is
> > s/create/update/, and it's probably fine.
> 
> Yeah, it we want to get the 'create' back, we could handle it by
> checking if old_sha1 is null_sha1 in transaction_update (that would
> take of other callers, too, like 'git update-ref <ref> <commit> ""').
> But I haven't convinced myself that's worth the complication --- in
> any event it could be a separate patch to avoid blocking this one.

Agreed on all of that.

-Peff
