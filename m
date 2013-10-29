From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes:
 line
Date: Mon, 28 Oct 2013 22:02:28 -0400
Message-ID: <20131029020227.GD11861@sigill.intra.peff.net>
References: <20131026181709.GB10488@kroah.com>
 <20131027013402.GA7146@leaf>
 <526CA7D4.1070904@alum.mit.edu>
 <20131027071407.GA11683@leaf>
 <874n83m8xv.fsf@linux-k42r.v.cablecom.net>
 <20131027092019.GB13149@leaf>
 <CALKQrgc7a+p5eebJErcGdA3QDyvdHEaef36RhZocQp9LjDUeeg@mail.gmail.com>
 <CAP8UFD3MZJKWUbdZqrSwoatpnx73MTpiwSkxPHYDagGjMSqJNw@mail.gmail.com>
 <CALKQrgcgfimZRJL7WyS-brqEZnHJkJjK_0cqe6-7HWkuCW6Dzw@mail.gmail.com>
 <87txg1hwsa.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Christian Couder <christian.couder@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git mailing list <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Oct 29 03:02:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vaydg-0001a9-S5
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 03:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505Ab3J2CCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 22:02:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:57447 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756896Ab3J2CCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 22:02:31 -0400
Received: (qmail 30969 invoked by uid 102); 29 Oct 2013 02:02:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 21:02:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 22:02:28 -0400
Content-Disposition: inline
In-Reply-To: <87txg1hwsa.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236887>

On Mon, Oct 28, 2013 at 11:10:13PM +0100, Thomas Rast wrote:

> * In your list
> 
> >   Fixes:
> >   Reported-by:
> >   Suggested-by:
> >   Improved-by:
> >   Acked-by:
> >   Reviewed-by:
> >   Tested-by:
> >   Signed-off-by:
> 
>   and I might add
> 
>     Cherry-picked-from:
>     Reverts:
> 
>   if one were to phrase that as a footer/pseudoheader, observe that
>   there are only two kinds of these: footers that contain identities,
>   and footers that contain references to commits.

I think people put other things in, too. For example, cross-referencing
bug-tracker ids.

In fact, if I saw "fixes: XXX", I would expect the latter to be a
tracker id.  People do this a lot with GitHub issues, because GitHub
will auto-close issue 123 if a commit with "fixes #123" is pushed to
master. Because of the "#", no pseudo-header is needed, but I have also
seen people use the footer style (I don't have any examples on-hand,
though).

That being said, in your examples:

> So why not support these use-cases?  We could have something like
> footer.foo.* configuration, e.g.
> 
> [footer "fixes"]
>         type = commit
>         suggest = true
> [footer "acked-by"]
>         type = identity

you could easily have "type=text" to handle arbitrary text.

-Peff
